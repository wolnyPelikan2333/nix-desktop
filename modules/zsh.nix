{ config, pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    dotDir = "${config.xdg.configHome}/zsh";

    
    initContent = ''
      autoload -Uz colors
      colors

      # Czytelny, kontrastowy prompt
      PROMPT=$'\n%{\e[38;5;220m%}%~%{\e[0m%}\n%{\e[38;5;81m%}❯%{\e[0m%} '
    
      unalias ns 2>/dev/null
      unalias nss 2>/dev/null
      unalias sys-status 2>/dev/null
      unalias nh-menu 2>/dev/null
      unalias g3 2>/dev/null
      unalias g5 2>/dev/null 

      NOTEFILE="$HOME/.config/nixos-notes.log"

      ##########################################################
      # SYSTEM SNAPSHOT + AUTO-COMMIT
      ##########################################################
      sys-note(){
        mkdir -p "$HOME/.config"
        echo "$(date '+%F %H:%M') — $*" >> "$NOTEFILE"
        echo "📝 zapisano"
      }

      sys-save-os(){
        local msg="$*"
        [ -z "$msg" ] && msg="update"

        echo "⚙ build + switch..."
        sudo nixos-rebuild switch --flake /etc/nixos#nixos || { echo "❌ FAIL"; return; }

        git -C /etc/nixos add -A
        git -C /etc/nixos commit -m "snapshot: $(date +%F_%H-%M) — $msg" && git -C /etc/nixos push

        echo "🚀 snapshot zapisany → $msg"
      }

      ns(){ sys-note "$*"; sys-save-os "$*"; }
      nss(){ sys-save-os "$*"; }

      ##########################################################
      # STATUS SYSTEMU
      ##########################################################
      sys-status(){
        echo "===== SYSTEM STATUS ====="
        echo
        echo "📊 Uptime:"; uptime | sed 's/^/  /'; echo
        echo "💾 Disk /:"; df -h / | sed '1d;s/^/  /'; echo
        echo "🔐 Repo:"; if [ -z "$(git -C /etc/nixos status --porcelain)" ]; then echo "  CLEAN ✔"; else echo "  DIRTY ✖"; fi; echo
        echo "🗂 System gens:"; sudo nix-env --list-generations --profile /nix/var/nix/profiles/system | tail -n 7 | sed 's/^/  /'; echo
        echo "🏠 Home gens:"; home-manager generations | head -n 5 | sed 's/^/  /'; echo
        echo "🗑 Garbage dry-run:"; nix-collect-garbage -d --dry-run | sed 's/^/  /'; echo
      }
             sys-history(){
        if [ -f "$NOTEFILE" ]; then
          echo "📜 Historia zmian:"
          nl -ba "$NOTEFILE" | less
        else
          echo "📭 Brak historii — użyj 'ns opis' aby dodać snapshot"
        fi
      }
       
             sys-list(){
        echo "===== SYSTEM GENERATIONS ====="
        sudo nix-env --list-generations --profile /nix/var/nix/profiles/system \
          | tail -n 20 | sed 's/^/  /'
        echo

        echo "===== HOME GENERATIONS ====="
        home-manager generations | head -n 20 | sed 's/^/  /'
        echo
      }


      ##########################################################
      # ROLLBACK BASIC
      ##########################################################
      nh-rollback(){
        local gen=$(sudo nix-env --list-generations --profile /nix/var/nix/profiles/system \
          | fzf --prompt="Rollback generation > " --height=60%)

        [[ -z "$gen" ]] && echo "❌ anulowano" && return

        sudo nixos-rebuild switch --rollback
      }

      ##########################################################
      # ROLLBACK PRO (z diff podglądem)
      ##########################################################
      nh-rollback-pro(){
        local gen=$(sudo nix-env --list-generations --profile /nix/var/nix/profiles/system \
          | fzf --prompt="Rollback generation > " --height=60% --border --ansi)

        [[ -z "$gen" ]] && echo "❌ anulowano" && return

        local gnum=$(echo "$gen" | awk '{print $1}')
        echo "🔍 diff względem generacji: $gnum"
        sudo nix store diff-closures /run/current-system /nix/var/nix/profiles/system-$gnum | less

        read -p "⏪ rollback do $gnum ? (y/n) > " x
        [[ $x == "y" ]] && sudo nixos-rebuild switch --rollback && echo "✔ wykonano"
      }

      ##########################################################
      # MENU PRO+ (FZF launcher)
      ##########################################################
      nh-menu(){
        local choice=$(printf "
	🛠 System
	  🔄 switch
	  🚀 update
	  🌐 flake-update
	  📸 snapshot

	⏪ Bezpieczeństwo
	  ⏪ rollback
	  🔥 rollback-pro
	  📦 show-gens

	🧹 Porządki
	  🗑 clean
	  📊 status
	" | fzf --prompt="≡ NixOS menu > " --ansi --height=85% --border --header="📦 zarządzanie systemem")

		choice=$(echo "$choice" | sed 's/^[[:space:]]*//')

        case "$choice" in
          "🔄 switch")        nh os switch /etc/nixos#nixos ;;
          "🚀 update")        sudo nixos-rebuild switch --flake /etc/nixos#nixos ;;
          "🌐 flake-update")  nix flake update /etc/nixos && nh os switch /etc/nixos#nixos ;;
          "📸 snapshot")      read "?Opis snapshotu: " msg; ns "$msg" ;;
          "⏪ rollback")       sudo nixos-rebuild switch --flake /etc/nixos#nixos --rollback ;;
          "🔥 rollback-pro")  nh-rollback-pro ;;
          "📦 show-gens")     sudo nix-env --list-generations --profile /nix/var/nix/profiles/system | less ;;
          "🗑 clean")         sudo nix-collect-garbage -d && sudo nix store optimise ;;
          "📊 status")        sys-status ;;
        esac
      }

      ##########################################################
      # GC helpers — system generations
      ##########################################################

      g3() {
        echo "🧹 Keeping last 3 system generations"
        sudo nix-env --delete-generations +3 \
          --profile /nix/var/nix/profiles/system
        sudo nix-collect-garbage -d
      }

      g5() {
        echo "🧹 Keeping last 5 system generations"
        sudo nix-env --delete-generations +5 \
          --profile /nix/var/nix/profiles/system
        sudo nix-collect-garbage -d
      }


    '';

    

    history = { size = 50000; save = 50000; share = true; };
  };
}


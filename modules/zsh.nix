{ config, pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    defaultKeymap = "viins";

    
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

        docs() {
    DOCS_DIR="/etc/nixos/docs/ściągi"

    if ! command -v fzf >/dev/null; then
      echo "❌ fzf nie jest zainstalowany"
      return 1
    fi

    FILE=$(find "$DOCS_DIR" -type f -name "*.md" | sort | fzf --prompt="📚 docs > ")

    [ -z "$FILE" ] && return 0

    less "$FILE"
  }
      ##########################################################
      # SESJA — START / STOP (workflow)
      ##########################################################

      sesja-start() {
        echo "$(date '+%F %H:%M')" > /tmp/sesja.start
        echo "🟢 Start: $(cat /tmp/sesja.start)"

        echo "===== 🧭 START SESJI ====="
        echo
        echo "📄 Ostatnia sesja (/etc/nixos/docs/SESJA.md):"
        echo "-------------------------------------------"
        if [ -f /etc/nixos/docs/SESJA.md ]; then
          sed -n '/--- END SESSION ---/,$p' /etc/nixos/docs/SESJA.md
        else
          echo "❌ Brak pliku SESJA.md"
        fi
        echo
        echo "📦 Stan repo (/etc/nixos):"
        git -C /etc/nixos status
        echo
      }

      sesja-stop() {
  if [ ! -f /tmp/sesja.start ]; then
    echo "❌ Brak sesji start (sesja-start)"
    return 1
  fi

  START="$(cat /tmp/sesja.start)"
  END="$(date '+%F %H:%M')"
  DAY="$(date '+%F')"
  SESJA_FILE="/etc/nixos/docs/SESJA.md"

  {
    echo
    echo "## 📅 $DAY"
    echo
    echo "### ⏱ Czas"
    echo "start: $START#*   "
    echo "koniec: $END#*   "
    echo
    echo "### 🔧 Zmiany techniczne"
    git -C /etc/nixos status --porcelain | while read -r _ f; do echo "- \$f"; done
    echo
    echo "### 🎯 Cel sesji"
    echo "- "
    echo
    echo "### ✅ Zrobione"
    echo "- "
    echo
    echo "### 🧠 Wnioski"
    echo "- "
    echo
    echo "### 📌 Następny krok"
    echo "- "
  } >> "$SESJA_FILE"

  rm -f /tmp/sesja.start

  echo "✍️  Otwieram SESJA.md do uzupełnienia..."
  nvim "$SESJA_FILE"
}


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

      # 📓 Daily note
        note() {
          NOTES_DIR="$HOME/notes-md"
          DAILY_DIR="$NOTES_DIR/daily"
          TEMPLATE="$DAILY_DIR/TEMPLATE.md"
          TODAY="$(date +%F)"
          FILE="$DAILY_DIR/$TODAY.md"

          mkdir -p "$DAILY_DIR"

          if [ ! -f "$FILE" ]; then
            sed "s/{{date}}/$TODAY/" "$TEMPLATE" > "$FILE"
          fi

          cd "$NOTES_DIR" || return
          nvim "$FILE"
}

        # 🔄 Notes: auto sync
          notes-sync() {
            NOTES_DIR="$HOME/notes-md"

            cd "$NOTES_DIR" || return

            if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
              echo "❌ Not a git repository: $NOTES_DIR"
              return 1
            fi

            if [ -z "$(git status --porcelain)" ]; then
              echo "✔ No changes to sync"
              return 0
            fi

            git add .
            git commit -m "notes: update $(date +%F_%H-%M)"
            git push

            echo "☁️ Notes synced"
}              
           # 🔄 Ask before syncing notes
              notes-sync-ask() {
                echo
                read "?☁️  Sync notes now? [y/N] " answer
                case "$answer" in
                  y|Y)
                    notes-sync
                    ;;
                  *)
                    echo "↩️  Skipped sync"
                    ;;
                esac
}

          # 🗂 Notes navigation
            nd() {
              cd "$HOME/notes-md/daily" || return
              nvim .
            }

            ni() {
              cd "$HOME/notes-md/ideas" || return
              nvim .
            }

            nn() {
              cd "$HOME/notes-md/nixos" || return
              nvim .
}
    
            # ❄️ NixOS note templates
ndd() {
  FILE="$HOME/notes-md/nixos/debug-$(date +%F).md"
  cp "$HOME/notes-md/nixos/TEMPLATE-debug.md" "$FILE"
  nvim "$FILE"
  notes-sync-ask
}

ndr() {
  FILE="$HOME/notes-md/nixos/runbook-$(date +%F).md"
  cp "$HOME/notes-md/nixos/TEMPLATE-runbook.md" "$FILE"
  nvim "$FILE"
  notes-sync-ask
}

ndc() {
  FILE="$HOME/notes-md/nixos/decision-$(date +%F).md"
  cp "$HOME/notes-md/nixos/TEMPLATE-decision.md" "$FILE"
  nvim "$FILE"
  notes-sync-ask
}




    '';

    

    history = { size = 50000; save = 50000; share = true; };
  };
}


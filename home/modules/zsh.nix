{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    dotDir = "${config.xdg.configHome}/zsh";

    # 🟦 Alias & workflow
    shellAliases = {
      # ─── Twoje aliasy ─────────────────────────────────────────────
      g3 = "nix-env --delete-generations +3 && sudo nix-collect-garbage -d";
      g5 = "nix-env --delete-generations +5 && sudo nix-collect-garbage -d";
      l = "ls -alh";
      la = "eza -a";
      ll = "eza -l";
      lla = "eza -la";
      ls = "eza";
      lt = "eza --tree";
      nb = "nh os boot /etc/nixos#desktop";
      nh-clean = "nh clean all && sudo nix-env --delete-generations +5 && sudo nix-collect-garbage -d";
      nt = "nh os test /etc/nixos#desktop";
      run-help = "man";
      se = "sudoedit";
      which-command = "whence";

      # ─── aliasy workflow NixOS (dopiszemy więcej później) ────────
      nht = "nh os build /etc/nixos#desktop";
      nhs = "nh os switch /etc/nixos#desktop";
      nsc = "ns";
      clean-system = "sudo nix-collect-garbage -d && sudo nix store optimise";
      clean-weekly = "sudo nix-env --delete-generations +7 && sudo nix-collect-garbage -d";
      sys-snapshots = "git -C /etc/nixos log --oneline --graph --decorate";
    };

    history = {
      size = 50000;
      save = 50000;
      share = true;

          # 🟦 Funkcje terminalowe (workflow NixOS)
    initExtra = ''
      NOTEFILE="$HOME/.config/nixos-notes.log"

      sys-note(){
        mkdir -p "$HOME/.config"
        echo "$(date '+%F %H:%M') — $*" >> "$NOTEFILE"
        echo "📝 $*"
      }

      sys-history(){
        [ -f "$NOTEFILE" ] && nl -ba "$NOTEFILE" || echo "📜 brak historii"
      }

      sys-save-os(){
        echo "⚙️ build..."
        sudo nixos-rebuild switch --flake /etc/nixos#desktop || { echo "❌ FAIL"; return; }
        git add -A
        git commit -m "os $(date +%F_%H-%M) - $*" && git push
        echo "🚀 snapshot → $*"
      }

      nss(){ sys-save-os "$*"; }

      ns(){
        sys-note "$*"
        echo "⚙️ snapshot → $*"
        nss "$*"
      }

      sys-status(){
        echo "===== SYSTEM STATUS ====="
        echo
        echo "Uptime:"; uptime | sed 's/^/  /'; echo
        echo "Disk /:"; df -h / | sed '1d;s/^/  /'; echo
        echo "Repo:"; if [ -z "$(git -C /etc/nixos status --porcelain)" ]; then echo "  CLEAN ✔"; else echo "  DIRTY ✖"; fi; echo
        echo "Last snapshots:"; git -C /etc/nixos log --oneline -7 | sed 's/^/  /'; echo
        echo "System generations:"; sudo nix-env --list-generations --profile /nix/var/nix/profiles/system | tail -n 7 | sed 's/^/  /'; echo
        echo "Home generations:"; home-manager generations | head -n 5 | sed 's/^/  /'; echo
        echo "Garbage (dry-run):"; nix-collect-garbage -d --dry-run | sed 's/^/  /'; echo
      }
    '';

    };
  };
}


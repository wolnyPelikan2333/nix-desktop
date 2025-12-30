{ config, pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    dotDir = "${config.xdg.configHome}/zsh";
    defaultKeymap = "viins";

    sessionVariables = {
      MPC_HOST = "127.0.0.1";
      MPC_PORT = "6600";
    };

    history = {
      path = "$HOME/.config/zsh/.zsh_history";
      size = 50000;
      save = 50000;
      share = true;
      ignoreDups = true;
      extended = true;
    };

    # ==========================================================
    # HOME MANAGER — JEDYNE MIEJSCE NA ZSH
    # ==========================================================
    initContent = ''
      # ----------------------------------------------------------
      # PODSTAWY
      # ----------------------------------------------------------
      autoload -Uz colors
      colors
      
            # ==========================================================
      # PROMPT — SYGNAŁ STANU REPO (/etc/nixos)
      # ==========================================================

      nix_repo_hint() {
        case "$PWD" in
          /etc/nixos* ) ;;
          * ) return ;;
        esac

        local hint=""

        status=$(git -C /etc/nixos status --porcelain 2>/dev/null)
        if [ -n "$status" ]; then
          hint="✖"
        fi

        if git -C /etc/nixos rev-list --count @{u}..HEAD >/dev/null 2>&1; then
          if [ "$(git -C /etc/nixos rev-list --count @{u}..HEAD)" -gt 0 ]; then
            hint="$hint↑"
          fi
        fi

        if [ -n "$hint" ]; then
          echo " [$hint]"
        fi
      }

            PROMPT=$'\n%{\e[38;5;220m%}%~%{\e[0m%}$(nix_repo_hint)\n%{\e[38;5;81m%}❯%{\e[0m%} '



      setopt APPEND_HISTORY
      setopt INC_APPEND_HISTORY
      setopt HIST_REDUCE_BLANKS
      setopt HIST_SAVE_NO_DUPS

          # ==========================================================
    # SESJA — START (orientacja, zero automatyki)
    # ==========================================================
    
      sesja-start() {
        echo "🧭 START SESJI"
        echo

        if [ -f /etc/nixos/SESJE/AKTYWNA.md ]; then
          echo "📄 Źródło startu:"
          echo "  → /etc/nixos/SESJE/AKTYWNA.md"
          echo
          nvim /etc/nixos/SESJE/AKTYWNA.md
        else
          echo "📄 Źródło startu:"
          echo "  → /etc/nixos/docs/SESJA.md"
          echo
          nvim /etc/nixos/docs/SESJA.md
        fi
      }
    
             # ==========================================================
    # SYSTEM STATUS — MINI RAPORT (B)
    # ==========================================================
    sys-status() {
      echo "===== SYSTEM STATUS ====="
      echo

      echo "📊 Uptime:"
      uptime | sed 's/^/  /'
      echo

      echo "💾 Disk /:"
      df -h / | sed '1d;s/^/  /'
      echo

      echo "🔐 Repo (/etc/nixos):"

      # licznik zmian
      local modified untracked
      modified=$(git -C /etc/nixos status --porcelain | grep -c '^ M')
      untracked=$(git -C /etc/nixos status --porcelain | grep -c '^??')

      if [ "$modified" -eq 0 ] && [ "$untracked" -eq 0 ]; then
        echo "  Stan: CLEAN ✔"
      else
        echo "  Stan: DIRTY ✖"
        echo "  Zmiany:"
        echo "    M  $modified   (zmodyfikowane)"
        echo "    ?? $untracked   (nieśledzone)"
      fi

      # ahead / behind (bez fetch)
      local ahead behind
      ahead=$(git -C /etc/nixos rev-list --count @{u}..HEAD 2>/dev/null || echo 0)
      behind=$(git -C /etc/nixos rev-list --count HEAD..@{u} 2>/dev/null || echo 0)

      echo
      echo "  Commit:"
      echo "    ahead: $ahead   behind: $behind"

      # ostatni commit
      echo
      echo "  Ostatni commit:"
      git -C /etc/nixos log -1 --pretty='  %h  "%s"' 2>/dev/null
      echo
    }


      # ----------------------------------------------------------
      # ALIASY
      # ----------------------------------------------------------
      alias w='w3m'
      alias nixman='w3m https://nixos.org/manual/nixos/stable/'
      alias nixerr='less /etc/nixos/docs/ściągi/nix/nix-build-errors.md'
      alias st='sys-status'


      # ----------------------------------------------------------
      # NSS — WRAPPER
      # ----------------------------------------------------------
      nss() {
        /etc/nixos/scripts/nss-safe "$@"
      }
    '';
  };
}


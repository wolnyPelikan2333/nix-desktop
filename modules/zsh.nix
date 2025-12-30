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

      PROMPT=$'\n%{\e[38;5;220m%}%~%{\e[0m%}\n%{\e[38;5;81m%}❯%{\e[0m%} '

      setopt APPEND_HISTORY
      setopt INC_APPEND_HISTORY
      setopt HIST_REDUCE_BLANKS
      setopt HIST_SAVE_NO_DUPS

          # ==========================================================
    # SESJA — START (orientacja, zero automatyki)
    # ==========================================================
    ''
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
    ''


      # ----------------------------------------------------------
      # ALIASY
      # ----------------------------------------------------------
      alias w='w3m'
      alias nixman='w3m https://nixos.org/manual/nixos/stable/'
      alias nixerr='less /etc/nixos/docs/ściągi/nix/nix-build-errors.md'

            # ----------------------------------------------------------
      # NSS — WRAPPER
      # ----------------------------------------------------------
      nss() {
        /etc/nixos/scripts/nss-safe "$@"
      }
    '';
  };
}


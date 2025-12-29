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

    # ==========================================================
    # HISTORIA — STABILNA, BEZ KORUPCJI
    # ==========================================================
    history = {
      path = "$HOME/.config/zsh/.zsh_history";
      size = 50000;
      save = 50000;
      share = true;
      ignoreDups = true;
      extended = true;
    };

    # ==========================================================
    # INIT CONTENT — TYLKO STRINGI (mkMerge)
    # ==========================================================
    initContent = lib.mkMerge [

      ''
        autoload -Uz colors
        colors

        PROMPT=$'\n%{\e[38;5;220m%}%~%{\e[0m%}\n%{\e[38;5;81m%}❯%{\e[0m%} '

        setopt APPEND_HISTORY
        setopt INC_APPEND_HISTORY
        setopt HIST_REDUCE_BLANKS
        setopt HIST_SAVE_NO_DUPS

        alias w='w3m'
        alias nixman='w3m https://nixos.org/manual/nixos/stable/'
        alias nixerr='less /etc/nixos/docs/ściągi/nix/nix-build-errors.md'
      ''

      ''
        unalias ns 2>/dev/null
        unalias nss 2>/dev/null
        unalias sys-status 2>/dev/null
        unalias nh-menu 2>/dev/null
        unalias g3 2>/dev/null
        unalias g5 2>/dev/null
      ''

      ''
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
      ''

      ''
        sesja-start() {
          echo "$(date '+%F %H:%M')" > /tmp/sesja.start
          echo "🟢 Start: $(cat /tmp/sesja.start)"
          echo
          git -C /etc/nixos status
          echo
          nvim /etc/nixos/SESJE/AKTYWNA.md
        }
      ''

      ''
        nss() {
          /etc/nixos/scripts/nss-safe "$@"
        }
      ''
    ];

    # ==========================================================
    # INTERACTIVE SHELL INIT — NixOS (TU MA BYĆ NSS-DOC)
    # ==========================================================
    interactiveShellInit = ''
      nss-doc() {
        nvim /etc/nixos/docs/ściągi/nix/nss.md
      }
    '';
  };
}


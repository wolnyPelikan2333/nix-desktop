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
    initExtra = ''
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

      # ----------------------------------------------------------
      # ALIASY
      # ----------------------------------------------------------
      alias w='w3m'
      alias nixman='w3m https://nixos.org/manual/nixos/stable/'
      alias nixerr='less /etc/nixos/docs/ściągi/nix/nix-build-errors.md'

      # ----------------------------------------------------------
      # NSS — DOKUMENTACJA
      # ----------------------------------------------------------
      nss-doc() {
        nvim /etc/nixos/docs/ściągi/nix/nss.md
      }

      # ----------------------------------------------------------
      # NSS — WRAPPER
      # ----------------------------------------------------------
      nss() {
        /etc/nixos/scripts/nss-safe "$@"
      }
    '';
  };
}


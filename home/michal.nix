{ config, pkgs, ... }:

{
 imports = [
    ./modules/packages.nix
  ];


  home.username = "michal";
  home.homeDirectory = "/home/michal";


  xdg.configFile."wezterm/wezterm.lua".text = ''
local wezterm = require "wezterm"
local config = {}
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 14
config.color_scheme = "Dracula"
config.hide_tab_bar_if_only_one_tab = true
config.leader = { key="Space", mods="CTRL", timeout_milliseconds=800 }
return config
'';

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    dotDir = "${config.xdg.configHome}/zsh";

    initContent = ''
      unalias ns 2>/dev/null
      unalias nss 2>/dev/null

      NOTEFILE="$HOME/.config/nixos-notes.log"
      sys-note(){ mkdir -p "$HOME/.config"; echo "$(date '+%F %H:%M') — $*" >> "$NOTEFILE"; }
      sys-history(){ [ -f "$NOTEFILE" ]&&nl -ba "$NOTEFILE"||echo "📜 no history"; }

      sys-save-os(){
        cd /etc/nixos||return
        sudo nixos-rebuild switch --flake /etc/nixos#desktop || return
        git add -A
        git commit -m "os $(date +%F_%H-%M) - $*" && git push
      }
      nss(){ sys-save-os "$*"; }

      sys-status(){
        local G="\033[32m";local R="\033[31m";local B="\033[34m";local X="\033[0m"
        echo -e "''${B}===== STATUS =====''${X}"
        uptime
      }

      ns(){ sys-note "$*"; echo "⚙️ → $*"; nss "$*"; }
    '';
  };

  programs.fzf.enable = true;
  programs.bat.enable = true;
  programs.eza.enable = true;

  home.stateVersion = "25.05";
}

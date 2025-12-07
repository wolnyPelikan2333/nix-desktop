{ config, pkgs, ... }:

{
  home.username = "michal";
  home.homeDirectory = "/home/michal";

  home.packages = with pkgs; [
    neovim btop fastfetch wezterm pkgs.nerd-fonts.jetbrains-mono copyq
    lutris wineWowPackages.full winetricks protontricks mangohud gamemode steam-run
    gimp-with-plugins gmic imagemagick libwebp libheif libraw openexr jasper libavif
    inkscape krita
  ];

  ##############################################
  # WezTerm — działający czysty config + skróty
  ##############################################
    xdg.configFile."wezterm/wezterm.lua" = {
    force = true;
    text = ''
      local wezterm = require "wezterm"
      local config = {}

      config.font = wezterm.font("JetBrainsMono Nerd Font")
      config.font_size = 14.0
      config.color_scheme = "Dracula"
      config.hide_tab_bar_if_only_one_tab = true

      config.leader = { key="Space", mods="CTRL", timeout_milliseconds=800 }

      config.keys = {
        {key="v", mods="LEADER", action=wezterm.action.SplitVertical{domain="CurrentPaneDomain"}},
        {key="s", mods="LEADER", action=wezterm.action.SplitHorizontal{domain="CurrentPaneDomain"}},
        {key="x", mods="LEADER", action=wezterm.action.CloseCurrentPane{confirm=true}},

        {key="h", mods="LEADER", action=wezterm.action.ActivatePaneDirection "Left"},
        {key="j", mods="LEADER", action=wezterm.action.ActivatePaneDirection "Down"},
        {key="k", mods="LEADER", action=wezterm.action.ActivatePaneDirection "Up"},
        {key="l", mods="LEADER", action=wezterm.action.ActivatePaneDirection "Right"},
      }

      return config
    '';
  };

  #####################################################################
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    dotDir = "${config.xdg.configHome}/zsh";

    shellAliases = {
      nhs = "nh os switch /etc/nixos#desktop";
      ll = "eza -al --icons";
      clean-system = "sudo nix-collect-garbage -d && sudo nix store optimise";
    };

    history = { size = 50000; save = 50000; share = true; };

    #################################################################
    initContent = ''
      unalias ns 2>/dev/null
      unalias nss 2>/dev/null
      zstyle ":completion:*" menu yes select

      _sys_cd_etc_nixos(){ cd /etc/nixos || { echo "❌ brak repo"; return 1;} }

      ########################################################
      NOTEFILE="$HOME/.config/nixos-notes.log"

      sys-note(){
        mkdir -p "$HOME/.config"
        echo "$(date '+%F %H:%M') — $*" >> "$NOTEFILE"
        echo "📝 $*"
      }

      sys-history(){ [ -f "$NOTEFILE" ] && nl -ba "$NOTEFILE" || echo "📜 brak historii"; }

      ########################################################
      sys-save-os(){
        _sys_cd_etc_nixos || return
        echo "⚙️ build..."
        sudo nixos-rebuild switch --flake /etc/nixos#desktop || { echo "❌ FAIL"; return;}
        git add -A
        git commit -m "os $(date +%F_%H-%M) - $*" && git push
        echo "🚀 snapshot → $*"
      }

      nss(){ sys-save-os "$*"; }

      ########################################################
      ns(){
        sys-note "$*"
        echo "⚙️ snapshot → $*"
        nss "$*"
      }

      ########################################################
      ########################################################
       ########################################
      # SYS-STATUS PRO — wersja czysta, bez kolorów
      ########################################
      sys-status() {
        echo "========== SYSTEM STATUS =========="

        echo "Uptime:"
        uptime | sed 's/^/  /'
        echo

        echo "Dysk root (/):"
        df -h / | sed '1d;s/^/  /'
        echo

        echo "Repo /etc/nixos:"
        _sys_cd_etc_nixos || return
        if [ -z "$(git status --porcelain)" ]; then
          echo "  ✔ CLEAN (brak lokalnych zmian)"
        else
          echo "  ✖ DIRTY — masz lokalne zmiany"
        fi
        echo

        echo "Ostatnie snapshoty:"
        git --no-pager log --oneline -7 | sed 's/^/  /'
        echo

        echo "Generacje systemu:"
        sudo nix-env --list-generations --profile /nix/var/nix/profiles/system | tail -n 8 | sed 's/^/  /'
        echo

        echo "Generacje Home-Manager:"
        if command -v home-manager >/dev/null; then
          home-manager generations | head -n 5 | sed 's/^/  /'
        else
          nix run home-manager/master -- generations | head -n 5 | sed 's/^/  /'
        fi
        echo

        echo "Garbage dry-run (co zostanie usunięte):"
        nix-collect-garbage -d --dry-run 2>/dev/null | sed 's/^/  /' || echo "  brak danych"
        echo

        echo "Rekomendacja:"
        if [ -z "$(git status --porcelain)" ]; then
          echo "  ✔ repo czyste – możesz pracować dalej"
        else
          echo "  ➤ użyj:  ns \"opis\"  aby zrobić snapshot + push"
        fi
       echo "==================================="
      }
    '';
  };

  programs.fzf.enable = true;
  programs.eza.enable = true;
  programs.bat.enable = true;

  home.stateVersion = "25.05";
}
 

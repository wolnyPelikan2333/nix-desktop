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
  # WezTerm – pełna konfiguracja + Twoje skróty
  ##############################################
  xdg.configFile."wezterm/wezterm.lua".text = ''
  local wezterm = require "wezterm"
  local config = {}

  -- ====== Wygląd ======
  config.font = wezterm.font_with_fallback({
    "JetBrainsMono Nerd Font",
    "Monospace",
})
  config.font_size = 14.0
  config.color_scheme = "Dracula"
  config.window_decorations = "RESIZE"
  config.window_padding = { left = 3, right = 3, top = 1, bottom = 1 }
  config.hide_tab_bar_if_only_one_tab = true
  config.use_fancy_tab_bar = true
  config.scrollback_lines = 5000

  -- ====== Leader ======
  config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 800 }

  config.keys = {
  -- SPLIT
  { key = "v", mods = "LEADER", action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" } },
  { key = "s", mods = "LEADER", action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" } },

  -- NAWIGACJA
  { key = "h", mods = "LEADER", action = wezterm.action.ActivatePaneDirection "Left" },
  { key = "j", mods = "LEADER", action = wezterm.action.ActivatePaneDirection "Down" },
  { key = "k", mods = "LEADER", action = wezterm.action.ActivatePaneDirection "Up" },
  { key = "l", mods = "LEADER", action = wezterm.action.ActivatePaneDirection "Right" },

  -- RESIZE
  { key = "H", mods = "LEADER", action = wezterm.action.AdjustPaneSize { "Left", 5 } },
  { key = "J", mods = "LEADER", action = wezterm.action.AdjustPaneSize { "Down", 5 } },
  { key = "K", mods = "LEADER", action = wezterm.action.AdjustPaneSize { "Up", 5 } },
  { key = "L", mods = "LEADER", action = wezterm.action.AdjustPaneSize { "Right", 5 } },

  -- ZOOM + FULLSCREEN
  { key = "z", mods = "LEADER", action = wezterm.action.TogglePaneZoomState },
  { key = "f", mods = "LEADER", action = wezterm.action.ToggleFullScreen },

  -- COPY/PASTE
  { key = "c", mods = "LEADER", action = wezterm.action.CopyTo "Clipboard" },
  { key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom "Clipboard" },

  -- TABS
  { key = "1", mods = "LEADER", action = wezterm.action.ActivateTab(0) },
  { key = "2", mods = "LEADER", action = wezterm.action.ActivateTab(1) },
  { key = "3", mods = "LEADER", action = wezterm.action.ActivateTab(2) },
  { key = "4", mods = "LEADER", action = wezterm.action.ActivateTab(3) },
}
 return config
 '';

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
      sys-status(){
        echo "===== STATUS ====="
        uptime
      }
    '';
  };

  programs.fzf.enable = true;
  programs.eza.enable = true;
  programs.bat.enable = true;

  home.stateVersion = "25.05";
}


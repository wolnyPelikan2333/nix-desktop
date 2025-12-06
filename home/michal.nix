{ config, pkgs, ... }:

{
  home.username = "michal";
  home.homeDirectory = "/home/michal";

  ##############################################
  # Programy instalowane przez Home-Managera
  ##############################################
  home.packages = with pkgs; [
    # --- DEV / CLI ---
    neovim
    btop
    fastfetch
    wezterm
    pkgs.nerd-fonts.jetbrains-mono
    copyq
    # --- GAMING ---
    lutris
    wineWowPackages.full
    winetricks
    protontricks
    mangohud
    gamemode
    steam-run

    # --- GIMP Pro Pack ---
    gimp-with-plugins

    # Plugins do GIMP (testowane na nixos-25.05)
    gmic
     # gimpPlugins.resynthesizer
     # gimpPlugins.lqr-plugin
     # gimpPlugins.gimplensfun
     
    # Format support & tools
    libwebp libheif libraw imagemagick openexr jasper libavif

    # Extra graphics
    inkscape
    krita
  ];

##############################################
# WezTerm – pełna konfiguracja + Twoje skróty
##############################################
xdg.configFile."wezterm/wezterm.lua".text = ''
local wezterm = require 'wezterm'
local config = {}

------------------------------------------------------------
-- Wygląd
------------------------------------------------------------
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 12.0
config.color_scheme = "Dracula"
config.hide_tab_bar_if_only_one_tab = true

------------------------------------------------------------
-- Skróty – LEVEL A (stabilne podstawy)
------------------------------------------------------------
config.disable_default_key_bindings = true

config.keys = {
  -- SPLITS
  {key="v", mods="ALT", action=wezterm.action.SplitVertical{domain="CurrentPaneDomain"}},
  {key="s", mods="ALT", action=wezterm.action.SplitHorizontal{domain="CurrentPaneDomain"}},

  -- RUCH
  {key="h", mods="ALT", action=wezterm.action.ActivatePaneDirection "Left"},
  {key="j", mods="ALT", action=wezterm.action.ActivatePaneDirection "Down"},
  {key="k", mods="ALT", action=wezterm.action.ActivatePaneDirection "Up"},
  {key="l", mods="ALT", action=wezterm.action.ActivatePaneDirection "Right"},

  -- RESIZE
  {key="h", mods="CTRL", action=wezterm.action.AdjustPaneSize {"Left", 3}},
  {key="j", mods="CTRL", action=wezterm.action.AdjustPaneSize {"Down", 3}},
  {key="k", mods="CTRL", action=wezterm.action.AdjustPaneSize {"Up", 3}},
  {key="l", mods="CTRL", action=wezterm.action.AdjustPaneSize {"Right", 3}},

  -- ZOOM + FULLSCREEN
  {key="z", mods="ALT", action=wezterm.action.TogglePaneZoomState},
  {key="f", mods="ALT", action=wezterm.action.ToggleFullScreen},

  -- COPY/PASTE
  {key="C", mods="CTRL|SHIFT", action=wezterm.action.CopyTo "Clipboard"},
  {key="V", mods="CTRL|SHIFT", action=wezterm.action.PasteFrom "Clipboard"},

  -- TABS ALT+1..4
  {key="1", mods="ALT", action=wezterm.action.ActivateTab(0)},
  {key="2", mods="ALT", action=wezterm.action.ActivateTab(1)},
  {key="3", mods="ALT", action=wezterm.action.ActivateTab(2)},
  {key="4", mods="ALT", action=wezterm.action.ActivateTab(3)},
}

return config
'';
    ##############################################
  # ZSH + snapshot manager
  ##############################################
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    dotDir = "${config.xdg.configHome}/zsh";

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 50000;
      save = 50000;
      share = true;
      expireDuplicatesFirst = true;
    };

    plugins = [
      { name = "zsh-history-substring-search"; src = pkgs.zsh-history-substring-search; }
      { name = "zsh-fzf-tab"; src = pkgs.zsh-fzf-tab; }
    ];

    shellAliases = {
      nhs = "nh os switch /etc/nixos#desktop";
      ll = "eza -al --icons";
      clean-system = "sudo nix-collect-garbage -d && sudo nix store optimise";
      clean-weekly = "sudo nix-env --delete-generations +7 && sudo nix-collect-garbage -d";
    };

    initContent = ''
      zstyle ":completion:*" menu yes select
      zstyle ":fzf-tab:*" switch-group "," "."
      bindkey "^[[A" history-substring-search-up
      bindkey "^[[B" history-substring-search-down

      _sys_cd_etc_nixos() {
        cd /etc/nixos || { 
          echo "❌ brak repo /etc/nixos"; 
          return 1; 
        }
      }

      sys-save() {
        _sys_cd_etc_nixos || return
        git add -A
        local msg="$*"
        [ -z "$msg" ] && read "msg?Opis snapshotu: "
        git commit -m "snapshot $(date +%F_%H-%M) - $msg" && git push
        echo "📦 snapshot zapisany → $msg"
      }

      sys-save-os() {
        local msg="$*"
        _sys_cd_etc_nixos || return
        echo "⚙️ buduję system..."
        sudo nixos-rebuild switch --flake /etc/nixos#desktop || { echo "❌ build fail"; return; }
        git add -A
        [ -z "$msg" ] && read "msg?Opis snapshotu: "
        git commit -m "os $(date +%F_%H-%M) - $msg" && git push
        echo "🚀 OS snapshot zapisany → $msg"
      }
            sys-list() {
        _sys_cd_etc_nixos || return
        git --no-pager log --graph --oneline --decorate --date=format:'%F %H:%M'
      }

      sys-compare() {
        _sys_cd_etc_nixos || return
        if [ "$1" = "last" ]; then
          local a=$(git log --pretty=%h -n1)
          local b=$(git log --pretty=%h -n2 | tail -n1)
          echo "🔍 diff: $b ↔ $a"; git diff "$b" "$a"; return
        fi
        [ $# -ge 2 ] && git diff "$1" "$2" || git diff "$1" HEAD
      }

      sys-rollback() {
        _sys_cd_etc_nixos || return
        local t="$1"
        [ "$t" = "pick" ] && t=$(git log --oneline | fzf | awk '{print $1}')
        [ -z "$t" ] && { echo "❌ anulowano"; return; }
        git checkout "$t"
        nh os switch /etc/nixos#desktop
        echo "🔙 cofnięto → $t"
      }

      nss() { sys-save-os "$*"; }

      unalias ns 2>/dev/null
      alias ns="nss"
    '';
  };
 
      
############################################
programs.fzf.enable = true;
programs.bat.enable = true;
programs.eza.enable = true;

##############################################
home.stateVersion = "25.05";

##############################################
home.sessionVariables.TEST_NS = "works";
home.sessionVariables.SNAPSHOT_TEST = "ok";

}


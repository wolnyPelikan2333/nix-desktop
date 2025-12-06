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

-- Wyłączamy wszystkie domyślne skróty WezTerm
config.disable_default_key_bindings = true

------------------------------------------------------------
-- Wygląd
------------------------------------------------------------
config.font = wezterm.font_with_fallback({
  "JetBrainsMono Nerd Font",
  "Noto Color Emoji",
})
config.font_size = 12.0
config.color_scheme = "Dracula"
config.hide_tab_bar_if_only_one_tab = true

------------------------------------------------------------
-- Skróty klawiszowe – Tiling Mode (Hybryda bez Super)
------------------------------------------------------------
config.keys = {

  ------------------------------------------------------------
  -- SPLITS (Alt + v/s)
  ------------------------------------------------------------
  {key = "v", mods = "ALT",
    action = wezterm.action.SplitVertical{domain = "CurrentPaneDomain"}
  },
  {key = "s", mods = "ALT",
    action = wezterm.action.SplitHorizontal{domain = "CurrentPaneDomain"}
  },

  ------------------------------------------------------------
  -- RUCH (Alt + h/j/k/l)
  ------------------------------------------------------------
  {key = "h", mods = "ALT", action = wezterm.action.ActivatePaneDirection "Left"},
  {key = "j", mods = "ALT", action = wezterm.action.ActivatePaneDirection "Down"},
  {key = "k", mods = "ALT", action = wezterm.action.ActivatePaneDirection "Up"},
  {key = "l", mods = "ALT", action = wezterm.action.ActivatePaneDirection "Right"},

  ------------------------------------------------------------
  -- ZMIANA ROZMIARU (Ctrl + h/j/k/l)
  ------------------------------------------------------------
  {key = "h", mods = "CTRL", action = wezterm.action.AdjustPaneSize {"Left", 3}},
  {key = "j", mods = "CTRL", action = wezterm.action.AdjustPaneSize {"Down", 3}},
  {key = "k", mods = "CTRL", action = wezterm.action.AdjustPaneSize {"Up", 3}},
  {key = "l", mods = "CTRL", action = wezterm.action.AdjustPaneSize {"Right", 3}},

  ------------------------------------------------------------
  -- ZAMYKANIE PANELU (Alt + q / Alt + x)
  ------------------------------------------------------------
  -- Z potwierdzeniem
  {key = "q", mods = "ALT",
    action = wezterm.action.CloseCurrentPane{confirm = true}
  },

  -- Bez potwierdzenia (szybkie kill-pane)
  {key = "x", mods = "ALT",
    action = wezterm.action.CloseCurrentPane{confirm = false}
  },

  ------------------------------------------------------------
  -- FULLSCREEN (alt+f)
  ------------------------------------------------------------
  {key = "f", mods = "ALT",
    action = wezterm.action.TogglePaneZoomState
  },

  ------------------------------------------------------------
  -- COPY / PASTE (Ctrl+Shift+C/V)
  ------------------------------------------------------------
  {key = "C", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo "Clipboard"},
  {key = "V", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom "Clipboard"},
}

------------------------------------------------------------
-- 🎛 LEVEL 2 – Borders, padding, taby, dodatkowe skróty
------------------------------------------------------------
config.window_padding = { left = 3, right = 3, top = 3, bottom = 3 }

config.window_frame = {
  active_titlebar_bg = "#44475a",
}

config.colors = {
  split = "#ff79c6", -- kolor borderów (zastępuje focused/inactive)
}

config.enable_tab_bar = true

-- 🔥 Nowe keybindy
table.insert(config.keys, { key="z", mods="ALT", action=wezterm.action.TogglePaneZoomState })

table.insert(config.keys, { key="LeftArrow",  mods="ALT|SHIFT", action=wezterm.action.ActivatePaneDirection "Left" })
table.insert(config.keys, { key="RightArrow", mods="ALT|SHIFT", action=wezterm.action.ActivatePaneDirection "Right" })
table.insert(config.keys, { key="UpArrow",    mods="ALT|SHIFT", action=wezterm.action.ActivatePaneDirection "Up" })
table.insert(config.keys, { key="DownArrow",  mods="ALT|SHIFT", action=wezterm.action.ActivatePaneDirection "Down" })

table.insert(config.keys, { key="1", mods="ALT", action=wezterm.action.ActivateTab(0) })
table.insert(config.keys, { key="2", mods="ALT", action=wezterm.action.ActivateTab(1) })
table.insert(config.keys, { key="3", mods="ALT", action=wezterm.action.ActivateTab(2) })
table.insert(config.keys, { key="4", mods="ALT", action=wezterm.action.ActivateTab(3) })

return config
'';
  ##############################################
  # ZSH
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
    nhs = "nh os switch /etc/nixos#desktop";   # fallback
    ll = "eza -al --icons";
    clean-system = "sudo nix-collect-garbage -d && sudo nix store optimise";
    clean-weekly = "sudo nix-env --delete-generations +7 && sudo nix-collect-garbage -d";
    ns = "ns";   # <-- alias wskazuje na funkcję z initContent
  };

  ## 🔥 tu funkcja nhs() z auto-commit + push
  initContent = ''
    nhs() {
      cd /etc/nixos || return
      nh os switch /etc/nixos#desktop
      if [[ $? -eq 0 ]]; then
        git add -A
        if ! git diff --cached --quiet; then
          git commit -m "nh update $(date +%F_%H-%M)"
          git push
        fi
      fi
    }

    zstyle ':completion:*' menu yes select
    zstyle ':fzf-tab:*' switch-group ',' '.'
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
      
      # -------------------------------------------------------
      # 🔥 System Snapshot Manager PRO
      # -------------------------------------------------------

      _sys_cd_etc_nixos() {
        cd /etc/nixos || { echo "❌ Brak /etc/nixos"; return 1; }
      }

      sys-status() {
        _sys_cd_etc_nixos || return
        echo "📂 Repo: /etc/nixos"
        git status -sb
        echo; echo "🕒 Ostatnie snapshoty:"
        git --no-pager log -n 5 --pretty=format:'%C(yellow)%h%Creset | %Cgreen%ad%Creset | %s' --date=format:'%F %H:%M'
      }

      sys-save() {
        _sys_cd_etc_nixos || return
        git add -A
        if git diff --cached --quiet; then
          echo "⚠️ Brak zmian — snapshot pominięty."
          return
        fi
        local msg="$*"
        [ -z "$msg" ] && read "msg?Opis snapshotu: "
        git commit -m "snapshot $(date +%F_%H-%M) - $msg" && git push
        echo "📦 Snapshot zapisany: $msg"
      }

      sys-save-os() {
        local msg="$*"
        _sys_cd_etc_nixos || return
        echo "🛠 Buduję system..."
        sudo nixos-rebuild switch --flake /etc/nixos#desktop || {
          echo "❌ Build nieudany — snapshot anulowany."
          return
        }
        git add -A
        if git diff --cached --quiet; then
          echo "⚠️ System zbudowany — brak zmian."
          return
        fi
        [ -z "$msg" ] && read "msg?Opis snapshotu: "
        git commit -m "os $(date +%F_%H-%M) - $msg" && git push
        echo "🚀 System zapisany + wypchnięty."
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
          echo "🔍 Porównuję: $b ↔ $a"; git diff "$b" "$a"; return
        fi
        case "$#" in
          1) echo "🔍 Porównuję: $1 ↔ HEAD"; git diff "$1" HEAD;;
          2) echo "🔍 Porównuję: $1 ↔ $2"; git diff "$1" "$2";;
          *) echo "Użycie: sys-compare <commit1> <commit2> | <commit> | last";;
        esac
      }

      sys-rollback() {
        _sys_cd_etc_nixos || return
        local t="$1"
        if [ "$t" = "pick" ]; then
          t=$(git log --oneline | fzf | awk '{print $1}')
        fi
        [ -z "$t" ] && { echo "⛔ anulowano"; return; }
        git checkout "$t"
        nh os switch /etc/nixos#desktop
        echo "🔙 Przywrócono snapshot: $t"
      }

      # -------------------------------------------------------
      # 🔥 NS PRO → rebuild + snapshot z opisem
      # -------------------------------------------------------
      ns() {
        local msg="$*"
        if [ -z "$msg" ]; then
          read "msg?Opis snapshotu: "
        fi
        sys-save-os "$msg"
      }
  '';

};
 

  ##############################################
  programs.fzf.enable = true;
  programs.bat.enable = true;
  programs.eza.enable = true;

  ##############################################
  home.stateVersion = "25.05";
  ##############################################
  home.sessionVariables.TEST_NS = "works";
  home.sessionVariables.SNAPSHOT_TEST = "ok";

}

# test

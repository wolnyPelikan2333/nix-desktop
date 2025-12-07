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
local wezterm = require "wezterm"
local config = {}

------------------------------------------------------------
-- Wygląd
------------------------------------------------------------
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 14.0
config.color_scheme = "Dracula"
config.hide_tab_bar_if_only_one_tab = true

------------------------------------------------------------
-- ✨ Tryb LEADER (bez konfliktów z KDE)
------------------------------------------------------------
-- config.disable_default_key_bindings = true
config.leader = { key="Space", mods="CTRL", timeout_milliseconds=800 }

config.keys = {
  -- SPLIT
  {key="v", mods="LEADER", action=wezterm.action.SplitVertical{domain="CurrentPaneDomain"}},
  {key="s", mods="LEADER", action=wezterm.action.SplitHorizontal{domain="CurrentPaneDomain"}},

  -- NAWIGACJA
  {key="h", mods="LEADER", action=wezterm.action.ActivatePaneDirection "Left"},
  {key="j", mods="LEADER", action=wezterm.action.ActivatePaneDirection "Down"},
  {key="k", mods="LEADER", action=wezterm.action.ActivatePaneDirection "Up"},
  {key="l", mods="LEADER", action=wezterm.action.ActivatePaneDirection "Right"},

  -- RESIZE
  {key="H", mods="LEADER", action=wezterm.action.AdjustPaneSize {"Left", 5}},
  {key="J", mods="LEADER", action=wezterm.action.AdjustPaneSize {"Down", 5}},
  {key="K", mods="LEADER", action=wezterm.action.AdjustPaneSize {"Up", 5}},
  {key="L", mods="LEADER", action=wezterm.action.AdjustPaneSize {"Right", 5}},

  -- ZOOM / FULLSCREEN
  {key="z", mods="LEADER", action=wezterm.action.TogglePaneZoomState},
  {key="f", mods="LEADER", action=wezterm.action.ToggleFullScreen},

  -- COPY/PASTE
  {key="c", mods="LEADER", action=wezterm.action.CopyTo "Clipboard"},
  {key="v", mods="CTRL|SHIFT", action=wezterm.action.PasteFrom "Clipboard"},

  -- TABS
  {key="1", mods="LEADER", action=wezterm.action.ActivateTab(0)},
  {key="2", mods="LEADER", action=wezterm.action.ActivateTab(1)},
  {key="3", mods="LEADER", action=wezterm.action.ActivateTab(2)},
  {key="4", mods="LEADER", action=wezterm.action.ActivateTab(3)},
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
      unalias ns 2>/dev/null
      unalias nss 2>/dev/null
      setopt no_aliases
      zstyle ":completion:*" menu yes select
      zstyle ":fzf-tab:*" switch-group "," "."
      bindkey "^[[A" history-substring-search-up
      bindkey "^[[B" history-substring-search-down

      _sys_cd_etc_nixos() {
        cd /etc/nixos || { echo "❌ brak repo /etc/nixos"; return 1; }
      }

      ########################################
      # Git + Snapshot manager
      ########################################

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

      nss() { sys-save-os "$*"; }

      ########################################
      # SNAPSHOT DIFF / HISTORY / NOTEBOOK
      ########################################

      NOTEFILE="$HOME/.config/nixos-notes.log"

      sys-note() {
        mkdir -p "$HOME/.config"
        echo "$(date '+%F %H:%M') — $*" >> "$NOTEFILE"
        echo "📝 Notatka zapisana → $*"
      }

      sys-history() {
        [ -f "$NOTEFILE" ] && nl -ba "$NOTEFILE" || echo "📜 brak historii — użyj sys-note"
      }

      sys-diff() { _sys_cd_etc_nixos && git --no-pager diff; }

      sys-compare-last() {
        cd /etc/nixos || return
        local a=$(git log --pretty=%h -n1)
        local b=$(git log --pretty=%h -n2 | tail -n1)
        echo "🔍 diff $b ↔ $a"
        git diff "$b" "$a"
      }

      ########################################
      # ROLLBACK / PANIC / RECOVERY
      ########################################

      sys-abort() { cd /etc/nixos && git restore . && echo "🧹 lokalne zmiany cofnięte"; }

      sys-abort-hard() {
        cd /etc/nixos || return
        read "ok?⚠️ przywrócić origin/master? (y/N): "
        [[ "$ok" == "y" ]] || { echo "❌ anulowano"; return; }
        git fetch && git reset --hard origin/master
        echo "🔄 repość cofnięte 1:1 do GitHub"
      }

      sys-undo-last() { cd /etc/nixos && git reset --hard HEAD~1 && echo "↩️ cofnąłem ostatni commit"; }

      ########################################
      # SYS-STATUS v2
      ########################################

      sys-status() {
        echo "========== 🖥 System Status =========="
        echo "--- Uptime ---"; uptime
        echo "--- Disk ---"; df -h / | sed 1d

        echo "--- Git ---"
        _sys_cd_etc_nixos
        if [ -z "$(git status --porcelain)" ]; then echo "📁 CLEAN"; else echo "📁 DIRTY"; fi

        echo "--- Snapshots (git) ---"; git --no-pager log --oneline -5

        echo "--- System Generations ---"
        sudo nix-env --list-generations --profile /nix/var/nix/profiles/system | tail -n 10

        echo "--- Home Generations ---"
        if command -v home-manager >/dev/null 2>&1; then
          home-manager generations | head -n 5
        else
          nix run home-manager/master -- generations | head -n 5
        fi

        echo "--- GC dry-run ---"; nix-collect-garbage -d --dry-run 2>/dev/null
        echo "======================================"
      }

      sys-status-full() {
        sys-status
        echo "--- FULL GIT LOG ---"; git --no-pager log --graph --decorate --all --oneline -20
        echo "--- DISK ---"; df -h
        echo "--- ALL HOME GENERATIONS ---"
        if command -v home-manager >/dev/null 2>&1; then home-manager generations
        else nix run home-manager/master -- generations
        fi
      }

      ########################################
      # ns = notatka + build + snapshot
      ########################################

      unalias ns 2>/dev/null
      ns() {
        sys-note "$*"
        echo "⚙️ buduję → $*"
        nss "$*"
     }
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


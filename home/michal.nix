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
      local act = wezterm.action
      local config = {}

      config.font = wezterm.font("JetBrainsMono Nerd Font")
      config.font_size = 14.0
      config.color_scheme = "Dracula"
      config.hide_tab_bar_if_only_one_tab = true

      -- Leader zmieniony na Ctrl+a (działa u Ciebie)
      config.leader = { key="a", mods="CTRL", timeout_milliseconds=2000 }

      config.keys = {
        -- 🧩 Splity
        {key="v", mods="LEADER", action=act.SplitVertical{domain="CurrentPaneDomain"}},
        {key="s", mods="LEADER", action=act.SplitHorizontal{domain="CurrentPaneDomain"}},

        -- 🧭 Ruch między panelami
        {key="h", mods="LEADER", action=act.ActivatePaneDirection "Left"},
        {key="j", mods="LEADER", action=act.ActivatePaneDirection "Down"},
        {key="k", mods="LEADER", action=act.ActivatePaneDirection "Up"},
        {key="l", mods="LEADER", action=act.ActivatePaneDirection "Right"},

        -- ❌ Zamknij panel
        {key="x", mods="LEADER", action=act.CloseCurrentPane{confirm=true}},   -- pyta przed zamknięciem
        {key="X", mods="LEADER", action=act.CloseCurrentPane{confirm=false}}, -- natychmiast (Shift+X)

        -- ➕ taby
        {key="t", mods="LEADER", action=act.SpawnTab "CurrentPaneDomain"},
        {key="w", mods="LEADER", action=act.CloseCurrentTab{confirm=true}},

        -- 🔥 Fullscreen
        {key="f", mods="LEADER", action="ToggleFullScreen"},
      }
      
   -- 🔥 Wymuszenie startu na monitorze Philips (HDMI-A-1 +0+0)
wezterm.on("gui-startup", function(cmd)
  local _, _, window = wezterm.mux.spawn_window(cmd or {})
  local gui = window:gui_window()

  -- czekamy aż okno wstanie, potem je przenosimy
  wezterm.sleep_ms(250)

  gui:set_position(0, 0)        -- Lewy ekran, Philips
  gui:set_inner_size(1800, 1000) -- Ustaw duże okno (pewne przeniesienie)
  -- jeżeli chcesz fullscreen zamiast window mode, powiem Ci poniżej
end)

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
      ll = "eza -al --icons";
      clean-system = "sudo nix-collect-garbage -d && sudo nix store optimise";
      clean-weekly = "sudo nix-env --delete-generations +7 && sudo nix-collect-garbage -d";
      sys-snapshots = "git -C /etc/nixos log --oneline --graph --decorate";   # ← DODANE
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
 sys-status
===== SYSTEM STATUS =====

Uptime:
   16:19:30  działa  5:42,  1 użytkownik,  średnie obciążenie: 0,98, 1,07, 1,03

Disk /:
  /dev/nvme0n1p1  424G   35G  368G   9% /

Repo status:
  CLEAN ✔

Last snapshots:
  2b652c1 os 2025-12-08_16-07 - wezterm force-philips
  938b375 os 2025-12-08_16-04 - wezterm philips
  a31a3c2 os 2025-12-08_16-02 - wezterm move to DP-1
  c4f4af3 os 2025-12-08_15-57 - wezterm move to DP-1
  4c79606 os 2025-12-08_15-54 - wezterm left monitor
  b8b18d8 os 2025-12-08_15-45 - wezterm update
  5676b39 os 2025-12-08_15-39 - wezterm update

System generations:
[sudo] hasło użytkownika michal:
    78   2025-12-08 15:39:05
    79   2025-12-08 15:45:48
    80   2025-12-08 15:54:33
    81   2025-12-08 15:57:18
    82   2025-12-08 16:02:35
    83   2025-12-08 16:04:43
    84   2025-12-08 16:07:06   (current)

Home generations:
  2025-12-04 22:51 : id 13 -> /nix/store/ml3plqs0bzjdw0i6sv4c4jf7ahycxdwm-home-manager-generation (current)

Garbage (dry-run):
removing old generations of profile /home/michal/.local/state/nix/profiles/profile
removing old generations of profile /home/michal/.local/state/nix/profiles/home-manager

Recommendation:
  Repo czyste — możesz działać dalej.
===================================
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
        echo "===== SYSTEM STATUS ====="
        echo
        echo "Uptime:"
        uptime | sed 's/^/  /'
        echo

        echo "Disk /:"
        df -h / | sed '1d;s/^/  /'
        echo

        _sys_cd_etc_nixos || return
        echo "Repo status:"
        if [ -z "$(git status --porcelain)" ]; then
          echo "  CLEAN ✔"
          CLEAN=true
        else
          echo "  DIRTY ✖ (masz zmiany)"
          CLEAN=false
        fi
        echo

        echo "Last snapshots:"
        git --no-pager log --oneline -7 | sed 's/^/  /'
        echo

        echo "System generations:"
        sudo nix-env --list-generations --profile /nix/var/nix/profiles/system | tail -n 7 | sed 's/^/  /'
        echo

        echo "Home generations:"
        if command -v home-manager >/dev/null; then
          home-manager generations | head -n 5 | sed 's/^/  /'
        else
          nix run home-manager/master -- generations | head -n 5 | sed 's/^/  /'
        fi
        echo

        echo "Garbage (dry-run):"
        nix-collect-garbage -d --dry-run | sed 's/^/  /' || echo "  brak danych"
        echo

        echo "Recommendation:"
        if [ "$CLEAN" = false ]; then
          echo "  Użyj → ns \"opis\"  (build + snapshot tylko jeśli OK)"
        else
          echo "  Repo czyste — możesz działać dalej."
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
 

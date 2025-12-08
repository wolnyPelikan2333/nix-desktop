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
    sys-snapshots = "git -C /etc/nixos log --oneline --graph --decorate";
  };

  history = { size = 50000; save = 50000; share = true; };

    initContent = ''
      # --- wyłącz alias ns z pluginów nix ---
      unalias ns 2>/dev/null || true
      unset -f ns 2>/dev/null || true
      unalias nss 2>/dev/null || true

      zstyle ":completion:*" menu yes select

      _sys_cd_etc_nixos(){ cd /etc/nixos || { echo "❌ brak repo"; return 1;} }

      NOTEFILE="$HOME/.config/nixos-notes.log"

      sys-note(){
        mkdir -p "$HOME/.config"
        echo "$(date '+%F %H:%M') — $*" >> "$NOTEFILE"
        echo "📝 $*"
      }

      sys-history(){ [ -f "$NOTEFILE" ] && nl -ba "$NOTEFILE" || echo "📜 brak historii"; }

      sys-save-os(){
        _sys_cd_etc_nixos || return
        echo "⚙️ build..."
        sudo nixos-rebuild switch --flake /etc/nixos#desktop || { echo "❌ FAIL"; return;}
        git add -A
        git commit -m "os $(date +%F_%H-%M) - $*" && git push
        echo "🚀 snapshot → $*"
      }

      nss(){ sys-save-os "$*"; }

      ns(){
        sys-note "$*"
        echo "⚙️ snapshot → $*"
        nss "$*"
      }

      sys-status(){
        echo "===== SYSTEM STATUS ====="
        echo
        echo "Uptime:"; uptime | sed 's/^/  /'; echo
        echo "Disk /:"; df -h / | sed '1d;s/^/  /'; echo
        _sys_cd_etc_nixos || return
        echo "Repo status:"; if [ -z "$(git status --porcelain)" ]; then echo "  CLEAN ✔"; CLEAN=true; else echo "  DIRTY ✖"; CLEAN=false; fi; echo
        echo "Last snapshots:"; git --no-pager log --oneline -7 | sed 's/^/  /'; echo
        echo "System generations:"; sudo nix-env --list-generations --profile /nix/var/nix/profiles/system | tail -n 7 | sed 's/^/  /'; echo
        echo "Home generations:"; home-manager generations | head -n 5 | sed 's/^/  /'; echo
        echo "Garbage (dry-run):"; nix-collect-garbage -d --dry-run | sed 's/^/  /'; echo
        echo "Recommendation:"; if [ "$CLEAN" = false ]; then echo "  Użyj → ns \"opis\""; else echo "  Repo czyste — możesz działać dalej."; fi
        echo "===================================" 
      }
  '';
};

  programs.fzf.enable = true;
  programs.eza.enable = true;
  programs.bat.enable = true;
  
   programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-systems 10 --keep-homes 10 --max-disk-usage 12G";
   }; 

  home.stateVersion = "25.05";
}
 

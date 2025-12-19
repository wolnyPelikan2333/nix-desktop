{ config, pkgs, ... }:

{
  programs.wezterm.enable = true;

  xdg.configFile."wezterm/wezterm.lua".text = ''
    local wezterm = require("wezterm")
    local act = wezterm.action

    local config = {}

    -- 🔤 font
    config.font = wezterm.font("JetBrainsMono Nerd Font")
    config.font_size = 14

    -- 🎨 styl
    config.color_scheme = "Dracula"
    config.hide_tab_bar_if_only_one_tab = true

    -- 🧠 Leader: Ctrl + A
    config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 800 }

    -- ⌨️ Skróty
    config.keys = {
      -- SPLITY
      -- Ctrl+A d  → split poziomy (w dół)
      { key = "d", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

      -- Ctrl+A s  → split pionowy (w bok)
      { key = "s", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },

      -- Ruch między panelami (tmux-style)
      { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
      { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
      { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
      { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },

      -- Nowa karta: Ctrl+A c
      { key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },

      -- Zamknij panel: Ctrl+A x
      { key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },

      -- Powiększ panel: Ctrl+A Space
      { key = " ", mods = "LEADER", action = act.TogglePaneZoomState },
    }

    return config
  '';
}


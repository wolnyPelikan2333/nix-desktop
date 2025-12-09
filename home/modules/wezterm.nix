{ config, pkgs, ... }:

{
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

      -- Leader: Ctrl+a (tak jak miałeś)
      config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }

      config.keys = {
        -- 🧩 Splity
        { key = "v", mods = "LEADER", action = act.SplitVertical{ domain = "CurrentPaneDomain" } },
        { key = "s", mods = "LEADER", action = act.SplitHorizontal{ domain = "CurrentPaneDomain" } },

        -- 🧭 Ruch między panelami
        { key = "h", mods = "LEADER", action = act.ActivatePaneDirection "Left" },
        { key = "j", mods = "LEADER", action = act.ActivatePaneDirection "Down" },
        { key = "k", mods = "LEADER", action = act.ActivatePaneDirection "Up" },
        { key = "l", mods = "LEADER", action = act.ActivatePaneDirection "Right" },

        -- ❌ Zamknięcie panela
        { key = "x", mods = "LEADER", action = act.CloseCurrentPane{ confirm = true } },
        { key = "X", mods = "LEADER", action = act.CloseCurrentPane{ confirm = false } },

        -- ➕ Taby
        { key = "t", mods = "LEADER", action = act.SpawnTab "CurrentPaneDomain" },
        { key = "w", mods = "LEADER", action = act.CloseCurrentTab{ confirm = true } },

        -- 🔥 Fullscreen
        { key = "f", mods = "LEADER", action = "ToggleFullScreen" },
      }

      -- 🔥 Start na monitorze Philips (lewym)
      wezterm.on("gui-startup", function(cmd)
        local _, _, window = wezterm.mux.spawn_window(cmd or {})
        local gui = window:gui_window()

        wezterm.sleep_ms(250)

        gui:set_position(0, 0)
        gui:set_inner_size(1800, 1000)
      end)

      return config
    '';
  };
}


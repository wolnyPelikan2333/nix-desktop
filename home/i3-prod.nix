{ config, pkgs, ... }:

{
  xsession = {
    enable = true;

    windowManager.i3 = {
      enable = true;

      config = {
        modifier = "Mod4";
        terminal = "wezterm";

        # minimalne, bezpieczne skróty
        keybindings = {
          "Mod4+Return" = "exec wezterm";
          "Mod4+Shift+q" = "kill";
          "Mod4+Shift+r" = "restart";
        };
      };
    };
  };
}


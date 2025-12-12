{ config, pkgs, ... }:

{
  # Pakiety potrzebne do i3
  home.packages = with pkgs; [
    rofi
    nitrogen
    dmenu
  ];

  xsession = {
    enable = true;

    windowManager.i3 = {
      enable = true;

      config = {
        modifier = "Mod4";
        terminal = "wezterm";

        keybindings = {
          "Mod4+Return" = "exec wezterm";
          "Mod4+d" = "exec rofi -show drun";
          "Mod4+Shift+q" = "kill";
          "Mod4+Shift+r" = "restart";
        };
      };
    };
  };
}


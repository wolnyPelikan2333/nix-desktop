{ config, pkgs, ... }:

{
imports = [
   ../modules/packages.nix
   ../modules/wezterm.nix
   ../modules/zsh.nix
   ../modules/my-aliases.nix
   ../modules/nvim.nix
 ];


  home.username = "michal";
  home.homeDirectory = "/home/michal";

 
  programs.fzf.enable = true;
  programs.bat.enable = true;
  programs.eza.enable = true;

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    home-manager
    rofi
    nitrogen
  ];

  # ==========================
  # I3 WINDOW MANAGER CONFIG
  # ==========================
  xsession = {
    enable = true;


    windowManager.i3 = {
      enable = true;

      config = {
        terminal = "wezterm";
        modifier = "Mod4";

        keybindings = {
          "Mod4+Return" = "exec wezterm";
          "Mod4+d" = "exec rofi -show drun";
          "Mod4+Shift+q" = "kill";

          "Mod4+Left" = "focus left";
          "Mod4+Down" = "focus down";
          "Mod4+Up" = "focus up";
          "Mod4+Right" = "focus right";

          "Mod4+Shift+Left" = "move left";
          "Mod4+Shift+Down" = "move down";
          "Mod4+Shift+Up" = "move up";
          "Mod4+Shift+Right" = "move right";

          "Mod4+Shift+r" = "restart";
          "Mod4+Shift+c" = "reload";
        };

        gaps = {
          inner = 10;
          outer = 10;
        };

        window.border = 2;
        floating.border = 2;

        startup = [
          { command = "nitrogen --restore"; }
        ];
      };
    };
  };

 

  home.stateVersion = "25.05";
}

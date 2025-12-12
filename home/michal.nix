{ config, pkgs, ... }:

{
  imports = [
    ./packages.nix
    ./wezterm.nix
    ./zsh.nix
    ./my-aliases.nix
    ./nvim.nix
  ];

  my.aliases.enable = true;

  home.username = "michal";
  home.homeDirectory = "/home/michal";

  programs.fzf.enable = true;
  programs.bat.enable = true;
  programs.eza.enable = true;

  home.packages = with pkgs; [
    home-manager
    rofi
    nitrogen
  ];

  xsession = {
    enable = true;

    windowManager.i3 = {
      enable = true;
    };
  };

  home.stateVersion = "25.05";
}


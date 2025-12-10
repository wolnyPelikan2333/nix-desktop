{ config, pkgs, ... }:

{
 imports = [
    ../modules/packages.nix
    ../modules/wezterm.nix
    ../modules/zsh.nix
    ../modules/my-aliases.nix
  ];


  home.username = "michal";
  home.homeDirectory = "/home/michal";

 
  programs.fzf.enable = true;
  programs.bat.enable = true;
  programs.eza.enable = true;

  programs.home-manager.enable = true;
  home.packages = [ pkgs.home-manager ];

  home.stateVersion = "25.05";
}

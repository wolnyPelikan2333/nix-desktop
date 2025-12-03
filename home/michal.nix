{ config, pkgs, ... }:

{
  home.username = "michal";
  home.homeDirectory = "/home/michal";

  home.packages = with pkgs; [
    neovim
    btop
    fastfetch
  ];

  programs.git.enable = true;

  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.enableLsColors = true;
  programs.zsh.dotDir = ".config/zsh";
  programs.zsh.enableAutosuggestions = true;
  programs.zsh.enableSyntaxHighlighting = true;
  programs.fzf.enable = true;
  programs.bat.enable = true;
  programs.eza.enable = true;

  programs.zsh.shellAliases = {
    ns = "nh os switch /etc/nixos#desktop";
    ll = "eza -al --icons";
  };

  home.stateVersion = "25.05";
}


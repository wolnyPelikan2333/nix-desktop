{ config, pkgs, ... }:

{
  home.username = "michal";
  home.homeDirectory = "/home/michal";

  # PROGRAMY TYLKO DLA CIEBIE
  home.packages = with pkgs; [
    neovim
    btop
    fastfetch
  ];

  # PODSTAWOWE MODUŁY HM
  programs.git.enable = true;
  programs.zsh.enable = true;
  programs.fzf.enable = true;
  programs.bat.enable = true;
  programs.eza.enable = true;

  # ALIASY (przykład)
  programs.zsh.shellAliases = {
    ns = "nh os switch /etc/nixos#desktop";
    ll = "eza -al --icons";
  };

  home.stateVersion = "25.05";
}


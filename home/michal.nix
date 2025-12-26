{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../modules/wezterm.nix
    ../modules/zsh.nix
    ../modules/my-aliases.nix

     ./zsh/core.nix
     ./zsh/vi-mode.nix
     ./zsh/vim-indicator.nix
     ./zsh/prompt.nix
  ];
  my.aliases.enable = true;

  home.username = "michal";
  home.homeDirectory = "/home/michal";

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };



  programs.fzf.enable = true;
  programs.bat.enable = true;
  programs.eza.enable = true;

  programs.zoxide = {
  enable = true;
  enableZshIntegration = true;
};


  programs.home-manager.enable = true;
  home.packages = [pkgs.home-manager];

   programs.zellij = {
    enable = true;
  };
  


  home.stateVersion = "25.05";
}

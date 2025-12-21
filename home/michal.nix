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

   xdg.configFile."nvim/init.lua".text = ''
  -- HM-managed Neovim bootstrap (DO NOT EDIT MANUALLY)

  -- 1. dodaj systemowy config do runtimepath
  vim.opt.runtimepath:prepend("/etc/nixos/modules/editors/nvim")

  -- 2. załaduj główny init.lua z /etc
  vim.cmd("source /etc/nixos/modules/editors/nvim/init.lua")
'';


  programs.fzf.enable = true;
  programs.bat.enable = true;
  programs.eza.enable = true;

  programs.home-manager.enable = true;
  home.packages = [pkgs.home-manager];

  home.stateVersion = "25.05";
}

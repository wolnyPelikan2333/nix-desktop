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
  ];
  my.aliases.enable = true;

  home.username = "michal";
  home.homeDirectory = "/home/michal";

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

    xdg.configFile."nvim/init.lua".text = ''
    -- bootstrap loader (HM-managed, read-only by design)
    vim.opt.runtimepath:prepend("/etc/nixos/modules/editors/nvim")
    require("init")
  '';


  programs.fzf.enable = true;
  programs.bat.enable = true;
  programs.eza.enable = true;

  programs.home-manager.enable = true;
  home.packages = [pkgs.home-manager];

  home.stateVersion = "25.05";
}

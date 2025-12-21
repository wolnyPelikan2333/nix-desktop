{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    plugins = with pkgs.vimPlugins; [
      nvim-treesitter
    ];

    extraLuaConfig = ''
      vim.opt.runtimepath:prepend("/etc/nixos/modules/editors/nvim")
      require("plugins.treesitter")
    '';
  };
}


{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    plugins = with pkgs.vimPlugins; [
      nvim-treesitter
    ];

    extraLuaConfig = ''
      vim.cmd("packadd nvim-treesitter")

      require("nvim-treesitter.configs").setup({
        ensure_installed = { "nix" },
        highlight = { enable = true },
      })
    '';
  };
}


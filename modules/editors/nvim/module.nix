{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    plugins = with pkgs.vimPlugins; [
      nvim-treesitter
    ];

    extraLuaConfig = ''
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "nix" },
        highlight = { enable = true },
      })
    '';
  };
}


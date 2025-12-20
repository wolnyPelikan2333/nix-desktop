{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # --- core ---
    neovim
    btop
    fastfetch
    wezterm
    copyq

    # --- CLI tools ---
    binutils
    ripgrep
    fd
    tree
    jq

     # --- Neovim plugins (pure Nix) ---
    vimPlugins.nvim-treesitter
    vimPlugins.nvim-lspconfig
    vimPlugins.nvim-cmp
    vimPlugins.cmp-nvim-lsp
    vimPlugins.nvim-autopairs
    vimPlugins.fzf-lua
    vimPlugins.nvim-web-devicons
  ];
}


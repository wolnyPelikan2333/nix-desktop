return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "nix",
        "javascript",
        "lua",
      },
      highlight = {
        enable = true,
      },
    })
  end,
}


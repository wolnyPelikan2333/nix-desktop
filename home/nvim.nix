{ config, pkgs, lib, ... }:

let
  # języki LSP
  lspServers = with pkgs; [
    lua-language-server
    nixd
    pyright
    rust-analyzer
    gopls
    nodePackages.typescript-language-server
  ];

  formatters = with pkgs; [
    stylua
    nixfmt-rfc-style
    black
    prettierd
  ];
in {

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = lspServers ++ formatters;

    plugins = with pkgs.vimPlugins; [
      plenary-nvim
      nvim-web-devicons

      nvim-treesitter
      nvim-treesitter-textobjects

      telescope-nvim
      telescope-fzf-native-nvim

      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      luasnip
      cmp_luasnip

      lualine-nvim
      catppuccin-nvim

      noice-nvim
      nui-nvim
      nvim-notify

      indent-blankline-nvim
      gitsigns-nvim

      nvim-autopairs
      comment-nvim

      conform-nvim
    ];

    extraConfig = ''
lua << EOF
-----------------------------------------------------------
-- Opcje podstawowe
-----------------------------------------------------------

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.colorcolumn = "80"

-----------------------------------------------------------
-- Indent guides
-----------------------------------------------------------
require("ibl").setup {
  indent = { char = "▏" },
  scope = { enabled = true },
}

-----------------------------------------------------------
-- Kolory + UI
-----------------------------------------------------------
require("catppuccin").setup({})
vim.cmd.colorscheme("catppuccin")

require("lualine").setup()
require("gitsigns").setup()
require("telescope").setup()
require("telescope").load_extension("fzf")

-----------------------------------------------------------
-- Treesitter
-----------------------------------------------------------
require("nvim-treesitter.configs").setup {
  ensure_installed = "all",
  highlight = { enable = true },
  indent = { enable = true },
}

-----------------------------------------------------------
-- LSP
-----------------------------------------------------------
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = {
  lua_ls = {},
  nixd = {},
  pyright = {},
  rust_analyzer = {},
  gopls = {},
  tsserver = {},
}

for server, cfg in pairs(servers) do
  lspconfig[server].setup {
    capabilities = capabilities,
    settings = cfg,
  }
end

-----------------------------------------------------------
-- Autopairs + CMP integracja
-----------------------------------------------------------
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local autopairs = require("nvim-autopairs")
autopairs.setup{}

-----------------------------------------------------------
-- Completion (CMP)
-----------------------------------------------------------
local cmp = require("cmp")

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

cmp.setup {
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<Tab>"]   = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<CR>"]    = cmp.mapping.confirm { select = true },
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
  },
}

-----------------------------------------------------------
-- Comment.nvim
-----------------------------------------------------------
require("Comment").setup()

-----------------------------------------------------------
-- FORMATERY (CONFORM)
-----------------------------------------------------------
require("conform").setup({
  format_on_save = true,
  formatters_by_ft = {
    lua = { "stylua" },
    nix = { "nixfmt" },
    python = { "black" },
    markdown = { "prettierd" },
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    json = { "prettierd" },
  },
})

-----------------------------------------------------------
-- Noice UX
-----------------------------------------------------------
require("notify").setup({
  stages = "fade",
  timeout = 2000,
})
require("noice").setup()

EOF
    '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}


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
in {

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = lspServers;

    plugins = with pkgs.vimPlugins; [
      # Podstawy
      plenary-nvim
      nvim-web-devicons

      # Treesitter
      nvim-treesitter
      nvim-treesitter-textobjects

      # File finding / fuzzy
      telescope-nvim
      telescope-fzf-native-nvim

      # LSP & completion
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      luasnip
      cmp_luasnip

      # Statusline
      lualine-nvim

      # Kolory
      catppuccin-nvim

      # UX
      noice-nvim
      nui-nvim
      nvim-notify

      # Syntax
      indent-blankline-nvim

      # Git
      gitsigns-nvim
    ];

    extraConfig = ''
      lua << EOF
      require("catppuccin").setup({})
      vim.cmd.colorscheme("catppuccin")

      require("lualine").setup()

      require("gitsigns").setup()

      require("telescope").setup()
      require("telescope").load_extension("fzf")

      -- Treesitter
      require("nvim-treesitter.configs").setup {
        ensure_installed = "all",
        highlight = { enable = true },
        indent = { enable = true },
      }

      -- LSP
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local servers = { "lua_ls", "nixd", "pyright", "rust_analyzer", "gopls", "tsserver" }
      for _, s in ipairs(servers) do
        lspconfig[s].setup { capabilities = capabilities }
      end

      -- CMP
      local cmp = require("cmp")
      cmp.setup {
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = {
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        },
      }

      -- Noice (lepszy UX)
      require("notify").setup({
        stages = "fade",
        timeout = 2000
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


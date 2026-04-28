return {
  -- Mason: installs and manages LSP servers, linters, formatters
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {},
  },

  -- Bridge: auto-configures nvim-lspconfig for Mason-installed servers
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "pyright",      -- Python
        "clangd",       -- C/C++
        "gopls",        -- Go
        "lua_ls",       -- Lua (for editing this config)
        "bashls",       -- Bash
        "ts_ls",        -- TypeScript / JavaScript
        "marksman",     -- Markdown
      },
      automatic_installation = true,
    },
  },

  -- Mason extension for non-LSP tools (linters, formatters)
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "gopls",        -- Go LSP (here for eager install; also in mason-lspconfig)
        "shellcheck",   -- bash linter
        "shfmt",        -- bash formatter
        "ruff",         -- python linter + formatter
        "stylua",       -- lua formatter
        "eslint_d",     -- JS/TS linter
        "prettier",     -- JS/TS/JSON/CSS/YAML/Markdown formatter
        "clang-format", -- C/C++ formatter
      },
    },
  },

  -- Core LSP client configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "j-hui/fidget.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- Set capabilities globally; all servers inherit this automatically
      vim.lsp.config("*", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

      -- lua_ls: suppress "undefined global vim" warnings in nvim config
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace   = { checkThirdParty = false },
          },
        },
      })

      -- Servers with default config (lang-specific servers enabled in lang/*.lua)
      vim.lsp.enable({ "lua_ls", "marksman" })
    end,
  },

  -- Completion engine (replaces deoplete)
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp     = require("cmp")
      local luasnip = require("luasnip")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert({
          -- Tab: next item when menu open, expand/jump snippet, else literal tab
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),

          -- Shift-Tab: previous item or jump back in snippet
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<CR>"]  = cmp.mapping.confirm({ select = false }), -- confirm only explicit selection
          ["<C-Space>"] = cmp.mapping.complete(),              -- force-open menu
          ["<C-e>"] = cmp.mapping.abort(),                     -- close menu without confirming
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 10 },
          { name = "luasnip",  priority = 7 },
          { name = "buffer",   priority = 5 },
          { name = "path",     priority = 3 },
        }),
      })
    end,
  },
}

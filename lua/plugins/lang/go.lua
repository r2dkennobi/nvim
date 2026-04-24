return {
  -- vim-go kept for :GoRun, :GoTest, :GoBuild, :GoDebug
  -- LSP features disabled to avoid conflict with gopls via mason
  {
    "fatih/vim-go",
    ft = { "go" },
    config = function()
      -- Disable features handled by gopls via nvim-lspconfig
      vim.g.go_gopls_enabled        = 0
      vim.g.go_def_mapping_enabled  = 0
      vim.g.go_doc_keywordprg_enabled = 0
      vim.g.go_fmt_autosave         = 0  -- conform.nvim handles formatting

      -- Keep rich syntax highlighting and same-id highlighting
      vim.g.go_highlight_build_constraints = 1
      vim.g.go_highlight_extra_types       = 1
      vim.g.go_highlight_fields            = 1
      vim.g.go_highlight_functions         = 1
      vim.g.go_highlight_methods           = 1
      vim.g.go_highlight_operators         = 1
      vim.g.go_highlight_structs           = 1
      vim.g.go_highlight_types             = 1
      vim.g.go_auto_sameids                = 1
      vim.g.go_auto_type_info              = 1
    end,
  },

  -- gopls LSP config (installed via mason)
  {
    "neovim/nvim-lspconfig",
    opts = function(_, _)
      local lspconfig    = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      lspconfig.gopls.setup({
        capabilities = capabilities,
        settings = {
          gopls = {
            analyses  = { unusedparams = true },
            staticcheck = true,
          },
        },
      })
    end,
  },
}

return {
  -- pyright LSP (installed via mason)
  {
    "neovim/nvim-lspconfig",
    opts = function(_, _)
      local lspconfig    = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      lspconfig.pyright.setup({
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths  = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
      })
    end,
  },

  -- Virtualenv switcher: <Leader>lv to pick venv, pyright reloads automatically
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
    ft = "python",
    keys = {
      { "<Leader>lv", "<cmd>VenvSelect<CR>", desc = "Select Python venv" },
    },
    opts = { auto_refresh = true },
  },
}

return {
  -- pyright LSP (installed via mason)
  {
    "neovim/nvim-lspconfig",
    opts = function(_, _)
      vim.lsp.config("pyright", {
        settings = {
          python = {
            analysis = {
              typeCheckingMode      = "basic",
              autoSearchPaths       = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
      })
      vim.lsp.enable("pyright")
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

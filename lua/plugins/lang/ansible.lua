return {
  -- ansiblels LSP (installed via mason) + ansible-lint integration
  {
    "neovim/nvim-lspconfig",
    opts = function(_, _)
      vim.lsp.config("ansiblels", {
        settings = {
          ansible = {
            ansible    = { path = "ansible" },
            validation = { enabled = true, lint = { enabled = true, path = "ansible-lint" } },
          },
        },
      })
      vim.lsp.enable("ansiblels")
    end,
  },
}

return {
  -- ansiblels LSP (installed via mason) + ansible-lint integration
  {
    "neovim/nvim-lspconfig",
    opts = function(_, _)
      local lspconfig    = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      lspconfig.ansiblels.setup({
        capabilities = capabilities,
        settings = {
          ansible = {
            ansible    = { path = "ansible" },
            validation = { enabled = true, lint = { enabled = true, path = "ansible-lint" } },
          },
        },
      })
    end,
  },
}

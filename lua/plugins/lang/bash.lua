return {
  -- bashls LSP (installed via mason): completion, hover, go-to-definition for shell functions
  -- shellcheck runs as a diagnostic source through bashls
  -- shfmt wired into conform.nvim formatters_by_ft.sh
  {
    "neovim/nvim-lspconfig",
    opts = function(_, _)
      local lspconfig    = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      lspconfig.bashls.setup({
        capabilities = capabilities,
        filetypes = { "sh", "bash", "zsh" },
        settings = {
          bashIde = { shellcheckPath = "shellcheck" },
        },
      })
    end,
  },
}

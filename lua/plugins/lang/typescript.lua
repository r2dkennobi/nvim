return {
  -- ts_ls LSP for TypeScript/JavaScript (installed via mason)
  {
    "neovim/nvim-lspconfig",
    opts = function(_, _)
      local lspconfig    = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      lspconfig.ts_ls.setup({ capabilities = capabilities })

      -- eslint LSP: runs ESLint as a language server and auto-fixes on save
      lspconfig.eslint.setup({
        capabilities = capabilities,
        on_attach = function(_, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer  = bufnr,
            command = "EslintFixAll",
          })
        end,
      })
    end,
  },
}

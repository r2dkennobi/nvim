return {
  -- ts_ls LSP for TypeScript/JavaScript (installed via mason)
  {
    "neovim/nvim-lspconfig",
    opts = function(_, _)
      vim.lsp.config("ts_ls", {})

      -- eslint LSP: runs ESLint as a language server and auto-fixes on save
      vim.lsp.config("eslint", {
        on_attach = function(_, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer  = bufnr,
            command = "EslintFixAll",
          })
        end,
      })

      vim.lsp.enable({ "ts_ls", "eslint" })
    end,
  },
}

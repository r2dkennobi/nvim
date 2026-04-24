return {
  -- clangd LSP (installed via mason)
  -- Reads compile_commands.json from project root — no hardcoded include paths
  {
    "neovim/nvim-lspconfig",
    opts = function(_, _)
      local lspconfig    = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      lspconfig.clangd.setup({
        capabilities = capabilities,
        cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu" },
      })
    end,
  },
}

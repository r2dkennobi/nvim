return {
  -- clangd LSP (installed via mason)
  -- Reads compile_commands.json from project root — no hardcoded include paths
  {
    "neovim/nvim-lspconfig",
    opts = function(_, _)
      vim.lsp.config("clangd", {
        cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu" },
      })
      vim.lsp.enable("clangd")
    end,
  },
}

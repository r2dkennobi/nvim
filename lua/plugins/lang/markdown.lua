return {
  -- marksman LSP (installed via mason): link completion, document outline, [[wiki]] links
  {
    "neovim/nvim-lspconfig",
    opts = function(_, _)
      local lspconfig    = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      lspconfig.marksman.setup({ capabilities = capabilities })
    end,
  },
}
-- render-markdown.nvim: in plugins/editor.lua (ft = "markdown")
-- prettier:              in plugins/editor.lua conform formatters_by_ft.markdown
-- Treesitter parsers:    "markdown" + "markdown_inline" in plugins/treesitter.lua

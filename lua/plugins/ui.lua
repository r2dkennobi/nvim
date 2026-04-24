return {
  -- Colorscheme (replaces unmaintained vim-material-monokai)
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup({ theme = "wave" })
      vim.cmd("colorscheme kanagawa")
    end,
  },

  -- Kept as optional fallbacks
  { "jacoborus/tender.vim",  lazy = true },
  { "joshdick/onedark.vim",  lazy = true },

  -- Status line (replaces vim-airline)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "kanagawa",
        component_separators = { left = "", right = "" },
        section_separators   = { left = "", right = "" },
        globalstatus = true,
      },
      sections = {
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
      },
      extensions = { "fugitive", "oil", "lazy" },
    },
  },
}

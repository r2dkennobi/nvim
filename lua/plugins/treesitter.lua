return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua", "python", "go", "c", "cpp", "rust",
          "bash", "yaml", "toml", "json", "markdown", "markdown_inline",
          "html", "css", "javascript", "typescript", "tsx",
          "vim", "vimdoc",
        },
        highlight = { enable = true },
        indent    = { enable = true },

        -- Semantic text objects: vaf, vif, ]m, [m, etc.
        textobjects = {
          select = {
            enable    = true,
            lookahead = true,
            keymaps = {
              ["af"] = { query = "@function.outer", desc = "Around function" },
              ["if"] = { query = "@function.inner", desc = "Inside function" },
              ["ac"] = { query = "@class.outer",    desc = "Around class" },
              ["ic"] = { query = "@class.inner",    desc = "Inside class" },
              ["aa"] = { query = "@parameter.outer", desc = "Around argument" },
              ["ia"] = { query = "@parameter.inner", desc = "Inside argument" },
            },
          },
          move = {
            enable              = true,
            set_jumps           = true,
            goto_next_start     = { ["]m"] = "@function.outer", ["]c"] = "@class.outer" },
            goto_previous_start = { ["[m"] = "@function.outer", ["[c"] = "@class.outer" },
          },
        },
      })
    end,
  },

  -- Auto-close/rename HTML, JSX, TSX tags
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "javascript", "typescript", "javascriptreact", "typescriptreact", "xml" },
    opts = {},
  },
}

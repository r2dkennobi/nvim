return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    config = function()
      require("nvim-treesitter").install({
        "lua", "python", "go", "c", "cpp", "rust",
        "bash", "yaml", "toml", "json", "markdown", "markdown_inline",
        "html", "css", "javascript", "typescript", "tsx",
        "vim", "vimdoc",
      })

      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          pcall(vim.treesitter.start)
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })

      require("nvim-treesitter-textobjects").setup({
        select = { lookahead = true },
        move   = { set_jumps = true },
      })

      local sel  = require("nvim-treesitter-textobjects.select")
      local move = require("nvim-treesitter-textobjects.move")

      for _, m in ipairs({
        { "af", "@function.outer",  "Around function" },
        { "if", "@function.inner",  "Inside function" },
        { "ac", "@class.outer",     "Around class" },
        { "ic", "@class.inner",     "Inside class" },
        { "aa", "@parameter.outer", "Around argument" },
        { "ia", "@parameter.inner", "Inside argument" },
      }) do
        vim.keymap.set({ "x", "o" }, m[1], function()
          sel.select_textobject(m[2], "textobjects")
        end, { desc = m[3] })
      end

      vim.keymap.set("n", "]m", function() move.goto_next_start("@function.outer", "textobjects") end, { desc = "Next function" })
      vim.keymap.set("n", "]c", function() move.goto_next_start("@class.outer",    "textobjects") end, { desc = "Next class" })
      vim.keymap.set("n", "[m", function() move.goto_previous_start("@function.outer", "textobjects") end, { desc = "Prev function" })
      vim.keymap.set("n", "[c", function() move.goto_previous_start("@class.outer",    "textobjects") end, { desc = "Prev class" })
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "javascript", "typescript", "javascriptreact", "typescriptreact", "xml" },
    opts = {},
  },
}

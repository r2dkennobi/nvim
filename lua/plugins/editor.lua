return {
  -- File browser (replaces vim-filebeagle, keeps `-` mapping)
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = { { "-", "<cmd>Oil<CR>", desc = "Open parent directory" } },
    opts = { default_file_explorer = true },
  },

  -- Fuzzy finder (replaces fzf + fzf.vim), keeps <Leader>f/b/g
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = vim.fn.executable("make") == 1,
      },
    },
    keys = {
      { "<Leader>f", "<cmd>Telescope find_files<CR>",  desc = "Find files" },
      { "<Leader>b", "<cmd>Telescope buffers<CR>",     desc = "Buffers" },
      { "<Leader>g", "<cmd>Telescope live_grep<CR>",   desc = "Live grep" },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-t>"] = require("telescope.actions").select_tab,
              ["<C-u>"] = require("telescope.actions").select_horizontal,
              ["<C-h>"] = require("telescope.actions").select_vertical,
            },
          },
        },
      })
      telescope.load_extension("fzf")
    end,
  },

  -- Formatter (replaces F7 gg=G hack and ALE formatting)
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = {
      formatters_by_ft = {
        lua        = { "stylua" },
        python     = { "ruff_format", "ruff_fix" },
        go         = { "gofmt" },
        cpp        = { "clang_format" },
        c          = { "clang_format" },
        sh         = { "shfmt" },
        bash       = { "shfmt" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        json       = { "prettier" },
        yaml       = { "prettier" },
        css        = { "prettier" },
        markdown   = { "prettier" },
      },
      format_on_save = { timeout_ms = 500, lsp_fallback = true },
    },
  },

  -- Leader key popup
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup()
      wk.add({
        { "<Leader>l",  group = "LSP" },
        { "<Leader>lf", desc = "Format" },
        { "<Leader>lr", desc = "Rename" },
        { "<Leader>la", desc = "Code action" },
        { "<Leader>lv", desc = "Select Python venv" },
        { "<Leader>c",  group = "Claude / Terminal" },
        { "<Leader>cc", desc = "Claude Code float" },
      })
    end,
  },

  -- LSP progress spinner (shows "pyright indexing..." etc.)
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {},
  },

  -- Persistent embedded terminal (Ctrl+\ to toggle; <Leader>cc for Claude Code)
  {
    "akinsho/toggleterm.nvim",
    keys = { [[<C-\>]], "<Leader>cc" },
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<C-\>]],
        direction = "horizontal",
        shade_terminals = true,
      })
      local Terminal = require("toggleterm.terminal").Terminal
      local claude   = Terminal:new({ cmd = "claude", direction = "float", hidden = true })
      vim.keymap.set("n", "<Leader>cc", function() claude:toggle() end, { desc = "Claude Code" })
    end,
  },

  -- In-buffer markdown rendering (CLAUDE.md, READMEs, docs)
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft = { "markdown" },
    opts = {},
  },

  -- Motion (kept from easymotion)
  { "easymotion/vim-easymotion", event = "VeryLazy" },

  -- Tag browser
  { "majutsushi/tagbar", cmd = "TagbarToggle" },

  -- Grammar checker
  { "rhysd/vim-grammarous", cmd = "GrammarousCheck" },
}

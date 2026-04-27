return {
  -- Git signs in gutter (replaces vim-gitgutter)
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {
      signs = {
        add          = { text = "+" },
        change       = { text = "~" },
        delete       = { text = "_" },
        topdelete    = { text = "‾" },
        changedelete = { text = "~" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = function(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end
        map("n", "]c", gs.next_hunk,        "Next hunk")
        map("n", "[c", gs.prev_hunk,        "Prev hunk")
        map("n", "<Leader>gp", gs.preview_hunk, "Preview hunk")
        map("n", "<Leader>gb", gs.blame_line,   "Blame line")
      end,
    },
  },

  -- Git commands (:Git, :Gblame, :Gdiffsplit, etc.)
  { "tpope/vim-fugitive", cmd = { "Git", "Gblame", "Gdiffsplit", "Gread", "Gwrite" } },
}

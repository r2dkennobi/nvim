local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Filetype overrides
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.markdown", "*.mdown", "*.mkd", "*.md" },
  command = "set syntax=markdown",
})
autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.launch", command = "set syntax=xml" })
autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.jade",   command = "set syntax=jade" })
autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.rs",     command = "set syntax=rust filetype=rust" })
autocmd({ "BufRead", "BufNewFile" }, { pattern = { "*.s", "Makefile" }, command = "set noet sw=8 ts=8" })
autocmd({ "BufRead", "BufNewFile" }, { pattern = { "*.c", "*.cpp", "*.h", "*.hpp" }, command = "set et sw=2 ts=2" })
autocmd({ "BufRead", "BufNewFile" }, { pattern = { "*.java", "*.ml", "*.scala" }, command = "set et sw=4 ts=4" })
autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.conf", command = "set et sw=2 ts=2" })

autocmd("FileType", { group = augroup("ft_go",     { clear = true }), pattern = "go",     command = "set noet sw=4 ts=4 sts=4" })
autocmd("FileType", { group = augroup("ft_ruby",   { clear = true }), pattern = "ruby",   command = "set et sw=2 ts=2" })
autocmd("FileType", { group = augroup("ft_html",   { clear = true }), pattern = "html",   command = "set et sw=4 ts=4" })
autocmd("FileType", { group = augroup("ft_python", { clear = true }), pattern = "python", command = "set et sw=4 ts=4 cc=100" })
autocmd("FileType", { group = augroup("ft_sh",     { clear = true }), pattern = "sh",     command = "set et sw=2 ts=2" })

-- Relative number toggle on focus
local numtoggle = augroup("numbertoggle", { clear = true })
autocmd({ "BufEnter", "FocusGained", "InsertLeave" }, { group = numtoggle, command = "set relativenumber" })
autocmd({ "BufLeave", "FocusLost",   "InsertEnter"  }, { group = numtoggle, command = "set norelativenumber" })

-- Restore cursor position on file open
autocmd("BufReadPost", {
  group = augroup("file_restore", { clear = true }),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if vim.fn.expand("%") ~= ".git/COMMIT_EDITMSG" and mark[1] > 1 and mark[1] <= vim.fn.line("$") then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { import = "plugins.ui" },
  { import = "plugins.editor" },
  { import = "plugins.git" },
  { import = "plugins.treesitter" },
  { import = "plugins.syntax" },
  { import = "plugins.lsp" },
  { import = "plugins.lang.go" },
  { import = "plugins.lang.python" },
  { import = "plugins.lang.cpp" },
  { import = "plugins.lang.bash" },
  { import = "plugins.lang.typescript" },
  { import = "plugins.lang.markdown" },
}, {
  install = { colorscheme = { "kanagawa", "desert" } },
  checker  = { enabled = false },
  rocks    = { enabled = false },  -- no plugins need luarocks; avoids hererocks warning
})

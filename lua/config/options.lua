local opt = vim.opt

opt.number         = true
opt.relativenumber = true
opt.swapfile       = false
opt.expandtab      = true
opt.tabstop        = 2
opt.shiftwidth     = 2
opt.wildmenu       = true
opt.hlsearch       = false
opt.wildmode       = "longest:full,full"
opt.wildignore:append({ "*.swp", "*.bak", "*.dll", "*.o", "*.obj", "*.pyc", "*.exe",
                         "*.jpg", "*.gif", "*.png", "*.class", "*.ln" })
opt.listchars      = { tab = ">-", trail = "-", eol = "$", nbsp = "%" }
opt.colorcolumn    = "80"
opt.mouse          = "a"
opt.background     = "dark"
opt.termguicolors  = true
opt.ignorecase     = true
opt.smartcase      = true
opt.infercase      = true
opt.incsearch      = true
opt.list           = true

vim.g.loaded_matchparen = 1

-- Disable unused providers to suppress checkhealth warnings
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

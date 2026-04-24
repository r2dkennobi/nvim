local map = vim.keymap.set

-- Disable Ex mode and macro recording
map({ "n", "v" }, "Q", "<nop>")
map({ "n", "v" }, "q", "<nop>")

-- Copy current file path to clipboard
map("n", "cp", function() vim.fn.setreg("+", vim.fn.expand("%:p")) end)

-- Tab navigation
map("n", "H", "gT", { silent = true })
map("n", "L", "gt", { silent = true })

-- Plugin management (lazy.nvim replaces dein)
map("n", "<F2>", "<cmd>Lazy update<CR>", { silent = true })

-- File utilities
map("n", "<F3>", "<cmd>lcd %:p:h<CR>", { silent = true, desc = "cd to file dir" })
map("n", "<F5>", function()
  local save = vim.fn.getreg("/")
  vim.cmd([[%s/\s\+$//e]])
  vim.fn.setreg("/", save)
  vim.cmd("nohl")
end, { silent = true, desc = "Strip trailing whitespace" })
map("n", "<F6>", "<cmd>set hlsearch!<CR>", { silent = true, desc = "Toggle hlsearch" })
map("n", "<F7>", function() require("conform").format({ async = true }) end, { silent = true, desc = "Format file" })
map("n", "<F10>", "<cmd>set list!<CR>", { silent = true, desc = "Toggle listchars" })

-- Enhanced regex search
map("n", "/", "/\\v")

-- Window navigation
map("n", "<C-k>", "<cmd>wincmd k<CR>", { silent = true })
map("n", "<C-j>", "<cmd>wincmd j<CR>", { silent = true })
map("n", "<C-h>", "<cmd>wincmd h<CR>", { silent = true })
map("n", "<C-l>", "<cmd>wincmd l<CR>", { silent = true })
map("n", "<C-e>", "<cmd>wincmd R<CR>", { silent = true })

-- Window resizing / repositioning
map("n", "<Up>",    "<cmd>wincmd K<CR>", { silent = true })
map("n", "<Down>",  "<cmd>wincmd J<CR>", { silent = true })
map("n", "<Left>",  "<cmd>wincmd H<CR>", { silent = true })
map("n", "<Right>", "<cmd>wincmd L<CR>", { silent = true })

-- LSP diagnostics (replaces ALE <C-p>/<C-n>)
map("n", "<C-p>", vim.diagnostic.goto_prev, { silent = true, desc = "Previous diagnostic" })
map("n", "<C-n>", vim.diagnostic.goto_next, { silent = true, desc = "Next diagnostic" })

-- LSP actions (set on LspAttach so buffer-local)
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_keymaps", { clear = true }),
  callback = function(ev)
    local opts = { buffer = ev.buf, silent = true }
    map("n", "K",          vim.lsp.buf.hover,           vim.tbl_extend("force", opts, { desc = "Hover docs" }))
    map("n", "gd",         vim.lsp.buf.definition,      vim.tbl_extend("force", opts, { desc = "Go to definition" }))
    map("n", "gr",         vim.lsp.buf.references,      vim.tbl_extend("force", opts, { desc = "References" }))
    map("n", "<Leader>lr", vim.lsp.buf.rename,          vim.tbl_extend("force", opts, { desc = "Rename" }))
    map("n", "<Leader>la", vim.lsp.buf.code_action,     vim.tbl_extend("force", opts, { desc = "Code action" }))
    map("n", "<Leader>lf", function() require("conform").format({ async = true, lsp_fallback = true }) end,
      vim.tbl_extend("force", opts, { desc = "Format" }))
  end,
})

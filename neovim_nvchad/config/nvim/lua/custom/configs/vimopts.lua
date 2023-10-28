-- set number + relativenumber
vim.opt.nu = true
vim.opt.relativenumber = true
-- indentation options
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.autoread = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 5

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = "~/.vim/backups"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.updatetime = 50

-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })


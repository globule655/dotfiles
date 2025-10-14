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
vim.opt.scrolloff = 5

vim.opt.swapfile = false
vim.opt.backup = false

-- set undo dir depending on OS
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"

local backupdir = "/.vim/backups"
if is_windows then
  vim.opt.undodir = os.getenv("USERPROFILE") .. backupdir
else
  vim.opt.undodir = os.getenv("HOME") .. backupdir
end

vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.updatetime = 50

vim.opt.conceallevel = 2
vim.opt.laststatus = 3

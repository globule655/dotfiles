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

-- set backup dir depending on OS
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"

if is_windows then
  vim.opt.backupdir = os.getenv("USERPROFILE") .. "/AppData/Local/nvim/backups"
else
  vim.opt.undodir = os.getenv("HOME") .. "/.vim/backups"
end

vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.updatetime = 50


vim.keymap.set('n', '<leader>ht', '<CMD>ToggleTerm direction=horizontal<CR>', { desc = "ToggleTerm horizontal" })
vim.keymap.set('n', '<leader>vt', '<CMD>ToggleTerm direction=vertical size=50<CR>', { desc = "ToggleTerm vertical" })
vim.keymap.set('n', '<leader>ft', '<CMD>ToggleTerm direction=float<CR>', { desc = "ToggleTerm float" })
vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]])
vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]])
vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]])
vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]])
vim.keymap.set('t', '<esc>', [[<C-\><C-n>]])
vim.keymap.set('t', '<C-x>', [[<Cmd>ToggleTermToggleAll<CR>]])
vim.keymap.set('n', '<C-x>', [[<Cmd>ToggleTermToggleAll<CR>]])

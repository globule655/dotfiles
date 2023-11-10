vim.keymap.set('n', '<leader>n', "<cmd> set nu! <CR>", { desc = "Set line numbers" })
vim.keymap.set('n', '<leader>rn', "<cmd> set rnu! <CR>", { desc = "Set relative line numbers" })
vim.keymap.set('n', '<ESC>', ":noh <CR>", { desc = "Clear highlights" })
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = "Window left" })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = "Window down" })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = "Window up" })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = "Window right" })

vim.keymap.set('n', '<leader>fm', function()
  vim.lsp.buf.format { async = true }
end,
  { desc = "LSP formatting" })

vim.keymap.set('n', '<leader>x', "<cmd> bdelete <CR>", { desc = "Close buffer" })

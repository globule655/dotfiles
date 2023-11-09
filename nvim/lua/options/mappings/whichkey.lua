vim.keymap.set('n', '<leader>wK', function()
  vim.cmd "WhichKey"
end,
  { desc = "WhichKey all keymaps" })

vim.keymap.set('n', '<leader>wk', function()
  local input = vim.fn.input "WhichKey: "
  vim.cmd("WhichKey " .. input)
end,
  { desc = "WhichKey lookup" })

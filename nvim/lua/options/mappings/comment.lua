vim.keymap.set('v', '<leader>/', "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { desc = "Telescope find files"})

vim.keymap.set('v', '<leader>/', function()
  require("Comment.api").toggle.linewise.current()
end,
  { desc = "Toggle comment" })


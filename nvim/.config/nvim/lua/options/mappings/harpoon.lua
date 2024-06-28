vim.keymap.set("n", "<leader>mm", function ()
  require("harpoon.mark").add_file()
end, 
  { desc = "Harpoon add mark"})

vim.keymap.set("n", "<leader>mh", "<CMD>Telescope harpoon marks<CR>",
  { desc = "Harpoon toggle quick menu"})

vim.keymap.set('n', '<leader>,', function ()
  require("harpoon.ui").nav_prev()
end, { desc = "Harpoon previous mark" })

vim.keymap.set('n', '<leader>;', function ()
  require("harpoon.ui").nav_next()
end, { desc = "Harpoon next mark" })

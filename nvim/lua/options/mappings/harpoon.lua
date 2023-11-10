vim.keymap.set("n", "<leader>mm", function ()
  require("harpoon.mark").add_file()
end, 
  { desc = "Harpoon add mark"})

vim.keymap.set("n", "<leader>mh", function ()
  require("harpoon.ui").toggle_quick_menu()
end,
  { desc = "Harpoon toggle quick menu"})

vim.keymap.set('n', '<leader>,', function ()
  require("harpoon.ui").nav_prev()
end, { desc = "Harpoon previous mark" })

vim.keymap.set('n', '<leader>;', function ()
  require("harpoon.ui").nav_next()
end, { desc = "Harpoon next mark" })

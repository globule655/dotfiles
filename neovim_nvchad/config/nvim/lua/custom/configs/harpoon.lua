vim.keymap.set("n", "<leader>mm", function ()
  require("harpoon.mark").add_file()
end)

vim.keymap.set("n", "<leader>mh", function ()
  require("harpoon.ui").toggle_quick_menu()
end)

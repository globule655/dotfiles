vim.keymap.set("n", "<leader>go", function ()
  require("neogit").open({ cwd = "%:p:h" })
end, 
  { desc = "Open neogit"})

vim.keymap.set("n", "<leader>gc", function ()
  require("neogit").open({ "commit", cwd = "%:p:h" })
end, 
  { desc = "Open neogit commit popup"})

vim.keymap.set("n", "<leader>gs", function ()
  require("neogit").open({ kind = "split", cwd = "%:p:h" })
end, 
  { desc = "Open neogit with kind split"})


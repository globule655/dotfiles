vim.keymap.set("n", "<leader>go", function ()
  require("neogit").open()
end, 
  { desc = "Open neogit defaults"})

vim.keymap.set("n", "<leader>gc", function ()
  require("neogit").open({ "commit" })
end, 
  { desc = "Open neogit commit popup"})

vim.keymap.set("n", "<leader>gs", function ()
  require("neogit").open({ kind = "split" })
end, 
  { desc = "Open neogit with kind split"})

vim.keymap.set("n", "<leader>gh", function ()
  require("neogit").open({ cwd = "%:p:h" })
end, 
  { desc = "neogit open current buffer's repo"})


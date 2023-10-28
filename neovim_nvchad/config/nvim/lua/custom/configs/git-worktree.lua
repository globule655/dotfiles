vim.keymap.set("n", "<leader>gw", function ()
  require('telescope').extensions.git_worktree.git_worktrees()
end,
  { desc = "Telescope switch & delete worktrees"})

vim.keymap.set("n", "<leader>gc", function ()
  require('telescope').extensions.git_worktree.create_git_worktree()
end,
  { desc = "Telescope create worktree"})



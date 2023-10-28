vim.keymap.set("n", "<leader>gws", function ()
  require('telescope').extensions.git_worktree.git_worktrees()
end,
  { desc = "Telescope switch & delete worktrees"})

vim.keymap.set("n", "<leader>gwc", function ()
  require('telescope').extensions.git_worktree.create_git_worktree()
end,
  { desc = "Telescope create worktree"})



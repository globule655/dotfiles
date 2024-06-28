vim.keymap.set("n", "<leader>gwc", function ()
    require('telescope').extensions.git_worktree.create_git_worktree()
end,
  { desc = "Create new worktree"})

vim.keymap.set("n", "<leader>gws", function ()
  require('telescope').extensions.git_worktree.git_worktrees()
end,
  { desc = "Switch worktree"})


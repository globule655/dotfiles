vim.keymap.set("n", "<leader>gwc", function ()
  local path = vim.fn.input("Path: ")
  local branch = vim.fn.input("Branch: ")
  local upstream = vim.fn.input("upstream: ")
  require('git-worktree').create_worktree(path, branch, upstream)
end,
  { desc = "Create new worktree"})

vim.keymap.set("n", "<leader>gws", function ()
  local path = vim.fn.input("Path: ")
  require('git-worktree').switch_worktree(path)
end,
  { desc = "Switch worktree"})

vim.keymap.set("n", "<leader>gwd", function ()
  local path = vim.fn.input("Path: ")
  require('git-worktree').delete_worktree(path)
end,
  { desc = "Delete worktree"})


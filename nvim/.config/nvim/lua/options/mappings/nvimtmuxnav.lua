vim.g.tmux_navigator_no_mappings = 1
vim.g.tmux_navigator_save_on_switch = 1
vim.g.tmux_navigator_disable_when_zoomed = 1
vim.keymap.set({ 'n', 't' }, '<C-h>', ':TmuxNavigateLeft<CR>', { silent = true })
vim.keymap.set({ 'n', 't' }, '<C-j>', ':TmuxNavigateDown<CR>', { silent = true })
vim.keymap.set({ 'n', 't' }, '<C-k>', ':TmuxNavigateUp<CR>', { silent = true })
vim.keymap.set({ 'n', 't' }, '<C-l>', ':TmuxNavigateRight<CR>', { silent = true })

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Telescope find files"})
vim.keymap.set('n', '<leader>fw', builtin.live_grep, { desc = "Telescope live grep"})
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Telescope search buffers"})
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = "Telescope Open old files"})
vim.keymap.set('n', '<leader>fz', builtin.current_buffer_fuzzy_find, { desc = "Telescope search current buffer"})
vim.keymap.set('n', '<leader>th', '<CMD>Telescope themes<CR>', { desc = "Telescope themes"})
vim.keymap.set('n', '<leader>ma', '<CMD>Telescope marks<CR>', { desc = "Telescope marks"})
vim.keymap.set('n', '<leader>cm', '<CMD>Telescope git_commits<CR>', { desc = "Telescope git_commits"})
vim.keymap.set('n', '<leader>gt', '<CMD>Telescope git_status<CR>', { desc = "Telescope git_status"})
vim.keymap.set('n', '<leader>gb', '<CMD>Telescope git_branches<CR>', { desc = "Telescope git_branches"})

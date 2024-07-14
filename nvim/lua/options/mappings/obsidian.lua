vim.keymap.set({ 'n', 'v' }, '<leader>on', ':ObsidianTemplate note<CR>', { desc = 'Obsidian reformat file from note template'})
vim.keymap.set({ 'n', 'v' }, '<leader>ol', ':ObsidianLinkNew<CR>', { desc = 'Create New Link from selected text'})
vim.keymap.set({ 'n', 'v' }, '<leader>obl', ':ObsidianBackLink<CR>', { desc = 'Open Obsidian Backlink in Telescope'})

vim.keymap.set({ 'n', 'v' }, '<leader>on', ':ObsidianTemplate note<CR>', { desc = 'Obsidian reformat file from note template'})
vim.keymap.set({ 'n', 'v' }, '<leader>ot', ':ObsidianTemplate<CR>', { desc = 'Open Telescope to select template to reformat file from'})
vim.keymap.set({ 'n', 'v' }, '<leader>of', ':s/\\(# \\)[^_]*_/\\1/ | s/-/ /g<CR>', { desc = 'Obsidian reformat file from note template'})
vim.keymap.set({ 'n', 'v' }, '<leader>ol', ':ObsidianLinkNew<CR>', { desc = 'Create New Link from selected text'})
vim.keymap.set({ 'n', 'v' }, '<leader>bl', ':ObsidianBackLinks<CR>', { desc = 'Open Obsidian Backlink in Telescope'})

local gitsigns = require("gitsigns")
vim.keymap.set('n', '<leader>gb', function () gitsigns.blame_line{full=true} end, { desc = "Git blame line"})

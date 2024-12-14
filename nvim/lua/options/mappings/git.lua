local gitsigns = require("gitsigns")
vim.keymap.set('n', '<leader>bl', function () gitsigns.blame_line{full=true} end, { desc = "Git blame line"})

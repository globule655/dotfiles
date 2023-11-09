local api = require "nvim-tree.api"
local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
vim.keymap.set('n', '<C-n>', "<cmd> NvimTreeToggle <CR>", opts("Toggle nvim-tree") )
vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts("change_root_to_parent"))

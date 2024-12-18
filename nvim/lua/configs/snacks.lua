local snacksconfig = {

  opts = {
    bigfile = { enabled = true },
    input = { enabled = false },
    lazygit = { enabled = false },
    notifier = { enabled = false },
    notify = { enabled = false },
    quickfile = { enabled = true },
    scratch = { enabled = false },
    scroll = { enabled = true },
    zen = { enabled = true },
  },

  keys = {
    { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
    { "<leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
    { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    { "<leader>sb",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
  }

}

return snacksconfig

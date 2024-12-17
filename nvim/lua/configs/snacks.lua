local snacksconfig = {

  opts = {
    bigfile = { enabled = true },
    input = { enabled = true },
    lazygit = { enabled = true },
    notifier = { enabled = true },
    notify = { enabled = true },
    quickfile = { enabled = true },
    scratch = { enabled = true },
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

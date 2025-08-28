local snacksconfig = {

  opts = {
    bigfile = { enabled = true },
    lazygit = { enabled = true },
    image = { enabled = true },
    quickfile = { enabled = true },
    scroll = { enabled = true },
    zen = { enabled = true },
  },

  keys = {
    { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
    { "<leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
  }

}

return snacksconfig

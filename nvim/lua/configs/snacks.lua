local snacksconfig = {

  opts = {
    bigfile = { enabled = true },
    lazygit = { enabled = false },
    image = { enabled = true },
    quickfile = { enabled = true },
    scroll = { enabled = true },
    zen = { enabled = true },
  },

  keys = {
    { "<leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
  }

}

return snacksconfig

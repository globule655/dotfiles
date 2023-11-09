local blankline = {
  debounce = 100,
  indent = { char = "▏" },
  whitespace = { highlight = { "Whitespace", "NonText" } },
  exclude = {
    filetypes = {
      "help",
      "terminal",
      "lazy",
      "lspinfo",
      "TelescopePrompt",
      "TelescopeResults",
      "mason",
      "",
    },
  buftypes = { "terminal" },
  },
}

return blankline

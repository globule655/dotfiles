local lualine = {
  options = {
    theme = "auto",
  },
  -- sections = {
  --   lualine_x = {
  --     {
  --       require("noice").api.statusline.mode.get,
  --       cond = require("noice").api.statusline.mode.has,
  --       color = { fg = "#ff9e64" },
  --     }
  --   },
  -- },
  sections = {
      -- add to section of your choice
      lualine_c = { "macro_recording", "%S" },
    },
}

return lualine

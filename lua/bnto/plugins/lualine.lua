return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")

    lualine.setup({
      options = {
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        theme = "rose-pine",
      },
      sections = {
        lualine_a = {
          { "mode" },
        },
        lualine_c = {
          {
            "filename",
            path = 1,
          },
        },
        lualine_x = {
          { "encoding" },
          { "filetype" },
        },
        -- lualine_y = { "" },
        lualine_z = { "" },
      },
    })
  end,
}

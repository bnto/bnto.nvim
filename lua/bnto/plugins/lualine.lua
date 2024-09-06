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
          -- {
          --   "buffers",
          --   show_filename_only = true, -- Shows shortened relative path when set to false.
          --   hide_filename_extension = false, -- Hide filename extension when set to true.
          --   show_modified_status = true, -- Shows indicator when the buffer is modified.
          --   mode = 0, -- 0: Shows buffer name
          --   max_length = vim.o.columns * 2 / 3, -- Maximum width of buffers component,
          --   use_mode_colors = false,
          --   -- buffers_color = {
          --   --   active = "lualine_{section}_normal", -- Color for active buffer.
          --   --   inactive = "lualine_{section}_inactive", -- Color for inactive buffer.
          --   -- },
          --   symbols = {
          --     modified = " ●", -- Text to show when the buffer is modified
          --     alternate_file = "#", -- Text to show to identify the alternate file
          --     directory = "", -- Text to show when the buffer is a directory
          --   },
          -- },
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

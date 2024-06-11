return {

  -- set tokyonight colorscheme
  "folke/tokyonight.nvim",
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "storm",
      on_colors = function(colors)
        -- merge background with wezterm bg
        colors.bg = "#0B283A"
        colors.bg_sidebar = "#0B283A"
        colors.bg_highlight = "#0B283A"
        colors.bg_float = "#0B283A"
        -- Uncomment following for transparent backgrounds
        -- colors.bg = ""
        -- colors.bg_sidebar = ""
        -- colors.bg_float = ""
      end,
    })

    vim.cmd("colorscheme tokyonight")
  end,
}

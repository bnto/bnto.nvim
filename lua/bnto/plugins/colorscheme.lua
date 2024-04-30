return {

  -- set tokyonight colorscheme
  "folke/tokyonight.nvim",
  priority = 1000,
  config = function()
    
    require("tokyonight").setup({
      style = "storm",
      on_colors = function(colors)
        colors.bg = "#0B283A" -- merge background with wezterm bg
      end
    })

    vim.cmd("colorscheme tokyonight")
  end,

  -- set cobalt2 colorscheme
--  "lalitmee/cobalt2.nvim",
--  event = { "ColorSchemePre" },
--  dependencies = { "tjdevries/colorbuddy.nvim", tag = "v1.0.0" },
--  init = function()
--    require("colorbuddy").colorscheme("cobalt2")
--  end,
}

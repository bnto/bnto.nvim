return {
  "rose-pine/neovim",
  name = "rose-pine",
  config = function()
    require("rose-pine").setup({
      -- variant = "dawn",
      variant = "moon",
      -- dim_inactive_windows = true,
      styles = {
        transparency = true,
      },
    })
    -- vim.cmd("colorscheme rose-pine-dawn")
    vim.cmd("colorscheme rose-pine-moon")
  end,
}

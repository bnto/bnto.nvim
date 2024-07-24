return {
  "rose-pine/neovim",
  name = "rose-pine",
  config = function()
    require("rose-pine").setup({
      variant = "dawn",
      -- dim_inactive_windows = true,
      styles = {
        transparency = true,
      },
    })
    vim.cmd("colorscheme rose-pine-dawn")
  end,
}

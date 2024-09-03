return {
  "rose-pine/neovim",
  name = "rose-pine",
  config = function()
    require("rose-pine").setup({
      variant = "moon",
      dim_inactive_windows = false,
      styles = {
        transparency = true,
      },
      groups = {
        -- border = "love",
        panel = "love",
      },
      highlight_groups = {
        -- CurSearch = { fg = "base", bg = "text", inherit = false },
        -- Search = { fg = "text", bg = "text", blend = 20, inherit = false },
      },
    })

    vim.cmd.colorscheme("rose-pine-dawn")

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "rounded",
    })
  end,
}

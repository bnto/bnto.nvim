return {
  "rose-pine/neovim",
  name = "rose-pine",
  config = function()
    require("rose-pine").setup({
      dim_inactive_windows = false,
      styles = {
        transparency = true,
      },
      highlight_groups = {
        TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
      },
    })

    vim.cmd.colorscheme("rose-pine-dawn")

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "rounded",
    })
  end,
}

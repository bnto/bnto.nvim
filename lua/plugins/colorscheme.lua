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
        TelescopeSelection = { fg = "text", bg = "base" },
        TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
      },
    })

    vim.cmd.colorscheme("rose-pine-dawn")

    vim.cmd("highlight QuickFixLine guibg=#faf4ed ctermbg=none")
    vim.cmd("highlight QuickFixLine guifg=#d7827e ctermfg=none")
    vim.lsp.handlers["textDocument/hover"] =
      vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })
  end,
}

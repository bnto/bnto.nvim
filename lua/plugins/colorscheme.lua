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

  -- Rose-Pine-Dawn color codes
  --
  -- Base: #faf4ed
  -- Surface: #fffaf3
  -- Overlay: #f2e9e1
  -- Muted: #9893a5
  -- Subtle: #797593
  -- Text: #575279
  -- Love: #b4637a
  -- Gold: #ea9d34
  -- Rose: #d7827e
  -- Pine: #286983
  -- Foam: #56949f
  -- Iris: #907aa9
}

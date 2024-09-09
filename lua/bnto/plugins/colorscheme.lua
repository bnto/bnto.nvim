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

    -- ## base16 colors
    -- https://github.com/edunfelt/base16-rose-pine-scheme
    -- scheme = "Rosé Pine Dawn"
    -- base00 = "faf4ed"
    -- base01 = "fffaf3"
    -- base02 = "f2e9de"
    -- base03 = "9893a5"
    -- base04 = "797593"
    -- base05 = "575279"
    -- base06 = "575279"
    -- base07 = "cecacd"
    -- base08 = "b4637a"
    -- base09 = "ea9d34"
    -- base0A = "d7827e"
    -- base0B = "286983"
    -- base0C = "56949f"
    -- base0D = "907aa9"
    -- base0E = "ea9d34"
    -- base0F = "cecacd"

    vim.lsp.handlers["textDocument/hover"] =
      vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })
  end,
}

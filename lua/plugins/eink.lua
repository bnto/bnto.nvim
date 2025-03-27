return {
  -- E-ink colorscheme
  "alexxGmZ/e-ink.nvim",
  enabled = false,
  -- enabled = true,
  priority = 1000,
  config = function()
    require("e-ink").setup()
    -- vim.cmd.colorscheme("e-ink")
    vim.opt.background = "light"

    local set_hl = vim.api.nvim_set_hl
    local mono = require("e-ink.palette").mono()
    local everforest = require("e-ink.palette").everforest()

    set_hl(0, "Group", { fg = mono[15] })
    set_hl(0, "Group", { fg = everforest.green })
    set_hl(0, "Normal", { fg = mono[12], bg = "NONE" })

    set_hl(0, "QuickFixLine", { bg = "#faf4ed", ctermbg = "NONE"})
    set_hl(0, "QuickFixLine", { fg = "#d7827e", ctermfg = "NONE"})

    vim.lsp.handlers["textDocument/hover"] =
      vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })
  end,
}

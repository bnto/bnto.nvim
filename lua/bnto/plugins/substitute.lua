return {
  "gbprod/substitute.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()

    local substitute = require("substitute")
    substitute.setup()

    local keymap = vim.keymap
    vim.keymap.set("n", "s", substitute.operator)
    vim.keymap.set("n", "ss", substitute.line)
    vim.keymap.set("n", "S", substitute.eol)
    vim.keymap.set("x", "s", substitute.visual)
  end

}

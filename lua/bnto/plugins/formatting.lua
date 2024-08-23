return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")
    conform.setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        json = { "prettier" },
        markdown = { "prettier" },
        yaml = { "prettier" },
        lua = { "stylua" },
        python = { "black" },
      },
      -- format_on_save = {
      --   lsp_fallback = true,
      --   sync = false,
      --   timeout_ms = 1000,
      -- },
    })

    local keymap = vim.keymap
    keymap.set({ "n", "v" }, "<leader><leader>f", function()
      conform.format({
        lsp_fallback = true,
        sync = false,
        timeout_ms = 1000,
      })
    end)
  end,
}

return {
  "stevearc/aerial.nvim",
  opts = {},
  -- Optional dependencies
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("aerial").setup({
      -- optionally use on_attach to set keymaps when aerial has attached to a buffer
      on_attach = function()
        -- Jump forwards/backwards with '{' and '}'
        -- vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
        -- vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
      end,
      close_on_select = true,
      float = {
        relative = "win",
      },
      layout = {
        -- placement = "edge",
        -- default_direction = "prefer_left",
        -- max_width = nil,
        min_width = { 0.8 },
      },
      keymaps = {
        ["<space>"] = "actions.jump",
      },
    })

    vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle float<CR>")

  end,
}

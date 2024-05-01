return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    local treesitter = require("nvim-treesitter.configs")

    treesitter.setup({
      highlight = { enable = true },
      indent = { enable = true },
      autotag = { enable = true },

      -- language parsers:
      ensure_installed = {
        "json",
        "javascript",
        "typescript",
        "html",
        "css",
        "markdown",
        "markdown_inline",
        "bash",
        "lua",
        "vim",
        "dockerfile",
        "gitignore",
        "yaml",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          -- add keymapping here
          -- init_selection = "<C-space>",
          -- node_incremental = "<C-space>",
          -- scope_incremental = false,
        },
      },
    })
  end,
}

return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
      default_file_explorer = true,
      delete_to_trash = true,
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["<CR>"] = "actions.select",
        ["q"] = "actions.close",
      },
      float = {
        -- padding = 5,
        max_width = 50,
        border = "rounded",
      },
    })
  end,
}

return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local nvimtree = require("nvim-tree")

    -- bypass default file explorer
    -- vim.g.loaded_netrw = 1
    -- vim.g.loaded_netrwPlugin = 1

    nvimtree.setup({
      filters = {
        custom = { ".DS_Store", "node_modules" },
        dotfiles = false,
      },
      git = {
        ignore = false,
      },
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
      view = {
        float = {
          enable = true,
          quit_on_focus_loss = false,
          open_win_config = {
            relative = "editor",
            border = "rounded",
            width = 60,
            height = 30,
            row = 1,
            col = 1,
          },
        },
      },
    })

    -- vim.g.nvim_tree_ignore = { "node_modules" }

    -- set keymaps
    local keymap = vim.keymap

    keymap.set("n", "<leader>O", "<CMD>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer" })
  end,
}

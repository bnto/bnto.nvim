return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local nvimtree = require("nvim-tree")

    -- bypass default file explorer
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvimtree.setup({
      filters = {
        custom = { ".DS_Store", ".git" },
      },
      git = {
        ignore = false
      },
    })

    -- set keymaps
    local keymap = vim.keymap

    keymap.set("n", "<leader>b", "<CMD>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer" })
  end

}

return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
          },
        },
      },
    })

    telescope.load_extension("fzf")

    -- set keymaps
    vim.keymap.set("n", "<leader>f", "<CMD>Telescope find_files<CR>", { desc = "Find files in cwd" })
    vim.keymap.set("n", "<leader>F", "<CMD>Telescope live_grep<CR>", { desc = "Grep word in cwd" })

    -- other commands to consider keymapping:
    -- "Telescope oldfiles" - Find recent files
    -- "Telescope live_grep" - Find string in cwd
    -- "Telescope grep_string" - Find string under cursor in cwd
  end,
}

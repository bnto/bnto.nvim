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
            ["<esc>"] = actions.close, -- close telescope immediately
          },
        },
        file_ignore_patterns = {
          "node_modules",
          ".git",
        },
      },
      pickers = {
        find_files = {
          -- ignore_current_buffer = true,
          find_command = { "rg", "--files", "--sortr=modified" },
          hidden = true,
        },
        live_grep = {
          additional_args = function()
            return { "--hidden" }
          end,
        },
        buffers = {
          ignore_current_buffer = true,
          sort_lastused = true,
        },
      },
    })

    telescope.load_extension("fzf")

    -- set keymaps
    vim.keymap.set("n", "<leader>f", "<CMD>Telescope find_files<CR>") -- Find files in cwd
    vim.keymap.set("n", "<leader>F", "<CMD>Telescope live_grep<CR>") -- Grep word in cwd
    vim.keymap.set("n", "<leader>b", "<CMD>Telescope buffers<CR>") -- Show buffers
    vim.keymap.set("n", "<leader>B", "<CMD>Telescope oldfiles<CR>") -- Find in recent files
    vim.keymap.set("n", "<leader>p", "<CMD>Telescope registers<CR>") -- Show registers
    vim.keymap.set("n", "<leader>T", "<CMD>Telescope filetypes<CR>") -- Set filetype

    -- other commands to consider keymapping:
    -- "Telescope oldfiles" - Find recent files
    -- "Telescope live_grep" - Find string in cwd
    -- "Telescope grep_string" - Find string under cursor in cwd
  end,
}

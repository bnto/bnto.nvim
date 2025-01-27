return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local nvimtree = require("nvim-tree")

    -- bypass default file explorer
    -- vim.g.loaded_netrw = 1
    -- vim.g.loaded_netrwPlugin = 1

    local function my_on_attach(bufnr)
      local api = require("nvim-tree.api")

      local function opts(desc)
        return {
          desc = desc,
          buffer = bufnr,
          noremap = true,
          silent = true,
          nowait = true,
        }
      end

      -- default mappings
      api.config.mappings.default_on_attach(bufnr)

      -- custom mappings
      vim.keymap.set("n", "<space>", api.node.open.edit, opts("") )
      vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("") )
    end

    nvimtree.setup({
      on_attach = my_on_attach,
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
          quit_on_focus_loss = true,
          open_win_config = {
            relative = "editor",
            border = "rounded",
            width = 60,
            height = 45,
            row = 1,
            col = 1,
          },
        },
      },
    })

    -- vim.g.nvim_tree_ignore = { "node_modules" }

  end,
}

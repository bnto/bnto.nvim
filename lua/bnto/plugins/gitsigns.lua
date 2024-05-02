return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
      end

      -- git stage / unstage
      -- map("n", "<leader>gs", gs.stage_hunk, "Stage hunk")
      -- map("n", "<leader>gS", gs.reset_hunk("Unstage hunk"))

      -- map("v", "<leader>gs", function()
      --   gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      -- end, "Stage hunk")
      -- map("v", "<leader>gS", function()
      --   gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      -- end, "Unstage hunk")

      -- git blame
      map("n", "<leader>gb", function()
        gs.blame_line({ full = true })
      end, "Blame line")
      map("n", "<leader>gB", gs.toggle_current_line_blame, "Toggle blame")
    end,
  },
}

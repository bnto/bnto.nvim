return {
  "lewis6991/gitsigns.nvim",
  version = '0.8.1',
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
      end

      -- git stage / unstage hunk
      map("v", "<leader>gs", function()
        if vim.bo.modified then
          print("Please save changes before staging!")
        else
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end
      end, "")
      map("n", "<leader>gu", gs.undo_stage_hunk)
      map("n", "<leader>gd", gs.diffthis)
      map("n", "<leader>gD", ":GlLog -- %<CR>")
    end,
  },
}

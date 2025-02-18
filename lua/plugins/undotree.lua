return {
  "mbbill/undotree",

  config = function()
    local keymap = vim.keymap
    keymap.set("n", "<leader>u", ":UndotreeToggle<CR>:UndotreeFocus<CR>")
  end,
}

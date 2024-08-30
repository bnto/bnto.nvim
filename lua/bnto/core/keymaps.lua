vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>")

-- clear highlight on Escape
keymap.set("n", "<ESC>", "<CMD>nohlsearch<CR>")

-- keymap.set("n", "<leader>6", ":ls<CR>:b<Space>")
keymap.set("n", "<leader>6", "<C-6>")

-- keymaps for tmux and zk
keymap.set("n", "<C-f>f", "<cmd>silent !tmux neww ,tmux-session<CR>")
keymap.set("n", "<C-f>z", "<cmd>silent !tmux neww zk edit -i<CR>")
-- open terminal in split and entrer insert mode
keymap.set("n", "<leader>t", "<CMD>split +terminal<CR>i")

-- remove jumping through documents
keymap.set("n", "<C-o>", "<Nop>")
keymap.set("n", "<C-p>", "<Nop>")

-- disable arrow key
keymap.set("n", "<Up>", "<Nop>")
keymap.set("n", "<Down>", "<Nop>")
keymap.set("n", "<Left>", "<Nop>")
keymap.set("n", "<Right>", "<Nop>")

-- Reselect visual selection after indenting.
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- Move text up and down
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Easy insertion of a trailing ; or , from insert mode.
keymap.set("i", ";;", "<Esc>A;<Esc>")
keymap.set("i", ",,", "<Esc>A,<Esc>")

-- page jumps
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

-- copy to clipboard
keymap.set("n", "<leader>y", "\"+y")
keymap.set("v", "<leader>y", "\"+y")
keymap.set("n", "<leader>Y", "\"+Y")

-- paste from buffer
keymap.set("i", "<c-v>", function()
  require("telescope.builtin").registers()
end, { remap = true, silent = false })

-- Open file tree
-- keymap.set("n", "<leader>O", "<CMD>Oil --float<CR>")
keymap.set("n", "<leader>o", "<CMD>NvimTreeFindFileToggle<CR>")
keymap.set("n", "<leader>O", "<CMD>lefta 35vs +Oil<CR>")

-- save & quit
keymap.set("n", "<leader>w", "<CMD>w<CR>")

-- relaod config
-- keymap.set("n", "<leader><leader><CR>", "<CMD>so $MYVIMRC<CR>")

vim.g.mapleader = " "

local keymap = vim.keymap

-- clear highlight on Escape
keymap.set("n", "<ESC>", "<CMD>nohlsearch<CR>")

-- keymaps shared with tmux
keymap.set("n", "<C-f>f", "<cmd>silent !tmux neww ,tmux-session<CR>")
keymap.set("n", "<C-f>z", "<cmd>silent !tmux neww zk edit -i<CR>")
keymap.set("n", "<C-f>t", "<cmd>silent !tmux neww vit<CR>")
keymap.set("n", "<C-f>g", "<cmd>silent !tmux neww lazygit<CR>")

-- open fugitive
keymap.set("n", "<leader>gg", "<CMD>Git<CR>")

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

-- Open file tree
keymap.set("n", "<leader>o", "<CMD>NvimTreeFindFileToggle<CR>")
keymap.set("n", "<leader>O", "<CMD>Oil --float<CR>")

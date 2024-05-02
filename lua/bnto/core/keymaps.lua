vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear highlight on Escape
keymap.set("n", "<ESC>", "<CMD>nohlsearch<CR>")

-- window management
keymap.set("n", "<leader>o", "<C-w>o", { desc = "Close other windows" })
-- NOTE default keymaps for split : 
-- <C-w>v : split vertically
-- <C-w>s : split horizontally
-- <CMD>close<CR> : close split

-- page jumps
keymap.set("n", "<C-j>", "<C-d>zz")
keymap.set("n", "<C-k>", "<C-u>zz")

-- save & quit
keymap.set("n", "<leader>q", "<CMD>q<CR>", { desc = "Quit current" })
keymap.set("n", "<leader>s", "<CMD>w<CR>", { desc = "Save Document" })
keymap.set("n", "<leader>Q", "<CMD>q!<CR>", { desc = "Force quit"})

-- relaod config
keymap.set("n", "<leader><leader><CR>", "<CMD>so $MYVIMRC<CR>")

---------------
--  Options  --
---------------

local opt = vim.opt

-- line numbers
opt.relativenumber = true
opt.number = true

-- tabs & identation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- load .editorconfig file
vim.g.editorconfig = true

-- set external program for gq{motion} line formatting
-- opt.formatprg = "par -w80 -p0 -s0"

-- search settings
opt.ignorecase = true
opt.smartcase = true
-- opt.inccommand = 'split' -- automatically display substitution in split window

-- line settings
opt.cursorline = true
opt.scrolloff = 10
opt.wrap = false
opt.showmode = false
-- opt.cmdheight = 0 -- hide the command line

-- termguicolors
opt.termguicolors = true
opt.signcolumn = "yes"

-- terminal option
opt.shell = "bash -l"

-- Use undo history
opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.undodir"
opt.swapfile = false
opt.backup = false

-- backspace
opt.backspace = "indent,eol,start"

-- hide/show some paths
opt.path:append({ "**" })
opt.wildignore:append({ "*/node_modules/*" })

-- split windows
opt.splitright = true
opt.splitbelow = true

-- hint about whitespaces
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.colorcolumn = "80"

-- Markdown
opt.conceallevel = 2

---------------
--  Autocmd  --
---------------

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Keep folds on quit
opt.foldmethod = "manual"
vim.api.nvim_create_autocmd({"BufWinLeave"}, {
  pattern = {"*.md"},
  desc = "Save folds when closing file",
  command = "mkview",
})
vim.api.nvim_create_autocmd({"BufWinEnter"}, {
  pattern = {"*.md"},
  desc = "Load folds when opening file",
  command = "silent! loadview",
})

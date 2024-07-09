vim.cmd("let g:netrw_liststyle = 3")
vim.cmd("hi EndOfBuffer guibg=NONE ctermbg=NONE")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- tabs & identation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- line settings
opt.cursorline = true
opt.scrolloff = 10
opt.cmdheight = 0 -- hide the command line
opt.wrap = false

-- termguicolors
opt.termguicolors = true
opt.signcolumn = "yes"
-- opt.background = "dark"

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

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard

-- split windows
opt.splitright = true
opt.splitbelow = true

-- hint about whitespaces
vim.opt.list = true

-- Markdown
vim.opt.conceallevel = 2

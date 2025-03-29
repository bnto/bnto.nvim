-- neovim configuration

-- vim.cmd("let g:netrw_liststyle = 3")
-- vim.cmd("hi EndOfBuffer guibg=NONE ctermbg=NONE")

---------------
--  Keymaps  --
---------------

vim.g.mapleader = " "
local keymap = vim.keymap

-- clear highlight on Escape
keymap.set(
  "n",
  "<ESC>",
  "<CMD>nohlsearch<CR>",
  { desc = "Clear Search highlighting" }
)

-- keymaps shared with tmux
keymap.set("n", "<C-f>f", "<cmd>silent !tmux neww ,tmux-session<CR>")
keymap.set("n", "<C-f>z", "<cmd>silent !tmux neww zk edit -i<CR>")
keymap.set("n", "<C-f>t", "<cmd>silent !tmux neww vit<CR>")
keymap.set("n", "<C-f>g", "<cmd>silent !tmux neww lazygit<CR>")

-- remove jumping through documents
keymap.set("n", "<C-o>", "<Nop>")
keymap.set("n", "<C-p>", "<Nop>")

-- disable arrow key
keymap.set("n", "<Up>", "<Nop>")
keymap.set("n", "<Down>", "<Nop>")
keymap.set("n", "<Left>", "<Nop>")
keymap.set("n", "<Right>", "<Nop>")

-- -- disable open file explorer
-- keymap.set("n", "gx", "<Nop>")
-- keymap.set("v", "gx", "<Nop>")

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
keymap.set("n", "<leader>O", "<CMD>Oil --float<CR>")

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
opt.cmdheight = 0 -- hide the command line

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

-- Install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

---------------
--  Plugins  --
---------------

require("lazy").setup({
  -- Fuzzy File Finder
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>f", "<cmd>FzfLua files<cr>", desc = "Find files in cwd" },
      {
        "<leader>F",
        "<cmd>FzfLua grep_project<cr>",
        desc = "Grep word in cwd",
      },
      { "<leader>b", "<cmd>FzfLua buffers<cr>", desc = "Show current buffers" },
      {
        "<leader>B",
        "<cmd>FzfLua oldfiles<cr>",
        desc = "Find in recent files",
      },
      { "<leader>p", "<cmd>FzfLua registers<cr>", desc = "Show registers" },
      {
        "<leader>t",
        "<cmd>FzfLua builtin<cr>",
        desc = "Show all builtin command",
      },
      { "<leader>T", "<cmd>FzfLua filetypes<cr>", desc = "Set filetype" },
    },
    opts = {
      winopts = {
        preview = {
          layout = "vertical",
        },
        backdrop = 100,
      },
      hls = {
        normal = "@none",
      },
      files = {
        hidden = true,
        git_icons = true,
      },
      grep = {
        hidden = false,
      },
    },
  },
  -- AutoPairs
  {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    opts = {},
  },
  -- Undotree Explorer
  {
    "mbbill/undotree",
    init = function()
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_DiffAutoOpen = 0
      vim.g.undotree_ShortIndicators = 1
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_HelpLine = 0
    end,
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<Cr>", desc = "Toggle Undotree" },
    },
  },
  -- Nvim Tree File Explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    keys = {
      {
        "<leader>o",
        "<cmd>NvimTreeFindFileToggle<Cr>",
        desc = "Open File Explorer",
      },
    },
    config = function()
      local nvimtree = require("nvim-tree")
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
        vim.keymap.set("n", "<space>", api.node.open.edit, opts(""))
        vim.keymap.set("n", "h", api.node.navigate.parent_close, opts(""))
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
          width = 60,
          float = {
            enable = false,
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
    end,
  },
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      default_file_explorer = true,
      delete_to_trash = true,
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["<CR>"] = "actions.select",
        ["q"] = "actions.close",
      },
      float = {
        -- padding = 5,
        max_width = 50,
        border = "rounded",
      },
    },
    keys = {
      { "<leader>O", "<cmd>Oil --float<cr>", desc = "Open Oil File Explorer" },
    },
  },
  -- Colorscheme
  {
    "rose-pine/neovim",
    enabled = false,
    name = "rose-pine",
    opts = {
      dim_inactive_windows = false,
      styles = {
        transparency = true,
      },
      highlight_groups = {
        TelescopeSelection = { fg = "text", bg = "base" },
        TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
      },
    },
    init = function()
      vim.cmd.colorscheme("rose-pine-dawn")

      vim.cmd("highlight QuickFixLine guibg=#faf4ed ctermbg=none")
      vim.cmd("highlight QuickFixLine guifg=#d7827e ctermfg=none")

      vim.lsp.handlers["textDocument/hover"] =
        vim.lsp.with(vim.lsp.handlers.hover, {
          border = "rounded",
        })
    end,
  },
  {
    "echasnovski/mini.base16",
    enabled = false,
    version = false,
    config = function()
      require("mini.base16").setup({
        palette = {
          -- https://github.com/edunfelt/base16-rose-pine-scheme
          scheme = "Rosé Pine Dawn",
          base00 = "#faf4ed", -- Base
          base01 = "#fffaf3", -- Surface
          base02 = "#f2e9de", -- Overlay
          base03 = "#9893a5", -- Muted
          base04 = "#797593", -- Subtle
          base05 = "#575279", -- Text
          base06 = "#575279", -- Text
          base07 = "#cecacd",
          base08 = "#b4637a", -- Love
          base09 = "#ea9d34", -- Gold
          base0A = "#d7827e", -- Rose
          base0B = "#286983", -- Pine
          base0C = "#56949f", -- Foam
          base0D = "#907aa9", -- Iris
          base0E = "#ea9d34", -- Gold
          base0F = "#cecacd",
        },
      })
    end,
  },
  -- E-ink colorscheme
  {
    "alexxGmZ/e-ink.nvim",
    -- enabled = false,
    priority = 1000,
    opts = {},
    init = function()
      vim.opt.background = "light"

      local set_hl = vim.api.nvim_set_hl
      local mono = require("e-ink.palette").mono()
      local everforest = require("e-ink.palette").everforest()

      set_hl(0, "Group", { fg = mono[15] })
      set_hl(0, "Group", { fg = everforest.green })
      set_hl(0, "Normal", { fg = mono[12], bg = "NONE" })

      set_hl(0, "QuickFixLine", { bg = "#faf4ed", ctermbg = "NONE" })
      set_hl(0, "QuickFixLine", { fg = "#d7827e", ctermfg = "NONE" })

      -- set_hl(0, "ColorColumn", { link = "CursorLine" })
      set_hl(0, "ColorColumn", {})

      set_hl(0, "BlinkCmpKind", { link = "Normal" })

      vim.lsp.handlers["textDocument/hover"] =
        vim.lsp.with(vim.lsp.handlers.hover, {
          border = "rounded",
        })
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      heading = {
        icons = { "󰲡  ", "󰲣  ", "󰲥  ", "󰲧  ", "󰲩  ", "󰲫  " },
      },
      code = {
        width = "block",
        -- highlight = "RenderMarkdownH1Bg",
        highlight_inline = "RenderMarkdownH1Bg",
      },
    },
  },
  -- Comments
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
    -- dependencies = {
    --   "JoosepAlviste/nvim-ts-context-commentstring",
    -- },
    -- init = function()
    --   require("Comment").setup({
    --     pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    --   })
    -- end,
  },
  -- Formatting
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      formatters_by_ft = {
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        html = { "prettierd" },
        css = { "prettierd" },
        json = { "prettierd" },
        -- markdown = { "prettier" },
        -- yaml = { "prettier" },
        lua = { "stylua" },
      },
      -- format_on_save = {
      --   lsp_fallback = true,
      --   sync = false,
      --   timeout_ms = 1000,
      -- },
    },
    keys = {
      {
        "<leader><leader>f",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = "",
        desc = "Format current buffer",
      },
    },
  },
  -- Indent indicator
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
    event = { "BufReadpre", "BufNewFile" },
    main = "ibl",
    opts = {
      indent = { char = "|" },
    },
  },
  -- Lualine
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- enabled = false,
    -- event = "Colorscheme",
    opts = {
      options = {
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        -- theme = "rose-pine",
      },
      sections = {
        lualine_a = { { "mode" } },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { { "encoding" }, { "filetype" } },
        -- lualine_y = { "" },
        lualine_z = { "" },
      },
    },
  },
  -- Code Outline
  {
    "stevearc/aerial.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      {
        "<leader>a",
        "<cmd>AerialToggle float<Cr>",
        desc = "Toggle Code outline",
      },
    },
    opts = {
      close_on_select = true,
      float = {
        relative = "win",
      },
      layout = {
        min_width = { 0.8 },
      },
      keymaps = {
        ["<space>"] = "actions.jump",
      },
    },
  },
  -- GitSigns
  {
    "lewis6991/gitsigns.nvim",
    version = "0.8.1",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "tpope/vim-fugitive" },
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
    keys = {
      {
        "<leader>gg",
        "<cmd>Git<Cr>",
        desc = "Open Git Panel",
      },
      {
        "<leader>gD",
        "<cmd>:GlLog -- %<cr>",
        desc = "Diff git current buffer",
      },
    },
  },
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = {
        "javascript",
        "typescript",
        "html",
        "css",
        "markdown",
        "markdown_inline",
        "bash",
        "lua",
        "luadoc",
        -- "vim",
        -- "dockerfile",
        -- "gitignore",
        -- "yaml",
        -- "python",
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "ruby" },
      },
      indent = { enable = true, disable = { "ruby" } },
    },
  },
  -- Lazydev LSP for lua
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  -- better dotnet LSP
  {
    "seblj/roslyn.nvim",
    ft = "cs",
    opts = {},
  },
  -- Main LSP Configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", opts = {} },
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      {
        "j-hui/fidget.nvim",
        opts = {
          notification = {
            window = {
              winblend = 0,
              border = "rounded",
            },
          },
        },
      },
      "saghen/blink.cmp",
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup(
          "kickstart-lsp-attach",
          { clear = true }
        ),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(
              mode,
              keys,
              func,
              { buffer = event.buf, desc = "LSP: " .. desc }
            )
          end

          map("gd", require("fzf-lua").lsp_definitions, "Goto Definition")
          -- map('gr', require('fzf-lua').lsp_references, 'Goto References')
          -- map('gI', require('fzf-lua').lsp_implementations, 'Goto Implementation')
          -- map('<leader>D', require('fzf-lua').lsp_typedefs, 'Type Definition')
          -- map('<leader>ds', require('fzf-lua').lsp_document_symbols, 'Document Symbols')
          -- map('<leader>ws', require('fzf-lua').lsp_live_workspace_symbols, 'Workspace Symbols')
          -- map('<leader>rn', vim.lsp.buf.rename, 'Rename')
          -- map('<leader>ca', vim.lsp.buf.code_action, 'Code Action', { 'n', 'x' })
          -- map("gD", vim.lsp.buf.declaration, "Goto Declaration")

          local function client_supports_method(client, method, bufnr)
            if vim.fn.has("nvim-0.11") == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if
            client
            and client_supports_method(
              client,
              vim.lsp.protocol.Methods.textDocument_documentHighlight,
              event.buf
            )
          then
            local highlight_augroup = vim.api.nvim_create_augroup(
              "kickstart-lsp-highlight",
              { clear = false }
            )
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup(
                "kickstart-lsp-detach",
                { clear = true }
              ),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({
                  group = "kickstart-lsp-highlight",
                  buffer = event2.buf,
                })
              end,
            })
          end
        end,
      })
      vim.diagnostic.config({
        severity_sort = true,
        float = { border = "rounded", source = "if_many" },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
          },
        },
        virtual_text = {
          source = "if_many",
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      })
      local capabilities = require("blink.cmp").get_lsp_capabilities(
        vim.lsp.protocol.make_client_capabilities()
      )
      local servers = {
        bashls = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
        harper_ls = {
          enabled = false,
          filetypes = { "markdown" },
          settings = {
            ["harper_ls"] = {
              -- language = "fr",
              linters = {
                ToDoHyphens = false,
                SpellCheck = true,
              },
              -- isolateEnglish = true,
              markdown = {
                IgnoreLinkTitle = true,
              },
            },
          },
        },
      }
      -- Installed Mason packages
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        "stylua",
        "prettierd",
      })
      require("mason-tool-installer").setup({
        ensure_installed = ensure_installed,
      })
      require("mason-lspconfig").setup({
        ensure_installed = {},
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend(
              "force",
              {},
              capabilities,
              server.capabilities or {}
            )
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })
    end,
  },
  -- Autocompletion
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "moyiz/blink-emoji.nvim",
    },
    version = "1.*",
    opts = {
      keymap = {
        preset = "default",
        ["<C-z>"] = { "accept", "fallback" },
      },
      appearance = {
        nerd_font_variant = "mono",
      },
      completion = {
        menu = {
          border = "rounded",
          scrollbar = false,
          winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:BlinkCmpMenuSelection,Search:None",
          -- auto_show = false,
        },
        ghost_text = {
          enabled = true,
        },
        documentation = {
          auto_show = true,
          window = {
            border = "rounded",
            winhighlight = "Normal:Normal,FloatBorder:Normal,EndOfBuffer:BlinkCmpDoc",
          },
        },
      },
      cmdline = {
        enabled = false,
      },
      signature = {
        enabled = true,
        window = {
          border = "rounded",
        },
      },
      sources = {
        default = {
          "lsp",
          "path",
          "emoji",
          -- "snippets",
          -- "buffer",
        },
        providers = {
          emoji = {
            module = "blink-emoji",
            name = "Emoji",
            score_offset = 15,
            opts = { insert = true },
            should_show_items = function()
              return vim.tbl_contains(
                { "gitcommit", "markdown" },
                vim.o.filetype
              )
            end,
          },
        },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },
  {
    "hrsh7th/nvim-cmp",
    enabled = false,
    event = "InsertEnter",
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        build = (function()
          if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
            return
          end
          return "make install_jsregexp"
        end)(),
        dependencies = {},
      },
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      luasnip.config.setup({})
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        completion = { completeopt = "menu,menuone,noinsert" },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete({}),
          ["<C-l>"] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { "i", "s" }),
          ["<C-h>"] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { "i", "s" }),
        }),
        sources = {
          {
            name = "lazydev",
            group_index = 0,
          },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "render-markdown" },
        },
      })
    end,
  },
})

-- neovim configuration

local light_mode = true

require("keymaps")
require("options")

-- Install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

---------------
--  Plugins  --
---------------

require("lazy").setup({
  -- # Fuzzy File Finder
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>f", "<cmd>FzfLua files<cr>", desc = "Find files in cwd" },
      {
        "<leader>F",
        "<cmd>FzfLua live_grep<cr>",
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
        rg_opts = "--sortr=modified --color=never --hidden --files -g '!.git'",
        fd_opts = "--color=never --hidden --exclude .git --type f --strip-cwd-prefix --exec-batch ls -t",
      },
      grep = {
        -- hidden = false,
        hidden = true,
        rg_opts = "--sortr=modified --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
      },
    },
  },
  -- # AutoPairs
  {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    opts = {},
  },
  -- # Undotree Explorer
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
  -- # Restore last cursor position when reopening a file
  {
    "farmergreg/vim-lastplace",
  },
  -- # Nvim Tree File Explorer
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
        vim.keymap.set("n", "<esc>", api.tree.close, opts(""))
      end
      nvimtree.setup({
        on_attach = my_on_attach,
        filters = {
          custom = { ".DS_Store", "node_modules", ".git" },
          dotfiles = false,
        },
        git = {
          ignore = false,
        },
        renderer = {
          highlight_git = false,
          icons = {
            git_placement = "after",
            show = {
              folder_arrow = true,
            },
            web_devicons = {
              file = {
                color = false,
              },
              folder = {
                color = false,
              },
            },
            glyphs = {
              folder = {
                arrow_closed = " ",
                arrow_open = " ",
              },
              git = {
                unstaged = "M",
                staged = "S",
                unmerged = "",
                renamed = "R",
                untracked = "?",
                deleted = "D",
                ignored = "",
              },
            },
          },
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
    -- enabled = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      default_file_explorer = true,
      delete_to_trash = true,
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["<CR>"] = "actions.select",
        ["<SPACE><SPACE>"] = "actions.select",
        ["q"] = "actions.close",
        ["H"] = { "actions.parent", mode = "n" },
        ["<ESC>"] = { "actions.close", mode = "n" },
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
  {
    "brenoprata10/nvim-highlight-colors",
    opts = {},
  },
  -- # Colorscheme
  {
    "rose-pine/neovim",
    -- enabled = false,
    name = "rose-pine",
    opts = {
      dim_inactive_windows = false,
      styles = {
        transparency = true,
      },
      highlight_groups = {
        TelescopeSelection = { fg = "text", bg = "base" },
        TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
        TabLineSel = { fg = "surface", bg = "rose" },
        TabLineFill = { bg = "overlay" },
        StatusLineNC = { fg = "muted", bg = "overlay" },
      },
    },
    init = function()
      if light_mode then
        vim.cmd.colorscheme("rose-pine-dawn")
      else
        vim.cmd.colorscheme("rose-pine-moon")
      end

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
          base0E = "#286983", -- Pine
          base0C = "#56949f", -- Foam
          base0D = "#907aa9", -- Iris
          base0B = "#ea9d34", -- Gold
          base0F = "#cecacd",
          -- scheme = "Rosé Pine Moon",
          -- base00 = "232136",
          -- base01 = "2a273f",
          -- base02 = "393552",
          -- base03 = "6e6a86",
          -- base04 = "908caa",
          -- base05 = "e0def4",
          -- base06 = "e0def4",
          -- base07 = "56526e",
          -- base08 = "eb6f92",
          -- base09 = "f6c177",
          -- base0A = "ea9a97",
          -- base0B = "3e8fb0",
          -- base0C = "9ccfd8",
          -- base0D = "c4a7e7",
          -- base0E = "f6c177",
          -- base0F = "56526e",
        },
      })
    end,
  },
  -- # E-ink colorscheme
  {
    "alexxGmZ/e-ink.nvim",
    enabled = false,
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
      file_types = { "markdown" },
    },
  },
  -- # Comments
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },
  -- # Formatting
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      formatters_by_ft = {
        javascript = { "prettierd" },
        -- typescript = { "prettier" },
        html = { "prettierd" },
        css = { "prettierd" },
        json = { "prettierd" },
        markdown = { "prettier" },
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
        "<leader>=",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = "",
        desc = "Format current buffer",
      },
    },
  },
  -- # Indent indicator
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadpre", "BufNewFile" },
    main = "ibl",
    opts = {
      indent = { char = "┆" },
    },
  },
  -- # Lualine
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
        lualine_c = {
          {
            "filename",
            path = 1,
            symbols = {
              modified = "\u{EABC}",
              readonly = "\u{F0221}",
              -- unnamed = "",
              -- newfile = "",
            },
          },
        },
        lualine_x = { { "encoding" }, { "filetype" } },
        -- lualine_y = { "" },
        lualine_z = { "" },
      },
      inactive_sections = {
        lualine_c = { { "filename", color = "StatusLineNC" } },
        lualine_x = { { "progress", color = "StatusLineNC" } },
      },
    },
  },
  -- # Code Outline
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
  -- # GitSigns
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
        map("n", "<leader>gn", gs.next_hunk)
        map("n", "<leader>gp", gs.prev_hunk)
      end,
    },
    keys = {
      { "<leader>gg", "<cmd>Git<Cr>", desc = "Open Git Panel" },
      {
        "<leader>gD",
        "<cmd>GlLog -- %<cr>",
        desc = "Git diff current buffer",
      },
      { "<leader>gl", "<cmd>Git log --oneline<Cr>", desc = "Open git log" },
    },
  },
  -- # Treesitter
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
        "angular",
        -- "vim",
        -- "dockerfile",
        -- "gitignore",
        -- "yaml",
        -- "python",
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "ruby", "markdown" },
      },
      indent = { enable = true, disable = { "ruby" } },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
        pattern = { "*.component.html", "*.container.html" },
        callback = function()
          vim.treesitter.start(nil, "angular")
        end,
      })
    end,
  },
  -- # Main LSP Configuration
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
      {
        -- # Lazydev LSP for lua
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
      {
        -- # better dotnet LSP
        "seblj/roslyn.nvim",
        ft = "cs",
        opts = {},
      },
      {
        "zk-org/zk-nvim",
        config = function()
          require("zk").setup({
            picker = "fzf_lua",
            picker_options = {
              fzf_lua = {
                winopts = {
                  preview = {
                    -- hidden = true,
                  },
                },
              },
            },
            lsp = {
              config = {
                cmd = { "zk", "lsp" },
                name = "zk",
              },
              auto_attach = {
                enabled = true,
                filetypes = { "markdown" },
              },
            },
          })
        end,
        keys = {
          {
            "<leader>zk",
            function()
              require("zk").edit({ sort = { "random" } }, {
                fzf_lua = {
                  fzf_opts = {
                    ["--header"] = require("fzf-lua").utils.ansi_codes.blue(
                      "Ctrl-E: create a note with the query as title"
                    ),
                  },
                  actions = {
                    ["ctrl-e"] = function(_, opts)
                      local query = opts.last_query or ""
                      if query and query ~= "" then
                        vim.cmd("ZkNew { title = [[" .. query .. "]] }")
                      end
                    end,
                  },
                },
              })
            end,
            desc = "Search zk",
          },
          { "<leader>zt", "<cmd>ZkTags<Cr>", desc = "Search zk" },
        },
      },
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
        angularls = {
          cmd = {
            "ngserver",
            "--stdio",
            "--tsProbeLocations",
            ".",
            "--ngProbeLocations",
            ".",
          },
          on_new_config = function(new_config, _)
            new_config.cmd_env = {
              NG_DEBUG = "true",
            }
          end,
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
  -- # Autocompletion
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
          -- enabled = true,
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
})

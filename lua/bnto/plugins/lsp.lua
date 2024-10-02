return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim", config = true },
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",

    -- Useful status updates for LSP.
    { "j-hui/fidget.nvim", opts = {} },

    -- Allows extra capabilities provided by nvim-cmp
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup(
        "kickstart-lsp-attach",
        { clear = true }
      ),
      callback = function(event)
        local map = function(keys, func, mode)
          mode = mode or "n"
          vim.keymap.set(mode, keys, func, { buffer = event.buf })
        end

        map("gd", require("telescope.builtin").lsp_definitions)
        map("gr", require("telescope.builtin").lsp_references)
        map("gI", require("telescope.builtin").lsp_implementations)
        map("<leader>D", require("telescope.builtin").lsp_type_definitions)
        map("<leader>ds", require("telescope.builtin").lsp_document_symbols)
        map(
          "<leader>ws",
          require("telescope.builtin").lsp_dynamic_workspace_symbols
        )
        -- map("<leader>rn", vim.lsp.buf.rename)
        -- map("<leader>ca", vim.lsp.buf.code_action, { "n", "x" })
        -- map("gD", vim.lsp.buf.declaration)
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend(
      "force",
      capabilities,
      require("cmp_nvim_lsp").default_capabilities()
    )

    local servers = {
      lua_ls = {
        -- cmd = {...},
        -- filetypes = { ...},
        -- capabilities = {},
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
          },
        },
      },
    }

    -- Ensure the servers and tools above are installed
    require("mason").setup({
      ui = {
        border = "rounded",
      },
    })
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      "stylua", -- Used to format Lua code
    })
    require("mason-tool-installer").setup({
      ensure_installed = ensure_installed,
    })

    require("mason-lspconfig").setup({
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

    require("lspconfig.ui.windows").default_options = {
      border = "rounded",
    }
  end,
}

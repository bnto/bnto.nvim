return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    mason.setup({})

    mason_lspconfig.setup({
      -- list of servers to force install
      ensure_installed = {
        "html",
        "cssls",
        "tsserver",
        "lua_ls",
        "emmet_ls",
        -- "tailwindcss",
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier",
        "stylua",
        "eslint_d",
      }
    })
  end,
}

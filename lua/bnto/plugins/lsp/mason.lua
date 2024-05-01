return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local mason = require("mason")

    local mason_lspconfig = require("mason-lspconfig")

    mason.setup({
      
    })

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

  end,
}

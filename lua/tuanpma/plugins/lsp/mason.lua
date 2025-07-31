return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- import mason
    local mason = require("mason")
    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    -- minimal mason-lspconfig setup - just for installation
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "pyright", 
        "clangd",
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "stylua", -- lua formatter
        "black", -- python formatter
        "pylint",
        "isort", -- python formatter
      },
    })
  end,
}
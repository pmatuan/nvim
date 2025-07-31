return {
  "williamboman/mason.nvim",
  dependencies = {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
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

    -- Install LSP servers and tools directly through mason-tool-installer
    mason_tool_installer.setup({
      ensure_installed = {
        -- LSP servers
        "lua-language-server", -- lua_ls
        "pyright", -- python
        "clangd", -- c/c++
        
        -- Formatters and linters
        "stylua", -- lua formatter
        "black", -- python formatter
        "pylint", -- python linter
        "isort", -- python import sorter
      },
    })
  end,
}
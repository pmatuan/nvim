return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    local toggleterm = require("toggleterm")
    
    toggleterm.setup({
      size = 20,
      open_mapping = [[<c-`>]], -- Ctrl + ` để bật/tắt terminal
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true, -- whether or not the open mapping applies in insert mode
      terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
      persist_size = true,
      persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
      direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
      close_on_exit = true, -- close the terminal window when the process exits
      shell = vim.o.shell, -- change the default shell
      auto_scroll = true, -- automatically scroll to the bottom on terminal output
      -- This field is only relevant if direction is set to 'float'
      float_opts = {
        border = "curved", -- 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
        width = 120,
        height = 30,
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
      winbar = {
        enabled = false,
        name_formatter = function(term) --  term: Terminal
          return term.name
        end
      },
    })

    -- Custom terminal functions
    local Terminal = require("toggleterm.terminal").Terminal

    -- Lazygit terminal
    local lazygit = Terminal:new({
      cmd = "lazygit",
      dir = "git_dir",
      direction = "float",
      float_opts = {
        border = "double",
      },
      -- function to run on opening the terminal
      on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
      end,
      -- function to run on closing the terminal
      on_close = function(term)
        vim.cmd("startinsert!")
      end,
    })

    -- Node.js terminal
    local node = Terminal:new({
      cmd = "node",
      direction = "float",
      float_opts = {
        border = "double",
      },
    })

    -- Python terminal
    local python = Terminal:new({
      cmd = "python3",
      direction = "float",
      float_opts = {
        border = "double",
      },
    })

    -- Set keymaps
    local keymap = vim.keymap

    keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Toggle floating terminal" })
    keymap.set("n", "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", { desc = "Toggle horizontal terminal" })
    keymap.set("n", "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", { desc = "Toggle vertical terminal" })
    
    -- Custom terminal keymaps
    keymap.set("n", "<leader>tg", function() lazygit:toggle() end, { desc = "Toggle Lazygit" })
    keymap.set("n", "<leader>tn", function() node:toggle() end, { desc = "Toggle Node terminal" })
    keymap.set("n", "<leader>tp", function() python:toggle() end, { desc = "Toggle Python terminal" })

    -- Terminal mode keymaps
    function _G.set_terminal_keymaps()
      local opts = {buffer = 0}
      keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
      keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
      keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    end

    -- Tự động áp dụng keymaps khi mở terminal
    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
  end,
}
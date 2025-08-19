vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt -- for conciseness

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = false -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- appearance

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "light" -- colorschemes that can be light or dark will be made light (matching everforest config)
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- Enhanced clipboard support for SSH/remote sessions
if vim.env.SSH_TTY then
  -- When connected via SSH, use OSC52 escape sequences to copy to local clipboard
  vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
      ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
    },
    paste = {
      ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
      ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
    },
  }
end

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

-- ensure hidden is set for plugins like toggleterm
opt.hidden = true

-- Terminal-specific configurations for better zsh autosuggestion visibility
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	callback = function()
		-- Set terminal-local options for better zsh experience
		vim.opt_local.scrolloff = 0
		vim.opt_local.sidescrolloff = 0

		-- Additional terminal colors for zsh autosuggestions
		-- This ensures suggestions are bright enough to be visible
		vim.fn.setenv("ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE", "fg=#a7a7a7,bg=none,bold")
	end,
})

-- Function to adjust terminal colors if needed
_G.AdjustTerminalColors = function()
	vim.g.terminal_color_8 = "#b0b0b0" -- Even brighter for suggestions
	print("Terminal colors adjusted for better zsh autosuggestion visibility")
end

-- Command to easily adjust terminal colors
vim.api.nvim_create_user_command("AdjustTerminalColors", function()
	_G.AdjustTerminalColors()
end, { desc = "Adjust terminal colors for better zsh autosuggestion visibility" })

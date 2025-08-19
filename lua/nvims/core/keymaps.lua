-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------
-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- move lines faster
keymap.set("n", "J", "5j", { desc = "Move down 5 lines" })
keymap.set("n", "K", "5k", { desc = "Move up 5 lines" })

-- clear search highlights (space + n + h)
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- window navigation
keymap.set("n", "<leader>wh", "<C-w>h", { desc = "Move to left window" })
keymap.set("n", "<leader>wj", "<C-w>j", { desc = "Move to bottom window" })
keymap.set("n", "<leader>wk", "<C-w>k", { desc = "Move to top window" })
keymap.set("n", "<leader>wl", "<C-w>l", { desc = "Move to right window" })

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- terminal mode mapping
keymap.set("t", "<C-`>", function()
	require("snacks").terminal()
end, { desc = "Toggle Terminal" })

---------------------
-- Clipboard Keymaps for SSH/Remote -------------------
-- Enhanced copy/paste for remote servers

-- Copy to system clipboard in visual mode (works with SSH via OSC52)
keymap.set("v", "<leader>y", '"+y', { desc = "Copy to system clipboard" })
keymap.set("n", "<leader>Y", '"+yg_', { desc = "Copy line to system clipboard" })
keymap.set("n", "<leader>yy", '"+yy', { desc = "Copy line to system clipboard" })

-- Paste from system clipboard
keymap.set("n", "<leader>p", '"+p', { desc = "Paste from system clipboard" })
keymap.set("n", "<leader>P", '"+P', { desc = "Paste from system clipboard before cursor" })
keymap.set("v", "<leader>p", '"+p', { desc = "Paste from system clipboard" })

-- Alternative copy method using pbcopy (if available on remote server)
keymap.set("v", "<leader>cy", ":w !pbcopy<CR><CR>", { desc = "Copy selection via pbcopy" })

-- Copy current file path to clipboard
keymap.set("n", "<leader>cf", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  print("Copied to clipboard: " .. path)
end, { desc = "Copy file path to clipboard" })

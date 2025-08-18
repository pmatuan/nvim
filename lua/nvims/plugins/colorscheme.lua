return {
	{
		"sainnhe/everforest",
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- Configure everforest for better terminal visibility
			vim.o.background = "light" -- Set background to light mode
			vim.g.everforest_background = "hard"
			vim.g.everforest_better_performance = 1
			vim.g.everforest_enable_italic = 1
			vim.g.everforest_transparent_background = 0

			vim.cmd("colorscheme everforest")

			-- Terminal color overrides for better zsh autosuggestion visibility
			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "everforest",
				callback = function()
					-- Set terminal colors for better contrast and visibility (light mode)
					local colors = {
						-- Dark colors (0-7) - darker for light background
						terminal_color_0 = "#5c6a72", -- black
						terminal_color_1 = "#f85552", -- red
						terminal_color_2 = "#8da101", -- green
						terminal_color_3 = "#dfa000", -- yellow
						terminal_color_4 = "#3a94c5", -- blue
						terminal_color_5 = "#df69ba", -- magenta
						terminal_color_6 = "#35a77c", -- cyan
						terminal_color_7 = "#ddd8be", -- white

						-- Bright colors (8-15) - adjusted for light mode
						terminal_color_8 = "#708089", -- bright black (for suggestions)
						terminal_color_9 = "#f85552", -- bright red
						terminal_color_10 = "#8da101", -- bright green
						terminal_color_11 = "#dfa000", -- bright yellow
						terminal_color_12 = "#3a94c5", -- bright blue
						terminal_color_13 = "#df69ba", -- bright magenta
						terminal_color_14 = "#35a77c", -- bright cyan
						terminal_color_15 = "#5c6a72", -- bright white
					}

					-- Apply terminal colors
					for color, value in pairs(colors) do
						vim.g[color] = value
					end

					-- Specifically override the suggestion color to be more visible
					-- This makes zsh autosuggestions darker and more readable on light background
					vim.g.terminal_color_8 = "#888888" -- Darker gray for suggestions on light background
				end,
			})

			-- Trigger the autocmd immediately
			vim.schedule(function()
				vim.cmd("doautocmd ColorScheme everforest")
			end)
		end,
	},
}

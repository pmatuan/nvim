return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		local colors = {
			blue = "#3A94C5",
			green = "#8DA101",
			violet = "#DF69BA",
			yellow = "#DFA000",
			red = "#F85552",
			orange = "#FF8C00",
			fg = "#5C6A72",
			bg = "#FDF6E3",
			inactive_bg = "#F4F0D9",
			inactive_fg = "#939F91",
		}

		local my_lualine_theme = {
			normal = {
				a = { bg = colors.green, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			insert = {
				a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			visual = {
				a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			command = {
				a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			replace = {
				a = { bg = colors.red, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			inactive = {
				a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
				b = { bg = colors.inactive_bg, fg = colors.semilightgray },
				c = { bg = colors.inactive_bg, fg = colors.semilightgray },
			},
		}

		-- Function to get Python environment
		local function get_python_env()
			-- Check for virtual environment
			local venv = vim.env.VIRTUAL_ENV
			if venv then
				-- local venv_name = vim.fn.fnamemodify(venv, ":t")
				return "🐍 " .. vim.fn.fnamemodify(venv, ":~")
			end

			-- Return message when no environment is active
			return "❌ no venv"
		end

		-- configure lualine with modified theme
		lualine.setup({
			options = {
				theme = my_lualine_theme,
			},
			sections = {
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = colors.orange },
					},
					-- Python environment component
					{
						get_python_env,
						color = function()
							-- Different colors for active vs inactive
							if
								vim.env.VIRTUAL_ENV
								or (vim.env.CONDA_DEFAULT_ENV and vim.env.CONDA_DEFAULT_ENV ~= "base")
							then
								return { fg = colors.green } -- Green when venv is active
							else
								return { fg = colors.red } -- Red when no venv
							end
						end,
					},
					{ "encoding" },
					{ "fileformat" },
					{ "filetype" },
				},
			},
		})
	end,
}

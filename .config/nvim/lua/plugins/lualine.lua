return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"nvim-neotest/neotest",
	},
	config = function()
		local lualine = require("lualine")

		local colors = {
			blue = "#65D1FF",
			dark_blue = "#112638",
			green = "#3EFFDC",
			violet = "#FF61EF",
			purple = "#191724",
			yellow = "#FFDA7B",
			red = "#FF4A4A",
			white = "#c3ccdc",
			inactive_bg = "#2c3043",
		}

		local bg = colors.purple
		local fg = colors.white

		local lols = {
			normal = {
				a = { bg = colors.blue, fg = bg, gui = "bold" },
				b = { bg = bg, fg = fg },
				c = { bg = bg, fg = fg },
			},
			insert = {
				a = { bg = colors.green, fg = bg, gui = "bold" },
				b = { bg = bg, fg = fg },
				c = { bg = bg, fg = fg },
			},
			visual = {
				a = { bg = colors.violet, fg = bg, gui = "bold" },
				b = { bg = bg, fg = fg },
				c = { bg = bg, fg = fg },
			},
			command = {
				a = { bg = colors.yellow, fg = bg, gui = "bold" },
				b = { bg = bg, fg = fg },
				c = { bg = bg, fg = fg },
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

		lualine.setup({
			options = {
				icons_enabled = true,
				theme = lols,
				component_separators = { left = "|", right = "|" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				always_show_tabline = true,
				globalstatus = false,
				refresh = {
					statusline = 100,
					tabline = 100,
					winbar = 100,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					"diagnostics",
					{
						"branch",
						-- fmt = function(str)
						-- 	local slash_index = str:find("/")
						-- 	if slash_index then
						-- 		return str:sub(1, slash_index) .. "..."
						-- 	elseif #str > 12 then
						-- 		return str:sub(1, 12) .. "..."
						-- 	else
						-- 		return str
						-- 	end
						-- end,
					},
					{
						require("noice").api.statusline.mode.get,
						cond = require("noice").api.statusline.mode.has,
						color = { fg = "#ff9e64" },
					},
				},
				lualine_c = { { "filename", path = 4, shortening_target = 20 } },

				lualine_x = { "filetype", "overseer" },
				lualine_y = {
					"lsp_status",
				},
				lualine_z = {
					"location",
				},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {
				"quickfix",
				"nvim-dap-ui",
				"trouble",
				"toggleterm",
			},
		})
	end,
}

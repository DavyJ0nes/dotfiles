return {
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	priority = 1000, -- make sure to load this before all the other start plugins
	-- 	config = function()
	-- 		require("tokyonight").setup({
	-- 			style = "storm",
	-- 		})
	-- 		-- load the colorscheme here
	-- 		vim.cmd([[colorscheme tokyonight-storm]])
	-- 	end,
	-- },
	-- {
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("catppuccin").setup({
	-- 			flavour = "auto", -- latte, frappe, macchiato, mocha
	-- 			background = { -- :h background
	-- 				light = "mocha",
	-- 				dark = "mocha",
	-- 			},
	-- 			integrations = {
	-- 				blink_cmp = true,
	-- 				cmp = true,
	-- 				gitsigns = true,
	-- 				nvimtree = true,
	-- 				treesitter = true,
	-- 				notify = false,
	-- 				mini = {
	-- 					enabled = true,
	-- 					indentscope_color = "",
	-- 				},
	-- 				neogit = true,
	-- 				neotest = true,
	-- 				copilot_vim = true,
	-- 				dadbod_ui = true,
	-- 				dap_ui = true,
	-- 				dap = true,
	-- 			},
	-- 		})
	-- 		-- setup must be called before loading
	-- 		vim.cmd.colorscheme("catppuccin")
	-- 	end,
	-- },
	-- {
	-- 	"ray-x/aurora",
	-- 	init = function()
	-- 		vim.g.aurora_italic = 1
	-- 		vim.g.aurora_transparent = 1
	-- 		vim.g.aurora_bold = 1
	-- 	end,
	-- 	config = function()
	-- 		vim.cmd.colorscheme("aurora")
	-- 		-- override defaults
	-- 		vim.api.nvim_set_hl(0, "@number", { fg = "#e933e3" })
	-- 	end,
	-- },
	{
		"rebelot/kanagawa.nvim",
		lazy = true,
		opts = {
			dimInactive = true, -- dim inactive window `:h hl-NormalNC`
			-- Remove gutter background
			colors = {
				theme = {
					all = {
						ui = {
							bg_gutter = "none",
						},
					},
				},
			},
			overrides = function(colors)
				local theme = colors.theme
				return {
					-- Transparent background
					NormalFloat = { bg = "none" },
					FloatBorder = { bg = "none" },
					FloatTitle = { bg = "none" },

					NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
					LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
					MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

					-- Credit to https://github.com/rebelot/kanagawa.nvim/pull/268
					-- SnacksDashboard
					SnacksDashboardHeader = { fg = theme.vcs.removed },
					SnacksDashboardFooter = { fg = theme.syn.comment },
					SnacksDashboardDesc = { fg = theme.syn.identifier },
					SnacksDashboardIcon = { fg = theme.ui.special },
					SnacksDashboardKey = { fg = theme.syn.special1 },
					SnacksDashboardSpecial = { fg = theme.syn.comment },
					SnacksDashboardDir = { fg = theme.syn.identifier },
					-- SnacksNotifier
					SnacksNotifierBorderError = { link = "DiagnosticError" },
					SnacksNotifierBorderWarn = { link = "DiagnosticWarn" },
					SnacksNotifierBorderInfo = { link = "DiagnosticInfo" },
					SnacksNotifierBorderDebug = { link = "Debug" },
					SnacksNotifierBorderTrace = { link = "Comment" },
					SnacksNotifierIconError = { link = "DiagnosticError" },
					SnacksNotifierIconWarn = { link = "DiagnosticWarn" },
					SnacksNotifierIconInfo = { link = "DiagnosticInfo" },
					SnacksNotifierIconDebug = { link = "Debug" },
					SnacksNotifierIconTrace = { link = "Comment" },
					SnacksNotifierTitleError = { link = "DiagnosticError" },
					SnacksNotifierTitleWarn = { link = "DiagnosticWarn" },
					SnacksNotifierTitleInfo = { link = "DiagnosticInfo" },
					SnacksNotifierTitleDebug = { link = "Debug" },
					SnacksNotifierTitleTrace = { link = "Comment" },
					SnacksNotifierError = { link = "DiagnosticError" },
					SnacksNotifierWarn = { link = "DiagnosticWarn" },
					SnacksNotifierInfo = { link = "DiagnosticInfo" },
					SnacksNotifierDebug = { link = "Debug" },
					SnacksNotifierTrace = { link = "Comment" },
					-- SnacksProfiler
					SnacksProfilerIconInfo = { bg = theme.ui.bg_search, fg = theme.syn.fun },
					SnacksProfilerBadgeInfo = { bg = theme.ui.bg_visual, fg = theme.syn.fun },
					SnacksScratchKey = { link = "SnacksProfilerIconInfo" },
					SnacksScratchDesc = { link = "SnacksProfilerBadgeInfo" },
					SnacksProfilerIconTrace = { bg = theme.syn.fun, fg = theme.ui.float.fg_border },
					SnacksProfilerBadgeTrace = { bg = theme.syn.fun, fg = theme.ui.float.fg_border },
					SnacksIndent = { fg = theme.ui.bg_p2, nocombine = true },
					SnacksIndentScope = { fg = theme.ui.pmenu.bg, nocombine = true },
					SnacksZenIcon = { fg = theme.syn.statement },
					SnacksInputIcon = { fg = theme.ui.pmenu.bg },
					SnacksInputBorder = { fg = theme.syn.identifier },
					SnacksInputTitle = { fg = theme.syn.identifier },
					-- SnacksPicker
					SnacksPickerInputBorder = { fg = theme.syn.constant },
					SnacksPickerInputTitle = { fg = theme.syn.constant },
					SnacksPickerBoxTitle = { fg = theme.syn.constant },
					SnacksPickerSelected = { fg = theme.syn.number },
					SnacksPickerToggle = { link = "SnacksProfilerBadgeInfo" },
					SnacksPickerPickWinCurrent = { fg = theme.ui.fg, bg = theme.syn.number, bold = true },
					SnacksPickerPickWin = { fg = theme.ui.fg, bg = theme.ui.bg_search, bold = true },
				}
			end,
		},
	},
}

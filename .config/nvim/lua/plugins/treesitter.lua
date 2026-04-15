return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		branch = "main",
		build = ":TSUpdate",
		dependencies = {
			"windwp/nvim-ts-autotag",
		},
		config = function()
			local ts = require("nvim-treesitter")
			ts.setup({
				highlight = { enable = true, use_languagetree = true },
				indent = { enable = true },
				autotag = { enable = true },
				sync_install = false,
				auto_install = true,
				ignore_install = {},
			})
			ts.install({
				"bash",
				"dockerfile",
				"gitignore",
				"go",
				"graphql",
				"javascript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"query",
				"rust",
				"toml",
				"tsx",
				"typescript",
				"vimdoc",
				"vim",
				"yaml",
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "BufRead",
		opts = {
			multiwindow = true,
			max_lines = 0,
			line_numbers = true,
			multiline_threshold = 20,
			trim_scope = "outer",
			mode = "cursor",
		},
	},
}

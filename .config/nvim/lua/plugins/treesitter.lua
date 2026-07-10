return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		branch = "main",
		build = ":TSUpdate",
		dependencies = {
			"windwp/nvim-ts-autotag",
		},
		init = function()
			-- On the main branch, the plugin only manages parsers.
			-- Highlighting and indentation are Neovim builtins now.
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					pcall(vim.treesitter.start)
					if vim.bo.indentexpr == "" then
						vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
		config = function()
			vim.treesitter.language.register("yaml", "helm")

			local ts = require("nvim-treesitter")
			local installed = require("nvim-treesitter.config").get_installed()
			local wanted = {
				"bash",
				"dockerfile",
				"elixir",
				"gitignore",
				"go",
				"graphql",
				"heex",
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
			}
			local to_install = vim.iter(wanted)
				:filter(function(p) return not vim.tbl_contains(installed, p) end)
				:totable()
			if #to_install > 0 then
				ts.install(to_install)
			end
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

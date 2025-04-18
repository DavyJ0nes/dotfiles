return {
	"nvim-neotest/neotest",
	ft = {
		"go",
		"terraform",
		"typescript",
		"javascriptreact",
		"python",
		"typescriptreact",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"jfpedroza/neotest-elixir",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/nvim-nio",
		{ "fredrikaverpil/neotest-golang", version = "*" },
	},
	config = function()
		local neotest_ns = vim.api.nvim_create_namespace("neotest")

		vim.diagnostic.config({
			virtual_text = {
				format = function(diagnostic)
					local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
					return message
				end,
			},
		}, neotest_ns)

		require("neotest").setup({
			adapters = {
				require("neotest-elixir"),
				require("neotest-golang")({
					go_test_args = {
						"-v",
						"-race",
					},
				}),
			},
			discovery = {
				-- Drastically improve performance in ginormous projects by
				-- only AST-parsing the currently opened buffer.
				enabled = true,
				-- Number of workers to parse files concurrently.
				-- A value of 0 automatically assigns number based on CPU.
				-- Set to 1 if experiencing lag.
				concurrent = 0,
			},
			diagnostic = {
				enabled = true,
				severity = vim.diagnostic.severity.ERROR,
			},
			running = {
				-- Run tests concurrently when an adapter provides multiple commands to run.
				concurrent = true,
			},
			log_level = vim.log.levels.WARN, -- increase to DEBUG when troubleshooting
			output = {
				enabled = true,
				open_on_run = true,
			},
			run = {
				enabled = true,
			},
			status = {
				enabled = true,
				signs = true, -- Sign after function signature
				virtual_text = false,
			},
			strategies = {
				integrated = {
					height = 40,
					width = 120,
				},
			},
			summary = {
				enabled = true,
				animated = true,
				expand_errors = true,
				follow = true,
				count = true,
				mappings = {
					attach = "a",
					expand = { "<CR>", "<2-LeftMouse>" },
					expand_all = "e",
					jumpto = "gd",
					output = "o",
					run = "r",
					short = "O",
					stop = "u",
				},
			},
		})
	end,
}

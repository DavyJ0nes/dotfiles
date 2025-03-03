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
		-- "nvim-neotest/neotest-go",
		"jfpedroza/neotest-elixir",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/nvim-nio",
		{ "fredrikaverpil/neotest-golang", version = "*" }, -- Installation
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
			diagnostic = {
				enabled = false,
			},
			floating = {
				border = "rounded",
				max_height = 0.6,
				max_width = 0.6,
			},
			icons = {
				child_indent = "│",
				child_prefix = "├",
				collapsed = "─",
				expanded = "╮",
				failed = "✖",
				final_child_indent = " ",
				final_child_prefix = "╰",
				non_collapsible = "─",
				passed = "",
				running = "",
				skipped = "",
				unknown = "",
			},
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
				expand_errors = true,
				follow = true,
				mappings = {
					attach = "a",
					expand = { "<CR>", "<2-LeftMouse>" },
					expand_all = "e",
					jumpto = "i",
					output = "o",
					run = "r",
					short = "O",
					stop = "u",
				},
			},
		})
	end,
}

return {
	"nvim-neotest/neotest",
	ft = { "go", "rust", "typescript", "typescriptreact", "javascriptreact" },
	dependencies = {
		{ "nvim-lua/plenary.nvim", version = "*" },
		"antoinemadec/FixCursorHold.nvim",
		"jutonz/neotest-bun",
		"marilari88/neotest-vitest",
		"nvim-treesitter/nvim-treesitter",
		"mrcjkb/rustaceanvim",
		{ "nvim-neotest/nvim-nio", version = "*" },
		{ "fredrikaverpil/neotest-golang", version = "*" },
	},
	config = function()
		local neotest_ns = vim.api.nvim_create_namespace("neotest")

		vim.diagnostic.config({
			virtual_text = {
				format = function(diagnostic)
					return diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
				end,
			},
		}, neotest_ns)

		require("neotest").setup({
			adapters = {
				require("neotest-bun")({ additional_args = {} }),
				require("rustaceanvim.neotest"),
				(function()
					-- neotest-vitest crashes with nil rootPath in non-JS projects;
					-- wrap root() with pcall so it returns nil gracefully instead.
					local vitest = require("neotest-vitest")({
						filter_dir = function(name, _, _)
							return name ~= "node_modules"
						end,
					})
					local orig_root = vitest.root
					vitest.root = function(...)
						local ok, result = pcall(orig_root, ...)
						return ok and result or nil
					end
					return vitest
				end)(),
				require("neotest-golang")({
					warn_test_name_dupes = false,
					runner = "gotestsum",
				}),
			},
			discovery = { enabled = true, concurrent = 0 },
			diagnostic = { enabled = true, severity = vim.diagnostic.severity.ERROR },
			running = { concurrent = true },
			log_level = vim.log.levels.WARN,
			output = { enabled = true, open_on_run = true },
			status = { enabled = true, signs = true, virtual_text = false },
			strategies = { integrated = { height = 40, width = 120 } },
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

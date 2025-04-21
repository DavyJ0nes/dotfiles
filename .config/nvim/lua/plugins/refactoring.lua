return {
	"ThePrimeagen/refactoring.nvim",
	vscode = true,
	dependencies = {
		{ "nvim-lua/plenary.nvim", vscode = true },
		{ "nvim-treesitter/nvim-treesitter" },
	},
	keys = {
		{
			"<leader>rm",
			function()
				require("refactoring").select_refactor({
					show_success_message = true,
				})
			end,
			mode = { "n", "v" },
			desc = "Refactoring Menu",
		},
		{
			"<leader>re",
			function()
				require("refactoring").refactor("Extract Function")
			end,
			desc = "Extract",
			mode = "x",
		},
		{
			"<leader>rf",
			function()
				require("refactoring").refactor("Extract Function To File")
			end,
			desc = "Extract to file",
			mode = "x",
		},
		{
			"<leader>rv",
			function()
				require("refactoring").refactor("Extract Variable")
			end,
			desc = "Extract variable",
			mode = "x",
		},
		{
			"<leader>ri",
			function()
				require("refactoring").refactor("Inline Variable")
			end,
			desc = "Inline variable",
			mode = { "n", "x" },
		},
		{
			"<leader>rI",
			function()
				require("refactoring").refactor("Inline Function")
			end,
			desc = "Inline function",
			mode = { "n" },
		},
		{
			"<leader>rb",
			function()
				require("refactoring").refactor("Extract Block")
			end,
			desc = "Extract block",
		},
		{
			"<leader>rB",
			function()
				require("refactoring").refactor("Extract Block To File")
			end,
			desc = "Extract block to file",
		},
		-- Debug variable
		{
			"<leader>dv",
			function()
				require("refactoring").debug.print_var({
					show_success_message = true,
					below = true,
				})
			end,
			mode = { "n", "x" },
			desc = "Print below variables",
		},
		{
			"<leader>dV",
			function()
				require("refactoring").debug.print_var({
					show_success_message = true,
					below = false,
				})
			end,
			mode = { "n", "x" },
			desc = "Print above variables",
		},
		-- Clean up debugging
		{
			"<leader>dc",
			function()
				require("refactoring").debug.cleanup({
					force = true,
					show_success_message = true,
				})
			end,
			desc = "Clear debugging",
		},
	},
	opts = {
		prompt_func_return_type = {
			go = false,
			java = false,

			cpp = false,
			c = false,
			h = false,
			hpp = false,
			cxx = false,
		},
		prompt_func_param_type = {
			go = false,
			java = false,

			cpp = false,
			c = false,
			h = false,
			hpp = false,
			cxx = false,
		},
		printf_statements = {},
		print_var_statements = {},
	},
}

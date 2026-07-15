return {
	"2kabhishek/exercism.nvim",
	cmd = {
		"ExercismLanguages",
		"ExercismList",
		"ExercismSubmit",
		"ExercismTest",
	},
	keys = {
		"<leader>exa",
		"<leader>exl",
		"<leader>exs",
		"<leader>ext",
	},
	dependencies = {
		"2kabhishek/utils.nvim", -- required, for utility functions
		"stevearc/dressing.nvim", -- optional, highly recommended, for fuzzy select UI
		"2kabhishek/termim.nvim", -- optional, better UX for running tests
	},
	-- Add your custom configs here, keep it blank for default configs (required)
	opts = {
		exercism_workspace = "~/Exercism",
		default_language = "elixir",
	},
	config = function(_, opts)
		require("exercism").setup(opts)
		-- utils.nvim runs async job callbacks in plenary's fast (libuv) on_exit
		-- context, where vim.cmd/nvim_exec2 is illegal (E5560). Defer the callback
		-- to the main loop so opening the exercise (cd + picker) works.
		local shell = require("utils.shell")
		local async_shell_execute = shell.async_shell_execute
		shell.async_shell_execute = function(command, callback)
			async_shell_execute(command, function(result)
				vim.schedule(function()
					callback(result)
				end)
			end)
		end
	end,
}

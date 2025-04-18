return {
	"leoluz/nvim-dap-go",
	ft = "go",
	dependencies = {
		"mfussenegger/nvim-dap",
		"rcarriga/nvim-dap-ui",
	},
	config = function(_, opts)
		local dapgo = require("dap-go")
		opts = {
			dap_configurations = {
				{
					type = "go",
					name = "attach process (Go)",
					request = "attach",
					mode = "local",
					processId = require("dap.utils").pick_process,
					buildFlags = '-gcflags="all=-N -l"',
					program = vim.fn.expand("%:p:h"), -- Or "${workspaceFolder}", or absolute path to source dir
					cwd = vim.fn.getcwd(),
				},
				{
					type = "go",
					name = "attach remote",
					request = "attach",
					mode = "remote",
					port = 4444,
					host = "127.0.0.1",
				},
			},
			tests = {
				-- enables verbosity when running the test.
				verbose = false,
			},
		}
		dapgo.setup(opts)

		vim.keymap.set("n", "<leader>dt", function()
			require("dap-go").debug_test()
		end, { desc = "Debug go test" })
	end,
}

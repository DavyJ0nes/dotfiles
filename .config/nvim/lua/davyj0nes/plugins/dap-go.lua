return {
	"leoluz/nvim-dap-go",
	ft = "go",
	dependencies = {
		"mfussenegger/nvim-dap",
		"rcarriga/nvim-dap-ui",
	},
	config = function(_, opts)
		require("dap-go").setup(opts)

		vim.keymap.set("n", "<leader>dt", function()
			require("dap-go").debug_test()
		end, { desc = "Debug go test" })
	end,
}

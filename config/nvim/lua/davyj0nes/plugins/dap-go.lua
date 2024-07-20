return {
	"leoluz/nvim-dap-go",
	ft = "go",
	dependencies = {
		"mfussenegger/nvim-dap",
		"rcarriga/nvim-dap-ui",
	},
	config = function()
		require("dap-go").setup({})

    local keymap = vim.keymap -- for conciseness
    keymap.set("n", "<leader>dt",
      function()
				require("dap-go").debug_test()
      end,
      { desc = "Debug go test" }
    )
    keymap.set("n", "<leader>dtl",
      function()
				require("dap-go").debug_last_test()
      end,
      { desc = "Debug last run go test" }
    )
	end,

}

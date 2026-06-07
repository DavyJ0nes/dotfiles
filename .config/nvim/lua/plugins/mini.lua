return {
	"echasnovski/mini.nvim",
	version = "*",
	config = function()
		require("mini.ai").setup({ n_lines = 500 })
		require("mini.surround").setup()
		require("mini.pairs").setup()
		require("mini.indentscope").setup({
			symbol = "│",
			options = { try_as_border = true },
		})
	end,
}

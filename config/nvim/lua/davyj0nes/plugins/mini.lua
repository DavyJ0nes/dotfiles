return {
	"echasnovski/mini.nvim",
	event = "VeryLazy",
	config = function()
		require("mini.animate").setup({
			scroll = {
				enable = false,
			},
		})
	end,
}

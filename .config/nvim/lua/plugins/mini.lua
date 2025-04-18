return {
	"echasnovski/mini.nvim",
	config = function()
		require("mini.basics").setup({})
		require("mini.comment").setup({})

		local ai = require("mini.ai")
		ai.setup({
			custom_textobjects = {
				F = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
			},
		})
	end,
}

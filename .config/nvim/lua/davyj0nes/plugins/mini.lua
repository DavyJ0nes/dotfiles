return {
	"echasnovski/mini.nvim",
	config = function()
		require("mini.basics").setup({})
		require("mini.comment").setup({})
		require("mini.pairs").setup({})
		require("mini.starter").setup({})
		require("mini.surround").setup({})

		require("mini.sessions").setup({
			autoread = true,
			autowrite = true,
		})

		require("mini.indentscope").setup({
			draw = {
				animation = require("mini.indentscope").gen_animation.none(),
			},
		})

		local ai = require("mini.ai")
		ai.setup({
			custom_textobjects = {
				F = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
			},
		})

		local animate = require("mini.animate")
		animate.setup({
			cursor = { enable = false },
			scroll = {
				-- Animate for 150 milliseconds with linear easing
				timing = animate.gen_timing.linear({ duration = 50, unit = "total" }),
			},
			resize = {
				-- Animate for 150 milliseconds with linear easing
				timing = animate.gen_timing.linear({ duration = 50, unit = "total" }),

				-- Animate only if there are at least 3 windows
				subresize = animate.gen_subscroll.equal({
					predicate = function(sizes_from)
						return vim.tbl_count(sizes_from) >= 3
					end,
				}),
			},
		})
	end,
}

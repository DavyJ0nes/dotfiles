return {
	"supermaven-inc/supermaven-nvim",
	config = function()
		require("supermaven-nvim").setup({
			ignore_filetypes = { "markdown", "elixir" },
			disable_inline_completion = true,
		})
	end,
}

return {
	"hedyhli/outline.nvim",
	lazy = true,
	version = "*",
	dependencies = {
		"epheien/outline-treesitter-provider.nvim",
	},
	cmd = { "Outline", "OutlineOpen" },
	keys = {
		{ "<leader>oo", "<cmd>Outline<CR>", desc = "Toggle Outline" },
	},
	opts = {
		focus_on_open = true,
		keymaps = {
			show_help = "?",
			down_and_jump = "j",
			up_and_jump = "k",
		},
	},
}

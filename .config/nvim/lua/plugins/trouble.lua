return {
	"folke/trouble.nvim",
	cmd = { "Trouble" },
	keys = {
		{ "<leader>cx", "<cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics (Trouble)" },
		{ "<leader>cX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer Diagnostics (Trouble)" },
		{ "<leader>cs", "<cmd>Trouble symbols toggle focus=false<CR>", desc = "Symbols (Trouble)" },
		{ "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<CR>", desc = "LSP (Trouble)" },
		{ "<leader>xL", "<cmd>Trouble loclist toggle<CR>", desc = "Location List (Trouble)" },
		{ "<leader>xQ", "<cmd>Trouble qflist toggle<CR>", desc = "Quickfix (Trouble)" },
	},
	opts = {},
}

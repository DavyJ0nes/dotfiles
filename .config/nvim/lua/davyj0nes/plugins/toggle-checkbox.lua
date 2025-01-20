return {
	"opdavies/toggle-checkbox.nvim",
	ft = {
		"markdown",
	},
	vim.keymap.set("n", "<leader>mm", ":lua require('toggle-checkbox').toggle()<CR>"),
}

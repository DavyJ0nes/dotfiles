return {
	"RutaTang/quicknote.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("quicknote").setup({
			mode = "portable", -- "portable" | "resident", default to "portable"
			sign = "󰷫", -- This is used for the signs on the left side (refer to ShowNoteSigns() api).
			-- You can change it to whatever you want (eg. some nerd fonts icon), 'N' is default
			filetype = "md",
		})
	end,
}

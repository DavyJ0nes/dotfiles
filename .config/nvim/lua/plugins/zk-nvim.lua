return {
	"zk-org/zk-nvim",
	version = "*",
	config = function()
		require("zk").setup({
			picker = "snacks_picker",
			lsp = {
				config = {
					cmd = { "zk", "lsp" },
					name = "zk",
					filetypes = { "markdown" },
				},
				auto_attach = { enabled = true },
			},
			cmd = { "ZkNew", "ZkNotes", "ZkTags", "ZkMatch" },
		})
	end,
}

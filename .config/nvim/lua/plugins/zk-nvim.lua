return {
	"zk-org/zk-nvim",
	version = "*",
	config = function()
		require("zk").setup({
			picker = "fzf_lua",
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

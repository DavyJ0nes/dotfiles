return {
	"zk-org/zk-nvim",
	config = function()
		local opts = {
			-- Can be "telescope", "fzf", "fzf_lua", "minipick", "snacks_picker",
			-- or select" (`vim.ui.select`). It's recommended to use "telescope",
			-- "fzf", "fzf_lua", "minipick", or "snacks_picker".
			picker = "snacks_picker",

			lsp = {
				-- `config` is passed to `vim.lsp.start_client(config)`
				config = {
					cmd = { "zk", "lsp" },
					name = "zk",
					-- on_attach = ...
					-- etc, see `:h vim.lsp.start_client()`
				},

				-- automatically attach buffers in a zk notebook that match the given filetypes
				auto_attach = {
					enabled = true,
					filetypes = { "markdown" },
				},
			},
			cmd = { "ZkNew", "ZkNotes", "ZkTags", "ZkMatch" },
		}
		require("zk").setup(opts)
	end,
}

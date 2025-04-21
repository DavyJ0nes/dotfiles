return {
	"zk-org/zk-nvim",
	dependencies = {
		"folke/which-key.nvim",
	},
	config = function()
		local wk = require("which-key")
		wk.add({
			{ "<leader>nz", group = "zk notes" }, -- group
		})

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
		-- stylua: ignore
		keys = {
			{ '<leader>nzn', "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", desc = 'Zk New' },
			{ '<leader>nzo', "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", desc = 'Zk Notes' },
			{ '<leader>nzt', '<Cmd>ZkTags<CR>', desc = 'Zk Tags' },
			{ '<leader>nzf', "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>", desc = 'Zk Search' },
			{ '<leader>nzg', ":'<,'>ZkMatch<CR>", mode = 'x', desc = 'Zk Match' },
			{ '<leader>nzb', '<Cmd>ZkBacklinks<CR>', desc = 'Zk Backlinks' },
			{ '<leader>nzl', '<Cmd>ZkLinks<CR>', desc = 'Zk Links' },
		},
		}
		require("zk").setup(opts)
	end,
}

return {
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "+" },
					change = { text = "┃" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},

				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns
					local keymap = vim.keymap

					keymap.set({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", { desc = "[G]it [S]tage hunk" })
					keymap.set({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", { desc = "[G]it [R]eset hunk" })
					keymap.set("n", "<leader>gp", gs.preview_hunk, { desc = "[G]it [P]review hunk" })
					keymap.set("n", "<leader>gu", gs.undo_stage_hunk, { desc = "[G]it [U]ndo stage hunk" })
					keymap.set("n", "<leader>gd", gs.diffthis, { desc = "[G]it [D]iff this" })
					keymap.set("n", "<leader>gdl", ":Gitsigns diffthis ~1<CR>", { desc = "[G]it [D]iff [L]ast commit" })
					-- keymap.set('n', '<leader>hR', gs.reset_buffer)
					-- keymap.set('n', '<leader>hb', function() gs.blame_line{full=true} end)
					-- keymap.set('n', '<leader>tB', gs.toggle_current_line_blame)
					-- keymap.set('n', '<leader>hD', function() gs.diffthis('~') end)
				end,
			})
		end,
	},
}

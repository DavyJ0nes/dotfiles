return {
	"lewis6991/gitsigns.nvim",
	event = "VeryLazy",
	config = function()
		require("gitsigns").setup({
			signs = {
				add          = { text = "+" },
				change       = { text = "┃" },
				delete       = { text = "_" },
				topdelete    = { text = "‾" },
				changedelete = { text = "~" },
				untracked    = { text = "┆" },
			},
			on_attach = function(buf)
				local gs = require("gitsigns")
				local set = vim.keymap.set

				-- hunk navigation
				set("n", "]h", function() gs.nav_hunk("next") end, { buffer = buf, desc = "Next Hunk" })
				set("n", "[h", function() gs.nav_hunk("prev") end, { buffer = buf, desc = "Prev Hunk" })

				-- hunk actions
				set({ "n", "v" }, "<leader>ghs", function() gs.stage_hunk() end, { buffer = buf, desc = "Stage Hunk" })
				set({ "n", "v" }, "<leader>ghr", function() gs.reset_hunk() end, { buffer = buf, desc = "Reset Hunk" })
				set("n", "<leader>ghS", gs.stage_buffer, { buffer = buf, desc = "Stage Buffer" })
				set("n", "<leader>ghu", gs.undo_stage_hunk, { buffer = buf, desc = "Undo Stage Hunk" })
				set("n", "<leader>ghR", gs.reset_buffer, { buffer = buf, desc = "Reset Buffer" })
				set("n", "<leader>ghp", gs.preview_hunk, { buffer = buf, desc = "Preview Hunk" })
				set("n", "<leader>ghd", gs.diffthis, { buffer = buf, desc = "Diff This" })
				set("n", "<leader>ghD", function() gs.diffthis("~") end, { buffer = buf, desc = "Diff This ~" })

				-- text object
				set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { buffer = buf, desc = "Select Hunk" })
			end,
		})
	end,
}

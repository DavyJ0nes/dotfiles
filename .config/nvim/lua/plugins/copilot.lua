return {
	{
		"zbirenbaum/copilot.lua",
		lazy = true,
		event = "InsertEnter",
		enabled = true,
		dependencies = {
			{
				"nvim-lualine/lualine.nvim",
				event = "VeryLazy",
				opts = function(_, _) end,
			},
		},
		cmd = "Copilot",
		build = ":Copilot auth",
		opts = {
			panel = {
				enabled = false,
			},
			suggestion = {
				enabled = false,
			},
		},
		config = function(_, opts)
			require("copilot").setup(opts)

			-- hide copilot suggestions when cmp menu is open
			-- to prevent odd behavior/garbled up suggestions
			-- local cmp_status_ok, cmp = pcall(require, "cmp")
			-- if cmp_status_ok then
			-- 	cmp.event:on("menu_opened", function()
			-- 		vim.b.copilot_suggestion_hidden = true
			-- 	end)
			--
			-- 	cmp.event:on("menu_closed", function()
			-- 		vim.b.copilot_suggestion_hidden = false
			-- 	end)
			-- end
		end,
	},
	-- -- {
	-- -- 	"CopilotC-Nvim/CopilotChat.nvim",
	-- -- 	lazy = true,
	-- -- 	event = "VeryLazy",
	-- -- 	enabled = true,
	-- -- 	-- branch = "main", // BROKE
	-- -- 	version = "v3.6.0",
	-- -- 	dependencies = {
	-- -- 		{ "zbirenbaum/copilot.lua" },
	-- -- 		{ "nvim-lua/plenary.nvim" },
	-- -- 	},
	-- -- 	build = "make tiktoken",
	-- -- 	opts = {
	-- -- 		debug = false, -- Enable debugging
	-- -- 	},
	-- -- },
}

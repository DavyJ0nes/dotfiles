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
				opts = function(_, opts) end,
			},
		},
		cmd = "Copilot",
		build = ":Copilot auth",
		opts = {
			panel = {
				enabled = true,
				auto_refresh = true,
			},
			suggestion = {
				enabled = true,
				-- use the built-in keymapping for "accept" (<M-l>)
				auto_trigger = true,
				accept = false, -- disable built-in keymapping
			},
			filetypes = {
				sh = function()
					if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
						-- disable for .env files
						return false
					end
					return true
				end,
			},
		},
		config = function(_, opts)
			require("copilot").setup(opts)

			-- hide copilot suggestions when cmp menu is open
			-- to prevent odd behavior/garbled up suggestions
			local cmp_status_ok, cmp = pcall(require, "cmp")
			if cmp_status_ok then
				cmp.event:on("menu_opened", function()
					vim.b.copilot_suggestion_hidden = true
				end)

				cmp.event:on("menu_closed", function()
					vim.b.copilot_suggestion_hidden = false
				end)
			end
		end,
	},

	{
		"CopilotC-Nvim/CopilotChat.nvim",
		lazy = true,
		event = "VeryLazy",
		enabled = true,
		branch = "main",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim" },
		},
		opts = {
			debug = false, -- Enable debugging
		},
		config = function(_, opts)
			require("CopilotChat").setup(opts)
			-- NOTE: cmp is disabled
			-- require("CopilotChat.integrations.cmp").setup()
		end,
	},
}

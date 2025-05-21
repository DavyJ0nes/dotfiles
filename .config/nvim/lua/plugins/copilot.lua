local function enable()
	local disabled_filetypes = {
		"elixir",
		"markdown",
	}
	return not vim.tbl_contains(disabled_filetypes, vim.bo.filetype)
end

return {
	{
		"zbirenbaum/copilot.lua",
		lazy = true,
		event = "InsertEnter",
		enabled = enable(),
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
}

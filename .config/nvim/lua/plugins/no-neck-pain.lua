local function calculate_width()
	local width = vim.api.nvim_win_get_width(0)
	local min_width = math.max(width * 0.70, 85)
	return math.min(width, min_width)
end

return {
	"shortcuts/no-neck-pain.nvim",
	opts = {
		width = calculate_width(),
		buffers = {
			right = {
				enabled = false,
			},
			scratchPad = {
				enabled = true,
				pathToFile = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/notes/scratch/scratch.md",
				-- .. curr_file()
				-- .. ".md",
			},
			bo = {
				filetype = "md",
			},
		},
	},
	keys = {
		-- add <leader>cz to enter zen mode
		{
			"<leader>zz",
			"<cmd>NoNeckPain<cr>",
			desc = "Distraction Free Mode",
		},
		-- Increase and decrease width of NoNeckPain
		{
			"<leader>zu",
			"<cmd>NoNeckPainWidthUp<cr>",
			desc = "Increase NoNeckPain Width",
		},
		{
			"<leader>zd",
			"<cmd>NoNeckPainWidthDown<cr>",
			desc = "Decrease NoNeckPain Width",
		},
	},
	integrations = {
		neotest = {
			-- The position of the tree.
			---@type "right"
			position = "right",
			-- When `true`, if the tree was opened before enabling the plugin, we will reopen it.
			reopen = true,
		},
		-- @link https://github.com/rcarriga/nvim-dap-ui
		NvimDAPUI = {
			-- The position of the tree.
			---@type "none"
			position = "none",
			-- When `true`, if the tree was opened before enabling the plugin, we will reopen it.
			reopen = true,
		},
		-- @link https://github.com/hedyhli/outline.nvim
		outline = {
			-- The position of the tree.
			---@type "left"|"right"
			position = "right",
			-- When `true`, if the tree was opened before enabling the plugin, we will reopen it.
			reopen = false,
		},
	},
}

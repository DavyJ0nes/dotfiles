local function calculate_width()
	local width = vim.api.nvim_win_get_width(0)
	local min_width = math.max(width * 0.70, 85)
	return math.min(width, min_width)
end

local function curr_file()
	local filename = vim.fn.expand("%:t")
	vim.notify(filename, "No file name found")
	return vim.fn.fnamemodify(filename, ":r") -- ':r' removes the extension
end

return {
	"shortcuts/no-neck-pain.nvim",
	opts = {
		width = calculate_width(),
		buffers = {
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
}

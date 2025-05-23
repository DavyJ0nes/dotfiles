return {
	"otavioschwanck/arrow.nvim",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
		-- or if using `mini.icons`
		-- { "echasnovski/mini.icons" },
	},
	config = function()
		local opts = {
			show_icons = true,
			always_show_path = true,
			leader_key = ";", -- Recommended to be a single key
			buffer_leader_key = "m", -- Per Buffer Mappings
			per_buffer_config = {
				lines = 4, -- Number of lines showed on preview.
				sort_automatically = true, -- Auto sort buffer marks.
				satellite = { -- defualt to nil, display arrow index in scrollbar at every update
					enable = true,
					overlap = true,
					priority = 1000,
				},
				zindex = 10, --default 50
			},
			-- custom_actions = {
			-- 	open = function(target_file_name, current_file_name) end, -- target_file_name = file selected to be open, current_file_name = filename from where this was called
			-- 	split_vertical = function(target_file_name, current_file_name) end,
			-- 	split_horizontal = function(target_file_name, current_file_name) end,
			-- },
			mappings = {
				edit = "e",
				delete_mode = "d",
				clear_all_items = "C",
				toggle = "s", -- used as save if separate_save_and_remove is true
				open_vertical = "v",
				open_horizontal = "-",
				quit = "q",
				remove = "x", -- only used if separate_save_and_remove is true
				next_item = "]",
				prev_item = "[",
			},
		}
		local arrow = require("arrow")
		arrow.setup(opts)

		local statusline = require("arrow.statusline")
		statusline.is_on_arrow_file() -- return nil if current file is not on arrow.  Return the index if it is.
		statusline.text_for_statusline() -- return the text to be shown in the statusline (the index if is on arrow or "" if not)
		statusline.text_for_statusline_with_icons() -- Same, but with an bow and arrow icon ;D
	end,
}

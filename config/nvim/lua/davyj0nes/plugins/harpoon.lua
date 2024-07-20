return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },

	config = function(_, opts)
		local harpoon = require("harpoon")
		local keymap = vim.keymap -- for conciseness
		harpoon:setup(opts)

		-- basic telescope configuration
		local conf = require("telescope.config").values
		local function toggle_telescope(harpoon_files)
			local finder = function()
				local paths = {}
				for _, item in ipairs(harpoon_files.items) do
					table.insert(paths, item.value)
				end

				return require("telescope.finders").new_table({
					results = paths,
				})
			end

			require("telescope.pickers")
				.new({}, {
					prompt_title = "Harpoon",
					finder = finder(),
					previewer = conf.file_previewer({}),
					sorter = conf.generic_sorter({}),
					attach_mappings = function(prompt_bufnr, map)
						map("i", "<C-d>", function()
							local state = require("telescope.actions.state")
							local selected_entry = state.get_selected_entry()
							local current_picker = state.get_current_picker(prompt_bufnr)

							table.remove(harpoon_files.items, selected_entry.index)
							current_picker:refresh(finder())
						end)
						return true
					end,
				})
				:find()
		end

		keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end, { desc = "Add file to harpoon" })

		keymap.set("n", "<C-e>", function()
			toggle_telescope(harpoon:list())
		end, { desc = "Open harpoon list" })

		-- keymap.set("n", "<C-1>", function() harpoon:list():select(1) end, { desc = "Go to harpoon 1" })
		-- keymap.set("n", "<C-2>", function() harpoon:list():select(2) end, { desc = "Go to harpoon 2" })
		-- keymap.set("n", "<C-3>", function() harpoon:list():select(3) end, { desc = "Go to harpoon 3" })
		-- keymap.set("n", "<C-4>", function() harpoon:list():select(4) end, { desc = "Go to harpoon 4" })
		--
		-- Toggle previous & next buffers stored within Harpoon list
		-- keymap.set("n", "<C-S-E>", function() harpoon:list():prev() end, { desc = "Go to prev harpoon mark" })
		keymap.set("n", "<C-N>", function()
			harpoon:list():next()
		end, { desc = "Go to next harpoon mark" })
	end,
}

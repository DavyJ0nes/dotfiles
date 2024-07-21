return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		local find_cmd = { "rg", "--files", "--color", "never", "-g", "!.git" }

		local opts = {
			defaults = {
				path_display = { "truncate" },
				winblend = 0,
				border = {},
				borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
				color_devicons = true,
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
			vimgrep_arguments = {
				"rg",
				"-L",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
			},
			pickers = {
				find_files = {
					find_command = find_cmd,
					hidden = true,
				},
			},
			extensions_list = { "fzf" },
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		}

		telescope.setup(opts)
		-- load extensions
		for _, ext in ipairs(opts.extensions_list) do
			telescope.load_extension(ext)
		end

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		-- keymap.set(
		-- 	"n",
		-- 	"<leader>ff",
		-- 	function()
		-- 		require("telescope.builtin").find_files({
		-- 			hidden = true,
		-- 			follow = true,
		-- 		})
		-- 	end,
		-- 	-- "<cmd>Telescope find_files hidden=true follow=true<cr>",
		-- 	{ desc = "[F]ind [F]iles" }
		-- )
		keymap.set(
			"n",
			"<leader>ff",
			"<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files prompt_prefix=00<cr>",
			{ desc = "[F]ind [B]uffers" }
		)
		keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "[F]ind [B]uffers" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "[F]ind [R]ecent" })
		keymap.set("n", "<leader>fw", "<cmd>Telescope live_grep<cr>", { desc = "[F]ind [W]ord" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "[F]ind [C]urrent word" })
		keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "[F]ind [T]ODOs" })
		keymap.set("n", "<leader>fm", "<cmd>Telescope marks <cr>", { desc = "[F]ind [M]arks" })
	end,
}

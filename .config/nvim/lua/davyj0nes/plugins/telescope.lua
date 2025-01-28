return {
	"nvim-telescope/telescope.nvim",
	-- branch = "0.1.x",
	branch = "master",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"nvim-telescope/telescope-file-browser.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		local find_cmd = {
			"rg",
			"--files",
			"--color",
			"never",
			"-g",
			"!.git",
			"-g",
			"!build",
			"-g",
			"!.cpcache*",
			"-g",
			"!.lsp*",
			"-g",
			"!.clj-kondo*",
			"-g",
			"!target/*",
			"-g",
			"!*/gen/*",
		}

		local opts = {
			defaults = {
				path_display = { shorten = { len = 2, exclude = { -2, -1 } } },
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
				"-g",
				"!**/gen/**",
			},
			pickers = {
				find_files = {
					find_command = find_cmd,
					hidden = true,
					theme = "ivy",
				},
			},
			extensions_list = { "fzf", "file_browser" },
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
				file_browser = {
					theme = "ivy",
					-- disables netrw and use telescope-file-browser in its place
					hijack_netrw = true,
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

		keymap.set(
			"n",
			"<leader>ff",
			"<cmd>Telescope find_files hidden=true follow=true<cr>",
			{ desc = "[F]ind [F]iles" }
		)
		keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "[F]ind [B]uffers" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "[F]ind [R]ecent" })
		keymap.set("n", "<leader>fw", "<cmd>Telescope live_grep<cr>", { desc = "[F]ind [W]ord" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "[F]ind [C]urrent word" })
		keymap.set("n", "<leader>fm", "<cmd>Telescope marks <cr>", { desc = "[F]ind [M]arks" })
		keymap.set("n", "<leader>ft", "<cmd>Telescope treesitter <cr>", { desc = "[F]ind [T]reesitter" })
		keymap.set(
			"n",
			"<leader>fn",
			"<cmd>Telescope file_browser path=/Users/davy/Library/Mobile\\ Documents/iCloud~md~obsidian/Documents/notes/<cr>",
			{ desc = "[F]ind [N]otes" }
		)
		keymap.set("n", "<leader>sn", "<cmd>ObsidianSearch<cr>", { desc = "[S]earch [N]otes" })
	end,
}

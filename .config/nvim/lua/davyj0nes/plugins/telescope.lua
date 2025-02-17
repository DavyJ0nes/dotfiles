local function live_grep_from_project_git_root()
	local function is_git_repo()
		vim.fn.system("git rev-parse --is-inside-work-tree")

		return vim.v.shell_error == 0
	end

	local function get_git_root()
		local dot_git_path = vim.fn.finddir(".git", ".;")
		return vim.fn.fnamemodify(dot_git_path, ":h")
	end

	local opts = {}

	if is_git_repo() then
		opts = {
			cwd = get_git_root(),
		}
	end

	require("telescope.builtin").live_grep(opts)
end

local function find_files_from_project_git_root()
	local function is_git_repo()
		vim.fn.system("git rev-parse --is-inside-work-tree")
		return vim.v.shell_error == 0
	end
	local function get_git_root()
		local dot_git_path = vim.fn.finddir(".git", ".;")
		return vim.fn.fnamemodify(dot_git_path, ":h")
	end
	local opts = {}
	if is_git_repo() then
		opts = {
			cwd = get_git_root(),
		}
	end
	require("telescope.builtin").find_files(opts)
end

return {
	"nvim-telescope/telescope.nvim",
	-- branch = "0.1.x",
	branch = "master",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"HPRIOR/telescope-gpt",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
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
		require("telescope").setup({
			defaults = {
				layout_strategy = "horizontal",
				layout_config = { prompt_position = "top" },
				sorting_strategy = "ascending",

				path_display = { shorten = { len = 2, exclude = { -2, -1 } } },
				winblend = 0,
				border = {},
				borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
				color_devicons = true,

				file_ignore_patterns = {
					"node_modules/",
					"^.git/",
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

				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
					},
				},
			},

			pickers = {
				find_files = {
					find_command = find_cmd,
					theme = "ivy",
					hidden = true,
					follow = true,
				},
			},

			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		})

		-- load extensions
		require("telescope").load_extension("fzf")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		-- require("davyj0nes.config.telescope.multigrep").setup()
		keymap.set("n", "<leader>ff", find_files_from_project_git_root, { desc = "[F]ind [F]iles" })
		keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags, { desc = "[F]ind [H]elp tags" })
		keymap.set("n", "<leader>fb", require("telescope.builtin").buffers, { desc = "[F]ind [B]uffers" })
		keymap.set("n", "<leader>fr", require("telescope.builtin").oldfiles, { desc = "[F]ind [R]ecent" })
		keymap.set("n", "<leader>fw", "<cmd>Telescope live_grep<cr>", { desc = "[F]ind [W]ord" })
		keymap.set("n", "<leader>fc", require("telescope.builtin").grep_string, { desc = "[F]ind [C]urrent word" })
		keymap.set("n", "<leader>fm", require("telescope.builtin").marks, { desc = "[F]ind [M]arks" })
		keymap.set("n", "<leader>ft", require("telescope.builtin").treesitter, { desc = "[F]ind [T]reesitter" })
		keymap.set("n", "<leader>fn", function()
			require("telescope.builtin").find_files({
				cwd = vim.fn.expand("~/Library/Mobile Documents/iCloud~md~obsidian/Documents/notes"),
			})
		end, { desc = "[F]ind [N]otes" })

		vim.keymap.set("n", "<leader>/", function()
			-- You can pass additional configuration to telescope to change theme, layout, etc.
			require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = true,
			}))
		end, { desc = "[/] Fuzzily search in current buffer]" })
	end,
}

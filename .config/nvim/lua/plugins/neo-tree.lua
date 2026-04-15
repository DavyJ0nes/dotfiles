return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{ "<leader>ee", "<cmd>Neotree toggle<CR>", desc = "Toggle File Explorer" },
		{ "<leader>ef", "<cmd>Neotree reveal<CR>", desc = "Reveal Current File" },
	},
	opts = {
		close_if_last_window = true,
		event_handlers = {
			{
				event = "file_opened",
				handler = function()
					require("neo-tree.command").execute({ action = "close" })
				end,
			},
		},
		window = {
			position = "left",
			width = 35,
			mappings = {
				["<C-j>"] = function() vim.cmd("wincmd j") end,
			},
		},
		filesystem = {
			filtered_items = {
				visible = true,       -- show hidden files (greyed out rather than hidden)
				hide_dotfiles = false,
				hide_gitignored = false,
				hide_by_name = { "node_modules", ".git" },
				never_show = { ".DS_Store" },
			},
			follow_current_file = { enabled = true },
			use_libuv_file_watcher = true,
		},
		git_status = {
			window = { position = "float" },
		},
		default_component_configs = {
			git_status = {
				symbols = {
					added     = "+",
					modified  = "~",
					deleted   = "✖",
					renamed   = "󰁕",
					untracked = "?",
					ignored   = "",
					unstaged  = "󰄱",
					staged    = "",
					conflict  = "",
				},
			},
		},
	},
}

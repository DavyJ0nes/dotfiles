return {
	"nvim-neorg/neorg",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-neorg/neorg-telescope" },
		{ "pysan3/neorg-templates", dependencies = { "L3MON4D3/LuaSnip" } },
		{ "pritchett/neorg-capture" },
	},
	lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
	version = "*", -- Pin Neorg to the latest stable release
	config = function()
		require("neorg").setup({
			load = {
				["core.defaults"] = {},
				["core.keybinds"] = {},
				["core.concealer"] = {},
				["core.qol.todo_items"] = {
					config = {
						create_todo_parents = true,
					},
				},
				["core.journal"] = {
					config = {
						strategy = "flat",
						journal_folder = "journal/2024",
					},
				},
				["core.integrations.telescope"] = {},
				["core.presenter"] = {
					config = {
						zen_mode = "zen-mode",
					},
				},
				["core.dirman"] = {
					config = {
						workspaces = {
							notes = "~/notes",
						},
						default_workspace = "notes",
					},
				},
				["external.templates"] = {
					templates_dir = vim.fn.stdpath("config") .. "/templates/norg",
					default_subcommand = "add", -- or "fload", "load"
					keywords = {
						TODAY_NORG = function() -- detect date from filename and return in norg date format
							local ls = require("luasnip")
							local s = require("neorg.modules.external.templates.default_snippets")
							return ls.text_node(s.parse_date(0, os.time(), [[%a, %d %b %Y %H:%M:%S]])) -- Wed, 1 Nov 2006 19:15
						end,
						CURSOR = function() -- detect date from filename and return in norg date format
						end,
					},
				},
				["external.capture"] = {
					config = {
						templates = {
							{
								description = "idea",
								name = "idea",
								file = "/Users/davyjones/notes/inbox.norg",
								path = { "Inbox" },
							},
							{
								description = "snippet",
								name = "snippet",
								file = "/Users/davyjones/notes/inbox.norg",
								path = { "Inbox" },
							},
						},
					},
				},
			},
		})

		vim.wo.foldlevel = 99
		vim.wo.conceallevel = 2
	end,
}

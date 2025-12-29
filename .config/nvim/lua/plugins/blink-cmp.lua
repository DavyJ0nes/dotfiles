local function sources()
	if vim.tbl_contains({ "elixir", "markdown" }, vim.bo.filetype) then
		return { "lsp", "path", "buffer" }
	end
	return { "lsp", "path", "snippets", "copilot", "buffer" }
end

local function enable_copilot()
	local disabled_filetypes = {
		"elixir",
		"markdown",
	}
	return not vim.tbl_contains(disabled_filetypes, vim.bo.filetype)
end

return {
	"saghen/blink.cmp",
	-- optional: provides snippets for the snippet source
	dependencies = {
		"rafamadriz/friendly-snippets",
		"giuxtaposition/blink-cmp-copilot",
		"zbirenbaum/copilot.lua",
		"zbirenbaum/copilot-cmp",
		"huijiro/blink-cmp-supermaven",
	},

	-- use a release tag to download pre-built binaries
	version = "*",
	opts = {
		-- 'default' for mappings similar to built-in completion
		-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
		-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
		-- See the full "keymap" documentation for information on defining your own keymap.
		keymap = {
			preset = "enter",
		},
		-- enabled = function()
		-- 	return not vim.tbl_contains({ "elixir", "markdown" }, vim.bo.filetype)
		-- end,

		cmdline = {
			enabled = true,
			keymap = {
				preset = "cmdline",
			},
			completion = { menu = { auto_show = false } },
		},

		signature = {
			enabled = false,
		},

		completion = {
			menu = {
				auto_show = true,
			},
			ghost_text = {
				enabled = false,
				-- Show the ghost text when an item has been selected
				show_with_selection = true,
				-- Show the ghost text when no item has been selected, defaulting to the first item
				show_without_selection = false,
			},
		},

		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			providers = {
				-- supermaven = {
				-- 	name = "supermaven",
				-- 	enabled = enable_copilot,
				-- 	module = "blink-cmp-supermaven",
				-- 	async = true,
				-- },
				copilot = {
					name = "copilot",
					enabled = enable_copilot,
					module = "blink-cmp-copilot",
					score_offset = 100,
					async = true,
					transform_items = function(_, items)
						local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
						local kind_idx = #CompletionItemKind + 1
						CompletionItemKind[kind_idx] = "Copilot"
						for _, item in ipairs(items) do
							item.kind = kind_idx
						end
						return items
					end,
				},
			},
			default = sources(),
		},
		appearance = {
			kind_icons = {
				Copilot = "",
				Text = "󰉿",
				Method = "󰊕",
				Function = "󰊕",
				Constructor = "󰒓",

				Field = "󰜢",
				Variable = "󰆦",
				Property = "󰖷",

				Class = "󱡠",
				Interface = "󱡠",
				Struct = "󱡠",
				Module = "󰅩",

				Unit = "󰪚",
				Value = "󰦨",
				Enum = "󰦨",
				EnumMember = "󰦨",

				Keyword = "󰻾",
				Constant = "󰏿",

				Snippet = "󱄽",
				Color = "󰏘",
				File = "󰈔",
				Reference = "󰬲",
				Folder = "󰉋",
				Event = "󱐋",
				Operator = "󰪚",
				TypeParameter = "󰬛",
			},
		},
	},
	opts_extend = { "sources.default" },
}

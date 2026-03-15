local function sources()
	if vim.tbl_contains({ "elixir", "markdown" }, vim.bo.filetype) then
		return { "lsp", "path", "buffer" }
	end
	return { "lsp", "path", "snippets", "copilot", "buffer" }
end

local function enable_copilot()
	local disabled_filetypes = { "elixir", "markdown" }
	return not vim.tbl_contains(disabled_filetypes, vim.bo.filetype)
end

return {
	"saghen/blink.cmp",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"giuxtaposition/blink-cmp-copilot",
		"zbirenbaum/copilot.lua",
		"onsails/lspkind.nvim",
	},
	version = "v1.8.0",

	init = function()
		vim.opt.completeopt = { "menu", "menuone", "noselect" }
		vim.opt.shortmess:append("c")
	end,

	opts = {
		keymap = {
			preset = "enter",
			["<C-space>"] = {},
			["<C-x>"] = { "show", "fallback" },
		},

		cmdline = {
			enabled = true,
			keymap = { preset = "cmdline" },
			completion = {
				menu = { auto_show = false },
			},
		},

		signature = { enabled = false },

		completion = {
			menu = {
				auto_show = true,
				-- Cleaner border style
				border = "rounded",
				-- More compact sizing
				max_height = 15,
				scrollbar = true,
				draw = {
					columns = {
						{ "kind_icon" },
						{ "label", "label_description", gap = 1 },
						{ "kind" },
					},
					components = {
						kind_icon = {
							text = function(ctx)
								return require("lspkind").symbol_map[ctx.kind] or ""
							end,
						},
					},
				},
			},

			-- Ghost text configuration
			ghost_text = {
				enabled = false,
				show_with_selection = true,
				show_without_selection = false,
			},

			-- Documentation window
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
				window = {
					border = "rounded",
					max_width = 80,
					max_height = 20,
				},
			},
		},

		sources = {
			default = sources(),
			providers = {
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
		},

		appearance = {
			use_nvim_cmp_as_default = false,
			nerd_font_variant = "mono",
			kind_icons = {
				Copilot = "",
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

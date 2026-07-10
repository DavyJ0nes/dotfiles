local function sources()
	if vim.tbl_contains({ "markdown" }, vim.bo.filetype) then
		return { "lsp", "path", "buffer" }
	end
	return { "lsp", "path", "snippets", "buffer" }
end

return {
	"saghen/blink.cmp",
	dependencies = {
		"rafamadriz/friendly-snippets",
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
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-x>"] = { "show", "fallback" },
			["<Tab>"] = {
				function()
					local ok, sm = pcall(require, "supermaven-nvim.completion_preview")
					if ok and sm.has_suggestion() then
						-- blink maps <Tab> as an expr mapping (textlock); defer the
						-- buffer-mutating accept so it runs outside that context
						vim.schedule(sm.on_accept_suggestion)
						return true
					end
				end,
				"snippet_forward",
				"fallback",
			},
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
				border = "rounded",
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
			ghost_text = { enabled = false },
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
		},

		appearance = {
			use_nvim_cmp_as_default = false,
			nerd_font_variant = "mono",
			kind_icons = {
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

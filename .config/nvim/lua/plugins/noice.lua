return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = { "MunifTanjim/nui.nvim" },
	opts = {
		cmdline = {
			format = {
				cmdline      = { pattern = "^:", icon = "" },
				search_down  = { kind = "search", pattern = "^/", icon = " " },
				search_up    = { kind = "search", pattern = "^%?", icon = " " },
				filter       = { pattern = "^:%s*!", icon = "$" },
				lua          = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "" },
			},
		},
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = false,
				["vim.lsp.util.stylize_markdown"] = false,
			},
		},
		presets = {
			bottom_search = true,
			long_message_to_split = true,
		},
		routes = {
			{ view = "notify", filter = { event = "msg_showmode" } },
		},
	},
}

return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		local prompt_library = require("davyj0nes.plugins.code-companion.prompts")
		require("codecompanion").setup({
			strategies = {
				chat = {
					adapter = "copilot",

					agents = {
						["go_dev"] = {
							description = "Golang dev - Can run code, edit code and modify files",
							system_prompt = [[You are a senior golang developer working on a professional code base with a multi cultural team.
- **DO NOT** make any assumptions about the dependencies that a user has installed.
- If you need to install any dependencies to fulfil the user's request, do so via the Command Runner tool.
- If the user doesn't specify a path, use their current working directory.
- When creating tests utilise the table tests pattern were possible and the require package for assertions.
- The code you write should prioritise readability, maintainability and reliability and should be as idiomatic as possible.]],
							tools = {
								"cmd_runner",
								"editor",
								"files",
							},
						},
					},
				},
				inline = {
					adapter = "copilot",
				},
			},
			prompt_library = prompt_library,
			display = {
				diff = {
					enabled = true,
					close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
					layout = "horizontal", -- vertical|horizontal split for default provider
					opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
					provider = "mini_diff", -- default|mini_diff
				},
			},
		})
	end,
}

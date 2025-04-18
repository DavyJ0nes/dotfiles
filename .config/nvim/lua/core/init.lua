require("core.autocmds")
require("core.keymaps")
require("core.lazy")
require("core.options")

require("kanagawa").load("wave")

vim.lsp.enable({
	"elixirls", -- Elixir
	"gopls", -- Go
	"json", -- JSON
	"lua_ls", -- Lua
	"ts_ls", -- TypeScript
})

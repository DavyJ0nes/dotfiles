require("core.autocmds")
require("core.keymaps")
require("core.lazy")
require("core.options")

vim.cmd.colorscheme("nightfox")
-- vim.cmd.colorscheme("dayfox")

vim.lsp.enable({
	"elixirls", -- Elixir
	"gopls", -- Go
	"json", -- JSON
	"lua_ls", -- Lua
	"markdown", -- Markdown
	"ts_ls", -- TypeScript
})

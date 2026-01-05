require("core.autocmds")
require("core.keymaps")
require("core.lazy")
require("core.options")
require("core.today-note")

-- vim.cmd.colorscheme("nightfox")
vim.cmd.colorscheme("catppuccin")
-- vim.cmd.colorscheme("dayfox")

vim.lsp.enable({
	"gopls", -- Go
	"json", -- JSON
	"lua_ls", -- Lua
	"markdown", -- Markdown
	"ts_ls", -- TypeScript
	"superhtml", -- HTML
})

require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.statusline")
require("core.lazy")

vim.cmd.colorscheme("tokyonight")

vim.lsp.enable({
	"bashls",
	"dockerls",
	"gopls",
	"helm_ls",
	"jsonls",
	"lua_ls",
	"pyright",
	"terraformls",
	"ts_ls",
	"yamlls",
	-- rust_analyzer is managed by rustaceanvim
})

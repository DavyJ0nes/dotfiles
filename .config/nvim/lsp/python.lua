local Lsp = require("utils.lsp")
return {
	on_attach = Lsp.on_attach,
	init_options = { hostInfo = "neovim" },
	cmd = { "pylsp", "--ws" },
	filetypes = {
		"python",
	},
	root_markers = { ".git", "__init__.py" },
}

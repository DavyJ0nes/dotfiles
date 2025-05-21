local Lsp = require("utils.lsp")
return {
	cmd = { "marksman" },
	on_attach = Lsp.on_attach,
	filetypes = { "markdown" },
}

local Lsp = require("utils.lsp")
return {
	cmd = { "superhtml", "lsp" },
	on_attach = Lsp.on_attach,
	filetypes = { "html" },
	root_markers = { ".git" },
}

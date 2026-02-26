local Lsp = require("utils.lsp")
return {
	cmd = { "gleam", "lsp" },
	on_attach = Lsp.on_attach,
	filetypes = { "gleam" },
	root_markers = { "gleam.toml", ".git" },
}

local Lsp = require("utils.lsp")
return {
	cmd = { "elixir-ls" },
	on_attach = Lsp.on_attach,
	filetypes = { "elixir" },
}

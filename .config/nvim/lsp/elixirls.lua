local Lsp = require("utils.lsp")
return {
	cmd = { "elixir-ls" },
	on_attach = Lsp.on_attach,
	filetypes = { "elixir", "eelixir", "heex", "surface" },
	root_markers = { "mix.exs", ".git" },
	settings = {
		elixirLS = {
			dialyzerEnabled = true,
			fetchDeps = false,
			enableTestLenses = true,
			suggestSpecs = true,
		},
	},
}

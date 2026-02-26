local Lsp = require("utils.lsp")

-- NOTE: npm i -g vscode-langservers-extracted
return {
	cmd = { "vscode-json-language-server", "--stdio" },
	on_attach = Lsp.on_attach,
	filetypes = { "json", "jsonc" },
	init_options = {
		provideFormatter = true,
	},
	root_markers = { ".git" },
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
}

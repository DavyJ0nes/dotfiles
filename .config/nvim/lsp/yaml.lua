local Lsp = require("utils.lsp")

return {
	cmd = { "yaml-language-server", "--stdio" },
	on_attach = Lsp.on_attach,
	filetypes = { "yaml" },
	init_options = {
		provideFormatter = true,
	},
	root_markers = { ".git" },
	settings = {
		yaml = {
			schemaStore = {
				enable = false,
				url = "",
			},
			schemas = require("schemastore").yaml.schemas(),
			validate = true,
		},
	},
}

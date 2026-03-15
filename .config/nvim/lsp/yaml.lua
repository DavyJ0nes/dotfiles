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
			schemas = vim.tbl_extend("force", require("schemastore").yaml.schemas(), {
				kubernetes = { "*.yaml", "*.yml" },
			}),
			validate = true,
			completion = true,
			hover = true,
		},
	},
}

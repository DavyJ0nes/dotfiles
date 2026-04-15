return {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
	settings = {
		typescript = {
			inlayHints = {
				includeInlayParameterNameHints = "literals",
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayVariableTypeHints = false,
			},
		},
		javascript = {
			inlayHints = {
				includeInlayParameterNameHints = "literals",
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayVariableTypeHints = false,
			},
		},
	},
}

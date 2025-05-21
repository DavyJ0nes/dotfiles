local Lsp = require("utils.lsp")
-- go install golang.org/x/tools/gopls@latest
return {
	cmd = { "gopls" },
	on_attach = Lsp.on_attach,
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_markers = { "go.sum", "go.mod", ".git" },
	flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
	settings = {
		gopls = {
			gofumpt = true,
			codelenses = {
				gc_details = false,
				generate = true,
				regenerate_cgo = true,
				run_govulncheck = true,
				test = true,
				tidy = true,
				upgrade_dependency = true,
				vendor = true,
			},
			-- hints = {
			-- 	assignVariableTypes = true,
			-- 	compositeLiteralFields = true,
			-- 	compositeLiteralTypes = true,
			-- 	constantValues = true,
			-- 	functionTypeParameters = false,
			-- 	parameterNames = false,
			-- 	rangeVariableTypes = true,
			-- },
			-- analyzer docs: https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md
			analyses = {
				shadow = false,
			},
			usePlaceholders = true,
			completeUnimported = true,
			staticcheck = true,
			directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
			semanticTokens = false,
		},
	},
}

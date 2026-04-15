return {
	"williamboman/mason.nvim",
	config = function()
		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
			ensure_installed = {
				-- LSP servers
				"bash-language-server",
				"dockerfile-language-server",
				"gopls",
				"helm-ls",
				"json-lsp",
				"lua-language-server",
				"pyright",
				"terraform-ls",
				"typescript-language-server",
				"yaml-language-server",
				-- rust-analyzer is managed by rustaceanvim

				-- Formatters / linters / tools
				"stylua",
				"goimports",
				"gci",
				"delve",
				"golangci-lint",
				"hadolint",   -- Dockerfile linter
				"biome",
				"prettier",
				"prettierd",
				"black",
				"tflint",
				"mdformat",
			},
		})
	end,
}

return {
	"williamboman/mason.nvim",
	config = function()
		require("mason").setup({
			registries = {
				"github:mason-org/mason-registry",
				-- Unofficial registry for roslyn-language-server (no official Mason package yet)
				"github:Crashdummyy/mason-registry",
			},
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
				"elixir-ls",
				"gopls",
				"helm-ls",
				"json-lsp",
				"lua-language-server",
				"pyright",
				"terraform-ls",
				"typescript-language-server",
				"yaml-language-server",
				-- rust-analyzer is managed by rustaceanvim, roslyn is managed by roslyn.nvim

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

				-- C# / .NET
				"roslyn-language-server",
				"csharpier",
				"netcoredbg",
				"mdformat",
			},
		})
	end,
}

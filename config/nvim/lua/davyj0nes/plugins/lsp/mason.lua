return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"bashls",
				"bufls",
				"elixirls",
				"gopls",
				"lua_ls",
				"markdown_oxide",
				"elixirls",
				"gopls",
				"lua_ls",
				"markdown_oxide",
				"pyright",
				"ruff",
				"rust_analyzer",
				"terraformls",
				"tflint",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"gopls", -- go formatter
				"gci", -- go formatter
				"golangci-lint", -- go linter
				"tflint", -- terraform linter
				"mdformat", -- markdown formatter
				"cpptools", -- go formatter
				"codelldb", -- go formatter
				"buf", -- proto formatter and linter
				"protolint", -- proto linter
				"pyright", -- python linter
				"black", -- python formatter
			},
		})
	end,
}

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
			automatic_installation = true,
			ensure_installed = {
				"bashls",
				-- "clojure_lsp",
				"gopls",
				"lua_ls",
				"markdown_oxide",
				"pyright",
				"ruff",
				"terraformls",
				"tflint",
				-- "elixirls",
				-- "ocamllsp",
				"rust_analyzer",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- prettier formatter
				"prettierd", -- javascript/typescript formatter
				"stylua", -- lua formatter
				"gopls", -- go formatter
				"gci", -- go formatter
				"delve", -- go debugger
				"golangci-lint", -- go linter
				"tflint", -- terraform linter
				"mdformat", -- markdown formatter
				-- "buf", -- proto formatter and linter
				-- "protolint", -- proto linter
				"pyright", -- python linter
				"black", -- python formatter
				-- "ocamlformat", -- ocaml formatter
			},
		})
	end,
}

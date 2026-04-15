return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufWritePre" },
	ft = {
		"go",
		"rust",
		"javascript",
		"typescript",
		"javascriptreact",
		"typescriptreact",
		"python",
		"lua",
		"markdown",
		"html",
		"terraform",
		"dockerfile",
	},
	config = function()
		require("conform").setup({
			formatters = {
				mdformat = {
					command = "mdformat",
					prepend_args = { "--number", "--wrap", "79" },
				},
				prettierd = {
					condition = function()
						return vim.loop.fs_realpath(".prettierrc.js") ~= nil
							or vim.loop.fs_realpath(".prettierrc.mjs") ~= nil
					end,
				},
			},
			formatters_by_ft = {
				lua = { "stylua" },
				terraform = { "terraform_fmt" },
				rust = { "rustfmt" },
				go = { "gofmt", "gci", "goimports" },
				html = { "superhtml" },
				markdown = { "mdformat" },
				typescript = { "biome" },
				typescriptreact = { "biome" },
				javascript = { "biome" },
				javascriptreact = { "biome" },
				json = { "biome" },
				dockerfile = { "hadolint" },
				["*"] = { "trim_whitespace" },
			},
			format_on_save = {
				timeout_ms = 600,
				lsp_fallback = true,
			},
			format_after_save = { lsp_fallback = true },
		})
	end,
}

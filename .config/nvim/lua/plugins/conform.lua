return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufWritePre" },
	ft = {
		"clojure",
		"go",
		"rust",
		"elixir",
		"terraform",
		"javascript",
		"typescript",
		"javascriptreact",
		"typescriptreact",
		"python",
		"gleam",
		"ocaml",
		"markdown",
		"html",
	},
	config = function()
		require("conform").setup({
			formatters = {
				mdformat = {
					command = "/Users/davy/.local/bin/mdformat",
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
				go = { "gofmt", "gci", "goimports" },
				elixir = { "mix" },
				ocaml = { "ocamlformat" },
				html = { "superhtml" },
				markdown = { "mdformat" },
				typescript = { "biome" },
				typescriptreact = { "biome" },
				javascript = { "biome" },
				javascriptreact = { "biome" },
				json = { "biome" },
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

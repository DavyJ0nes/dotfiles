return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufWritePre" },
	ft = {
		"clojure",
		"go",
		"rust",
		"elixir",
		"terraform",
		"typescript",
		"javascriptreact",
		"typescriptreact",
		"python",
		"gleam",
		"ocaml",
	},
	config = function()
		require("conform").setup({
			formatters = {
				mdformat = {
					prepend_args = { "--number", "--wrap", "80" },
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
				-- gleam = { "gleam" },
				elixir = { "mix" },
				-- clojure = { "cljstyle" },
				ocaml = { "ocamlformat" },
				html = { "prettierd" },
				javascript = { "prettierd" },
				javascriptreact = { "prettierd" },
				markdown = { "prettierd" },
				typescript = { "prettierd" },
				typescriptreact = { "prettierd" },
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

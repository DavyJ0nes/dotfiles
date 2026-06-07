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
				rumdl = {
					command = "rumdl",
					-- Run from the buffer's own directory so rumdl discovers the nearest
					-- .rumdl.toml (it walks upward) — e.g. the notes config — regardless of
					-- Neovim's cwd. Pass the real path via --stdin-filename so [per-file-flavor]
					-- and exclude/include globs resolve under stdin (they can't match "<stdin>").
					cwd = function(_, ctx) return ctx.dirname end,
					args = function(_, ctx) return { "fmt", "--stdin-filename", ctx.filename, "-" } end,
					stdin = true,
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
				markdown = { "rumdl" },
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

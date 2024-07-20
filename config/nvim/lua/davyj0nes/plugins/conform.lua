return {
  "stevearc/conform.nvim",
	event = { "BufReadPre", "BufWritePre" },
	ft = {
		"go",
		"rust",
		"elixir",
		"terraform",
		"typescript",
		"javascriptreact",
		"python",
		"typescriptreact",
		"gleam",
	},
	config = function()
		require("conform").setup({
	    formatters = {
	    	mdformat = {
	    		prepend_args = { "--number", "--wrap", "80" },
	    	},
	    },
	    formatters_by_ft = {
	    	lua = { "stylua" },
	    	terraform = { "terraform_fmt" },
	    	go = { "gofmt", "golines", "gci" },
	    	gleam = { "gleam" },
	    	elixir = { "mix" },
	    },
	    format_on_save = {
	    	timeout_ms = 500,
	    	lsp_fallback = true,
	    },
	    format_after_save = { lsp_fallback = true },
    })
	end,
}

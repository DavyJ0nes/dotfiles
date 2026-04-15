return {
	{
		"saecki/crates.nvim",
		tag = "stable",
		config = function()
			require("crates").setup()
		end,
	},
	{

		"mrcjkb/rustaceanvim",
		version = "^9",
		lazy = false,
		init = function()
			local Lsp = require("utils.lsp")
			vim.g.rustaceanvim = {
				server = {
					on_attach = function(client, bufnr)
						Lsp.on_attach(client, bufnr)
						local opts = { buffer = bufnr, silent = true }
						vim.keymap.set("n", "K", function()
							vim.cmd.RustLsp({ "hover", "actions" })
						end, vim.tbl_extend("force", opts, { desc = "Rust Hover Actions" }))
						vim.keymap.set({ "n", "v" }, "<leader>ca", function()
							vim.cmd.RustLsp("codeAction")
						end, vim.tbl_extend("force", opts, { desc = "Rust Code Action" }))
						vim.keymap.set("n", "<leader>re", function()
							vim.cmd.RustLsp("explainError")
						end, vim.tbl_extend("force", opts, { desc = "Explain Error" }))
					end,
					default_settings = {
						["rust-analyzer"] = {
							check = { command = "clippy" },
							diagnostics = {
								enable = true,
								-- suppress duplicate "related information" notes that
								-- Neovim promotes into separate diagnostic entries
								experimental = { enable = false },
							},
						},
					},
				},
			}
		end,
	},
}

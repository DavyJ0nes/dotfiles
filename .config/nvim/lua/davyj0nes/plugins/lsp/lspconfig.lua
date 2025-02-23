return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			{ "antosha417/nvim-lsp-file-operations", config = true },
			{ "folke/neodev.nvim", opts = {} },
		},
		config = function()
			local lspconfig = require("lspconfig")
			local cmp_nvim_lsp = require("cmp_nvim_lsp")
			local util = require("lspconfig/util")
			local keymap = vim.keymap -- for conciseness

			local client_capabilities = vim.lsp.protocol.make_client_capabilities()
			client_capabilities.textDocument.completion.completionItem.snippetSupport = true
			client_capabilities.textDocument.completion.completionItem.resolveSupport = {
				properties = {
					"documentation",
					"detail",
					"additionalTextEdits",
				},
			}
			-- The nvim-cmp almost supports LSP's capabilities so you should advertise it to LSP servers..
			local completion_capabilities = cmp_nvim_lsp.default_capabilities()
			local capabilities = vim.tbl_deep_extend("force", client_capabilities, completion_capabilities)

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = {
						buffer = ev.buf,
						silent = true,
					}

					opts.desc = "Go back"
					keymap.set("n", "gb", "<C-o>", opts)

					opts.desc = "See available code actions"
					keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

					opts.desc = "Smart rename"
					keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

					opts.desc = "Show documentation for what is under cursor"
					keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

					opts.desc = "Restart LSP"
					keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

					local codelens = vim.api.nvim_create_augroup("LSPCodeLens", { clear = true })
					vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "CursorHold" }, {
						group = codelens,
						callback = function()
							vim.lsp.codelens.refresh()
						end,
						buffer = ev.buf,
					})
				end,
			})

			local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			lspconfig.gopls.setup({
				capabilities = capabilities,
				filetypes = { "go", "gomod", "gosum", "gotmpl", "gohtmltmpl", "gotexttmpl" },
				message_level = vim.lsp.protocol.MessageType.Error,
				cmd = { "gopls" },
				root_dir = util.root_pattern("go.work", "go.mod", ".git"),
				flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
				settings = {
					gopls = {
						gofumpt = true,
						codelenses = {
							gc_details = false,
							generate = true,
							regenerate_cgo = true,
							run_govulncheck = true,
							test = true,
							tidy = true,
							upgrade_dependency = true,
							vendor = true,
						},
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
						analyses = {
							modernize = true,
							fieldalignment = true,
							nilness = true,
							unusedparams = true,
							unusedwrite = true,
							useany = true,
							deadcode = true,
						},
						usePlaceholders = true,
						completeUnimported = true,
						staticcheck = true,
						directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
						semanticTokens = true,
					},
				},
			})

			lspconfig.ruff.setup({
				capabilities = capabilities,
				filetypes = { "python", "py" },
			})

			lspconfig.pyright.setup({
				capabilities = capabilities,
				filetypes = { "python", "py" },
			})

			lspconfig.terraformls.setup({
				capabilities = capabilities,
				filetypes = { "terraform" },
				cmd = { "terraform-ls", "serve" },
				root_dir = util.root_pattern(".terraform", ".git"),
			})

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						-- make the language server recognize "vim" global
						diagnostics = {
							globals = { "vim" },
						},
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			})

			lspconfig.clojure_lsp.setup({
				capabilities = capabilities,
				filetypes = { "clojure" },
			})

			lspconfig.ocamllsp.setup({
				capabilities = capabilities,
				filetypes = { "ocaml" },
			})

			lspconfig.ts_ls.setup({
				capabilities = capabilities,
				filetypes = { "typescript" },
			})
		end,
	},
	{
		"nvimtools/none-ls.nvim", -- none-ls is an active community fork of null-ls
		opts = function(_, opts)
			local nls = require("null-ls")
			opts.sources = vim.list_extend(opts.sources or {}, {
				nls.builtins.code_actions.gomodifytags,
				nls.builtins.code_actions.impl,
			})
			return opts
		end,
	},
}

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

					-- set keybinds
					-- opts.desc = "Show LSP references"
					-- keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references
					--
					-- opts.desc = "Go to declaration"
					-- keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration
					--
					-- opts.desc = "Show LSP definitions"
					-- keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

					opts.desc = "Go back"
					keymap.set("n", "gb", "<C-o>", opts)

					-- opts.desc = "Show LSP implementations"
					-- keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations
					--
					-- opts.desc = "Show LSP type definitions"
					-- keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

					opts.desc = "See available code actions"
					keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

					opts.desc = "Smart rename"
					keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

					-- opts.desc = "[F]ind [D]ocument [S]ymbols"
					-- keymap.set("n", "<leader>fds", require("telescope.builtin").lsp_document_symbols, opts)

					-- opts.desc = "[F]ind [W]orkspace [S]ymbols"
					-- keymap.set("n", "<leader>fws", require("telescope.builtin").lsp_dynamic_workspace_symbols, opts)
					-- opts.desc = "Show buffer diagnostics"
					-- keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file
					--
					-- opts.desc = "Show line diagnostics"
					-- keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line
					--
					-- opts.desc = "Go to previous diagnostic"
					-- keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer
					--
					-- opts.desc = "Go to next diagnostic"
					-- keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

					opts.desc = "Show documentation for what is under cursor"
					keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

					opts.desc = "Restart LSP"
					keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

					-- local codelens = vim.api.nvim_create_augroup("LSPCodeLens", { clear = true })
					-- vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "CursorHold" }, {
					-- 	group = codelens,
					-- 	callback = function()
					-- 		vim.lsp.codelens.refresh()
					-- 	end,
					-- 	buffer = ev.buf,
					-- })
				end,
			})

			local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
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
						-- analyses = {
						-- 	fieldalignment = true,
						-- 	nilness = true,
						-- 	unusedparams = true,
						-- 	unusedwrite = true,
						-- 	useany = true,
						-- },
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

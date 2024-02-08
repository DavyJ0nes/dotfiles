local plugins = {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
		"nvim-neotest/neotest",
		ft = { "go", "rust", "typescript", "javascriptreact", "typescriptreact" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-go",
			"rouge8/neotest-rust",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("custom.configs.neotest")
		end,
	},
	{
		"neovim/nvim-lspconfig",
		ft = { "go", "rust", "terraform", "typescript", "javascriptreact", "typescriptreact" },
		dependencies = {
			"ray-x/go.nvim",
		},
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end,
	},
	{
		"nvimtools/none-ls.nvim",
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		cmd = "Telescope",
		init = function()
			require("core.utils").load_mappings("telescope")
		end,
		opts = function()
			return require("custom.configs.telescope")
		end,
		config = function(_, opts)
			dofile(vim.g.base46_cache .. "telescope")
			local telescope = require("telescope")
			telescope.setup(opts)

			-- load extensions
			for _, ext in ipairs(opts.extensions_list) do
				telescope.load_extension(ext)
			end
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"stylua",
				"gopls",
				"gci",
				"golangci-lint",
				"rust-analyzer",
				"elixir-ls",
				"terraform-ls",
				"tflint",
				"mdformat",
				"cpptools",
				"codelldb",
				"buf-language-server", -- lsp (prototype, not feature-complete yet, rely on buf for now)
				"buf", -- formatter, linter
				"protolint", -- linter
			},
		},
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
		},
		init = function()
			require("core.utils").load_mappings("dap")
			-- require "custom.configs.dap"
		end,
		config = function()
			require("dap").adapters.codelldb = {
				type = "server",
				host = "127.0.0.1",
				port = 13000,
				executable = {
					command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb",
					args = { "--port", "13000" },

					-- on windows you may have to uncomment this:
					-- detached = false,
				},
			}
		end,
	},
	{
		"leoluz/nvim-dap-go",
		ft = "go",
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
		},
		config = function(_, opts)
			require("dap-go").setup(opts)
			require("core.utils").load_mappings("dap_go")
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = "mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			require("dapui").setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = function()
			return require("custom.configs.go")
		end,
		config = function(_, opts)
			require("go").setup()
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	},
	{
		"mfussenegger/nvim-lint",
		ft = { "go" },
		enabled = true,
		opts = function(_, opts)
			local linters = require("lint").linters

			local function find_file(filename)
				-- find file
				local command = "fd --hidden --no-ignore '" .. filename .. "' " .. vim.fn.getcwd() .. " | head -n 1"
				local file = io.popen(command):read("*l")
				return file and file or nil
			end

			local use_golangci_config_if_available = function()
				local config_file = find_file(".golangci.yml")
				if config_file then
					print("Using golangci-lint config: " .. config_file)
					return {
						"run",
						"--out-format",
						"json",
						"--config",
						config_file,
						function()
							return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
						end,
					}
				else
					return linters.golangcilint.args
				end
			end

			linters.golangcilint.args = use_golangci_config_if_available()
			linters.mypy.cmd = prefer_bin_from_venv("mypy")

			local linters_by_ft = {
				-- this extends lazyvim's nvim-lint setup
				-- https://www.lazyvim.org/extras/linting/nvim-lint
				protobuf = { "buf", "protolint" },
				yaml = { "yamllint" },
				go = { "golangcilint" },
			}

			-- extend opts.linters_by_ft
			for ft, linters_ in pairs(linters_by_ft) do
				opts.linters_by_ft[ft] = opts.linters_by_ft[ft] or {}
				vim.list_extend(opts.linters_by_ft[ft], linters_)
			end
		end,
	},
	-- RUST PLUGINS --------------------------------------------------------------
	-- {
	--   "rust-lang/rust.vim",
	--   ft = "rust",
	--   init = function()
	--     vim.g.rustfmt_autosave = 1
	--   end
	-- },
	{
		"mrcjkb/rustaceanvim",
		version = "^4", -- Recommended
		ft = { "rust" },
		opts = {
			server = {
				on_attach = function(_, bufnr)
					-- register which-key mappings
					local wk = require("which-key")
					wk.register({
						["<leader>dr"] = {
							function()
								vim.cmd.RustLsp("debuggables")
							end,
							"Rust debuggables",
						},
					}, { mode = "n", buffer = bufnr })
				end,
				settings = {
					-- rust-analyzer language server configuration
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
							loadOutDirsFromCheck = true,
							runBuildScripts = true,
						},
						-- Add clippy lints for Rust.
						checkOnSave = {
							allFeatures = true,
							command = "clippy",
							extraArgs = { "--no-deps" },
						},
						-- rustfmt = {
						--
						-- },
						procMacro = {
							enable = true,
							ignored = {
								["async-trait"] = { "async_trait" },
								["napi-derive"] = { "napi" },
								["async-recursion"] = { "async_recursion" },
							},
						},
					},
				},
			},
		},
		config = function(_, opts)
			vim.g.rustaceanvim = opts
		end,
	},
	{
		"saecki/crates.nvim",
		ft = { "rust", "toml" },
		event = { "BufRead Cargo.toml" },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function(_, _)
			local crates = require("crates")
			crates.setup()
			crates.show()
			require("core.utils").load_mappings("crates")
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		opts = function()
			local M = require("plugins.configs.cmp")
			table.insert(M.sources, { name = "crates" })
			return M
		end,
	},
	{
		"nvim-tree/nvim-web-devicons",
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		config = function()
			return require("custom.configs.noice")
		end,
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			-- "rcarriga/nvim-notify",
		},
	},
	{
		"echasnovski/mini.nvim",
		event = "VeryLazy",
		config = function()
			require("mini.animate").setup({
				scroll = {
					enable = false,
				},
			})
		end,
	},
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
	},
	{
		"ThePrimeagen/vim-be-good",
		ft = { "markdown" },
	},
	{
		"johmsalas/text-case.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		-- Author's Note: If default keymappings fail to register (possible config issue in my local setup),
		-- verify lazy loading functionality. On failure, disable lazy load and report issue
		-- lazy = false,
		config = function()
			require("textcase").setup({
				default_keymappings_enabled = false,
			})
			require("telescope").load_extension("textcase")
		end,
	},
	{
		"chrishrb/gx.nvim",
		event = { "BufEnter" },
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = function()
			return require("custom.configs.gx")
		end,
		config = function(_, opts)
			require("gx").setup(opts)
		end,
	},
	{
		"chentoast/marks.nvim",
		event = "VeryLazy",
		opts = function()
			return require("custom.configs.marks")
		end,
		config = function(_, opts)
			require("marks").setup(opts)
		end,
	},
	{
		"stevearc/conform.nvim",
		ft = { "go", "rust", "terraform", "lua", "markdown" },
		opts = function()
			return require("custom.configs.conform")
		end,
		config = function(_, opts)
			require("conform").setup(opts)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "VeryLazy",
		opts = function()
			return require("custom.configs.treesitter-context")
		end,
		config = function(_, opts)
			require("treesitter-context").setup(opts)
		end,
	},
}

return plugins

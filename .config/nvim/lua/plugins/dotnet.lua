local Lsp = require("utils.lsp")

return {
	{
		-- Roslyn LSP — the same C# language server that powers VS Code and Visual Studio.
		-- Handles solution/project discovery, analyzers, code actions, refactoring, etc.
		-- Requires: dotnet SDK 10+, roslyn-language-server (installed via Mason or dotnet tool).
		"seblyng/roslyn.nvim",
		ft = "cs",
		dependencies = { "williamboman/mason.nvim" },
		---@module 'roslyn.config'
		---@type RoslynNvimConfig
		opts = {
			broad_search = true,
		},
		config = function(_, opts)
			-- Wire LSP config for roslyn before calling setup
			vim.lsp.config("roslyn", {
				on_attach = Lsp.on_attach,
			})
			require("roslyn").setup(opts)
		end,
	},
	{
		-- DAP adapter for .NET — mirrors the nvim-dap-go pattern.
		-- Requires: netcoredbg (installed via Mason).
		"NicholasMata/nvim-dap-cs",
		ft = "cs",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			require("dap-cs").setup()

			-- Ensure DOTNET_ROOT is in the adapter environment so netcoredbg
			-- can find the .NET 10 runtime managed by mise.
			local dap = require("dap")
			local dotnet_root = vim.env.DOTNET_ROOT or (vim.env.HOME .. "/.local/share/mise/dotnet-root")
			dap.adapters.coreclr = {
				type = "executable",
				command = vim.fn.exepath("netcoredbg"),
				args = { "--interpreter=vscode" },
				options = {
					env = {
						DOTNET_ROOT = dotnet_root,
						PATH = vim.env.PATH,
						HOME = vim.env.HOME,
					},
				},
			}
		end,
	},
}

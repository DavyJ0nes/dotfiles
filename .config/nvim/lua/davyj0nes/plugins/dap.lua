return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"Weissle/persistent-breakpoints.nvim",
	},
	lazy = true,
	init = function()
		local keyset = vim.keymap.set
		local n = "n"

		keyset(n, "<leader>db", function()
			-- require("dap").toggle_breakpoint()
			require("persistent-breakpoints.api").toggle_breakpoint()
		end, { desc = "Add breakpoint to line" })

		keyset(n, "<leader>dx", function()
			-- require("dap").toggle_breakpoint()
			require("persistent-breakpoints.api").clear_all_breakpoints()
		end, { desc = "Clear all breakpoints" })

		keyset(n, "<leader>dc", function()
			require("dap").continue()
		end, { desc = "Dap continue" })

		keyset(n, "<leader>do", function()
			require("dap").step_over()
		end, { desc = "Dap step over" })

		keyset(n, "<leader>dr", function()
			require("dap").run_last()
		end, { desc = "Dap rerun" })

		keyset(n, "<leader>dq", function()
			require("dap").terminate()
		end, { desc = "Dap quit" })

		keyset(n, "<leader>dus", function()
			local widgets = require("dap.ui.widgets")
			local sidebar = widgets.sidebar(widgets.scopes)
			sidebar.open()
		end, { desc = "Open debugging sidebar" })

		keyset(n, "<leader>dso", function()
			local widgets = require("dap.ui.widgets")
			local sidebar = widgets.sidebar(widgets.scopes)
			sidebar.open()
		end, { desc = "Open debugging sidebar" })

		vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapStopped", { text = "👉", texthl = "", linehl = "", numhl = "" })
	end,

	config = function()
		local dap = require("dap")
		-- Elixir
		dap.adapters.mix_task = {
			type = "executable",
			command = vim.fn.stdpath("data") .. "/mason/bin/elixir-ls-debugger",
			args = {},
		}
		dap.configurations.elixir = {
			{
				type = "mix_task",
				name = "mix test",
				task = "test",
				taskArgs = { "--trace" },
				request = "launch",
				startApps = true, -- for Phoenix projects
				projectDir = "${workspaceFolder}",
				requireFiles = {
					"test/**/test_helper.exs",
					"test/**/*_test.exs",
				},
			},
		}

		require("persistent-breakpoints").setup({
			load_breakpoints_event = { "BufReadPost" },
		})
	end,
}

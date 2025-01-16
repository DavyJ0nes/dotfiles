return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
	init = function()
		local keymap = vim.keymap -- for conciseness
		keymap.set("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "Add breakpoint to line" })
		keymap.set("n", "<leader>do", "<cmd> DapStepOver <CR>", { desc = "Dap step over" })
		keymap.set("n", "<leader>dc", "<cmd> DapContinue <CR>", { desc = "Dap continue" })
		keymap.set("n", "<leader>dr", "<cmd> DapRerun <CR>", { desc = "Dap rerun" })
		keymap.set("n", "<leader>dq", "<cmd> DapTerminate <CR>", { desc = "Dap quit" })
		keymap.set("n", "<leader>dus", function()
			local widgets = require("dap.ui.widgets")
			local sidebar = widgets.sidebar(widgets.scopes)
			sidebar.open()
		end, { desc = "Open debugging sidebar" })
		keymap.set("n", "<leader>dso", function()
			local widgets = require("dap.ui.widgets")
			local sidebar = widgets.sidebar(widgets.scopes)
			sidebar.open()
		end, { desc = "Open debugging sidebar" })
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
		-- 	dap.adapters.codelldb = {
		-- 		type = "server",
		-- 		host = "127.0.0.1",
		-- 		port = 13000,
		-- 		executable = {
		-- 			command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb",
		-- 			args = { "--port", "13000" },
		-- 		},
		-- 	}
	end,
}

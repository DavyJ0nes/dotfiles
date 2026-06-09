return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},
		keys = {
			{ "<leader>db", function() require("persistent-breakpoints.api").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
			{ "<leader>dB", function() require("persistent-breakpoints.api").set_conditional_breakpoint() end, desc = "Conditional Breakpoint" },
			{ "<leader>dx", function() require("persistent-breakpoints.api").clear_all_breakpoints() end, desc = "Clear Breakpoints" },
			{ "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
			{ "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
			{ "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
			{ "<leader>dO", function() require("dap").step_out() end, desc = "Step Out" },
			{ "<leader>dr", function() require("dap").run_last() end, desc = "Rerun" },
			{ "<leader>du", function() require("dapui").toggle() end, desc = "DAP UI" },
			{ "<leader>dq", function() require("dap").terminate() require("dapui").close() end, desc = "Quit Debugger" },
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
      vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})

			dapui.setup({
				-- Custom window layout: a single left column only.
				-- Dropped the REPL, Watches and Console panes — no bottom panel.
				layouts = {
					{
						position = "left",
						size = 50, -- columns; wider than the default 40 to give the variables view room
						elements = {
							{ id = "scopes", size = 0.55 }, -- variables view; given the most space
							{ id = "stacks", size = 0.25 },
							{ id = "breakpoints", size = 0.20 },
						},
					},
				},
			})

			dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
			dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
			dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
		end,
	},
	{
		-- Persist nvim-dap breakpoints across restarts (project-scoped by cwd).
		-- Loaded on BufReadPre so its BufReadPost restore autocmd is registered
		-- before the first buffer is read. Breakpoints set via the keymaps above
		-- (which call this plugin's API) are saved to
		-- stdpath('data')/nvim_checkpoints/<cwd>.json automatically.
		"Weissle/persistent-breakpoints.nvim",
		event = { "BufReadPre" },
		config = function()
			require("persistent-breakpoints").setup({
				load_breakpoints_event = { "BufReadPost" },
			})
		end,
	},
	{
		"leoluz/nvim-dap-go",
		ft = "go",
		config = function()
			require("dap-go").setup({
				dap_configurations = {
					{
						type = "go",
						name = "Attach remote",
						mode = "remote",
						request = "attach",
					},
				},
				delve = {
					initialize_timeout_sec = 20,
					port = "${port}",
				},
			})
		end,
	},
}

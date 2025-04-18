return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
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

		keyset(n, "<leader>d?", function()
			require("dapui").eval(nil, { enter = true })
		end, { desc = "eval var under cursor" })

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

		dap.adapters.dlv_spawn = function(cb)
			local stdout = vim.loop.new_pipe(false)
			local handle
			local pid_or_err
			local port = 38697
			local opts = {
				stdio = { nil, stdout },
				args = { "dap", "-l", "127.0.0.1:" .. port },
				detached = true,
			}
			handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
				stdout:close()
				handle:close()
				if code ~= 0 then
					print("dlv exited with code", code)
				end
			end)
			assert(handle, "Error running dlv: " .. tostring(pid_or_err))
			stdout:read_start(function(err, chunk)
				assert(not err, err)
				if chunk then
					vim.schedule(function()
						--- You could adapt this and send `chunk` to somewhere else
						require("dap.repl").append(chunk)
					end)
				end
			end)
			-- Wait for delve to start
			vim.defer_fn(function()
				cb({ type = "server", host = "127.0.0.1", port = port })
			end, 100)
		end

		dap.configurations.go = {
			{
				type = "dlv_spawn",
				name = "Launch dlv & file",
				request = "launch",
				program = "${file}",
			},
		}

		require("persistent-breakpoints").setup({
			load_breakpoints_event = { "BufReadPost" },
		})
	end,
}

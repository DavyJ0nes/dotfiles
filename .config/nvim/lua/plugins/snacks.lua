local function git_root()
	local result = vim.fn.systemlist("git rev-parse --show-toplevel")
	return (vim.v.shell_error == 0 and result[1]) or vim.fn.getcwd()
end

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	keys = {
		-- Explorer
		{ "<leader>ee", function() Snacks.explorer.open({ cwd = git_root() }) end, desc = "Toggle File Explorer" },
		{ "<leader>ef", function() Snacks.explorer.open({ cwd = git_root(), reveal = true }) end, desc = "Reveal Current File" },

		-- Find / top-level
		{ "<leader><space>", function() Snacks.picker.files({ cwd = git_root() }) end, desc = "Find Files" },
		{ "<leader>/", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
		{ "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },

		-- Projects
		{
			"<leader>fp",
			function()
				local projects = require("project").get_recent_projects()
				Snacks.picker({
					title = "Projects",
					items = vim.tbl_map(function(p) return { text = p, file = p } end, projects),
					confirm = function(picker, item)
						picker:close()
						if item then
							vim.cmd("cd " .. item.text)
							Snacks.picker.files({ cwd = item.text })
						end
					end,
				})
			end,
			desc = "Projects",
		},

		-- Find
		{ "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
		{ "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
		{ "<leader>ff", function() Snacks.picker.files({ cwd = git_root() }) end, desc = "Find Files" },
		{ "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
		{ "<leader>fr", function() Snacks.picker.recent({ cwd = git_root(), filter = { cwd = true } }) end, desc = "Recent Files" },

		-- Git
		{ "<leader>gbb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
		{ "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
		{ "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
		{ "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
		{ "<leader>gd", function() Snacks.picker.git_status() end, desc = "Git Diff (Hunks)" },
		{ "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },

		-- Grep
		{ "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
		{ "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
		{ "<leader>sg", function() Snacks.picker.grep({ cwd = git_root() }) end, desc = "Grep" },
		{ "<leader>fw", function() Snacks.picker.grep({ cwd = git_root() }) end, desc = "Find Word (Grep)" },
		{ "<leader>sw", function() Snacks.picker.grep_word({ cwd = git_root() }) end, desc = "Grep Word", mode = { "n" } },
		{ "<leader>sw", function() Snacks.picker.grep_word({ cwd = git_root() }) end, desc = "Grep Selection", mode = { "x" } },

		-- Search / misc
		{ '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
		{ "<leader>fh", function() Snacks.picker.search_history() end, desc = "Search History" },
		{ "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
		{ "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
		{ "<leader>sH", function() Snacks.picker.help() end, desc = "Help Pages" },
		{ "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
		{ "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
		{ "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
		{ "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
		{ "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
		{ "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
		{ "<leader>sr", function() Snacks.picker.resume() end, desc = "Resume" },
		{ "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },

		-- Diagnostics
		{ "<leader>xw", function() Snacks.picker.diagnostics() end, desc = "Workspace Diagnostics" },
		{ "<leader>xx", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },

		-- LSP navigation
		{ "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
		{ "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
		{ "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
		{ "gi", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
		{ "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto Type Definition" },
		{ "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
		{ "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
	},
	opts = {
		dashboard = {
			preset = {
				header = table.concat({
					" ░▒▓███████▓▒░░▒▓████████▓▒░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓██████████████▓▒░  ",
					" ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ",
					" ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ",
					" ░▒▓█▓▒░░▒▓█▓▒░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ",
					" ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▓█▓▒░ ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ",
					" ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▓█▓▒░ ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ",
					" ░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░▒▓██████▓▒░   ░▒▓██▓▒░  ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ",
					"",
					"                                  GET TO WORK                                   ",
				}, "\n"),
			},
			sections = {
				{ section = "header" },
				{ section = "recent_files", cwd = true, limit = 10, padding = 1 },
				{ section = "startup" },
			},
		},
		explorer = {
			replace_netrw = true,
		},
		picker = {
			sources = {
				explorer = {
					auto_close = true,
					hidden = true,
				},
				files = {
					hidden = true,
					follow = true,
				},
				grep = {
					hidden = true,
					follow = true,
				},
			},
			ui_select = true,
		},
	},
}

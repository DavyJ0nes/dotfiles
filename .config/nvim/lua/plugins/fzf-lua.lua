return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local fzf = require("fzf-lua")
		fzf.setup({
			winopts = {
				width = 0.9,
				height = 0.85,
				preview = {
					default = "bat",
					layout = "flex",
					flip_columns = 120,
				},
			},
			fzf_opts = {
				["--cycle"] = true,
			},
			defaults = {
				file_icons = true,
				color_icons = true,
				git_icons = true,
				cwd_prompt = true,
			},
			files = {
				hidden = true,
				follow = true,
				fd_opts = "--hidden --follow --exclude .git --exclude node_modules --exclude target",
			},
			grep = {
				hidden = true,
				follow = true,
				rg_opts = "--column --line-number --no-heading --color=always --smart-case --hidden --follow --glob '!.git' --glob '!node_modules' --glob '!target'",
			},
			fzf_colors = true,
		})

		-- drive vim.ui.select (code actions, etc.) through fzf
		fzf.register_ui_select()
	end,
	keys = {
		-- Smart find / top-level
		{
			"<leader><space>",
			function()
				require("fzf-lua").files()
			end,
			desc = "Find Files",
		},
		{
			"<leader>/",
			function()
				require("fzf-lua").blines()
			end,
			desc = "Buffer Lines",
		},
		{
			"<leader>:",
			function()
				require("fzf-lua").command_history()
			end,
			desc = "Command History",
		},

		-- Projects
		{
			"<leader>fp",
			function()
				require("fzf-lua").fzf_exec(require("project").get_recent_projects(), {
					prompt = "Projects> ",
					actions = {
						["default"] = function(sel)
							if sel[1] then
								vim.cmd("cd " .. sel[1])
								require("fzf-lua").files({ cwd = sel[1] })
							end
						end,
					},
				})
			end,
			desc = "Projects",
		},
		-- Explorer (handled by neo-tree.lua, but kept here so which-key shows it)
		-- { "<leader>ee", ... } -- defined in neo-tree.lua
		-- Find
		{
			"<leader>fb",
			function()
				require("fzf-lua").buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>fc",
			function()
				require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
			end,
			desc = "Find Config File",
		},
		{
			"<leader>ff",
			function()
				require("fzf-lua").files()
			end,
			desc = "Find Files",
		},
		{
			"<leader>fg",
			function()
				require("fzf-lua").git_files()
			end,
			desc = "Find Git Files",
		},
		{
			"<leader>fr",
			function()
				require("fzf-lua").oldfiles()
			end,
			desc = "Recent Files",
		},
		-- Git
		{
			"<leader>gbb",
			function()
				require("fzf-lua").git_branches()
			end,
			desc = "Git Branches",
		},
		{
			"<leader>gl",
			function()
				require("fzf-lua").git_commits()
			end,
			desc = "Git Log",
		},
		{
			"<leader>gL",
			function()
				require("fzf-lua").git_bcommits()
			end,
			desc = "Git Log Line",
		},
		{
			"<leader>gs",
			function()
				require("fzf-lua").git_status()
			end,
			desc = "Git Status",
		},
		{
			"<leader>gd",
			function()
				require("fzf-lua").git_status()
			end,
			desc = "Git Diff (Hunks)",
		},
		{
			"<leader>gf",
			function()
				require("fzf-lua").git_bcommits()
			end,
			desc = "Git Log File",
		},
		-- Grep
		{
			"<leader>sb",
			function()
				require("fzf-lua").blines()
			end,
			desc = "Buffer Lines",
		},
		{
			"<leader>sB",
			function()
				require("fzf-lua").grep_buffers()
			end,
			desc = "Grep Open Buffers",
		},
		{
			"<leader>sg",
			function()
				require("fzf-lua").live_grep()
			end,
			desc = "Grep",
		},
		{
			"<leader>fw",
			function()
				require("fzf-lua").live_grep()
			end,
			desc = "Find Word (Grep)",
		},
		{
			"<leader>sw",
			function()
				require("fzf-lua").grep_cword()
			end,
			desc = "Grep Word",
			mode = { "n" },
		},
		{
			"<leader>sw",
			function()
				require("fzf-lua").grep_visual()
			end,
			desc = "Grep Selection",
			mode = { "x" },
		},
		-- Search / misc
		{
			'<leader>s"',
			function()
				require("fzf-lua").registers()
			end,
			desc = "Registers",
		},
		{
			"<leader>fh",
			function()
				require("fzf-lua").search_history()
			end,
			desc = "Search History",
		},
		{
			"<leader>sc",
			function()
				require("fzf-lua").command_history()
			end,
			desc = "Command History",
		},
		{
			"<leader>sC",
			function()
				require("fzf-lua").commands()
			end,
			desc = "Commands",
		},
		{
			"<leader>sH",
			function()
				require("fzf-lua").help_tags()
			end,
			desc = "Help Pages",
		},
		{
			"<leader>sj",
			function()
				require("fzf-lua").jumps()
			end,
			desc = "Jumps",
		},
		{
			"<leader>sk",
			function()
				require("fzf-lua").keymaps()
			end,
			desc = "Keymaps",
		},
		{
			"<leader>sl",
			function()
				require("fzf-lua").loclist()
			end,
			desc = "Location List",
		},
		{
			"<leader>sm",
			function()
				require("fzf-lua").marks()
			end,
			desc = "Marks",
		},
		{
			"<leader>sM",
			function()
				require("fzf-lua").man_pages()
			end,
			desc = "Man Pages",
		},
		{
			"<leader>sq",
			function()
				require("fzf-lua").quickfix()
			end,
			desc = "Quickfix List",
		},
		{
			"<leader>sr",
			function()
				require("fzf-lua").resume()
			end,
			desc = "Resume",
		},
		{
			"<leader>uC",
			function()
				require("fzf-lua").colorschemes()
			end,
			desc = "Colorschemes",
		},
		-- Diagnostics
		{
			"<leader>xw",
			function()
				require("fzf-lua").diagnostics_workspace()
			end,
			desc = "Workspace Diagnostics",
		},
		{
			"<leader>xx",
			function()
				require("fzf-lua").diagnostics_document()
			end,
			desc = "Buffer Diagnostics",
		},
		-- LSP navigation — same keys as before
		{
			"gd",
			function()
				require("fzf-lua").lsp_definitions()
			end,
			desc = "Goto Definition",
		},
		{
			"gD",
			function()
				require("fzf-lua").lsp_declarations()
			end,
			desc = "Goto Declaration",
		},
		{
			"gr",
			function()
				require("fzf-lua").lsp_references()
			end,
			nowait = true,
			desc = "References",
		},
		{
			"gi",
			function()
				require("fzf-lua").lsp_implementations()
			end,
			desc = "Goto Implementation",
		},
		{
			"gy",
			function()
				require("fzf-lua").lsp_typedefs()
			end,
			desc = "Goto Type Definition",
		},
		{
			"<leader>ss",
			function()
				require("fzf-lua").lsp_document_symbols()
			end,
			desc = "LSP Symbols",
		},
		{
			"<leader>sS",
			function()
				require("fzf-lua").lsp_live_workspace_symbols()
			end,
			desc = "LSP Workspace Symbols",
		},
	},
}

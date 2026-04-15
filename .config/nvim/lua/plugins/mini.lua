return {
	"echasnovski/mini.nvim",
	version = "*",
	config = function()
		require("mini.ai").setup({ n_lines = 500 })
		require("mini.surround").setup()
		require("mini.pairs").setup()
		require("mini.indentscope").setup({
			symbol = "│",
			options = { try_as_border = true },
		})

		local starter = require("mini.starter")
		starter.setup({
			evaluate_single = true,
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
			items = {
				function()
					local path = require("utils.path")
					local cwd = vim.fn.getcwd()
					local root = path.get_git_root() or cwd
					local files = {}
					for _, f in ipairs(vim.v.oldfiles) do
						if vim.startswith(f, root) and vim.fn.filereadable(f) == 1 then
							local name = vim.fn.fnamemodify(f, ":~:.")
							table.insert(files, { name = name, action = "edit " .. f, section = "Recent Files" })
							if #files >= 10 then break end
						end
					end
					if #files == 0 then
						return starter.sections.recent_files(10, false, false)()
					end
					return files
				end,
				starter.sections.builtin_actions(),
			},
			content_hooks = {
				starter.gen_hook.adding_bullet(),
				starter.gen_hook.aligning("center", "center"),
			},
			footer = "",
		})
	end,
}

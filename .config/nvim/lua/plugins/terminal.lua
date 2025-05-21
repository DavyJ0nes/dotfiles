return {
	"akinsho/toggleterm.nvim",
	version = "*",

	config = function()
		local opts = {
			size = function(term)
				if term.direction == "horizontal" then
					return 15
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				end
			end,
			float_opts = {
				border = "curved",
				height = math.floor(vim.o.lines - 3),
				width = math.floor(vim.o.columns - 2),
			},
		}
		require("toggleterm").setup(opts)
		local terminal = require("toggleterm.terminal").Terminal
		local lazygit = terminal:new({
			cmd = "lazygit",
			dir = "git_dir",
			direction = "float",
			float_opts = {
				border = "double",
			},
			-- function to run on opening the terminal
			on_open = function(term)
				vim.cmd("startinsert!")
				vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
			end,
			-- function to run on closing the terminal
			on_close = function(_)
				vim.cmd("startinsert!")
			end,
		})

		function _lazygit_toggle()
			lazygit:toggle()
		end

		vim.api.nvim_set_keymap(
			"n",
			"<leader>gt",
			"<cmd>lua _lazygit_toggle()<CR>",
			{ noremap = true, silent = true, desc = "open lazygit" }
		)
	end,
}

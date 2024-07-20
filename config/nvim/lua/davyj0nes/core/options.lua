vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

-- line numbering
opt.relativenumber = true
opt.number = true
opt.numberwidth = 2

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tabs to spaces
opt.autoindent = true -- use indentation from line above

opt.wrap = false

-- search settings
opt.ignorecase = true -- ignore case when seaching
opt.smartcase = true -- if mixed case then use that

opt.cursorline = true

-- UI
-- vim.cmd("colorscheme nightfox")
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.colorcolumn = "79,119"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default

-- window splits
opt.splitright = true
opt.splitbelow = true

-- turn off swapfile
opt.swapfile = false

-- disable some default providers
for _, provider in ipairs({ "node", "perl", "python3", "ruby" }) do
	vim.g["loaded_" .. provider .. "_provider"] = 0
end

-- add binaries installed by mason.nvim to path
local is_windows = vim.fn.has("win32") ~= 0
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH

-------------------------------------- autocmds -------------------------------
local autocmd = vim.api.nvim_create_autocmd

-- dont list quickfix buffers
autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.opt_local.buflisted = false
	end,
})

-- start terminal in insert mode
autocmd({ "WinEnter", "BufWinEnter", "TermOpen" }, {
	callback = function(args)
		if vim.startswith(vim.api.nvim_buf_get_name(args.buf), "term://") then
			vim.cmd("startinsert")
		end
	end,
})

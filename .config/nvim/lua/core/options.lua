local opt = vim.opt

-- line numbering
opt.relativenumber = true
opt.number = true
opt.numberwidth = 2

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.breakindent = true

opt.wrap = false
opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- search
opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

-- UI
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.colorcolumn = "79,119"
opt.mouse = ""
opt.conceallevel = 2
opt.concealcursor = "nc"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- performance
opt.updatetime = 250

-- window splits
opt.splitright = true
opt.splitbelow = true
opt.swapfile = false

-- disable some default providers
for _, provider in ipairs({ "node", "perl", "python3", "ruby" }) do
	vim.g["loaded_" .. provider .. "_provider"] = 0
end

-- add mason binaries to path
local is_windows = vim.fn.has("win32") ~= 0
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH

-- diagnostics
vim.diagnostic.config({
	virtual_text = { current_line = true },
})

-- treat livemd as markdown
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.livemd",
	command = "set filetype=markdown",
})

-- suppress noisy markdown treesitter conceal of code blocks
require("vim.treesitter.query").set(
	"markdown",
	"highlights",
	[[
;From MDeiml/tree-sitter-markdown
[
  (fenced_code_block_delimiter)
] @punctuation.delimiter
]]
)

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
autocmd("TextYankPost", {
	group = augroup("highlight_yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Disable big-file performance hogs (treesitter, LSP semantic tokens)
autocmd("BufReadPre", {
	group = augroup("bigfile", { clear = true }),
	callback = function(ev)
		local max = 1024 * 1024 -- 1 MB
		local ok, stat = pcall(vim.uv.fs_stat, ev.match)
		if ok and stat and stat.size > max then
			vim.bo[ev.buf].swapfile = false
			vim.bo[ev.buf].undofile = false
			vim.opt_local.foldmethod = "manual"
			vim.cmd("syntax off")
			vim.notify("Big file — syntax and LSP disabled", vim.log.levels.WARN)
		end
	end,
})

-- Close certain windows with q
autocmd("FileType", {
	group = augroup("close_with_q", { clear = true }),
	pattern = { "help", "lspinfo", "man", "notify", "qf", "checkhealth" },
	callback = function(ev)
		vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = ev.buf, silent = true })
	end,
})

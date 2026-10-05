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

-- Detect Helm chart templates
autocmd({ "BufRead", "BufNewFile" }, {
	group = augroup("helm_filetype", { clear = true }),
	pattern = { "*/templates/*.yaml", "*/templates/*.tpl", "*/templates/**/*.yaml", "*/templates/**/*.tpl" },
	callback = function()
		if vim.fs.find("Chart.yaml", { upward = true, path = vim.fn.expand("%:p:h") })[1] then
			vim.bo.filetype = "helm"
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

-- In markdown: gd opens URL under cursor in browser, falls back to LSP
autocmd("FileType", {
	group = augroup("markdown_gd_open", { clear = true }),
	pattern = "markdown",
	callback = function(ev)
		vim.keymap.set("n", "gd", function()
			local line = vim.api.nvim_get_current_line()
			local col = vim.api.nvim_win_get_cursor(0)[2] + 1 -- 1-indexed

			-- Check for markdown link [text](url) with a web URL under cursor
			for s, url, e in line:gmatch("()%[.-%]%((.-)%)()" ) do
				if col >= s and col < e and url:match("^https?://") then
					vim.ui.open(url)
					return
				end
			end

			-- Check for raw URL under cursor via <cfile>
			local cfile = vim.fn.expand("<cfile>")
			if cfile:match("^https?://") then
				vim.ui.open(cfile)
				return
			end

			-- Fall back to LSP definition
			Snacks.picker.lsp_definitions()
		end, { buffer = ev.buf, silent = true, desc = "Open link or goto definition" })
	end,
})

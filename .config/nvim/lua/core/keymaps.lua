local set = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " m"

-- enable mouse mode
function ToggleMouse()
	if vim.opt.mouse == "a" then
		vim.opt.mouse = ""
		print("Mouse mode disabled")
	else
		vim.opt.mouse = "a"
		print("Mouse mode enabled")
	end
end
set("n", "<leader>em", ":lua ToggleMouse()<CR>", { desc = "Enable mouse mode" })

-- Better up/down
set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Resize window using <ctrl> arrow keys
set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Goto
set("n", "gl", "$", { desc = "Go to end of line" })
set("n", "gh", "^", { desc = "Go to start of line" })
set("n", "gb", "<C-o>", { desc = "Go back" })

-- handle typos
set("n", ":Wq<CR>", ":wq<CR>", { desc = "write and quit" })
set("n", ":W<CR>", ":w<CR>", { desc = "write" })
set("n", "<A-s>", ":w<CR>", { desc = "alt save" })
set("n", ":Q<CR>", ":q<CR>", { desc = "quit" })
set("n", "<leader>q", ":q<CR>", { desc = "quit" })
set("n", "<leader>w", ":w<CR>", { desc = "write" })

-- clear search highlights
set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- window management
set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

set("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "Create new tab" })
set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
set("n", "<tab>", "<cmd>tabn<CR>", { desc = "Go to next tab" })
set("n", "<shift><tab>", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
set("n", "<leader>bt", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- buffers
set("n", "<leader>bp", "<cmd>bprev<CR>", { desc = "previous buffer" })
set("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "next buffer" })
set("n", "<leader>bx", "<cmd>bdelete<CR>", { desc = "close buffer" })

-- db ui
set("n", "∂", function()
	vim.cmd("tabnew")
	vim.cmd("DBUI")
end, { desc = "toggle db ui" })

-- spellcheck
set("n", "<leader>son", "<cmd> set spell spelllang=en_gb<CR>", { desc = "enable spellcheck" })
set("n", "<leader>soff", "<cmd> set nospell<CR>", { desc = "disable spellcheck" })

-- LSP (buffer-local via LspAttach, but global defaults here)
set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions" })
set("v", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions" })
set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Code Rename" })
set("n", "<leader>cf", vim.lsp.buf.format, { desc = "Code Format" })
set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })

-- test
set("n", "<leader>ta", function()
	require("neotest").run.attach()
end, { desc = "[t]est [a]ttach" })
set("n", "<leader>tf", function()
	require("neotest").run.run(vim.fn.expand("%"))
end, { desc = "[t]est run [f]ile" })
set("n", "<leader>tA", function()
	require("neotest").run.run(vim.uv.cwd())
end, { desc = "[t]est [A]ll files" })
set("n", "<leader>tS", function()
	require("neotest").run.run({ suite = true })
end, { desc = "[t]est [S]uite" })
set("n", "<leader>tt", function()
	require("neotest").run.run()
end, { desc = "[t]est neares[t]" })
set("n", "<leader>tl", function()
	require("neotest").run.run_last()
end, { desc = "[t]est [l]ast" })
set("n", "<leader>ts", function()
	require("neotest").summary.toggle()
end, { desc = "[t]est [s]ummary" })
set("n", "<leader>to", function()
	require("neotest").output.open({ enter = true, auto_close = true })
end, { desc = "[t]est [o]utput" })
set("n", "<leader>tO", function()
	require("neotest").output_panel.toggle()
end, { desc = "[t]est [O]utput panel" })
set("n", "<leader>td", function()
	require("neotest").run.run({ suite = false, strategy = "dap" })
end, { desc = "Debug nearest test" })
set("n", "<leader>tw", function()
	require("neotest").watch.toggle()
end, { desc = "Toggle test watch" })

-- csv
set("n", "<leader>vc", "<cmd>CsvViewToggle<cr>", { desc = "Toggle csv view" })

-- project
set("n", "<leader>pp", "<cmd>Project<cr>", { desc = "open project menu" })

-- vim kata
set("n", "<leader>kk", "<cmd>VimKataMenu<cr>", { desc = "open katas" })

-- notes
set("n", "<leader>oi", "<cmd>ObsidianToday<cr>", { desc = "Open today's note" })
set("n", "<leader>oy", "<cmd>ObsidianYesterday<cr>", { desc = "Open yesterday's note" })
set("n", "<leader>nn", function()
	require("zk.commands").get("ZkNew")({ title = vim.fn.input("Title: ") })
end, { desc = "new note" })
set("v", "<leader>nt", ":'<,'>ZkNewFromTitleSelection<CR>", { desc = "new note title" })
set("v", "<leader>ns", ":'<,'>ZkNewFromContentSelection<CR>", { desc = "new note selection" })
set("n", "<leader>nl", function()
	require("zk.commands").get("ZkInsertLink")()
end, { desc = "insert link" })
set("v", "<leader>nl", function()
	require("zk.commands").get("ZkInsertLinkAtSelection")()
end, { desc = "insert link" })
set("n", "<leader>fzl", function()
	require("zk.commands").get("ZkLinks")()
end, { desc = "find zk links" })
set("n", "<leader>fzb", function()
	require("zk.commands").get("ZkBacklinks")()
end, { desc = "find zk backlinks" })
set("n", "<leader>fn", function()
	require("zk.commands").get("ZkNotes")({ sort = { "modified" } })
end, { desc = "find zk notes" })
set("n", "<leader>fzt", function()
	require("zk.commands").get("ZkTags")()
end, { desc = "find zk tags" })

-- quickfix
set("n", "<leader>xn", "<cmd>cnext<cr>", { desc = "Next quickfix" })
set("n", "<leader>xp", "<cmd>cprev<cr>", { desc = "Prev quickfix" })

-- notifications (noice)
set("n", "<leader>uH", "<cmd>Noice<CR>", { desc = "Notification History" })
set("n", "<leader>un", "<cmd>Noice dismiss<CR>", { desc = "Dismiss Notifications" })

-- git
set("n", "<leader>gbl", function()
	require("gitsigns").blame_line({ full = true })
end, { desc = "Git Blame Line" })

-- lazygit in a floating terminal
set("n", "<leader>gt", function()
	local width = math.floor(vim.o.columns * 0.95)
	local height = math.floor(vim.o.lines * 0.90)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
	})
	vim.fn.termopen("lazygit", {
		on_exit = function()
			vim.api.nvim_win_close(0, true)
		end,
	})
	vim.cmd("startinsert")
end, { desc = "LazyGit" })

-- worktrees
set("n", "<leader>gw", function()
	require("worktrees").open_picker()
end, { desc = "Git Worktrees" })

-- goto test / source file
local function goto_test()
	local current_path = vim.api.nvim_buf_get_name(0)
	if current_path == "" then
		vim.notify("Buffer has no associated file", vim.log.levels.WARN)
		return
	end

	local filename = vim.fn.fnamemodify(current_path, ":t")
	local dirname = vim.fn.fnamemodify(current_path, ":h")
	local derived_path = nil

	-- Go: file.go <-> file_test.go
	if filename:match("%.go$") and not filename:match("_test.go$") then
		derived_path = vim.fs.joinpath(dirname, (filename:gsub("%.go$", "_test.go")))
	elseif filename:match("_test.go$") then
		derived_path = vim.fs.joinpath(dirname, (filename:gsub("_test.go$", ".go")))

	-- Elixir: lib/../file.ex <-> test/../file_test.exs
	elseif filename:match("%.ex$") then
		local test_filename = (filename:gsub("%.ex$", "_test.exs"))
		local test_dirname = (dirname:gsub("/lib$", "/test"))
		if test_dirname == dirname then
			test_dirname = (dirname:gsub("/lib/", "/test/"))
		end
		if test_dirname ~= dirname then
			derived_path = vim.fs.joinpath(test_dirname, test_filename)
		else
			derived_path = vim.fs.joinpath(dirname, test_filename)
		end
	elseif filename:match("_test.exs$") then
		local source_filename = (filename:gsub("_test.exs$", ".ex"))
		local source_dirname = (dirname:gsub("/test$", "/lib"))
		if source_dirname == dirname then
			source_dirname = (dirname:gsub("/test/", "/lib/"))
		end
		if source_dirname ~= dirname then
			derived_path = vim.fs.joinpath(source_dirname, source_filename)
		else
			derived_path = vim.fs.joinpath(dirname, source_filename)
		end

	-- TypeScript: file.ts(x) <-> file.test.ts(x) / file.spec.ts(x)
	elseif filename:match("%.test%.tsx?$") or filename:match("%.spec%.tsx?$") then
		local source_filename = filename:gsub("%.test%.tsx?$", ""):gsub("%.spec%.tsx?$", "")
		local ext = filename:match("%.tsx?$")
		source_filename = source_filename .. ext
		local source_dirname = (dirname:gsub("/test$", "/src"))
		if source_dirname == dirname then
			source_dirname = (dirname:gsub("/test/([^/].*)$", "/src/%1"))
		end
		if source_dirname ~= dirname then
			derived_path = vim.fs.joinpath(source_dirname, source_filename)
		else
			derived_path = vim.fs.joinpath(dirname, source_filename)
		end
	elseif filename:match("%.tsx?$") and not filename:match("%.d.ts$") then
		local base = (filename:gsub("%.tsx?$", ""))
		local ext = filename:match("%.tsx?$")
		local test_dirname = (dirname:gsub("/src$", "/test"))
		if test_dirname == dirname then
			test_dirname = (dirname:gsub("/src/([^/].*)$", "/test/%1"))
		end
		if test_dirname ~= dirname then
			local candidates = {
				vim.fs.joinpath(test_dirname, base .. ".test" .. ext),
				vim.fs.joinpath(test_dirname, base .. ".spec" .. ext),
			}
			for _, candidate in ipairs(candidates) do
				if vim.fn.filereadable(candidate) == 1 then
					derived_path = candidate
					break
				end
			end
			if not derived_path then
				derived_path = candidates[1]
			end
		else
			local candidates = {
				vim.fs.joinpath(dirname, base .. ".test" .. ext),
				vim.fs.joinpath(dirname, base .. ".spec" .. ext),
			}
			for _, candidate in ipairs(candidates) do
				if vim.fn.filereadable(candidate) == 1 then
					derived_path = candidate
					break
				end
			end
			if not derived_path then
				derived_path = candidates[1]
			end
		end
	end

	if derived_path and vim.fn.filereadable(derived_path) == 1 then
		vim.cmd("edit " .. vim.fn.fnameescape(derived_path))
	elseif derived_path then
		vim.notify("Guessed path not found: " .. derived_path, vim.log.levels.WARN)
	else
		vim.notify("Could not determine corresponding file for: " .. filename, vim.log.levels.INFO)
	end
end

vim.keymap.set("n", "gt", goto_test, { noremap = true, silent = true, desc = "Switch to Test/Source File" })

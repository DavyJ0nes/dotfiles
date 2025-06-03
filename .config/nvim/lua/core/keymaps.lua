local set = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " m" -- was being used by conjure

-- paste without yanking
set("x", "<leader>p", [["_dP]])

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
set("n", "<A-s>", ":w<CR>", { desc = "alt [s]ave" })
set("n", ":Q<CR>", ":q<CR>", { desc = "quit" })
set("n", "<leader>q", ":q<CR>", { desc = "quit" })
set("n", "<leader>w", ":w<CR>", { desc = "write" })

-- clear search highlights
set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
-- increment/decrement numbers
set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

set("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "Create new tab" }) --  go to next tab
set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
set("n", "<tab>", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
set("n", "<shift><tab>", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
set("n", "<leader>bt", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- buffers
set("n", "<leader>bp", "<cmd>bprev<CR>", { desc = "previous buffer" })
set("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "next buffer" })
set("n", "<leader>bx", "<cmd>bdelete<CR>", { desc = "close buffer" })

-- terminal
local trim_spaces = true
set({ "n", "t" }, "<A-t>", "<cmd>ToggleTerm direction=float display_name=term<CR>", { desc = "toggle terminal" })
set({ "n", "t" }, "<leader>ro", "<cmd>ToggleTerm direction=vertical display_name=repl<CR>", { desc = "toggle repl" })
set({ "n", "t" }, "<A-i>", "<cmd>ToggleTerm direction=vertical display_name=repl<CR>", { desc = "toggle repl" })

set("v", "<leader>rs", function()
	require("toggleterm").send_lines_to_terminal("visual_lines", trim_spaces, { args = vim.v.count })
end, { desc = "repl eval" })

set("t", "<C-x>", "<C-\\><C-n>", { desc = "exit term mode" })

-- db ui
set("n", "∂", function()
	-- Open a new tab
	vim.cmd("tabnew")
	-- Call the DBUI function
	vim.cmd("DBUI")
end, { desc = "toggle db ui" })

-- spellcheck
set("n", "<leader>son", "<cmd> set spell spelllang=en_gb<CR>", { desc = "enable spellcheck" })
set("n", "<leader>soff", "<cmd> set nospell<CR>", { desc = "disable spellcheck" })

-- AI
local opts = { noremap = true, silent = true }

opts.desc = "Toggle AI Chat"
set({ "n", "v" }, "<leader>ai", "<cmd>CodeCompanionChat Toggle<CR>", opts)

opts.desc = "Toggle AI Actions"
set({ "n", "v" }, "<leader>aa", "<cmd>CodeCompanionActions<CR>", opts)

opts.desc = "Add selection to chat"
set("v", "ga", "<cmd>CodeCompanionChat Add<CR>", opts)

opts.desc = "Add AI Comment"
set({ "v" }, "<leader>apc", function()
	require("codecompanion").prompt("comment")
end, opts)

opts.desc = "Generate Go Tests"
set({ "v" }, "<leader>apt", function()
	require("codecompanion").prompt("gen_test")
end, opts)

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

set("n", "<leader>tt", function()
	require("neotest").run.run()
end, { desc = "Run test" })

set("n", "<leader>tf", function()
	require("neotest").run.run(vim.fn.expand("%"))
end, { desc = "Run tests on whole file" })

set("n", "<leader>tf", function()
	require("neotest").run.run(vim.fn.expand("%"))
end, { desc = "Run tests on whole file" })

set("n", "<leader>tl", function()
	require("neotest").run.run_last()
end, { desc = "Run last test" })

set("n", "<leader>ts", function()
	require("neotest").summary.toggle()
end, { desc = "Toggle test summary" })

set("n", "<leader>tw", function()
	require("neotest").watch.toggle()
end, { desc = "Toggle test watch" })

set("n", "<leader>vc", "<cmd>CsvViewToggle<cr>", { desc = "Toggle csv view" })

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
set("n", "<leader>xp", "<cmd>cclose<cr>", { desc = "Close quickfix" })

local function goto_test()
	local current_path = vim.api.nvim_buf_get_name(0)
	if current_path == "" then
		vim.notify("Buffer has no associated file", vim.log.levels.WARN)
		return
	end

	local filename = vim.fn.fnamemodify(current_path, ":t")
	local dirname = vim.fn.fnamemodify(current_path, ":h")
	local derived_path = nil

	-- Go: file.go <-> file_test.go (same directory)
	if filename:match("%.go$") and not filename:match("_test.go$") then
		derived_path = vim.fs.joinpath(dirname, (filename:gsub("%.go$", "_test.go"))) -- Use parentheses around gsub
	elseif filename:match("_test.go$") then
		derived_path = vim.fs.joinpath(dirname, (filename:gsub("_test.go$", ".go"))) -- Use parentheses around gsub

	-- Elixir: lib/../file.ex <-> test/../file_test.exs
	elseif filename:match("%.ex$") then -- Source file to test file
		local test_filename = (filename:gsub("%.ex$", "_test.exs")) -- Use parentheses around gsub
		local test_dirname = (dirname:gsub("/lib$", "/test")) -- Replace lib at the start with test
		if test_dirname == dirname then -- Handle cases where 'lib' is not at the start
			test_dirname = (dirname:gsub("/lib/", "/test/")) -- Replace /lib/ anywhere with /test/
		end
		-- DEBUG
		-- vim.notify(
		-- 	"sub names. filename: " .. test_filename .. ". dirname: " .. dirname .. ". test_dirname: " .. test_dirname,
		-- 	vim.log.levels.INFO
		-- )
		if test_dirname ~= dirname then -- Only construct path if directory changed
			derived_path = vim.fs.joinpath(test_dirname, test_filename)
		else
			-- Maybe the test file is in the same directory? (Less common for Elixir)
			-- derived_path = vim.fs.joinpath(dirname, test_filename)
			vim.notify("Could not determine Elixir test directory structure from: " .. dirname, vim.log.levels.INFO)
		end
	elseif filename:match("_test.exs$") then -- Test file to source file
		local source_filename = (filename:gsub("_test.exs$", ".ex")) -- Use parentheses around gsub
		local source_dirname = (dirname:gsub("/test$", "/lib")) -- Replace test at the start with lib
		if source_dirname == dirname then -- Handle cases where 'test' is not at the start
			source_dirname = (dirname:gsub("/test/", "/lib/")) -- Replace /test/ anywhere with /lib/
		end
		if source_dirname ~= dirname then -- Only construct path if directory changed
			derived_path = vim.fs.joinpath(source_dirname, source_filename)
		else
			vim.notify("Could not determine Elixir source directory structure from: " .. dirname, vim.log.levels.INFO)
		end
	end
	-- NOTE: Removed Python logic, added Elixir logic. Add more rules as needed.

	-- Open the derived path if it exists
	if derived_path and vim.fn.filereadable(derived_path) == 1 then
		vim.cmd("edit " .. vim.fn.fnameescape(derived_path))
	elseif derived_path then
		vim.notify("Guessed path not found or not readable: " .. derived_path, vim.log.levels.WARN)
	else
		vim.notify("Could not determine corresponding file for: " .. filename, vim.log.levels.INFO)
	end
end

-- Set the keymap
-- Use <leader>st in normal mode to trigger the switch
vim.keymap.set("n", "gt", goto_test, { noremap = true, silent = true, desc = "Switch to Test/Source File" })

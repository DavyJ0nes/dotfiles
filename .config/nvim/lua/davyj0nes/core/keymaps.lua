local set = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " m" -- was being used by conjure

-- paste without yanking
set("x", "<leader>p", [["_dP]])

-- handle typos
set("n", ":Wq<CR>", ":wq<CR>", { desc = "write and quit" })
set("n", ":W<CR>", ":w<CR>", { desc = "write" })
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
set({ "n", "t" }, "†", function()
	Snacks.terminal()
end, { desc = "toggle terminal" })
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

set("n", "<leader>to", function()
	require("neotest").output_panel.toggle({ enter = true, auto_close = true })
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

-- set("n", "<leader>to", function()
-- 	require("neotest").output.open({ enter = true })
-- end, { desc = "Toggle test output panel" })

set("n", "<leader>tw", function()
	require("neotest").watch.toggle()
end, { desc = "Toggle test watch" })

-- notes
set("n", "<leader>oi", "<cmd>ObsidianToday<cr>", { desc = "Open today's note" })
set("n", "<leader>oy", "<cmd>ObsidianYesterday<cr>", { desc = "Open yesterday's note" })

-- quickfix
set("n", "<leader>xn", "<cmd>cnext<cr>", { desc = "Next quickfix" })
set("n", "<leader>xp", "<cmd>cprev<cr>", { desc = "Prev quickfix" })
set("n", "<leader>xp", "<cmd>cclose<cr>", { desc = "Close quickfix" })

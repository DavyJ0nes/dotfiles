local keymap = vim.keymap

vim.g.mapleader = " "
vim.g.maplocalleader = " m" -- was being used by conjure

-- handle typos
keymap.set("n", ":Wq<CR>", ":wq<CR>", { desc = "write and quit" })
keymap.set("n", ":W<CR>", ":w<CR>", { desc = "write" })
keymap.set("n", ":Q<CR>", ":q<CR>", { desc = "quit" })
keymap.set("n", "<leader>q", ":q<CR>", { desc = "quit" })
keymap.set("n", "<leader>w", ":w<CR>", { desc = "write" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "Create new tab" }) --  go to next tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<tab>", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<shift><tab>", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>bt", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- terminal
keymap.set("n", "†", "<cmd>ToggleTerm direction=tab display_name=term<CR>", { desc = "toggle terminal" })
keymap.set("t", "†", "<cmd>ToggleTerm direction=tab display_name=term<CR>", { desc = "toggle terminal" })
keymap.set("n", "<leader>ot", "<cmd>ToggleTerm direction=tab display_name=term<CR>", { desc = "toggle terminal" })
keymap.set("t", "<leader>ot", "<cmd>ToggleTerm direction=tab display_name=term<CR>", { desc = "toggle terminal" })
keymap.set("t", "<C-x>", "<C-\\><C-n>", { desc = "exit term mode" })

-- db ui
keymap.set("n", "∂", function()
	-- Open a new tab
	vim.cmd("tabnew")
	-- Call the DBUI function
	vim.cmd("DBUI")
end, { desc = "toggle db ui" })

-- buffers
keymap.set("n", "<leader>bp", "<cmd>bprev<CR>", { desc = "previous buffer" })
keymap.set("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "next buffer" })
keymap.set("n", "<leader>bx", "<cmd>bdelete<CR>", { desc = "close buffer" })

-- spellcheck
keymap.set("n", "<leader>son", "<cmd> set spell spelllang=en_gb<CR>", { desc = "enable spellcheck" })
keymap.set("n", "<leader>soff", "<cmd> set nospell<CR>", { desc = "disable spellcheck" })
keymap.set("n", "<leader>ss", "<cmd>Telescope spell_suggest<CR>", { desc = "get spelling suggestion" })
keymap.set("n", "z=", "<cmd>Telescope spell_suggest<CR>", { desc = "get spelling suggestion" })

-- arrow
keymap.set("n", "mn", "<cmd>Arrow next_buffer_bookmark<CR>")
keymap.set("n", "mp", "<cmd>Arrow prev_buffer_bookmark<CR>")

-- test
keymap.set("n", "<leader>ta", function()
	require("neotest").run.attach()
end, { desc = "[t]est [a]ttach" })

keymap.set("n", "<leader>tf", function()
	require("neotest").run.run(vim.fn.expand("%"))
end, { desc = "[t]est run [f]ile" })

keymap.set("n", "<leader>tA", function()
	require("neotest").run.run(vim.uv.cwd())
end, { desc = "[t]est [A]ll files" })

keymap.set("n", "<leader>tS", function()
	require("neotest").run.run({ suite = true })
end, { desc = "[t]est [S]uite" })

keymap.set("n", "<leader>tt", function()
	require("neotest").run.run()
end, { desc = "[t]est neares[t]" })

keymap.set("n", "<leader>tl", function()
	require("neotest").run.run_last()
end, { desc = "[t]est [l]ast" })

keymap.set("n", "<leader>ts", function()
	require("neotest").summary.toggle()
end, { desc = "[t]est [s]ummary" })

keymap.set("n", "<leader>to", function()
	require("neotest").output.open({ enter = true, auto_close = true })
end, { desc = "[t]est [o]utput" })

keymap.set("n", "<leader>tO", function()
	require("neotest").output_panel.toggle()
end, { desc = "[t]est [O]utput panel" })

keymap.set("n", "<leader>td", function()
	require("neotest").run.run({ suite = false, strategy = "dap" })
end, { desc = "Debug nearest test" })

keymap.set("n", "<leader>tD", function()
	require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" })
end, { desc = "Debug current file" })

keymap.set("n", "<leader>tt", function()
	require("neotest").run.run()
end, { desc = "Run test" })

keymap.set("n", "<leader>tf", function()
	require("neotest").run.run(vim.fn.expand("%"))
end, { desc = "Run tests on whole file" })

keymap.set("n", "<leader>tf", function()
	require("neotest").run.run(vim.fn.expand("%"))
end, { desc = "Run tests on whole file" })

keymap.set("n", "<leader>tl", function()
	require("neotest").run.run_last()
end, { desc = "Run last test" })

keymap.set("n", "<leader>ts", function()
	require("neotest").summary.toggle()
end, { desc = "Toggle test summary" })

keymap.set("n", "<leader>to", function()
	require("neotest").output.open({ enter = true })
end, { desc = "Toggle test output panel" })

keymap.set("n", "<leader>tw", function()
	require("neotest").watch.toggle()
end, { desc = "Toggle test watch" })

-- notes
keymap.set("n", "<leader>oi", "<cmd>ObsidianToday<cr>", { desc = "Open today's note" })
keymap.set("n", "<leader>oy", "<cmd>ObsidianYesterday<cr>", { desc = "Open yesterday's note" })

-- copilot
keymap.set("n", "<leader>ai", "<cmd>CopilotChatToggle<cr>")
keymap.set("v", "<leader>air", "<cmd>CopilotChatReview<cr>")
keymap.set("v", "<leader>ait", "<cmd>CopilotChatTests<cr>")
keymap.set("v", "<leader>aie", "<cmd>CopilotChatExplain<cr>")

-- chatgpt

keymap.set("n", "<leader>ac", "<cmd>ChatGPT<CR>")
keymap.set({ "n", "v" }, "<leader>ae", "<cmd>ChatGPTEditWithInstruction<CR>")
keymap.set({ "n", "v" }, "<leader>aa", "<cmd>ChatGPTActAs<CR>")
keymap.set({ "n", "v" }, "<leader>ag", "<cmd>ChatGPTRun grammar_correction<CR>")
keymap.set({ "n", "v" }, "<leader>atr", "<cmd>ChatGPTRun translate<CR>")
keymap.set({ "n", "v" }, "<leader>ak", "<cmd>ChatGPTRun keywords<CR>")
keymap.set({ "n", "v" }, "<leader>ad", "<cmd>ChatGPTRun docstring<CR>")
keymap.set({ "n", "v" }, "<leader>at", "<cmd>ChatGPTRun add_tests<CR>")
keymap.set({ "n", "v" }, "<leader>ao", "<cmd>ChatGPTRun optimize_code<CR>")
keymap.set({ "n", "v" }, "<leader>as", "<cmd>ChatGPTRun summarize<CR>")
keymap.set({ "n", "v" }, "<leader>af", "<cmd>ChatGPTRun fix_bugs<CR>")
keymap.set({ "n", "v" }, "<leader>ax", "<cmd>ChatGPTRun explain_code<CR>")
keymap.set({ "n", "v" }, "<leader>ar", "<cmd>ChatGPTRun roxygen_edit<CR>")
keymap.set({ "n", "v" }, "<leader>al", "<cmd>ChatGPTRun code_readability_analysis<CR>")


local function setup_loading_template_on_new_file()
	local group = vim.api.nvim_create_augroup("NeorgLoadTemplateGroup", { clear = true })

	local is_buffer_empty = function(buffer)
		local content = vim.api.nvim_buf_get_lines(buffer, 0, -1, false)
		return not (#content > 1 or content[1] ~= "")
	end

	local callback = function(args)
		vim.schedule(function()
			if not is_buffer_empty(args.buf) then
				return
			end

			if string.find(args.file, "/journal/") then
				-- debug('loading template "journal" ' .. args.event)
				vim.api.nvim_cmd({ cmd = "Neorg", args = { "templates", "fload", "journal" } }, {})
			else
				-- debug("add metadata " .. args.event)
				vim.api.nvim_cmd({ cmd = "Neorg", args = { "inject-metadata" } }, {})
			end
		end)
	end

	vim.api.nvim_create_autocmd({ "BufNewFile", "BufNew" }, {
		desc = "Load template on new norg files",
		pattern = "*.norg",
		callback = callback,
		group = group,
	})
end

setup_loading_template_on_new_file()

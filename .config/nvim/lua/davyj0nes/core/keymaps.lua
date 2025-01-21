local keymap = vim.keymap

vim.g.mapleader = " "
vim.g.maplocalleader = " m" -- was being used by conjure

-- handle typos
keymap.set("n", ":Wq<CR>", ":wq<CR>", { desc = "write and quit" })
keymap.set("n", ":W<CR>", ":w<CR>", { desc = "write" })
keymap.set("n", ":Q<CR>", ":q<CR>", { desc = "quit" })
keymap.set("n", "<leader>wq", ":wq<CR>", { desc = "write and quit" })
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

-- buffers
keymap.set("n", "<leader>bp", "<cmd>bprev<CR>", { desc = "previous buffer" })
keymap.set("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "next buffer" })
keymap.set("n", "<leader>bx", "<cmd>bdelete<CR>", { desc = "close buffer" })

-- comment
keymap.set("n", "<leader>/", function()
	require("Comment.api").toggle.linewise.current()
end, { desc = "toggle comment" })

keymap.set(
	"v",
	"<leader>/",
	"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
	{ desc = "toggle comment" }
)

-- spellcheck
keymap.set("n", "<leader>son", "<cmd> set spell spelllang=en_gb<CR>", { desc = "enable spellcheck" })
keymap.set("n", "<leader>soff", "<cmd> set nospell<CR>", { desc = "disable spellcheck" })
keymap.set("n", "<leader>ss", "<cmd>Telescope spell_suggest<CR>", { desc = "get spelling suggestion" })
keymap.set("n", "z=", "<cmd>Telescope spell_suggest<CR>", { desc = "get spelling suggestion" })

-- arrow
keymap.set("n", "mn", "<cmd>Arrow next_buffer_bookmark<CR>")
keymap.set("n", "mp", "<cmd>Arrow prev_buffer_bookmark<CR>")

-- test
keymap.set("n", "<leader>tt", function()
	require("neotest").run.run()
end, { desc = "Run test" })

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
keymap.set(
	"n",
	"<leader>onl",
	"<cmd>:lua require('quicknote').NewNoteAtCurrentLine()<cr>",
	{ desc = "Create/open Quicknote for current line" }
)

keymap.set(
	"n",
	"<leader>ons",
	"<cmd>:lua require('quicknote').ToggleNoteSigns()<cr>",
	{ desc = "Show what lines have quicknotes" }
)

keymap.set("n", "<leader>oi", function()
	local date = os.date("%Y-%m-%d")
	vim.cmd("e +5 ~/notes/daily/" .. date .. ".md")
end, { desc = "Open today's note" })

vim.api.nvim_create_autocmd("Filetype", {
	pattern = "norg",
	callback = function()
		keymap.set("n", "<leader>mut", "<cmd>Neorg toc<CR>", {})
		keymap.set("n", "<leader>mm", "<Plug>(neorg.qol.todo-items.todo.task-cycle)", {})
		keymap.set("n", "<leader>fnh", "<Plug>(neorg.telescope.search_headings)", { desc = "[F]ind [N]ote [H]eadings" })
		keymap.set("n", "<leader>mil", "<Plug>(neorg.telescope.insert_link)", { desc = "Insert Link" })
	end,
})

-- copilot
keymap.set("n", "<leader>ai", "<cmd>CopilotChatToggle<cr>")
keymap.set("v", "<leader>air", "<cmd>CopilotChatReview<cr>")
keymap.set("v", "<leader>ait", "<cmd>CopilotChatTests<cr>")
keymap.set("v", "<leader>aie", "<cmd>CopilotChatExplain<cr>")

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

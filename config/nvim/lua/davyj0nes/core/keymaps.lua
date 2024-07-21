local keymap = vim.keymap

vim.g.mapleader = " "

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
keymap.set("n", "ƒ", "<cmd>ToggleTerm direction=tab display_name=term<CR>", { desc = "toggle terminal" })
keymap.set("t", "ƒ", "<cmd>ToggleTerm direction=tab display_name=term<CR>", { desc = "toggle terminal" })

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

keymap.set(
	"n",
	"<leader>ff",
	"<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files prompt_prefix=00<cr>",
	{ desc = "[F]ind [B]uffers" }
)

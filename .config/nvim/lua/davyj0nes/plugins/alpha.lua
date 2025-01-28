return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = { "epwalsh/obsidian.nvim" },
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Set header
		dashboard.section.header.val = {
			" ███    ██ ███████  ██████  ██    ██ ██ ███    ███ ",
			" ████   ██ ██      ██    ██ ██    ██ ██ ████  ████ ",
			" ██ ██  ██ █████   ██    ██ ██    ██ ██ ██ ████ ██ ",
			" ██  ██ ██ ██      ██    ██  ██  ██  ██ ██  ██  ██ ",
			" ██   ████ ███████  ██████    ████   ██ ██      ██ ",
			"                                                   ",
			"               (╯°□°)╯︵ ┻━┻             ",
			"",
			"                         ┻━┻ ︵ ヽ(°□°ヽ)",
			"",
			"             ┻━┻ ︵ ＼\\('0')/／ ︵ ┻━┻  ",
		}

		-- Set menu
		dashboard.section.buttons.val = {
			dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
			dashboard.button("SPC ff", "󰱼 > Find File", "<cmd>Telescope find_files hidden=true follow=true<CR>"),
			dashboard.button("SPC fs", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
			dashboard.button(
				"SPC fn",
				"  > Find Notes",
				"<cmd>Telescope file_browser path=/Users/davy/Library/Mobile\\ Documents/iCloud~md~obsidian/Documents/notes/<cr>"
			),
			dashboard.button("SPC exl", "  > List Exercism Tasks", "<cmd>ExercismList<cr>"),
			dashboard.button("SPC ul", "  > Update Lazy", "<cmd>Lazy sync<cr>"),
			dashboard.button("SPC um", "  > Update Mason", "<cmd>MasonUpdate<cr>"),
			dashboard.button("SPC wr", "󰁯  > Restore Session For Current Directory", "<cmd>SessionRestore<CR>"),
			dashboard.button("q", " > Quit NVIM", "<cmd>qa<CR>"),
		}

		-- Send config to alpha
		alpha.setup(dashboard.opts)

		-- Disable folding on alpha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}

-- go: 
-- go2: 
-- ocaml: 
-- elixir: 
-- clojure: 
-- zig: 
-- generic: 

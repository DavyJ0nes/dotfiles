return {
    {
        "aserowy/tmux.nvim",
        config = function()
            return require("tmux").setup()
        end,
    },
    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
        },
        keys = {
            { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },

    -- {
    -- 	"hiasr/vim-zellij-navigator.nvim",
    -- 	config = function()
    -- 		require("vim-zellij-navigator").setup()
    -- 	end,
    -- },
    -- plugins.lua / wherever you declare plugins
    -- {
    -- 	"mrjones2014/smart-splits.nvim",
    -- 	config = function()
    -- 		require("smart-splits").setup({
    -- 			multiplexer_integration = "zellij", -- let it talk to zellij
    -- 			zellij_move_focus_or_tab = false,
    -- 		})

    -- 		local ss = require("smart-splits")
    -- 		vim.keymap.set("n", "<C-h>", ss.move_cursor_left)
    -- 		vim.keymap.set("n", "<C-j>", ss.move_cursor_down)
    -- 		vim.keymap.set("n", "<C-k>", ss.move_cursor_up)
    -- 		vim.keymap.set("n", "<C-l>", ss.move_cursor_right)
    -- 	end,
    -- },
}

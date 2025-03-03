-- return {
-- 	"folke/trouble.nvim",
-- 	opts = {}, -- for default options, refer to the configuration section for custom setup.
-- 	cmd = "Trouble",
-- 	dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
-- 	keys = {
-- 		-- { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Open/close trouble list" },
-- 		{ "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Open trouble quickfix list" },
-- 		{ "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Open trouble location list" },
-- 		{ "<leader>xt", "<cmd>TodoTrouble<CR>", desc = "Open todos in trouble" },
-- 	},
-- 	specs = {
-- 		"folke/snacks.nvim",
-- 		opts = function(_, opts)
-- 			return vim.tbl_deep_extend("force", opts or {}, {
-- 				picker = {
-- 					actions = require("trouble.sources.snacks").actions,
-- 					win = {
-- 						input = {
-- 							keys = {
-- 								["<leader>xx"] = {
-- 									"trouble_open",
-- 									mode = { "n", "i" },
-- 								},
-- 							},
-- 						},
-- 					},
-- 				},
-- 			})
-- 		end,
-- 	},
-- }
--
return {
	"folke/trouble.nvim",
	optional = true,
	specs = {
		"folke/snacks.nvim",
		opts = function(_, opts)
			return vim.tbl_deep_extend("force", opts or {}, {
				picker = {
					actions = require("trouble.sources.snacks").actions,
					win = {
						input = {
							keys = {
								["<leader>xx"] = {
									"trouble_open",
									mode = { "n", "i" },
								},
							},
						},
					},
				},
			})
		end,
	},
}

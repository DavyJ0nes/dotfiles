return {
	"dundalek/parpar.nvim",
	dependencies = { "gpanders/nvim-parinfer", "julienvincent/nvim-paredit" },
	ft = { "clojure", "fennel" },
	config = function()
		local paredit = require("nvim-paredit")
		require("parpar").setup({
			paredit = {
				-- pass any nvim-paredit options here
				indent = {
					-- This controls how nvim-paredit handles indentation when performing operations which
					-- should change the indentation of the form (such as when slurping or barfing).
					--
					-- When set to true then it will attempt to fix the indentation of nodes operated on.
					enabled = true,
				},
				keys = {
					[">)"] = { paredit.api.slurp_forwards, "Slurp forwards" },
					[">("] = { paredit.api.barf_backwards, "Barf backwards" },

					["<)"] = { paredit.api.barf_forwards, "Barf forwards" },
					["<("] = { paredit.api.slurp_backwards, "Slurp backwards" },

					[">e"] = { paredit.api.drag_element_forwards, "Drag element right" },
					["<e"] = { paredit.api.drag_element_backwards, "Drag element left" },

					[">f"] = { paredit.api.drag_form_forwards, "Drag form right" },
					["<f"] = { paredit.api.drag_form_backwards, "Drag form left" },

					["E"] = {
						paredit.api.move_to_next_element_tail,
						"Next element tail",
						repeatable = false,
						mode = { "n", "x", "o", "v" },
					},
					["W"] = {
						paredit.api.move_to_next_element_head,
						"Next element head",
						repeatable = false,
						mode = { "n", "x", "o", "v" },
					},

					["B"] = {
						paredit.api.move_to_prev_element_head,
						"Previous element head",
						repeatable = false,
						mode = { "n", "x", "o", "v" },
					},
					["gE"] = {
						paredit.api.move_to_prev_element_tail,
						"Previous element tail",
						repeatable = false,
						mode = { "n", "x", "o", "v" },
					},

					["("] = {
						paredit.api.move_to_parent_form_start,
						"Parent form's head",
						repeatable = false,
						mode = { "n", "x", "v" },
					},

					[")"] = {
						paredit.api.move_to_parent_form_end,
						"Parent form's tail",
						repeatable = false,
						mode = { "n", "x", "v" },
					},

					["af"] = {
						paredit.api.select_around_form,
						"Around form",
						repeatable = false,
						mode = { "o", "v" },
					},

					["if"] = {
						paredit.api.select_in_form,
						"In form",
						repeatable = false,
						mode = { "o", "v" },
					},

					["aF"] = {
						paredit.api.select_around_top_level_form,
						"Around top level form",
						repeatable = false,
						mode = { "o", "v" },
					},

					["iF"] = {
						paredit.api.select_in_top_level_form,
						"In top level form",
						repeatable = false,
						mode = { "o", "v" },
					},

					["ae"] = {
						paredit.api.select_element,
						"Around element",
						repeatable = false,
						mode = { "o", "v" },
					},

					["ie"] = {
						paredit.api.select_element,
						"Element",
						repeatable = false,
						mode = { "o", "v" },
					},
					["df"] = {
						paredit.api.delete_form,
						"Delete form",
						repeatable = false,
						mode = { "n", "v" },
					},
					["dif"] = {
						paredit.api.delete_in_form,
						"Delete in form",
						repeatable = false,
						mode = { "n", "v" },
					},
					["de"] = {
						paredit.api.delete_element,
						"Delete element",
						repeatable = false,
						mode = { "n", "v" },
					},
				},
			},
		})
	end,
}

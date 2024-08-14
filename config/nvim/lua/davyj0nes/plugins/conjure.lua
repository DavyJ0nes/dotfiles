return {
	{
		"Olical/conjure",
		ft = { "clojure", "fennel", "python" }, -- etc
		lazy = true,
		init = function()
			-- Set configuration options here
			vim.g["conjure#extract#tree_sitter#enabled"] = true
			-- vim.g["conjure#debug"] = true
			-- vim.g["conjure#mapping#prefix"] = " c"
			-- vim.g["conjure#log#hud#enabled"] = false
			-- vim.g["conjure#eval#inline#highlight"] = "EndOfBuffer"
			-- Width of HUD as percentage of the editor width between 0.0 and 1.0. Default: `0.42`
			vim.g["conjure#log#hud#width"] = 0.4
			vim.g["conjure#log#hud#height"] = 1
			-- Display HUD (REPL log). Default: `true`
			vim.g["conjure#log#hud#enabled"] = true
			-- HUD corner position (over-ridden by HUD cursor detection). Default: `"NE"`
			-- Example: Set to `"SE"` and HUD width to `1.0` for full width HUD at bottom of screen
			vim.g["conjure#log#hud#anchor"] = "NE"
			-- Open log at bottom or far right of editor, using full width or height. Default: `false`
			vim.g["conjure#log#botright"] = true
			-- wrap log output
			vim.g["conjure#log#wrap`"] = true
			-- Lines from top of file to check for `ns` form, to sett evaluation context Default: `25`
			-- `b:conjure#context` to override a specific buffer that isn't finding the context
			vim.g["conjure#extract#context_header_lines"] = 100
			-- comment pattern for eval to comment command
			vim.g["conjure#eval#comment_prefix"] = ";; "
			-- Hightlight evaluated forms
			vim.g["conjure#highlight#enabled"] = true
			-- Start "auto-repl" process when nREPL connection not found, e.g. babashka. ;; Default: `true`
			-- vim.g["conjure#client#clojure#nrepl#connection#auto_repl#enabled"] = false
			-- Hide auto-repl buffer when triggered. Default: `false`
			vim.g["conjure#client#clojure#nrepl#connection#auto_repl#hidden"] = true
			-- Command to start the auto-repl. Default: `"bb nrepl-server localhost:8794"`
			vim.g["conjure#client#clojure#nrepl#connection#auto_repl#cmd"] = "lein repl"
			-- Ensure namespace required after REPL connection. Default: `true`
			vim.g["conjure#client#clojure#nrepl#eval#auto_require"] = false
			-- suppress `; (out)` prefix in log evaluation results
			vim.g["conjure#client#clojure#nrepl#eval#raw_out"] = true
			vim.g["conjure#client#clojure#nrepl#test#raw_out"] = false
			vim.g["conjure#client#clojure#nrepl#test#current_form_names"] = { "deftest", "defexpect", "describe" }
			-- test runner "clojure" (clojure.test) "clojurescript" (cljs.test) "kaocha"
			vim.g["conjure#client#clojure#nrepl#test#runner"] = "clojure"
			vim.g["conjure#client#clojure#nrepl#mapping#run_current_test"] = "tt"
		end,
	},
}

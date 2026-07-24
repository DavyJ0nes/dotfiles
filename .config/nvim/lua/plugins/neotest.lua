return {
	"nvim-neotest/neotest",
	ft = { "cs", "go", "rust", "typescript", "typescriptreact", "javascriptreact", "elixir" },
	dependencies = {
		{ "nvim-lua/plenary.nvim", version = "*" },
		"antoinemadec/FixCursorHold.nvim",
		"jutonz/neotest-bun",
		"marilari88/neotest-vitest",
		"nvim-treesitter/nvim-treesitter",
		"mrcjkb/rustaceanvim",
		{ "nvim-neotest/nvim-nio", version = "*" },
		{ "fredrikaverpil/neotest-golang", version = "*" },
		"jfpedroza/neotest-elixir",
		"Issafalcon/neotest-dotnet",
	},
	config = function()
		local neotest_ns = vim.api.nvim_create_namespace("neotest")

		vim.diagnostic.config({
			virtual_text = {
				format = function(diagnostic)
					return diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
				end,
			},
		}, neotest_ns)

		require("neotest").setup({
			adapters = {
				require("neotest-bun")({ additional_args = {} }),
				(function()
					-- neotest-dotnet compat shim for Neovim 0.12.
					-- Three issues prevent stock neotest-dotnet from working:
					--
					-- 1. The neotest subprocess can't find a parser for filetype "cs"
					--    (needs "c_sharp") and throws instead of falling back → discovery dies.
					--    Fix: rewrite discover_positions to parse in-process, bypassing subprocess.
					--
					-- 2. Neovim 0.12 removed the `all` option from iter_matches; captures are
					--    now always tables. framework-discovery.lua indexes captures[1] expecting
					--    a bare TSNode → get_node_text crashes.
					--    Fix: replace get_test_framework_utils_from_source with Neovim 0.12-safe version.
					--
					-- 3. tree-sitter-c-sharp models file_scoped_namespace_declaration (`namespace Foo;`)
					--    as a single line; neotest drops the empty namespace → position IDs miss it →
					--    TRX result matching fails → no gutter signs.
					--    Fix: post-process the position tree to re-insert the namespace.
					vim.treesitter.language.register("c_sharp", "cs")

					local adapter = require("neotest-dotnet")({
						dap = {
							adapter_name = "coreclr",
							args = { justMyCode = false },
						},
					})
					local lib = require("neotest.lib")
					local Tree = require("neotest.types").Tree
					local FD = require("neotest-dotnet.framework-discovery")
					local async = require("neotest.async")
					local xunit = require("neotest-dotnet.xunit")
					local nunit = require("neotest-dotnet.nunit")
					local mstest = require("neotest-dotnet.mstest")

					-- Fix 4: FanoutAccum:push in dotnet-utils.lua on_stdout callback runs
					-- outside nio async context. Patch the class method to retry via nio.run.
					local fa_constructor = require("neotest.types").FanoutAccum
					local dummy = fa_constructor(function(_, n) return n end, nil)
					local fa_class = getmetatable(dummy)
					local orig_push = fa_class.push
					fa_class.push = function(self, data)
						local ok = pcall(orig_push, self, data)
						if not ok then
							require("nio").run(function() orig_push(self, data) end)
						end
					end

					-- Fix 5: neotest-dotnet passes processId as a string (from regex match)
					-- but netcoredbg expects a number. Patch dap.run to coerce it.
					local dap_mod = require("dap")
					local orig_dap_run = dap_mod.run
					dap_mod.run = function(config, ...)
						if config and config.processId and type(config.processId) == "string" then
							config.processId = tonumber(config.processId)
						end
						return orig_dap_run(config, ...)
					end

					-- Fix 2: Neovim 0.12-safe framework detection
					FD.get_test_framework_utils_from_source = function(source, custom_attrs)
						local xunit_attrs = FD.attribute_match_list(custom_attrs, "xunit")
						local nunit_attrs = FD.attribute_match_list(custom_attrs, "nunit")
						local mstest_attrs = FD.attribute_match_list(custom_attrs, "mstest")
						local query_str = "(attribute name: (identifier) @attr (#any-of? @attr "
							.. xunit_attrs .. " " .. nunit_attrs .. " " .. mstest_attrs .. "))"

						async.scheduler()
						local root = vim.treesitter.get_string_parser(source, "c_sharp"):parse()[1]:root()
						local query = vim.treesitter.query.parse("c_sharp", query_str)
						for _, captures in query:iter_matches(root, source) do
							local node = captures[1]
							if type(node) == "table" then node = node[1] end
							local attr = vim.treesitter.get_node_text(node, source)
							if attr then
								if xunit_attrs:find(attr, 1, true) then return xunit end
								if nunit_attrs:find(attr, 1, true) then return nunit end
								if mstest_attrs:find(attr, 1, true) then return mstest end
								return xunit
							end
						end
					end

					-- Fix 1+3: bypass subprocess, parse in-process, fix file-scoped namespaces
					adapter.discover_positions = function(path)
						local content = lib.files.read(path)
						local test_framework = FD.get_test_framework_utils_from_source(content, nil)
						if not test_framework then return nil end
						local framework_queries = test_framework.get_treesitter_queries(nil)

						local query = [[
							(namespace_declaration
								name: (qualified_name) @namespace.name
							) @namespace.definition
							(namespace_declaration
								name: (identifier) @namespace.name
							) @namespace.definition
							(file_scoped_namespace_declaration
								name: (qualified_name) @namespace.name
							) @namespace.definition
							(file_scoped_namespace_declaration
								name: (identifier) @namespace.name
							) @namespace.definition
						]] .. framework_queries

						-- Parse in-process (bypass subprocess which can't resolve cs→c_sharp)
						local tree = lib.treesitter._parse_positions(path, query, {
							nested_namespaces = true,
							nested_tests = true,
							build_position = "require('neotest-dotnet')._build_position",
							position_id = "require('neotest-dotnet')._position_id",
						})

						local modified_tree = test_framework.post_process_tree_list(tree, path)

						-- Fix 3: re-insert dropped file-scoped namespace
						local lines = vim.fn.readfile(path)
						local ns_name
						for _, line in ipairs(lines) do
							ns_name = line:match("^%s*namespace%s+([%w%.]+)%s*;")
							if ns_name then break end
						end
						if not ns_name then return modified_tree end

						for _, child in ipairs(modified_tree:children()) do
							local d = child:data()
							if d.type == "namespace" and d.name == ns_name and #child:children() > 0 then
								return modified_tree
							end
						end

						local list = modified_tree:to_list()
						local file_node = list[1]
						local ns_node = {
							type = "namespace",
							name = ns_name,
							path = file_node.path,
							range = file_node.range,
							id = file_node.path .. "::" .. ns_name,
							is_class = false,
						}

						local function rewrite_ids(subtree)
							local node = subtree[1]
							if node and node.id and node.type ~= "file" then
								local p, rest = node.id:match("^(.+%.cs)::(.+)$")
								if p and rest then node.id = p .. "::" .. ns_name .. "::" .. rest end
							end
							for i = 2, #subtree do rewrite_ids(subtree[i]) end
						end

						local ns_subtree = { ns_node }
						for i = 2, #list do
							rewrite_ids(list[i])
							ns_subtree[#ns_subtree + 1] = list[i]
						end

						return Tree.from_list({ file_node, ns_subtree }, function(pos)
							return pos.id
						end)
					end

					return adapter
				end)(),
				require("rustaceanvim.neotest"),
				(function()
					-- neotest-vitest crashes with nil rootPath in non-JS projects;
					-- wrap root() with pcall so it returns nil gracefully instead.
					local vitest = require("neotest-vitest")({
						filter_dir = function(name, _, _)
							return name ~= "node_modules"
						end,
					})
					local orig_root = vitest.root
					vitest.root = function(...)
						local ok, result = pcall(orig_root, ...)
						return ok and result or nil
					end
					return vitest
				end)(),
				require("neotest-golang")({
					go_test_args = {
						"-v",
						"-count=1",
						"-race",
						"-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out",
						"-parallel=1",
					},
					runner = "gotestsum",
					gotestsum_args = { "--format=standard-verbose" },
					warn_test_name_dupes = false,
				}),
				require("neotest-elixir"),
			},
			discovery = { enabled = true, concurrent = 0 },
			diagnostic = { enabled = true, severity = vim.diagnostic.severity.ERROR },
			running = { concurrent = true },
			log_level = vim.log.levels.WARN,
			output = { enabled = true, open_on_run = false }, -- was true; auto-opening a terminal float on failed tests dropped nvim into terminal/insert mode. Use <leader>to on demand.
			status = { enabled = true, signs = true, virtual_text = false },
			strategies = { integrated = { height = 40, width = 120 } },
			summary = {
				enabled = true,
				animated = true,
				expand_errors = true,
				follow = true,
				count = true,
				mappings = {
					attach = "a",
					expand = { "<CR>", "<2-LeftMouse>" },
					expand_all = "e",
					jumpto = "gd",
					output = "o",
					run = "r",
					short = "O",
					stop = "u",
				},
			},
		})
	end,
}

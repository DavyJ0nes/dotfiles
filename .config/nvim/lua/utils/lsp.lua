local M = {}

-- Default LSP keymaps set on every attach
function M.on_attach(client, buffer)
	local set = vim.keymap.set
	local opts = function(desc)
		return { buffer = buffer, desc = "LSP: " .. desc }
	end

	set("n", "<leader>ca", vim.lsp.buf.code_action, opts("Code Actions"))
	set("v", "<leader>ca", vim.lsp.buf.code_action, opts("Code Actions"))
	set("n", "<leader>cr", vim.lsp.buf.rename, opts("Rename"))
	set("n", "<leader>cf", vim.lsp.buf.format, opts("Format"))
	set("n", "K", vim.lsp.buf.hover, opts("Hover Documentation"))
	set("n", "gb", "<C-o>", opts("Go Back"))
end

M.action = setmetatable({}, {
	__index = function(_, action)
		return function()
			vim.lsp.buf.code_action({
				apply = true,
				context = { only = { action }, diagnostics = {} },
			})
		end
	end,
})

-- Utils for conform: find a config file in cwd or git root
local Path = require("utils.path")

local function get_config_path(filename)
	local current_dir = vim.fn.getcwd()
	local config_file = current_dir .. "/" .. filename
	if vim.fn.filereadable(config_file) == 1 then return current_dir end

	local git_root = Path.get_git_root()
	if Path.is_git_repo() and git_root ~= current_dir then
		config_file = git_root .. "/" .. filename
		if vim.fn.filereadable(config_file) == 1 then return git_root end
	end

	return nil
end

M.biome_config_path    = function() return get_config_path("biome.json") end
M.biome_config_exists  = function() return get_config_path("biome.json") ~= nil end
M.deno_config_exist    = function()
	return get_config_path("deno.json") ~= nil or get_config_path("deno.jsonc") ~= nil
end

M.eslint_config_exists = function()
	local current_dir = vim.fn.getcwd()
	local config_files = {
		".eslintrc.js", ".eslintrc.cjs", ".eslintrc.yaml", ".eslintrc.yml",
		".eslintrc.json", ".eslintrc", "eslint.config.js",
	}
	for _, file in ipairs(config_files) do
		if vim.fn.filereadable(current_dir .. "/" .. file) == 1 then return true end
	end
	local git_root = Path.get_git_root()
	if Path.is_git_repo() and git_root ~= current_dir then
		for _, file in ipairs(config_files) do
			if vim.fn.filereadable(git_root .. "/" .. file) == 1 then return true end
		end
	end
	return false
end

return M

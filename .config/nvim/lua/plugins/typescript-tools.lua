local Lsp = require("utils.lsp")

local function set_default_keymaps(client, buffer)
	local keymaps = Lsp.get_default_keymaps()
	for _, keymap in ipairs(keymaps) do
		if not keymap.has or client.server_capabilities[keymap.has] then
			vim.keymap.set(keymap.mode or "n", keymap.keys, keymap.func, {
				buffer = buffer,
				desc = "LSP: " .. keymap.desc,
				nowait = keymap.nowait,
			})
		end
	end
end

return {
	"pmizio/typescript-tools.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"neovim/nvim-lspconfig",
		"dmmulroy/ts-error-translator.nvim",
	},
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
		"vue",
	},
	opts = {
		on_attach = set_default_keymaps,
		settings = {
			expose_as_code_action = "all",
			tsserver_file_preferences = {
				includeInlayParameterNameHints = "none",
				includeInlayFunctionParameterTypeHints = false,
				includeInlayFunctionLikeReturnTypeHints = false,
				includeInlayVariableTypeHints = false,
				includeInlayPropertyDeclarationTypeHints = false,
				includeInlayEnumMemberValueHints = false,
				includeCompletionsForModuleExports = true,
			},
		},
	},
}

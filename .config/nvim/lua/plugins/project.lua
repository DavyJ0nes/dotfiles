return {
	"DrKJeff16/project.nvim",
	lazy = false,
	config = function()
		require("project").setup({
			detection_methods = { "lsp", "pattern" },
			patterns = {
				".git",
				"go.mod",
				"Cargo.toml",
				"package.json",
				"Makefile",
				"Chart.yaml",    -- Helm charts
				"terraform.tf",  -- Terraform root
				"*.tf",
			},
			show_hidden = true,
			silent_chdir = true,
			scope_chdir = "global",
		})

		-- sync neo-tree root when project.nvim changes cwd
		vim.api.nvim_create_autocmd("DirChanged", {
			callback = function()
				if package.loaded["neo-tree"] then
					require("neo-tree.command").execute({
						action = "focus",
						dir = vim.fn.getcwd(),
					})
				end
			end,
		})
	end,
}

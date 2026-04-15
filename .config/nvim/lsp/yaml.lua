return {
	cmd = { "yaml-language-server", "--stdio" },
	filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
	root_markers = { ".git" },
	settings = {
		yaml = {
			schemaStore = {
				-- disable built-in schema store so schemastore.nvim takes over
				enable = false,
				url = "",
			},
			schemas = vim.tbl_extend("force", require("schemastore").yaml.schemas(), {
				-- kubernetes schemas for manifests — more specific than *.yaml
				kubernetes = {
					"*deployment*.yaml",
					"*service*.yaml",
					"*ingress*.yaml",
					"*configmap*.yaml",
					"*secret*.yaml",
					"*statefulset*.yaml",
					"*daemonset*.yaml",
					"*job*.yaml",
					"*cronjob*.yaml",
					"*namespace*.yaml",
					"*rbac*.yaml",
					"*serviceaccount*.yaml",
					"k8s/**/*.yaml",
					"kubernetes/**/*.yaml",
					"manifests/**/*.yaml",
					"deploy/**/*.yaml",
				},
			}),
			validate = true,
			completion = true,
			hover = true,
			format = { enable = true },
		},
	},
}

return {
	"clojure-vim/vim-jack-in",
	ft = { "clj", "clojure" },
	dependencies = {
		{
			"tpope/vim-dispatch",
			dependencies = {
				"radenling/vim-dispatch-neovim",
			},
		},
	},
}

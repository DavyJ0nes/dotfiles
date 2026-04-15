return {
	"davyj0nes/vim-katas",
	cmd = { "VimKata", "VimKataMenu", "VimKataStats" },
	opts = {},
	config = function(_, opts)
		require("vim_katas").setup(opts)
	end,
}

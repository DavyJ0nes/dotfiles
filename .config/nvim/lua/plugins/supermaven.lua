return {
	"supermaven-inc/supermaven-nvim",
	event = "InsertEnter",
	config = function()
		require("supermaven-nvim").setup({
			disable_keymaps = true, -- Tab is wired in blink-cmp.lua so it coexists with snippet jumping
			ignore_filetypes = {
        markdown = true,
        go = false,
        cs = false,
        c_sharp = false,
        elixir = false,
        zig = false,
      },
			color = {
				suggestion_color = "#565f89", -- tokyonight "night" comment gray; cosmetic, adjust to taste
				cterm = 244,
			},
			log_level = "off",
		})
	end,
}

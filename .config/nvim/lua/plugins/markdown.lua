return {
	"MeanderingProgrammer/markdown.nvim",
	name = "render-markdown",
	dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
	ft = { "markdown", "livemd" },
	opts = {
		enabled = true,
		max_file_size = 1.5,
		render_modes = { "n", "c" },
		heading = {
			enabled = true,
			icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
			signs = { "󰫎 " },
		},
		code = {
			enabled = true,
			width = "block",
			min_width = 80,
			border = "thin",
		},
		bullet = { enabled = true },
		checkbox = {
			enabled = true,
			unchecked = { icon = "󰄱 " },
			checked = { icon = "󰱒 " },
		},
		quote = { enabled = true, icon = "▋" },
		pipe_table = { enabled = true, style = "full" },
		link = { enabled = true },
	},
}

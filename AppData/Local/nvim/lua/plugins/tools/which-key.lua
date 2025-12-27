return {
	"folke/which-key.nvim",
	event = "VimEnter",
	opts = {
		plugins = {
			marks = false,
			registers = false,
			spelling = { enabled = false },
			presets = {
				operators = false,
				motions = false,
				text_objects = false,
				windows = false,
				nav = false,
				z = false,
				g = false,
			},
		},
		triggers = {
			{ "<auto>", mode = "n" },
		},
	},
	config = function(_, opts)
		require("which-key").setup(opts)
	end,
}

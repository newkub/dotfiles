return {
	"folke/which-key.nvim",
	event = "VimEnter",
	config = function(_, opts)
		require("which-key").setup(opts)
	end,
}

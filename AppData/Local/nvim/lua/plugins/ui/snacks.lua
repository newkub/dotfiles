return {
	"folke/snacks.nvim",
	priority = 1000,
	event = "VimEnter",
	opts = require("plugins.ui.snacks.opts"),
	keys = require("plugins.ui.snacks.keys"),
	init = require("plugins.ui.snacks.init"),
}

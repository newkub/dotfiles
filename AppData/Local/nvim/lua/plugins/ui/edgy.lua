return {
	"folke/edgy.nvim",
	event = "VimEnter",
	---@module 'edgy'
	---@param opts Edgy.Config
	opts = function(_, opts)
		opts.left = opts.left or {}
		opts.bottom = opts.bottom or {}

		table.insert(opts.bottom, {
			ft = "trouble",
			size = { height = 12 },
			title = "Trouble",
		})
	end,
	init = function()
	end,
}

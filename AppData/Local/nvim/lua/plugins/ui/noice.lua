return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {

		-- you can enable a preset for easier configuration
		presets = {
			bottom_search = true, -- use a classic bottom cmdline for search
			command_palette = true, -- position the cmdline and popupmenu together
			long_message_to_split = true, -- long messages will be sent to a split
			inc_rename = false, -- enables an input dialog for inc-rename.nvim
			lsp_doc_border = false, -- add a border to hover docs and signature help
		},
	},
  -- stylua: ignore
  keys = {
    { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
    { "<leader>sn", "", desc = "+noice" },
    { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
    { "<leader>sne", function() require("noice").cmd("errors") end, desc = "View Error Messages" },
    { "<leader>snh", function() require("noice").cmd("history") end, desc = "History" },
    { "<leader>snl", function() require("noice").cmd("last") end, desc = "Last Message" },
    { "<leader>snr", function() require("noice").cmd("redirect") end, desc = "Redirect Cmd Output" },
    { "<leader>sns", function() require("noice").cmd("split") end, desc = "Split Window" },
    { "<leader>snt", function() require("noice").cmd("telescope") end, desc = "Telescope" },
    { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward", mode = {"i", "n", "s"} },
    { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward", mode = {"i", "n", "s"} },
  },
	config = function(_, opts)
		require("noice").setup(opts)
	end,
	dependencies = {
		-- if you lazy-load any plugin that requires telescope.nvim, make sure to load it first
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp", -- if you want to use the cmp integration
	},
}

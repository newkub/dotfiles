
-- Text editing key mappings for Neovim

return {
	n = {

		-- Move Line Up/Down
		["<A-Up>"] = { ":m-2<CR>", "Move Line Up" },
		["<A-Down>"] = { ":m+1<CR>", "Move Line Down" },

		-- Move to next word
		["<Tab>"] = { "w", "Move to next word" },

		-- Cut/Copy/Paste
		["<C-v>"] = { '"+P', "Paste" },

		-- Select All
		["<C-a>"] = { "ggVG", "Select All" },
	},

	i = {
		-- Undo/Redo
		["<C-z>"] = { "<C-o>:undo<CR>", "Undo" },
		["<C-S-z>"] = { "<C-o>:redo<CR>", "Redo" },

		-- Delete Word
		["<C-BS>"] = { "<C-w>", "Delete Word Backward" },

		-- Cut/Paste
		["<C-v>"] = { "<C-r>+", "Paste" },
		["<C-c>"] = {
			function()
				local win = vim.api.nvim_get_current_win()
				local cursor = vim.api.nvim_win_get_cursor(win)
				vim.cmd("stopinsert")
				vim.cmd('normal! ggVG"+y')
				pcall(vim.api.nvim_win_set_cursor, win, cursor)
				vim.cmd("startinsert")
			end,
			"Copy All",
			{ noremap = true, silent = true },
		},
		["<C-x>"] = {
			function()
				vim.cmd("stopinsert")
				vim.cmd('normal! ggVG"+d')
				vim.cmd("startinsert")
			end,
			"Cut All",
			{ noremap = true, silent = true },
		},

		-- Select All
		["<C-a>"] = {
			function()
				vim.cmd("stopinsert")
				vim.cmd("normal! ggVG")
			end,
			"Select All",
			{ noremap = true, silent = true },
		},
	},

	v = {
		-- Cut/Copy/Paste
		["<C-x>"] = { '"+d', "Cut Selection" },
		["<C-c>"] = { '"+y', "Copy Selection" },
		["<C-v>"] = { '"+P', "Paste" },
		["<C-a>"] = { "ggVG", "Select All" },
	},
}

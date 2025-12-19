-- VS Code style navigation key mappings for Neovim

-- VS Code style navigation key mappings for Neovim

local utils = require("mappings.utils")

return {
	n = {
		-- File Explorer
		["<leader>e"] = {
			function()
				require("snacks").explorer()
			end,
			"File Explorer",
		},

		-- Go Back/Forward
		["<A-Left>"] = { "<C-o>", "Go Back" },
		["<A-Right>"] = { "<C-i>", "Go Forward" },

		-- Buffer Navigation
		["<C-Tab>"] = { ":bnext<CR>", "Next Buffer" },
		["<C-S-Tab>"] = { ":bprevious<CR>", "Previous Buffer" },

		-- Close Editor
		["<C-w>"] = { ":close<CR>", "Close Editor" },

		-- Return to Home/Dashboard
		["<leader>h"] = { utils.safe_dashboard, "Go to Home/Dashboard" },
		["<leader>H"] = {
			function()
				utils.safe_dashboard({ force = true })
			end,
			"Force go to Home",
		},

		-- Enter Insert Mode with Arrow Keys
		["<C-Left>"] = { "i", "Enter Insert Mode" },
		["<C-Right>"] = { "a", "Enter Insert Mode" },
	},
}

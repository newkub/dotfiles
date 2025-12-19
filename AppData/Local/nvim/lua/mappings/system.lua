-- VS Code style system operations key mappings for Neovim

-- VS Code style system operations key mappings for Neovim

local utils = require("mappings.utils")

return {
	n = {
		-- Command Palette (VS Code style: F1)
		["<F1>"] = {
			function()
				require("snacks").picker()
			end,
			"Command Palette",
			{ noremap = true, silent = true },
		},

		-- Rename File (VS Code style: F2)
		["<F2>"] = {
			function()
				require("snacks").rename.rename_file()
			end,
			"Rename File",
			{ noremap = true, silent = true },
		},

		-- Open Terminal (VS Code style: Ctrl+`)
		["<C-`>"] = { function() vim.cmd("terminal " .. require("core.utils").get_default_shell()) end, "Open Terminal" },

		-- Quit Neovim (safer version)
		["<C-c>"] = { ":qa!<CR>", "Force Quit Neovim" },

		-- Toggle/Focus Terminal
		["<C-l>"] = { utils.toggle_or_focus_terminal, "Toggle/Focus Terminal" },

		-- Undo/Redo (Standard Vim keys)
		["<C-z>"] = { "u", "Undo" },
		["<C-S-z>"] = { "<C-r>", "Redo" },
		["<C-y>"] = { "<C-r>", "Redo" }, -- Alternative for Redo
	},

	i = {
		-- Command Palette
		["<F1>"] = {
			function()
				require("snacks").picker()
			end,
			"Command Palette",
			{ noremap = true, silent = true },
		},

		-- Exit to Normal Mode
		["<C-c>"] = { "<Esc>", "Exit to Normal Mode", { silent = true } },

		-- Toggle/Focus Terminal
		["<C-l>"] = { utils.toggle_or_focus_terminal, "Toggle/Focus Terminal" },

		-- Undo/Redo
		["<C-z>"] = { "<C-o>u", "Undo" },
		["<C-S-z>"] = { "<C-o><C-r>", "Redo" },
		["<C-y>"] = { "<C-o><C-r>", "Redo" },

		-- VS Code style text selection with Shift+Arrow keys
		["<S-Right>"] = { "<C-o>vl<C-g>", "Select Right" },
		["<S-Left>"] = { "<C-o>vh<C-g>", "Select Left" },
		["<S-Up>"] = { "<C-o>vk<C-g>", "Select Up" },
		["<S-Down>"] = { "<C-o>vj<C-g>", "Select Down" },
		["<S-Home>"] = { "<C-o>v^<C-g>", "Select to Start of Line" },
		["<S-End>"] = { "<C-o>v$<C-g>", "Select to End of Line" },
		["<S-C-Right>"] = { "<C-o>vw<C-g>", "Select Word Right" },
		["<S-C-Left>"] = { "<C-o>vb<C-g>", "Select Word Left" },
	},

	v = {
		-- Extend selection with Shift+Arrow keys
		["<S-Right>"] = { "l<C-g>", "Extend Selection Right" },
		["<S-Left>"] = { "h<C-g>", "Extend Selection Left" },
		["<S-Up>"] = { "k<C-g>", "Extend Selection Up" },
		["<S-Down>"] = { "j<C-g>", "Extend Selection Down" },
		["<S-Home>"] = { "^<C-g>", "Extend Selection to Start of Line" },
		["<S-End>"] = { "$<C-g>", "Extend Selection to End of Line" },
		["<S-C-Right>"] = { "w<C-g>", "Extend Selection Word Right" },
		["<S-C-Left>"] = { "b<C-g>", "Extend Selection Word Left" },
	},

	s = {
		-- Extend selection in Select mode
		["<S-Right>"] = { "<Right>", "Extend Selection Right" },
		["<S-Left>"] = { "<Left>", "Extend Selection Left" },
		["<S-Up>"] = { "<Up>", "Extend Selection Up" },
		["<S-Down>"] = { "<Down>", "Extend Selection Down" },
		["<S-Home>"] = { "<Home>", "Extend Selection to Start of Line" },
		["<S-End>"] = { "<End>", "Extend Selection to End of Line" },
		["<S-C-Right>"] = { "<C-Right>", "Extend Selection Word Right" },
		["<S-C-Left>"] = { "<C-Left>", "Extend Selection Word Left" },

		-- Cancel selection and return to insert mode
		["<Right>"] = { "<Esc>i<Right>", "Cancel Selection and Move Right" },
		["<Left>"] = { "<Esc>i<Left>", "Cancel Selection and Move Left" },
		["<Up>"] = { "<Esc>i<Up>", "Cancel Selection and Move Up" },
		["<Down>"] = { "<Esc>i<Down>", "Cancel Selection and Move Down" },
		["<Home>"] = { "<Esc>i<Home>", "Cancel Selection and Move to Start" },
		["<End>"] = { "<Esc>i<End>", "Cancel Selection and Move to End" },
	},

	t = {
		-- Hide Terminal
		["<C-l>"] = {
			function()
				local current_win = vim.api.nvim_get_current_win()
				vim.api.nvim_win_hide(current_win)
			end,
			"Hide Terminal",
		},

		-- Focus back to editor
		["<C-k>"] = { "<C-\\><C-n><C-w>w", "Focus Editor" },
	},
}

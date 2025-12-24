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

		["<Esc>"] = { "i", "Toggle Insert Mode", { noremap = true, silent = true } },

		-- Rename File (VS Code style: F2)
		["<F2>"] = {
			function()
				require("snacks").rename.rename_file()
			end,
			"Rename File",
			{ noremap = true, silent = true },
		},

		["<C-r>"] = {
			function()
				require("snacks").rename.rename_file()
			end,
			"Rename File",
			{ noremap = true, silent = true },
		},
		["<C-d>"] = {
			function()
				local file = vim.fn.expand("%:p")
				if file == "" then
					return
				end
				local ok = vim.fn.confirm("Delete file?\n" .. file, "&Yes\n&No", 2)
				if ok ~= 1 then
					return
				end
				vim.cmd("silent! bdelete")
				pcall(function()
					vim.fn.delete(file)
				end)
			end,
			"Delete File",
			{ noremap = true, silent = true },
		},
		["<C-S-c>"] = {
			function()
				local src = vim.fn.expand("%:p")
				if src == "" then
					return
				end
				local dst = vim.fn.input("Copy to: ", src)
				if dst == "" or dst == src then
					return
				end
				local uv = vim.uv or vim.loop
				local ok = false
				if uv and uv.fs_copyfile then
					ok = pcall(uv.fs_copyfile, src, dst)
				end
				if not ok then
					vim.notify("Copy failed", vim.log.levels.ERROR)
					return
				end
				vim.notify("Copied to: " .. dst)
			end,
			"Copy File",
			{ noremap = true, silent = true },
		},
		["<C-S-p>"] = {
			function()
				local path = vim.fn.expand("%:p")
				if path == "" then
					return
				end
				vim.fn.setreg("+", path)
				vim.notify("Copied path")
			end,
			"Copy Path",
			{ noremap = true, silent = true },
		},

		-- Open Terminal (VS Code style: Ctrl+`)
		["<C-`>"] = { function() vim.cmd("terminal " .. require("core.utils").get_default_shell()) end, "Open Terminal" },

		-- Quit Neovim (safer version)
		["<C-c>"] = { "<cmd>qa!<cr>", "Force Quit Neovim", { noremap = true, silent = true } },

		-- Toggle/Focus Terminal
		["<C-l>"] = { utils.toggle_or_focus_terminal, "Toggle/Focus Terminal" },

		-- Undo/Redo (Standard Vim keys)
		["<C-z>"] = { "u", "Undo" },
		["<C-S-z>"] = { "<C-r>", "Redo" },
		["<C-y>"] = { "<C-r>", "Redo" }, -- Alternative for Redo

		-- Grep Search
		["<C-S-s>"] = {
			function()
				require("snacks").picker.grep()
			end,
			"Grep Search",
			{ noremap = true, silent = true },
		},
		["<C-s>"] = {
			function()
				require("snacks").picker.grep()
			end,
			"Grep Search",
			{ noremap = true, silent = true },
		},
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

		["<Tab>"] = {
			function()
				local ok, accepted = pcall(function()
					return vim.fn["codeium#Accept"]()
				end)
				if ok and type(accepted) == "string" and accepted ~= "" then
					return accepted
				end
				return "<Esc>wea"
			end,
			"Tab: Accept Codeium or Next Word",
			{ noremap = true, silent = true, expr = true, replace_keycodes = true },
		},

		-- File Picker
		["<C-p>"] = {
			function()
				vim.cmd("stopinsert")
				require("snacks").picker.files()
			end,
			"File Picker",
			{ noremap = true, silent = true },
		},

		-- Grep Search
		["<C-S-s>"] = {
			function()
				vim.cmd("stopinsert")
				require("snacks").picker.grep()
			end,
			"Grep Search",
			{ noremap = true, silent = true },
		},
		["<C-s>"] = {
			function()
				vim.cmd("stopinsert")
				require("snacks").picker.grep()
			end,
			"Grep Search",
			{ noremap = true, silent = true },
		},

		-- Exit to Normal Mode
		["<C-c>"] = { "<Esc>", "Exit to Normal Mode", { silent = true } },

		-- Toggle/Focus Terminal
		["<C-l>"] = { utils.toggle_or_focus_terminal, "Toggle/Focus Terminal" },

		-- Undo/Redo
		["<C-z>"] = { "<Esc>u", "Undo" },
		["<C-S-z>"] = { "<Esc><C-r>", "Redo" },
		["<C-y>"] = { "<Esc><C-r>", "Redo" },

		-- VS Code style text selection with Shift+Arrow keys
		["<S-Right>"] = { "<Esc>vl<C-g>", "Select Right" },
		["<S-Left>"] = { "<Esc>vh<C-g>", "Select Left" },
		["<S-Up>"] = { "<Esc>vk<C-g>", "Select Up" },
		["<S-Down>"] = { "<Esc>vj<C-g>", "Select Down" },
		["<S-Home>"] = { "<Esc>v^<C-g>", "Select to Start of Line" },
		["<S-End>"] = { "<Esc>v$<C-g>", "Select to End of Line" },
		["<S-C-Right>"] = { "<Esc>vw<C-g>", "Select Word Right" },
		["<S-C-Left>"] = { "<Esc>vb<C-g>", "Select Word Left" },
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

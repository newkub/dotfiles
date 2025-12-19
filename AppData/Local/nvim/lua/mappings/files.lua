-- VS Code style file operations key mappings for Neovim

return {
	n = {

		-- Switch to Last File
		["<C-l>"] = { ":e #<CR>", "Switch to Last File" },

		-- Save File (VS Code style: Ctrl+S)
		["<C-s>"] = { ":w<CR>", "Save File" },

		-- Undo Tree
		["<leader>u"] = { ":UndotreeToggle<CR>", "Toggle Undo Tree" },
	},

	i = {
		-- Save File
		["<C-s>"] = { "<C-o>:w<CR>", "Save File" },
	},
}

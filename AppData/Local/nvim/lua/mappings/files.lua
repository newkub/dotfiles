-- VS Code style file operations key mappings for Neovim

return {
	n = {

		-- Save File (VS Code style: Ctrl+S)
		["<C-s>"] = { ":w<CR>", "Save File" },

		["<F2>"] = {
			function()
				local buftype = vim.bo.buftype
				if buftype ~= "" then
					return
				end
				local old = vim.fn.expand("%:p")
				if old == "" then
					return
				end
				if vim.bo.modified then
					pcall(vim.cmd, "silent! write")
				end

				local dir = vim.fn.fnamemodify(old, ":h")
				local base = vim.fn.fnamemodify(old, ":t")
				local input = vim.fn.input("Rename to: ", base)
				if input == nil or input == "" or input == base then
					return
				end
				local new = input
				if not new:match("[\\/]" ) then
					new = dir .. "/" .. new
				end
				new = vim.fn.fnamemodify(new, ":p")

				local ok, err = pcall(function()
					local uv = vim.uv or vim.loop
					assert(uv.fs_rename(old, new))
				end)
				if not ok then
					vim.notify("Rename failed: " .. tostring(err), vim.log.levels.ERROR)
					return
				end

				vim.cmd("silent! edit " .. vim.fn.fnameescape(new))
			end,
			"Rename File",
		},

		["<Del>"] = {
			function()
				local buftype = vim.bo.buftype
				if buftype ~= "" then
					return
				end
				local path = vim.fn.expand("%:p")
				if path == "" then
					return
				end
				if vim.bo.modified then
					pcall(vim.cmd, "silent! write")
				end

				local ok, err = pcall(function()
					local uv = vim.uv or vim.loop
					assert(uv.fs_unlink(path))
				end)
				if not ok then
					vim.notify("Delete failed: " .. tostring(err), vim.log.levels.ERROR)
					return
				end

				vim.cmd("silent! bdelete!")
				vim.notify("Deleted: " .. path)
			end,
			"Delete File",
		},

		-- Undo Tree
		["<leader>u"] = { ":UndotreeToggle<CR>", "Toggle Undo Tree" },
	},

	i = {
		-- Save File
		["<C-s>"] = { "<C-o>:w<CR>", "Save File" },

		["<F2>"] = {
			function()
				vim.cmd("stopinsert")
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<F2>", true, false, true), "n", false)
			end,
			"Rename File",
		},

		["<Del>"] = {
			function()
				vim.cmd("stopinsert")
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Del>", true, false, true), "n", false)
			end,
			"Delete File",
		},
	},
}

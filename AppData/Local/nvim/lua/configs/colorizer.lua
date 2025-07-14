return {
	event = "VimEnter",
	config = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "nvdash", "nvcheatsheet" },
			callback = function()
				vim.keymap.set("n", "q", ":q<CR>", { buffer = true, silent = true })
				vim.keymap.set("n", "<Esc>", ":q<CR>", { buffer = true, silent = true })
			end,
		})
	end,
}
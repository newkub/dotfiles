return {
	"iamcco/markdown-preview.nvim",
	build = "cd app && bun install",
	ft = "markdown",
	config = function()
		-- Configuration for markdown-preview.nvim
		vim.g.mkdp_filetypes = { "markdown" }
		vim.g.mkdp_auto_start = 0
		vim.g.mkdp_auto_close = 1
		vim.g.mkdp_refresh_slow = 0
		vim.g.mkdp_command_for_global = 0
		vim.g.mkdp_open_to_the_world = 0
		vim.g.mkdp_open_ip = ""
		vim.g.mkdp_port = ""
		vim.g.mkdp_page_title = "${name}"

		-- Key mappings for markdown preview
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "markdown",
			callback = function()
				local opts = { noremap = true, silent = true }
				vim.keymap.set(
					"n",
					"<leader>mp",
					"<cmd>MarkdownPreview<cr>",
					vim.tbl_extend("force", opts, { desc = "Markdown Preview" })
				)
				vim.keymap.set(
					"n",
					"<leader>ms",
					"<cmd>MarkdownPreviewStop<cr>",
					vim.tbl_extend("force", opts, { desc = "Stop Markdown Preview" })
				)
				vim.keymap.set(
					"n",
					"<leader>mt",
					"<cmd>MarkdownPreviewToggle<cr>",
					vim.tbl_extend("force", opts, { desc = "Toggle Markdown Preview" })
				)
			end,
		})
	end,
}

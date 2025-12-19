return {
	"nvim-lualine/lualine.nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = false,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					{
						"branch",
						icon = "",
					},
					"diff",
					"diagnostics",
				},
				lualine_c = {
					{
						function()
							local path = vim.fn.expand("%:p:~")
							local size = vim.fn.getfsize(vim.fn.expand("%:p"))
							local size_str = size > 0 and string.format("%.1f", size / 1024) .. "KB" or ""
							return path .. (size_str ~= "" and " (" .. size_str .. ")" or "")
						end,
					},
				},
				lualine_x = {
					{
						function()
							if package.loaded["battery"] then
								return require("battery").get_status()
							end
							return ""
						end,
					},
					{
						function()
							local clients = vim.lsp.get_active_clients()
							return #clients > 0 and "LSP:" .. #clients or ""
						end,
					},
					"filetype",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		})
	end,
}

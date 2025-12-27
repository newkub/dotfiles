-- VS Code style navigation key mappings for Neovim

-- VS Code style navigation key mappings for Neovim

local function safe_dashboard(opts)
	opts = opts or {}
	local bufname = vim.fn.bufname()
	if bufname:match("dashboard") or bufname:match("alpha") then
		return
	end
	if opts.force then
		pcall(require("snacks").dashboard)
		return
	end
	if vim.api.nvim_buf_is_valid(0) and vim.api.nvim_buf_get_option(0, "modified") then
		pcall(vim.cmd, "write")
	end
	pcall(require("snacks").dashboard)
end

return {
	n = {
		-- File Explorer
		["<leader>e"] = {
			function()
				require("snacks").picker.files()
			end,
			"File Picker",
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
		["<leader>h"] = { safe_dashboard, "Go to Home/Dashboard" },
		["<leader>H"] = {
			function()
				safe_dashboard({ force = true })
			end,
			"Force go to Home",
		},

		-- Enter Insert Mode with Arrow Keys
		["<C-Left>"] = { "i", "Enter Insert Mode" },
		["<C-Right>"] = { "a", "Enter Insert Mode" },
	},
}

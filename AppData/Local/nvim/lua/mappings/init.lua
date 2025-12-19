-- Main mappings file that loads and sets all keymaps

local M = {}

function M.setup()
	local mappings = {
		require("mappings.navigation"),
		require("mappings.editing"),
		require("mappings.files"),
		require("mappings.system"),
		require("mappings.ai"),
	}

	for _, category in ipairs(mappings) do
		for mode, maps in pairs(category) do
			for key, map in pairs(maps) do
				local action = map[1]
				local desc = map[2]
				local extra_opts = map[3] or {}
				local opts = vim.tbl_extend("force", { desc = desc }, extra_opts)
				vim.keymap.set(mode, key, action, opts)
			end
		end
	end
end

return M

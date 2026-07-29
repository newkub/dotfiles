-- Core Neovim configuration

-- Disable optional providers that are not used (silences checkhealth warnings)
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- On Windows, a very long PATH makes cmd.exe (used by :system / :checkhealth)
-- unable to resolve external commands. Clean it up only for this nvim process.
if vim.fn.has("win32") == 1 and vim.env.PATH and #vim.env.PATH > 8191 then
	local parts = vim.split(vim.env.PATH, ";", { plain = true })
	local mise_shims = vim.fn.isdirectory(vim.fn.expand("~/AppData/Local/mise/shims")) == 1
	local seen, keep = {}, {}
	for _, part in ipairs(parts) do
		part = part:gsub("%s+", ""):gsub("\\+$", "")
		if part ~= "" and not seen[part] and vim.fn.isdirectory(part) == 1 then
			-- Prefer mise shims over individual mise install directories
			if mise_shims and part:lower():find("mise\\installs\\", 1, true) then
				-- skip, the shims directory handles these tools
			else
				seen[part] = true
				table.insert(keep, part)
			end
		end
	end
	vim.env.PATH = table.concat(keep, ";")
end

-- Define the leader key
vim.g.mapleader = " "

-- Monkey patch for deprecated vim.lsp.get_active_clients (Neovim 0.10+)
if vim.lsp.get_clients then
	vim.lsp.get_active_clients = vim.lsp.get_clients
end

-- Load core modules
require("core.options")
require("core.autocmds")
require("core.theme")
require("core.commands").setup()

-- Set up lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup(require("plugins"), require("configs.lazy"))

-- Load keymaps after plugins
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		require("mappings").setup()
	end,
})

-- File picker disabled - open Neovim directly without picker
-- vim.api.nvim_create_autocmd("VimEnter", {
--   once = true,
--   callback = function()
--     require("snacks").picker.files()
--   end,
-- })

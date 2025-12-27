-- Core Neovim configuration

-- Define the leader key
vim.g.mapleader = " "

-- Load core modules
require("core.options")
require("core.autocmds")
require("core.theme")

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
require("lazy").setup(require("plugins"))

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

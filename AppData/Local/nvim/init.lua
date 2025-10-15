-- Define the leader key BEFORE loading lazy
vim.g.mapleader = " "

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

-- Basic settings
vim.opt.termguicolors = true
vim.opt.background = "dark"

-- Enhanced swap file settings to prevent E325 errors
vim.opt.directory = vim.fn.stdpath("data") .. "/swap//"
vim.opt.swapfile = true

-- Create swap directory if it doesn't exist
local swap_dir = vim.fn.stdpath("data") .. "/swap/"
if vim.fn.isdirectory(swap_dir) == 0 then
  vim.fn.mkdir(swap_dir, "p")
end

-- Additional swap file management settings to reduce conflicts
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 8000  -- Increase update time to reduce swap file writes
vim.opt.swapfile = true  -- Explicitly enable swap files
vim.opt.directory = vim.fn.stdpath("data") .. "/swap//"  -- Ensure proper swap directory

-- Git integration settings
vim.opt.signcolumn = "yes"  -- Always show sign column for Git signs

-- Add error handling for vim.schedule callbacks
local original_schedule = vim.schedule
vim.schedule = function(fn)
  return original_schedule(function()
    local status, result = pcall(fn)
    if not status then
      vim.notify("Error in scheduled callback: " .. tostring(result), vim.log.levels.ERROR)
    end
  end)
end

-- Load plugins
require("lazy").setup("plugins")

-- Load theme settings
require("theme")

-- Load autocmds
require("autocmds")

-- Load key mappings
require("mappings")
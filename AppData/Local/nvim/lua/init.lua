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

-- Swap file settings to prevent E325 errors
vim.opt.directory = vim.fn.stdpath("data") .. "/swap//"
vim.opt.swapfile = true

-- Create swap directory if it doesn't exist
local swap_dir = vim.fn.stdpath("data") .. "/swap/"
if vim.fn.isdirectory(swap_dir) == 0 then
  vim.fn.mkdir(swap_dir, "p")
end

-- Create undo directory if it doesn't exist
local undo_dir = vim.fn.stdpath("data") .. "/undodir"
if vim.fn.isdirectory(undo_dir) == 0 then
  vim.fn.mkdir(undo_dir, "p")
end

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

-- Additional settings for insert mode behavior
vim.opt.backspace = "indent,eol,start"  -- Allow backspacing over everything in insert mode
vim.opt.whichwrap = "b,s,<,>,[,]"       -- Allow wrapping of cursor to prev/next line

-- Enable view options to save cursor position and other view settings
vim.opt.viewoptions = "cursor,folds,slash,unix"

-- Enable persistent undo
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"

-- Load plugins with error handling
local status, err = pcall(function()
  require("lazy").setup("plugins")
end)
if not status then
  vim.notify("Error loading plugins: " .. tostring(err), vim.log.levels.ERROR)
end

-- Load theme settings with error handling
status, err = pcall(function()
  require("theme")
end)
if not status then
  vim.notify("Error loading theme: " .. tostring(err), vim.log.levels.ERROR)
end

-- Load autocmds with error handling
status, err = pcall(function()
  require("autocmds")
end)
if not status then
  vim.notify("Error loading autocmds: " .. tostring(err), vim.log.levels.ERROR)
end

-- Load key mappings with error handling
status, err = pcall(function()
  require("mappings")
end)
if not status then
  vim.notify("Error loading mappings: " .. tostring(err), vim.log.levels.ERROR)
end
-- Custom key mappings for Neovim — entry point
-- Each category is organized in its own file for SRP (Single Responsibility Principle)

require("mappings.helpers")  -- load helpers first (defines functions used by others)
require("mappings.editor")   -- ESC, Ctrl+C, editing keymaps
require("mappings.files")    -- file explorer, picker, devin toggle
require("mappings.terminal") -- terminal toggle, BufEnter autocmd
require("mappings.ai")       -- Copilot, Undotree

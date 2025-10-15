-- Main mappings file that loads all sub-modules

-- Load navigation mappings
require("mappings.navigation")

-- Load text editing mappings
require("mappings.editing")

-- Load file operations mappings
require("mappings.files")

-- Load system operations mappings
require("mappings.system")

-- Load AI assistance mappings
require("mappings.ai")

-- Load autocmds
require("mappings.autocmds")

-- This file serves as the entry point for all key mappings
-- Each category of mappings is organized in its own file for better maintainability
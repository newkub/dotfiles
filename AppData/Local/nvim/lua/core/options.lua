-- Neovim options

-- Basic settings
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.number = true
vim.opt.backspace = "indent,eol,start"

-- Encoding settings for Thai language support
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.fileencodings = "utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936"
vim.scriptencoding = "utf-8"

-- GUI font settings (if using a GUI version of Neovim)
if vim.fn.has("gui_running") == 1 then
  vim.opt.guifont = "Consolas:h11"
end

-- Indentation settings
vim.opt.autoindent = true      -- Copy indent from current line when starting new line
vim.opt.smartindent = true     -- Smart autoindenting when starting a new line
vim.opt.expandtab = true       -- Use spaces instead of tabs
vim.opt.tabstop = 2            -- Number of spaces that a <Tab> counts for
vim.opt.shiftwidth = 2         -- Number of spaces to use for each step of (auto)indent
vim.opt.softtabstop = 2        -- Number of spaces that a <Tab> counts for while editing

-- Enhanced swap file settings to prevent E325 errors
vim.opt.directory = vim.fn.stdpath("data") .. "/swap//"
vim.opt.swapfile = true

-- Additional swap file management settings to reduce conflicts
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 8000  -- Increase update time to reduce swap file writes

-- Git integration settings
vim.opt.signcolumn = "yes"  -- Always show sign column for Git signs

-- Cursor settings
vim.opt.guicursor = "a:ver25-blinkon0"
vim.opt.cursorline = true
vim.opt.virtualedit = "onemore"

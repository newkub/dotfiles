-- Neovim options

-- Disable OSC 52 clipboard capability query to avoid TermResponse errors
vim.g.termfeatures = { osc52 = false }

-- Use PowerShell as the default shell for terminal and system commands.
-- Windows PowerShell (powershell) is preferred over pwsh for :! / system()
-- because pwsh startup is slow and triggers the "Slow shell invocation" checkhealth
-- warning. The <C-m> terminal toggle still uses pwsh (PowerShell 7+).
if vim.fn.executable("powershell") == 1 then
	vim.o.shell = "powershell"
elseif vim.fn.executable("pwsh") == 1 then
	vim.o.shell = "pwsh"
end
vim.o.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
vim.o.shellredir = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
vim.o.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
vim.o.shellquote = ""
vim.o.shellxquote = ""

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
vim.opt.autoindent = true -- Copy indent from current line when starting new line
vim.opt.smartindent = true -- Smart autoindenting when starting a new line
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.tabstop = 2 -- Number of spaces that a <Tab> counts for
vim.opt.shiftwidth = 2 -- Number of spaces to use for each step of (auto)indent
vim.opt.softtabstop = 2 -- Number of spaces that a <Tab> counts for while editing

-- Keep swap files in Neovim's data directory (C:\Users\Veerapong\AppData\Local\nvim-data\swap)
local swap_dir = vim.fn.stdpath("data") .. "/swap"
if vim.fn.isdirectory(swap_dir) == 0 then
	vim.fn.mkdir(swap_dir, "p")
end
vim.opt.directory = swap_dir .. "//"
vim.opt.swapfile = true

-- Additional swap file management settings to reduce conflicts
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 8000 -- Increase update time to reduce swap file writes

-- Git integration settings
vim.opt.signcolumn = "yes" -- Always show sign column for Git signs

-- Cursor settings
vim.opt.guicursor = "a:ver25-blinkon0"
vim.opt.cursorline = true
vim.opt.virtualedit = "onemore"

-- Enable ShaDa file to persist last cursor position marks
vim.opt.shada = "!,'100,<50,s10,h"

-- Use Snacks.statuscolumn for the status column
vim.opt.statuscolumn = "%!v:lua.Snacks.statuscolumn.get()"

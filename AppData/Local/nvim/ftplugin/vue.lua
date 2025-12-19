-- Vue file specific settings
vim.opt_local.commentstring = "<!-- %s -->"

-- Enable treesitter highlighting for Vue files
vim.api.nvim_command("setlocal filetype=vue")

-- Configure indentation for Vue files
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.expandtab = true

-- Enable syntax folding for Vue files
vim.opt_local.foldmethod = "syntax"
vim.opt_local.foldlevel = 99

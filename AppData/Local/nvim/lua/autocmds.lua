-- Autocommands for Neovim
-- Removed automatic explorer opening to respect user preference

-- Enhanced swap file management to prevent E325 warnings
-- Clean up swap files when Neovim exits normally
vim.api.nvim_create_autocmd("VimLeavePre", {
  pattern = "*",
  callback = function()
    -- This will help ensure swap files are properly cleaned up
    vim.cmd("silent! wa")  -- Write all buffers silently
  end,
})

-- Reduce swap file updates to prevent conflicts
vim.api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = "*",
  callback = function()
    -- Temporarily disable swap for write operations to prevent conflicts
    vim.opt_local.swapfile = false
  end,
})

vim.api.nvim_create_autocmd({"BufWritePost"}, {
  pattern = "*",
  callback = function()
    -- Re-enable swap after write operations
    vim.opt_local.swapfile = true
  end,
})

-- Additional swap file cleanup on focus lost
vim.api.nvim_create_autocmd({"FocusLost"}, {
  pattern = "*",
  callback = function()
    -- Write all buffers when focus is lost to reduce swap file conflicts
    if vim.fn.expand("%") ~= "" then
      vim.cmd("silent! wa")
    end
  end,
})

-- Handle terminal focus events for better swap file management
vim.api.nvim_create_autocmd({"TermClose"}, {
  pattern = "*",
  callback = function()
    -- Write buffers when terminal closes
    vim.cmd("silent! wa")
  end,
})

-- Save and restore cursor position
-- This will remember the last cursor position in files
vim.api.nvim_create_autocmd({"BufReadPost"}, {
  pattern = "*",
  callback = function()
    -- Check if the file is a normal file (not a special buffer)
    local bufname = vim.fn.bufname()
    if bufname ~= "" and not bufname:match("dashboard") and not bufname:match("alpha") and not bufname:match("NvimTree") then
      -- Restore cursor position
      local status, err = pcall(function()
        local line = vim.fn.line("'\"")
        local col = vim.fn.col("'\"")
        local total_lines = vim.fn.line("$")
        
        -- Check if the line number is valid
        if line > 0 and line <= total_lines then
          -- Move cursor to the last known position
          vim.api.nvim_win_set_cursor(0, {line, col})
        end
      end)
      
      if not status then
        vim.notify("Error restoring cursor position: " .. tostring(err), vim.log.levels.WARN)
      end
    end
  end,
})

vim.api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = "*",
  callback = function()
    -- Save cursor position before writing
    local status, err = pcall(function()
      vim.cmd("silent! mkview")
    end)
    
    if not status then
      vim.notify("Error saving cursor position: " .. tostring(err), vim.log.levels.WARN)
    end
  end,
})

vim.api.nvim_create_autocmd({"BufReadPre"}, {
  pattern = "*",
  callback = function()
    -- Restore cursor position when reading file
    local status, err = pcall(function()
      vim.cmd("silent! loadview")
    end)
    
    if not status then
      vim.notify("Error loading cursor position: " .. tostring(err), vim.log.levels.WARN)
    end
  end,
})

-- Terminal and system operations key mappings for Neovim

-- Ctrl+T to open terminal with PowerShell
vim.keymap.set("n", "<C-t>", function()
  local status, err = pcall(function()
    vim.cmd("terminal pwsh")
  end)
  if not status then
    vim.notify("Error opening terminal: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Open PowerShell Terminal" })

-- F5 to start debugging (like VS Code)
vim.keymap.set("n", "<F5>", function()
  local status, err = pcall(function()
    -- Start debugging
    vim.cmd("lua require('dap').continue()")
  end)
  if not status then
    vim.notify("Error starting debugger: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Start Debugging" })

-- Shift+F5 to stop debugging (like VS Code)
vim.keymap.set("n", "<S-F5>", function()
  local status, err = pcall(function()
    -- Stop debugging
    vim.cmd("lua require('dap').terminate()")
  end)
  if not status then
    vim.notify("Error stopping debugger: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Stop Debugging" })

-- F9 to toggle breakpoint (like VS Code)
vim.keymap.set("n", "<F9>", function()
  local status, err = pcall(function()
    -- Toggle breakpoint
    vim.cmd("lua require('dap').toggle_breakpoint()")
  end)
  if not status then
    vim.notify("Error toggling breakpoint: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Toggle Breakpoint" })

-- Ctrl+Shift+M to toggle problems panel (like VS Code)
vim.keymap.set("n", "<C-S-m>", function()
  local status, err = pcall(function()
    -- Toggle problems panel
    vim.cmd("TroubleToggle")
  end)
  if not status then
    vim.notify("Error toggling problems panel: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Toggle Problems Panel" })

-- Ctrl+Shift+V to paste from clipboard (like VS Code)
vim.keymap.set("n", "<C-S-v>", function()
  local status, err = pcall(function()
    -- Paste from system clipboard
    vim.cmd("normal \"+p")
  end)
  if not status then
    vim.notify("Error pasting from clipboard: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Paste from Clipboard" })

-- Ctrl+Shift+C to copy to clipboard (like VS Code)
vim.keymap.set("v", "<C-S-c>", function()
  local status, err = pcall(function()
    -- Copy to system clipboard
    vim.cmd("normal \"+y")
  end)
  if not status then
    vim.notify("Error copying to clipboard: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Copy to Clipboard" })
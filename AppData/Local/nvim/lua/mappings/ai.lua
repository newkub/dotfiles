-- AI assistance keymaps (GitHub Copilot, Undotree)

-- GitHub Copilot: accept suggestion
vim.keymap.set("i", "<M-l>", function()
  local status, err = pcall(function()
    vim.fn['copilot#Accept']('')
  end)
  if not status then
    vim.notify("Error accepting Copilot suggestion: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Accept Copilot Suggestion", silent = true, expr = true })

-- Copilot: previous suggestion
vim.keymap.set("i", "<M-[>", function()
  local status, err = pcall(function()
    vim.fn['copilot#Previous']()
  end)
  if not status then
    vim.notify("Error going to previous Copilot suggestion: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Previous Copilot Suggestion" })

-- Copilot: next suggestion
vim.keymap.set("i", "<M-]>", function()
  local status, err = pcall(function()
    vim.fn['copilot#Next']()
  end)
  if not status then
    vim.notify("Error going to next Copilot suggestion: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Next Copilot Suggestion" })

-- Copilot: dismiss suggestion
vim.keymap.set("i", "<C-]>", function()
  local status, err = pcall(function()
    vim.fn['copilot#Dismiss']()
  end)
  if not status then
    vim.notify("Error dismissing Copilot suggestion: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Dismiss Copilot Suggestion" })

-- Undotree toggle
vim.keymap.set("n", "<leader>u", function()
  local status, err = pcall(vim.cmd, "UndotreeToggle")
  if not status then
    vim.notify("Error toggling undotree: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Toggle Undo Tree" })

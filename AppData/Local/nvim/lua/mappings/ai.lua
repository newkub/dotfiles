-- AI assistance key mappings for Neovim

-- GitHub Copilot mappings
vim.keymap.set("i", "<M-l>", function()
  local status, err = pcall(function()
    vim.fn['copilot#Accept']('')
  end)
  if not status then
    vim.notify("Error accepting Copilot suggestion: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Accept Copilot Suggestion", silent = true, expr = true })

vim.keymap.set("i", "<M-[>", function()
  local status, err = pcall(function()
    vim.fn['copilot#Previous']()
  end)
  if not status then
    vim.notify("Error going to previous Copilot suggestion: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Previous Copilot Suggestion" })

vim.keymap.set("i", "<M-]>", function()
  local status, err = pcall(function()
    vim.fn['copilot#Next']()
  end)
  if not status then
    vim.notify("Error going to next Copilot suggestion: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Next Copilot Suggestion" })

vim.keymap.set("i", "<C-]>", function()
  local status, err = pcall(function()
    vim.fn['copilot#Dismiss']()
  end)
  if not status then
    vim.notify("Error dismissing Copilot suggestion: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Dismiss Copilot Suggestion" })

-- Codeium mappings
vim.keymap.set("i", "<M-=>", function()
  local status, err = pcall(function()
    vim.fn['codeium#Accept']()
  end)
  if not status then
    vim.notify("Error accepting Codeium suggestion: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Accept Codeium Suggestion" })

vim.keymap.set("i", "<M->>", function()
  local status, err = pcall(function()
    vim.fn['codeium#CycleCompletions'](1)
  end)
  if not status then
    vim.notify("Error cycling Codeium completions: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Next Codeium Completion" })

vim.keymap.set("i", "<M-<>", function()
  local status, err = pcall(function()
    vim.fn['codeium#CycleCompletions'](-1)
  end)
  if not status then
    vim.notify("Error cycling Codeium completions: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Previous Codeium Completion" })
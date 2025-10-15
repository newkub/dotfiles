-- File and buffer operations key mappings for Neovim

-- Ctrl+R to open recent files picker
vim.keymap.set({ "n", "i" }, "<C-r>", function()
  local status, err = pcall(function()
    require("snacks").picker.recent()
  end)
  if not status then
    vim.notify("Error opening recent files picker: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Recent Files Picker" })

-- Ctrl+P to open smart file picker
vim.keymap.set({ "n", "i" }, "<C-p>", function()
  local status, err = pcall(function()
    require("snacks").picker.smart()
  end)
  if not status then
    vim.notify("Error opening smart file picker: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Smart File Picker" })

-- Shift+F to open file picker
vim.keymap.set({ "n", "i" }, "<S-f>", function()
  local status, err = pcall(function()
    require("snacks").picker.files()
  end)
  if not status then
    vim.notify("Error opening file picker: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "File Picker" })

-- Ctrl+F to open file picker grep
vim.keymap.set({ "n", "i" }, "<C-f>", function()
  local status, err = pcall(function()
    require("snacks").picker.grep()
  end)
  if not status then
    vim.notify("Error opening grep picker: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Grep in Files" })

-- Ctrl+L to switch back to the last visited file (like VS Code)
vim.keymap.set({ "n", "i" }, "<C-l>", function()
  local status, err = pcall(function()
    -- This uses the built-in Ctrl+^ functionality to switch to the last visited file
    vim.cmd("e #")
  end)
  if not status then
    vim.notify("Error switching to last file: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Switch to Last File" })

-- Undotree mapping
vim.keymap.set("n", "<leader>u", function()
  local status, err = pcall(function()
    vim.cmd("UndotreeToggle")
  end)
  if not status then
    vim.notify("Error toggling undotree: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Toggle Undo Tree" })

-- Ctrl+N to create new file (like VS Code)
vim.keymap.set("n", "<C-n>", function()
  local status, err = pcall(function()
    -- Create new file
    vim.cmd("enew")
  end)
  if not status then
    vim.notify("Error creating new file: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "New File" })

-- Ctrl+O to open file (like VS Code)
vim.keymap.set("n", "<C-o>", function()
  local status, err = pcall(function()
    -- Open file dialog
    require("snacks").picker.files()
  end)
  if not status then
    vim.notify("Error opening file dialog: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Open File" })

-- Ctrl+S to save file (like VS Code)
vim.keymap.set({ "n", "i" }, "<C-s>", function()
  local status, err = pcall(function()
    -- Save current file
    vim.cmd("write")
  end)
  if not status then
    vim.notify("Error saving file: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Save File" })

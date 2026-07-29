-- File & buffer operation keymaps

local helpers = require("mappings.helpers")

-- Space + e to open file explorer
vim.keymap.set("n", "<leader>e", function()
  local status, err = pcall(function()
    require("snacks").explorer()
  end)
  if not status then
    vim.notify("Error opening explorer: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "File Explorer" })

-- F1 to open file picker (override default help)
vim.keymap.set({ "n", "i" }, "<F1>", function()
  local status, err = pcall(function()
    require("snacks").picker()
  end)
  if not status then
    vim.notify("Error opening picker: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "File Picker", noremap = true, silent = true })

-- Ctrl+R to open recent files picker
vim.keymap.set({ "n", "i" }, "<C-r>", function()
  local status, err = pcall(function()
    require("snacks").picker.recent()
  end)
  if not status then
    vim.notify("Error opening recent files picker: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Recent Files Picker" })

-- Ctrl+P to open file picker (VS Code-like)
vim.keymap.set({ "n", "i" }, "<C-p>", function()
  local status, err = pcall(function()
    require("snacks").picker.files()
  end)
  if not status then
    vim.notify("Error opening file picker: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "File Picker" })

-- Ctrl+L to toggle nvim-devin session panel
vim.keymap.set({ "n", "i" }, "<C-l>", function()
  if vim.fn.mode() == "i" then
    vim.cmd("stopinsert")
  end
  helpers.toggle_devin()
end, { desc = "Toggle Devin" })

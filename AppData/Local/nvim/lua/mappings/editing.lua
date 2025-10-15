-- Text editing key mappings for Neovim

-- Ctrl+A to select all text (like VS Code) - works in editor modes
vim.keymap.set({ "n", "i", "v" }, "<C-a>", function()
  local status, err = pcall(function()
    -- Select all text in the buffer
    vim.cmd("keepjumps normal! ggVG")
  end)
  if not status then
    vim.notify("Error selecting all text: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Select All Text" })

-- Ctrl+Z for undo (without changing modes)
vim.keymap.set({ "n", "i" }, "<C-z>", function()
  local status, err = pcall(function()
    -- Perform undo without changing modes
    vim.cmd("undo")
  end)
  if not status then
    vim.notify("Error performing undo: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Undo" })

-- Ctrl+Shift+Z for redo (without changing modes)
vim.keymap.set({ "n", "i" }, "<C-S-z>", function()
  local status, err = pcall(function()
    -- Perform redo without changing modes
    vim.cmd("redo")
  end)
  if not status then
    vim.notify("Error performing redo: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Redo" })

-- Ctrl+Backspace to delete entire word in insert mode
vim.keymap.set("i", "<C-BS>", function()
  local status, err = pcall(function()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>", true, false, true), "n", true)
  end)
  if not status then
    vim.notify("Error deleting word: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Delete word backward" })

-- Ctrl+X to delete entire line in insert mode (like VS Code)
vim.keymap.set("i", "<C-x>", function()
  local status, err = pcall(function()
    -- Exit to normal mode, delete the line, then go back to insert mode
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>ddi", true, false, true), "n", true)
  end)
  if not status then
    vim.notify("Error deleting line: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Delete entire line" })

-- Backspace in insert mode - delete selected text if any, otherwise normal backspace
vim.keymap.set("i", "<BS>", function()
  local status, err = pcall(function()
    -- Use the built-in delete functionality for selected text
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-h>", true, false, true), "n", true)
  end)
  if not status then
    vim.notify("Error handling backspace: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Backspace", silent = true })

-- Delete key in insert mode - delete selected text if any, otherwise normal delete
vim.keymap.set("i", "<Del>", function()
  local status, err = pcall(function()
    -- Use the built-in delete functionality for selected text
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-d>", true, false, true), "n", true)
  end)
  if not status then
    vim.notify("Error handling delete: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Delete", silent = true })

-- Ctrl+D to duplicate line (like VS Code)
vim.keymap.set("n", "<C-d>", function()
  local status, err = pcall(function()
    -- Duplicate current line
    vim.cmd("t.")
  end)
  if not status then
    vim.notify("Error duplicating line: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Duplicate Line" })

-- Ctrl+Shift+K to delete line (like VS Code)
vim.keymap.set("n", "<C-S-k>", function()
  local status, err = pcall(function()
    -- Delete current line
    vim.cmd("dd")
  end)
  if not status then
    vim.notify("Error deleting line: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Delete Line" })

-- Ctrl+/ to toggle comment (like VS Code)
vim.keymap.set({ "n", "i" }, "<C-/>", function()
  local status, err = pcall(function()
    -- Toggle comment for current line or selected lines
    vim.cmd("normal gcc")
  end)
  if not status then
    vim.notify("Error toggling comment: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Toggle Comment" })

-- Ctrl+Shift+/ to toggle block comment (like VS Code)
vim.keymap.set({ "n", "i" }, "<C-S-/>", function()
  local status, err = pcall(function()
    -- Toggle block comment for current line or selected lines
    vim.cmd("normal gC")
  end)
  if not status then
    vim.notify("Error toggling block comment: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Toggle Block Comment" })

-- Shift+Alt+F to format document (like VS Code)
vim.keymap.set("n", "<S-A-f>", function()
  local status, err = pcall(function()
    -- Format the entire document
    vim.lsp.buf.format()
  end)
  if not status then
    vim.notify("Error formatting document: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Format Document" })

-- Ctrl+] to indent (like VS Code)
vim.keymap.set("n", "<C-]>", function()
  local status, err = pcall(function()
    -- Indent selected lines or current line
    vim.cmd(">")
  end)
  if not status then
    vim.notify("Error indenting: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Indent" })

-- Ctrl+[ to outdent (like VS Code)
vim.keymap.set("n", "<C-[>", function()
  local status, err = pcall(function()
    -- Outdent selected lines or current line
    vim.cmd("<")
  end)
  if not status then
    vim.notify("Error outdenting: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Outdent" })

-- Ctrl+H to replace (like VS Code)
vim.keymap.set("n", "<C-h>", function()
  local status, err = pcall(function()
    -- Open replace prompt
    vim.cmd(":%s///g")
  end)
  if not status then
    vim.notify("Error opening replace: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Replace" })

-- F3 to find next (like VS Code)
vim.keymap.set("n", "<F3>", function()
  local status, err = pcall(function()
    -- Find next occurrence
    vim.cmd("n")
  end)
  if not status then
    vim.notify("Error finding next: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Find Next" })

-- Shift+F3 to find previous (like VS Code)
vim.keymap.set("n", "<S-F3>", function()
  local status, err = pcall(function()
    -- Find previous occurrence
    vim.cmd("N")
  end)
  if not status then
    vim.notify("Error finding previous: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Find Previous" })

-- Alt+Up to move line up (like VS Code)
vim.keymap.set("n", "<A-Up>", function()
  local status, err = pcall(function()
    -- Move current line up
    vim.cmd("m -2")
  end)
  if not status then
    vim.notify("Error moving line up: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Move Line Up" })

-- Alt+Down to move line down (like VS Code)
vim.keymap.set("n", "<A-Down>", function()
  local status, err = pcall(function()
    -- Move current line down
    vim.cmd("m +1")
  end)
  if not status then
    vim.notify("Error moving line down: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Move Line Down" })

-- Alt+Left to go back (like VS Code)
vim.keymap.set("n", "<A-Left>", function()
  local status, err = pcall(function()
    -- Go back to previous location
    vim.cmd("normal <C-o>")
  end)
  if not status then
    vim.notify("Error going back: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Go Back" })

-- Alt+Right to go forward (like VS Code)
vim.keymap.set("n", "<A-Right>", function()
  local status, err = pcall(function()
    -- Go forward to next location
    vim.cmd("normal <C-i>")
  end)
  if not status then
    vim.notify("Error going forward: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Go Forward" })

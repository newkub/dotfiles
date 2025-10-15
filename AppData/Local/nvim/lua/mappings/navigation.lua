-- Navigation and UI key mappings for Neovim

-- Helper function to safely navigate to dashboard
local function safe_dashboard(opts)
  opts = opts or {}
  
  -- Check if we're already on the dashboard
  local bufname = vim.fn.bufname()
  if bufname:match("dashboard") or bufname:match("alpha") then
    return
  end
  
  -- If force option is set, skip save check
  if opts.force then
    local status, err = pcall(function()
      require("snacks").dashboard({ force = true })
    end)
    if not status then
      vim.notify("Error opening dashboard (force): " .. tostring(err), vim.log.levels.ERROR)
    end
    return
  end
  
  -- Check if current buffer has unsaved changes
  local buf_modified = false
  local buf_valid = vim.api.nvim_buf_is_valid(0)
  
  if buf_valid then
    buf_modified = vim.api.nvim_buf_get_option(0, "modified")
  end
  
  -- If buffer is modified, save it first
  if buf_valid and buf_modified then
    local status, err = pcall(vim.cmd, "write")
    if not status then
      vim.notify("Error saving buffer: " .. tostring(err), vim.log.levels.ERROR)
      return
    end
  end
  
  -- Now navigate to dashboard with proper error handling
  local status, err = pcall(function()
    require("snacks").dashboard()
  end)
  if not status then
    vim.notify("Error opening dashboard: " .. tostring(err), vim.log.levels.ERROR)
  end
end

-- ESC to toggle between insert and normal modes
-- In insert mode: ESC goes to normal mode (default behavior)
-- In normal mode: ESC goes to insert mode
vim.keymap.set("n", "<Esc>", function()
  local status, err = pcall(function()
    vim.cmd("startinsert")
  end)
  if not status then
    vim.notify("Error entering insert mode: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Toggle Insert Mode" })

-- Ctrl+C to auto-save and return to home screen (from both normal and insert modes)
vim.keymap.set({ "n", "i" }, "<C-c>", function()
  local status, err = pcall(function()
    -- Check if we're in the home screen/dashboard
    local bufname = vim.fn.bufname()
    if bufname == "" or bufname:match("dashboard") or bufname:match("alpha") then
      -- Quit Neovim completely
      vim.cmd("qa")
    else
      -- Auto-save the current buffer and return to home screen
      safe_dashboard()
    end
  end)
  if not status then
    vim.notify("Error handling Ctrl+C: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Auto-save and Return to Home" })

-- Ctrl+Shift+C to force return to dashboard (discard unsaved changes)
vim.keymap.set({ "n", "i" }, "<C-S-c>", function()
  local status, err = pcall(function()
    -- Check if we're in the home screen/dashboard
    local bufname = vim.fn.bufname()
    if bufname == "" or bufname:match("dashboard") or bufname:match("alpha") then
      -- Quit Neovim completely (force quit if there are unsaved changes)
      vim.cmd("qa!")
    else
      -- Return to home screen (force discard changes)
      safe_dashboard({ force = true })
    end
  end)
  if not status then
    vim.notify("Error handling Ctrl+Shift+C: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Force Return to Home" })

-- Space + e to open file explorer
vim.keymap.set("n", "<leader>e", function()
  local status, err = pcall(function()
    require("snacks").explorer()
  end)
  if not status then
    vim.notify("Error opening explorer: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "File Explorer" })

-- F1 to open file picker (override default help) - works in both normal and insert modes
vim.keymap.set({ "n", "i" }, "<F1>", function()
  local status, err = pcall(function()
    require("snacks").picker()
  end)
  if not status then
    vim.notify("Error opening picker: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "File Picker", noremap = true, silent = true })

-- Ctrl+Shift+P to open command palette (like VS Code)
vim.keymap.set({ "n", "i" }, "<C-S-p>", function()
  local status, err = pcall(function()
    vim.cmd("Commands")
  end)
  if not status then
    vim.notify("Error opening command palette: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Command Palette" })

-- Ctrl+Tab to switch to next buffer (like VS Code)
vim.keymap.set("n", "<C-Tab>", function()
  local status, err = pcall(function()
    vim.cmd("bnext")
  end)
  if not status then
    vim.notify("Error switching to next buffer: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Next Buffer" })

-- Ctrl+Shift+Tab to switch to previous buffer (like VS Code)
vim.keymap.set("n", "<C-S-Tab>", function()
  local status, err = pcall(function()
    vim.cmd("bprev")
  end)
  if not status then
    vim.notify("Error switching to previous buffer: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Previous Buffer" })

-- Ctrl+1 to focus first editor group (like VS Code)
vim.keymap.set("n", "<C-1>", function()
  local status, err = pcall(function()
    -- Focus first editor group
    vim.cmd("wincmd h")
  end)
  if not status then
    vim.notify("Error focusing first editor group: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Focus First Editor Group" })

-- Ctrl+2 to focus second editor group (like VS Code)
vim.keymap.set("n", "<C-2>", function()
  local status, err = pcall(function()
    -- Focus second editor group
    vim.cmd("wincmd l")
  end)
  if not status then
    vim.notify("Error focusing second editor group: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Focus Second Editor Group" })

-- Ctrl+W to close editor (like VS Code)
vim.keymap.set("n", "<C-w>", function()
  local status, err = pcall(function()
    -- Close current window
    vim.cmd("close")
  end)
  if not status then
    vim.notify("Error closing editor: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Close Editor" })

-- Ctrl+K Ctrl+S to open keyboard shortcuts (like VS Code)
vim.keymap.set("n", "<C-k><C-s>", function()
  local status, err = pcall(function()
    -- Open keybindings documentation
    vim.cmd("help keybindings")
  end)
  if not status then
    vim.notify("Error opening keybindings help: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Keyboard Shortcuts" })

-- Ctrl+K Ctrl+T to open themes (like VS Code)
vim.keymap.set("n", "<C-k><C-t>", function()
  local status, err = pcall(function()
    -- Open themes configuration
    vim.cmd("Telescope colorscheme")
  end)
  if not status then
    vim.notify("Error opening themes: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Color Themes" })

-- Ctrl+K Ctrl+X to trim trailing whitespace (like VS Code)
vim.keymap.set("n", "<C-k><C-x>", function()
  local status, err = pcall(function()
    -- Trim trailing whitespace
    vim.cmd("%s/\\s\\+$//e")
  end)
  if not status then
    vim.notify("Error trimming whitespace: " .. tostring(err), vim.log.levels.ERROR)
  end
end, { desc = "Trim Trailing Whitespace" })

return {
  safe_dashboard = safe_dashboard
}
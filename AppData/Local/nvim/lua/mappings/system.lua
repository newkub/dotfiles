-- VS Code style system operations key mappings for Neovim

-- Custom function to toggle terminal (hide/show)
local function toggle_or_focus_terminal()
  local current_win = vim.api.nvim_get_current_win()
  local current_buf = vim.api.nvim_win_get_buf(current_win)
  
  -- เช็คว่า cursor อยู่ใน terminal หรือไม่
  if vim.bo[current_buf].buftype == "terminal" then
    -- ถ้าอยู่ใน terminal ให้ซ่อน window (ไม่ลบ buffer)
    vim.api.nvim_win_hide(current_win)
    return
  end
  
  -- หา terminal buffer และ window ที่มีอยู่
  local term_bufnr = nil
  local term_winnr = nil
  
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buftype == "terminal" and vim.api.nvim_buf_is_valid(buf) then
      term_bufnr = buf
      -- เช็คว่า buffer นี้มี window หรือไม่
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_buf(win) == buf then
          term_winnr = win
          break
        end
      end
      break
    end
  end
  
  -- ถ้ามี terminal buffer แต่ไม่มี window (ถูกซ่อนไว้)
  if term_bufnr and not term_winnr then
    -- แสดง terminal buffer ใน split window ด้านล่าง
    vim.cmd("botright split")
    vim.api.nvim_win_set_buf(0, term_bufnr)
    vim.cmd("startinsert")
  elseif term_winnr then
    -- ถ้ามี window อยู่แล้ว ให้ focus ไป
    vim.api.nvim_set_current_win(term_winnr)
    vim.cmd("startinsert")
  else
    -- ถ้าไม่มี terminal เลย ให้สร้างใหม่
    require("snacks").terminal()
  end
end

return {
  n = {
    -- Command Palette (VS Code style: F1)
    ["<F1>"] = { function() require("snacks").picker() end, "Pick a Picker", { noremap = true, silent = true } },
    
    -- Rename File (VS Code style: F2)
    ["<F2>"] = { function() require("snacks").rename.rename_file() end, "Rename File", { noremap = true, silent = true } },

    -- File Pickers
    ["<C-p>"] = { function() require("snacks").picker.files() end, "Pick Files", { noremap = true, silent = true } },
    ["<C-r>"] = { function() require("snacks").picker.recent() end, "Pick Recent Files", { noremap = true, silent = true } },

    -- Open Terminal (VS Code style: Ctrl+`)
    ["<C-`>"] = { ":terminal pwsh<CR>", "Open Terminal" },

    -- Quit Neovim
    ["<C-c>"] = { function() vim.cmd("q!") end, "Quit Neovim" },
    
    -- Toggle/Focus Terminal
    ["<C-l>"] = { toggle_or_focus_terminal, "Focus Terminal" },
    
    -- Undo/Redo (VS Code style)
    ["<C-z>"] = { "u", "Undo" },
    ["<C-S-z>"] = { "<C-r>", "Redo" },
    ["<C-y>"] = { "<C-r>", "Redo" },
  },

  i = {
    -- Command Palette (VS Code style: F1)
    ["<F1>"] = { function() require("snacks").picker() end, "Pick a Picker", { noremap = true, silent = true } },
    
    -- File Pickers
    ["<C-p>"] = { function() require("snacks").picker.files() end, "Pick Files", { noremap = true, silent = true } },
    ["<C-r>"] = { function() require("snacks").picker.recent() end, "Pick Recent Files", { noremap = true, silent = true } },
    
    -- Exit to Normal Mode
    ["<C-c>"] = { "<Esc>", "Exit to Normal Mode" },
    
    -- Toggle/Focus Terminal
    ["<C-l>"] = { toggle_or_focus_terminal, "Focus Terminal" },
    
    -- Undo/Redo (VS Code style)
    ["<C-z>"] = { "<C-o>u", "Undo" },
    ["<C-S-z>"] = { "<C-o><C-r>", "Redo" },
    ["<C-y>"] = { "<C-o><C-r>", "Redo" },
    
    -- VS Code style text selection with Shift+Arrow keys (using Select mode)
    ["<S-Right>"] = { "<C-o>vl<C-g>", "Select Right" },
    ["<S-Left>"] = { "<C-o>vh<C-g>", "Select Left" },
    ["<S-Up>"] = { "<C-o>vk<C-g>", "Select Up" },
    ["<S-Down>"] = { "<C-o>vj<C-g>", "Select Down" },
    ["<S-Home>"] = { "<C-o>v^<C-g>", "Select to Start of Line" },
    ["<S-End>"] = { "<C-o>v$<C-g>", "Select to End of Line" },
    
    -- Select word by word (VS Code style: Shift+Ctrl+Arrow)
    ["<S-C-Right>"] = { "<C-o>vw<C-g>", "Select Word Right" },
    ["<S-C-Left>"] = { "<C-o>vb<C-g>", "Select Word Left" },
  },

  v = {
    -- Continue selection with Shift+Arrow keys (switch to select mode)
    ["<S-Right>"] = { "l<C-g>", "Extend Selection Right" },
    ["<S-Left>"] = { "h<C-g>", "Extend Selection Left" },
    ["<S-Up>"] = { "k<C-g>", "Extend Selection Up" },
    ["<S-Down>"] = { "j<C-g>", "Extend Selection Down" },
    ["<S-Home>"] = { "^<C-g>", "Extend Selection to Start of Line" },
    ["<S-End>"] = { "$<C-g>", "Extend Selection to End of Line" },
    
    -- Select word by word
    ["<S-C-Right>"] = { "w<C-g>", "Extend Selection Word Right" },
    ["<S-C-Left>"] = { "b<C-g>", "Extend Selection Word Left" },
  },
  
  s = {
    -- Continue selection in Select mode with Shift
    ["<S-Right>"] = { "<Right>", "Extend Selection Right" },
    ["<S-Left>"] = { "<Left>", "Extend Selection Left" },
    ["<S-Up>"] = { "<Up>", "Extend Selection Up" },
    ["<S-Down>"] = { "<Down>", "Extend Selection Down" },
    ["<S-Home>"] = { "<Home>", "Extend Selection to Start of Line" },
    ["<S-End>"] = { "<End>", "Extend Selection to End of Line" },
    
    -- Select word by word with Shift+Ctrl
    ["<S-C-Right>"] = { "<C-Right>", "Extend Selection Word Right" },
    ["<S-C-Left>"] = { "<C-Left>", "Extend Selection Word Left" },
    
    -- Cancel selection when arrow keys without Shift (go back to insert mode)
    ["<Right>"] = { "<Esc>i<Right>", "Cancel Selection and Move Right" },
    ["<Left>"] = { "<Esc>i<Left>", "Cancel Selection and Move Left" },
    ["<Up>"] = { "<Esc>i<Up>", "Cancel Selection and Move Up" },
    ["<Down>"] = { "<Esc>i<Down>", "Cancel Selection and Move Down" },
    ["<Home>"] = { "<Esc>i<Home>", "Cancel Selection and Move to Start" },
    ["<End>"] = { "<Esc>i<End>", "Cancel Selection and Move to End" },
  },

  t = {
    -- Toggle terminal (hide)
    ["<C-l>"] = { function()
      local current_win = vim.api.nvim_get_current_win()
      vim.api.nvim_win_hide(current_win)
    end, "Hide Terminal" },
    
    -- Focus back to editor from terminal
    ["<C-k>"] = { "<C-\\><C-n><C-w>w", "Focus Editor" },
  },
}
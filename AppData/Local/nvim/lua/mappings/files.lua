-- VS Code style file operations key mappings for Neovim

return {
  n = {
    -- File Picker (VS Code style: Ctrl+P)
    ["<C-p>"] = { function() require("snacks").picker.files() end, "Find File" },

    -- Recent Files (VS Code style: Ctrl+R)
    ["<C-r>"] = { function() require("snacks").picker.recent() end, "Recent Files" },

    -- Switch to Last File
    ["<C-l>"] = { ":e #<CR>", "Switch to Last File" },

    -- Save File (VS Code style: Ctrl+S)
    ["<C-s>"] = { ":w<CR>", "Save File" },

    -- Undo Tree
    ["<leader>u"] = { ":UndotreeToggle<CR>", "Toggle Undo Tree" },
  },

  i = {
    -- Save File
    ["<C-s>"] = { "<C-o>:w<CR>", "Save File" },
  },
}

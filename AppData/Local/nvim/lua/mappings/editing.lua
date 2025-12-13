-- Text editing key mappings for Neovim

return {
  n = {
    -- Undo/Redo
    ["<C-z>"] = { ":undo<CR>", "Undo" },
    ["<C-S-z>"] = { ":redo<CR>", "Redo" },

    -- Move Line Up/Down
    ["<A-Up>"] = { ":m-2<CR>", "Move Line Up" },
    ["<A-Down>"] = { ":m+1<CR>", "Move Line Down" },

    -- Move to next word
    ["<Tab>"] = { "w", "Move to next word" },

    -- Cut/Copy/Paste
    ["<C-v>"] = { '"+P', "Paste" },

    -- Select All
    ["<C-a>"] = { "ggVG", "Select All" },
  },

  i = {
    -- Undo/Redo
    ["<C-z>"] = { "<C-o>:undo<CR>", "Undo" },
    ["<C-S-z>"] = { "<C-o>:redo<CR>", "Redo" },

    -- Delete Word
    ["<C-BS>"] = { "<C-w>", "Delete Word Backward" },

    -- Cut/Paste
    ["<C-v>"] = { "<C-r>+", "Paste" },
    ["<C-x>"] = { function()
      vim.cmd("normal! dd")
    end, "Delete Line", { noremap = true, silent = true } },

    -- Select All
    ["<C-a>"] = { "<C-o>ggVG", "Select All" },
  },

  v = {
    -- Cut/Copy/Paste
    ["<C-x>"] = { '"+d', "Cut Selection" },
    ["<C-c>"] = { '"+y', "Copy Selection" },
    ["<C-v>"] = { '"+P', "Paste" },
    ["<C-a>"] = { "ggVG", "Select All" },
  },
}

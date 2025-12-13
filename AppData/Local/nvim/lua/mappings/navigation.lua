-- VS Code style navigation key mappings for Neovim

-- Helper function to safely navigate to dashboard
local function safe_dashboard(opts)
  opts = opts or {}
  local bufname = vim.fn.bufname()
  if bufname:match("dashboard") or bufname:match("alpha") then
    return
  end
  if opts.force then
    pcall(require("snacks").dashboard, { force = true })
    return
  end
  if vim.api.nvim_buf_is_valid(0) and vim.api.nvim_buf_get_option(0, "modified") then
    pcall(vim.cmd, "write")
  end
  pcall(require("snacks").dashboard)
end

return {
  n = {
    -- File Explorer
    ["<leader>e"] = { function() require("snacks").explorer() end, "File Explorer" },

    -- Go Back/Forward
    ["<A-Left>"] = { "<C-o>", "Go Back" },
    ["<A-Right>"] = { "<C-i>", "Go Forward" },

    -- Buffer Navigation (VS Code style)
    ["<C-Tab>"] = { ":bnext<CR>", "Next Buffer" },
    ["<C-S-Tab>"] = { ":bprevious<CR>", "Previous Buffer" },

    -- Close Editor (VS Code style)
    ["<C-w>"] = { ":close<CR>", "Close Editor" },

    -- Enter Insert Mode with Arrow Keys
    ["<C-Left>"] = { "i", "Enter Insert Mode" },
    ["<C-Right>"] = { "a", "Enter Insert Mode" },

  },

  i = {
    -- Return to Home/Dashboard
    ["<Esc>"] = { safe_dashboard, "Return to Home" },
    ["<C-S-c>"] = { function() safe_dashboard({ force = true }) end, "Force Return to Home" },
  },

  v = {
    -- Return to Home/Dashboard
    ["<Esc>"] = { safe_dashboard, "Return to Home" },
  },
}
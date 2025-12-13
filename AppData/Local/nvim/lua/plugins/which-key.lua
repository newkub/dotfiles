return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    spec = {
      { "<leader>f", group = "File Operations" },
      { "<leader>s", group = "Search Operations" },
      { "<leader>g", group = "Git Operations" },
      { "<leader>p", group = "Package Management" },
      { "<leader>u", group = "UI Toggles" },
      { "<leader>c", group = "Code Actions" },
      { "<leader>x", group = "Diagnostics" },
      { "<leader>b", group = "Buffer Operations" },
      { "<leader>n", group = "Notifications" },
    },
  },
  keys = {
    {
      "<leader>?",
      "<cmd>WhichKey<cr>",
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
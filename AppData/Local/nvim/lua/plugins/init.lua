return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = require "configs.treesitter",
  },

  -- Exit keybindings configuration

  {
    "nvchad/nvim-colorizer.lua",
    event = "VimEnter",
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "nvdash", "nvcheatsheet" },
        callback = function()
          vim.keymap.set("n", "q", ":q<CR>", { buffer = true, silent = true })
          vim.keymap.set("n", "<Esc>", ":q<CR>", { buffer = true, silent = true })
        end,
      })
    end,
  },
}


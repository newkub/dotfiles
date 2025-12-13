return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function(_, opts)
    require("which-key").setup(opts)
    require("mappings").setup()
  end,
}
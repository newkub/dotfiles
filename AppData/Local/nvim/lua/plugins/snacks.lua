return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = require("plugins.snacks.opts"),
  config = require("plugins.snacks.config"),
  keys = require("plugins.snacks.keys"),
  init = require("plugins.snacks.init_fn"),
}

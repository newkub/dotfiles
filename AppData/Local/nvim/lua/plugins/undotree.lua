return {
  "mbbill/undotree",
  cmd = { "UndotreeToggle", "UndotreeShow", "UndotreeHide", "UndotreeFocus" },
  keys = {
    { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undo Tree" },
  },
  config = function()
    -- Configure undotree settings
    vim.g.undotree_SetFocusWhenToggle = 1
    vim.g.undotree_SplitWidth = 30
    vim.g.undotree_DiffpanelHeight = 10
    vim.g.undotree_RelativeTimestamp = 1
    
    -- Note: Persistent undo is already enabled in init.lua
  end,
}
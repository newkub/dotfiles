-- Theme and visual settings

-- Set cursor to blinking vertical line during editing
-- Ensure insert mode cursor is a blinking vertical line
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25-blinkwait200-blinkon200-blinkoff150,r-cr:hor20,o:hor50"

-- Enable cursor blinking
vim.opt.cursorline = true

-- Icons for LSP kinds
local M = {}

M.icons = {
  kinds = {
    Text = " ",
    Method = "󰆧 ",
    Function = " ",
    Constructor = " ",
    Field = "󰇽 ",
    Variable = "󰂡 ",
    Class = "󰠱 ",
    Interface = " ",
    Module = " ",
    Property = "󰜢 ",
    Unit = " ",
    Value = "󰎠 ",
    Enum = " ",
    Keyword = "󰌋 ",
    Snippet = " ",
    Color = "󰏘 ",
    File = "󰈙 ",
    Reference = " ",
    Folder = "󰉋 ",
    EnumMember = " ",
    Constant = "󰏿 ",
    Struct = " ",
    Event = " ",
    Operator = "󰆕 ",
    TypeParameter = "󰅲 ",
  }
}

return M
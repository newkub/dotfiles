-- Autocommands for Neovim mappings

-- Start in insert mode when entering a buffer
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    local status, err = pcall(function()
      -- Only start insert mode if we're not in a special buffer
      local bufname = vim.fn.bufname()
      if bufname ~= "" and not bufname:match("dashboard") and not bufname:match("alpha") and not bufname:match("NvimTree") then
        vim.cmd("startinsert")
      end
    end)
    if not status then
      vim.notify("Error starting insert mode: " .. tostring(err), vim.log.levels.ERROR)
    end
  end,
})
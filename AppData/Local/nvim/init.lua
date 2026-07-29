-- Work around Neovim vim.loader cache corruption on Windows long paths
-- which causes vim.* modules (iter, tty, ...) to load as `true` and break
-- plugins like blink.cmp, lualine, osc52, and LSP shutdown.
-- See: https://github.com/neovim/neovim/issues/25008
if vim.loader then
  vim.loader.enable(false)
end

-- Clear any corrupted module entries so they get reloaded from source
package.loaded["vim.iter"] = nil
package.loaded["vim.tty"] = nil

-- Load core configuration
require("core")

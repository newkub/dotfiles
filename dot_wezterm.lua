local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- ======================
-- Basic Settings
-- ======================
config.default_cwd = 'D:\\'
config.default_prog = { 'pwsh.exe', '-NoLogo' }
config.default_cursor_style = 'SteadyBar'
config.font_size = 15
config.window_close_confirmation = 'NeverPrompt'
config.tab_max_width = 30

-- ======================
-- Tab Bar Colors
-- ======================
local tab_bg = '#084a85'
local tab_active = '#1877F2'
local tab_fg_active = '#FFFFFF'
local tab_fg_inactive = '#6b9dc8'

config.colors = {
  tab_bar = {
    background = tab_bg,
    active_tab = { bg_color = tab_active, fg_color = tab_fg_active },
    inactive_tab = { bg_color = tab_bg, fg_color = tab_fg_inactive },
    new_tab = { bg_color = tab_bg, fg_color = tab_fg_inactive },
    inactive_tab_hover = { bg_color = tab_active, fg_color = tab_fg_active },
    new_tab_hover = { bg_color = tab_active, fg_color = tab_fg_active },
  },
}

-- ======================
-- Startup Layout
-- ======================
wezterm.on('gui-startup', function(cmd)
  local tab, left_pane, window = wezterm.mux.spawn_window(cmd or {})

  -- split ซ้าย | ขวา
  local right_pane = left_pane:split {
    direction = 'Right',
    size = 0.5,
  }

  -- จาก right_pane → split ลงล่าง
  right_pane:split {
    direction = 'Bottom',
    size = 0.5,
  }

  -- tab ถัดไป
  window:spawn_tab { args = { 'pwsh.exe', '-NoLogo' } }

  window:gui_window():maximize()
  tab:activate()
end)


-- ======================
-- Leader
-- ======================
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

-- ======================
-- Key Bindings
-- ======================
config.keys = {
  { key = 't', mods = 'CTRL', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
  { key = 'n', mods = 'CTRL|SHIFT', action = wezterm.action.SpawnWindow },
  { key = 'f', mods = 'CTRL', action = wezterm.action.Search 'CurrentSelectionOrEmptyString' },
  { key = 'F11', action = wezterm.action.ToggleFullScreen },
  { key = 'c', mods = 'LEADER', action = wezterm.action.ActivateCopyMode },

  -- Smart Ctrl+C
  {
    key = 'c',
    mods = 'CTRL',
    action = wezterm.action_callback(function(window, pane)
      if window:get_selection_text_for_pane(pane) ~= '' then
        window:perform_action(
          wezterm.action.CopyTo 'ClipboardAndPrimarySelection',
          pane
        )
        window:perform_action(wezterm.action.ClearSelection, pane)
      else
        window:perform_action(
          wezterm.action.SendKey { key = 'c', mods = 'CTRL' },
          pane
        )
      end
    end),
  },

  -- Pane Split
  { key = 'UpArrow',    mods = 'CTRL|SHIFT', action = wezterm.action.SplitPane { direction = 'Up' } },
  { key = 'DownArrow',  mods = 'CTRL|SHIFT', action = wezterm.action.SplitPane { direction = 'Down' } },
  { key = 'LeftArrow',  mods = 'CTRL|SHIFT', action = wezterm.action.SplitPane { direction = 'Left' } },
  { key = 'RightArrow', mods = 'CTRL|SHIFT', action = wezterm.action.SplitPane { direction = 'Right' } },

  -- Pane Navigation
  { key = 'Tab', mods = 'CTRL', action = wezterm.action.ActivatePaneDirection 'Next' },
  { key = 'Tab', mods = 'SHIFT', action = wezterm.action.ActivatePaneDirection 'Prev' },
}

-- ======================
-- Ctrl + 1..9 → Switch Tab
-- ======================
for i = 1, 9 do
  config.keys[#config.keys + 1] = {
    key = tostring(i),
    mods = 'CTRL',
    action = wezterm.action.ActivateTab(i - 1),
  }
end

return config

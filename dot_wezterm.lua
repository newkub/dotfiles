local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- ======================
-- Basic Settings
-- ======================
config.default_cwd = 'D:\\'
config.default_prog = { 'pwsh.exe' }
config.default_cursor_style = 'SteadyBar'
config.font_size = 15
config.window_close_confirmation = 'NeverPrompt'
config.tab_max_width = 30

-- ======================
-- Font (Stable for Markdown + Thai)
-- ======================
config.font = wezterm.font_with_fallback({
  'JetBrains Mono',   -- main monospace
  'Noto Sans Thai',   -- thai fallback only
})

-- ปิด ligatures ป้องกัน markdown/table เพี้ยน
config.harfbuzz_features = { 'liga=0', 'clig=0', 'calt=0' }

-- ป้องกัน glyph overflow
config.allow_square_glyphs_to_overflow_width = "Never"
config.warn_about_missing_glyphs = false

-- renderer เสถียร
config.front_end = "OpenGL"

-- ======================
-- Colors / Tab Bar
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
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
  window:spawn_tab({})
  pane:activate()
  window:gui_window():maximize()
end)

-- ======================
-- Leader
-- ======================
config.leader = { key = 'Space', mods = 'CTRL', timeout_milliseconds = 1000 }

-- ======================
-- Key Bindings
-- ======================
config.keys = {
  -- Window / Tab
  { key = 't', mods = 'CTRL', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
  { key = 'n', mods = 'CTRL|SHIFT', action = wezterm.action.SpawnWindow },
  { key = 'F11', action = wezterm.action.ToggleFullScreen },

  -- Tab Navigation
  { key = 'Tab', mods = 'CTRL', action = wezterm.action.ActivateTabRelative(1) },
  { key = 'Tab', mods = 'CTRL|SHIFT', action = wezterm.action.ActivateTabRelative(-1) },

  -- Pane Navigation
  { key = 'Tab', mods = 'SHIFT', action = wezterm.action.ActivatePaneDirection 'Next' },

  -- Search
  { key = 'f', mods = 'CTRL', action = wezterm.action.Search 'CurrentSelectionOrEmptyString' },

  -- Copy Mode
  { key = 'c', mods = 'LEADER', action = wezterm.action.ActivateCopyMode },

  -- Copy (Terminal)
  { key = 'c', mods = 'CTRL|SHIFT', action = wezterm.action.CopyTo 'ClipboardAndPrimarySelection' },

  -- Always pass Ctrl+C to apps
  { key = 'c', mods = 'CTRL', action = wezterm.action.SendKey { key = 'c', mods = 'CTRL' } },

  -- Pane Split
  { key = 'UpArrow',    mods = 'CTRL|SHIFT', action = wezterm.action.SplitPane { direction = 'Up' } },
  { key = 'DownArrow',  mods = 'CTRL|SHIFT', action = wezterm.action.SplitPane { direction = 'Down' } },
  { key = 'LeftArrow',  mods = 'CTRL|SHIFT', action = wezterm.action.SplitPane { direction = 'Left' } },
  { key = 'RightArrow', mods = 'CTRL|SHIFT', action = wezterm.action.SplitPane { direction = 'Right' } },
}

-- ======================
-- Ctrl + 1..9 เลือก Tab
-- ======================
for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'CTRL',
    action = wezterm.action.ActivateTab(i - 1),
  })
end

return config
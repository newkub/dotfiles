local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.default_cwd = 'D:\\'
config.default_prog = { 'pwsh.exe' }
config.default_cursor_style = 'SteadyBar'
config.font_size = 15
config.window_close_confirmation = 'NeverPrompt'
-- config.default_gui_startup_args = {'--fullscreen'}

config.font = wezterm.font_with_fallback({
  'JetBrains Mono',
  'Noto Sans Thai',
})

config.harfbuzz_features = { 'liga=0', 'clig=0', 'calt=0' }
config.allow_square_glyphs_to_overflow_width = "Never"
config.warn_about_missing_glyphs = false
config.front_end = "OpenGL"

config.use_fancy_tab_bar = true

config.tab_max_width = 15
config.hide_tab_bar_if_only_one_tab = true

config.colors = {
  tab_bar = {
    active_tab = {
      bg_color = '#4169E1',
      fg_color = '#FFFFFF',
    },
  },
}

config.keys = {
  { key = 'f', mods = 'CTRL', action = wezterm.action.Search { CaseInSensitiveString = '' } },
  { key = 'c', mods = 'CTRL|SHIFT', action = wezterm.action.CopyTo 'ClipboardAndPrimarySelection' },
  { key = 'v', mods = 'CTRL|SHIFT', action = wezterm.action.PasteFrom 'Clipboard' },
  { key = 't', mods = 'CTRL', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
  { key = 'w', mods = 'CTRL', action = wezterm.action.CloseCurrentTab { confirm = true } },
  { key = 'Tab', mods = 'CTRL', action = wezterm.action.ActivateTabRelative(1) },
  { key = 'Tab', mods = 'CTRL|SHIFT', action = wezterm.action.ActivateTabRelative(-1) },
  { key = 'Tab', mods = 'SHIFT', action = wezterm.action.ActivatePaneDirection 'Next' },
  { key = 'UpArrow', mods = 'CTRL|SHIFT', action = wezterm.action.SplitPane { direction = 'Up' } },
  { key = 'DownArrow', mods = 'CTRL|SHIFT', action = wezterm.action.SplitPane { direction = 'Down' } },
  { key = 'LeftArrow', mods = 'CTRL|SHIFT', action = wezterm.action.SplitPane { direction = 'Left' } },
  { key = 'RightArrow', mods = 'CTRL|SHIFT', action = wezterm.action.SplitPane { direction = 'Right' } },

  { key = 'UpArrow', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'DownArrow', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Down' },
  { key = 'LeftArrow', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'RightArrow', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Right' },
}

for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'CTRL',
    action = wezterm.action.ActivateTab(i - 1),
  })
end

-- Custom key table for search mode: Backspace closes search when pattern is empty
config.key_tables = {
  search_mode = {
    { key = 'Enter', mods = 'NONE', action = wezterm.action.CopyMode 'PriorMatch' },
    { key = 'Escape', mods = 'NONE', action = wezterm.action.CopyMode 'Close' },
    { key = 'Backspace', mods = 'NONE', action = wezterm.action.CopyMode 'Close' },
    { key = 'n', mods = 'CTRL', action = wezterm.action.CopyMode 'NextMatch' },
    { key = 'p', mods = 'CTRL', action = wezterm.action.CopyMode 'PriorMatch' },
    { key = 'r', mods = 'CTRL', action = wezterm.action.CopyMode 'CycleMatchType' },
    { key = 'u', mods = 'CTRL', action = wezterm.action.CopyMode 'ClearPattern' },
    { key = 'PageUp', mods = 'NONE', action = wezterm.action.CopyMode 'PriorMatchPage' },
    { key = 'PageDown', mods = 'NONE', action = wezterm.action.CopyMode 'NextMatchPage' },
    { key = 'UpArrow', mods = 'NONE', action = wezterm.action.CopyMode 'PriorMatch' },
    { key = 'DownArrow', mods = 'NONE', action = wezterm.action.CopyMode 'NextMatch' },
  },
}

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
  local tab2 = window:spawn_tab { cwd = 'D:\\' }
  tab:activate()
  window:gui_window():maximize()
end)

return config
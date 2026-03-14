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

config.use_fancy_tab_bar = false

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

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

return config
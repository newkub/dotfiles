-- WezTerm Configuration
local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Basic Settings
config.default_cwd = 'D:\\'
config.default_prog = {'pwsh.exe', '-NoLogo'}
config.default_cursor_style = 'SteadyBar'
config.font_size = 15.0
config.window_close_confirmation = 'NeverPrompt'
config.tab_max_width = 30
-- Tab Bar Colors
config.colors = {
  tab_bar = {
    background = '#084a85',
    active_tab = { bg_color = '#1877F2', fg_color = '#FFFFFF' },
    inactive_tab = { bg_color = '#084a85', fg_color = '#6b9dc8' },
    new_tab = { bg_color = '#084a85', fg_color = '#6b9dc8' },
    inactive_tab_hover = { bg_color = '#1877F2', fg_color = '#FFFFFF' },
    new_tab_hover = { bg_color = '#1877F2', fg_color = '#FFFFFF' },
  },
}

wezterm.on('gui-startup', function(cmd)
  -- Create the first window and get its components
  local tab1, _, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()

  -- Create the second tab
  window:spawn_tab({})

  -- IMPORTANT: Activate the first tab to ensure we are operating on it
  tab1:activate()

  -- Now that the first tab is guaranteed to be active, get its active pane and split it.
  -- This avoids issues with stale pane references.
  local pane1 = tab1:active_pane()
  pane1:split({ direction = 'Right', size = { Percent = 50 } })
end)

-- Leader Key
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

-- Key Bindings
config.keys = {
  -- New tab with Ctrl+T
  { key = 't', mods = 'CTRL', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
  
  -- Copy on Ctrl+C when text is selected, otherwise send Ctrl+C to terminal
  { key = 'c', mods = 'CTRL', action = wezterm.action_callback(function(window, pane)
    local has_selection = window:get_selection_text_for_pane(pane) ~= ''
    if has_selection then
      window:perform_action(wezterm.action.CopyTo 'ClipboardAndPrimarySelection', pane)
      window:perform_action(wezterm.action.ClearSelection, pane)
    else
      window:perform_action(wezterm.action.SendKey { key = 'c', mods = 'CTRL' }, pane)
    end
  end) },
  { key = 'UpArrow', mods = 'CTRL|SHIFT', action = wezterm.action{ SplitPane = { direction = 'Up' } } },
  { key = 'DownArrow', mods = 'CTRL|SHIFT', action = wezterm.action{ SplitPane = { direction = 'Down' } } },
  { key = 'LeftArrow', mods = 'CTRL|SHIFT', action = wezterm.action{ SplitPane = { direction = 'Left' } } },
  { key = 'RightArrow', mods = 'CTRL|SHIFT', action = wezterm.action{ SplitPane = { direction = 'Right' } } },
  { key = 'Tab', mods = 'SHIFT', action = wezterm.action.ActivatePaneDirection 'Prev' },
  { key = 'Tab', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Next' },
  { key = 'f', mods = 'CTRL', action = wezterm.action.Search 'CurrentSelectionOrEmptyString' },
  { key = 'F11', mods = '', action = wezterm.action.ToggleFullScreen },
  { key = 'n', mods = 'CTRL|SHIFT', action = wezterm.action.SpawnWindow },
  { key = 'c', mods = 'LEADER', action = wezterm.action.ActivateCopyMode },
}


return config

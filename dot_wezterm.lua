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

-- Startup: 1 tab with pwsh, maximize
wezterm.on('gui-startup', function()
  -- Create first window with 2 tabs
  local tab1, pane1, window = wezterm.mux.spawn_window({
    args = {'pwsh.exe', '-NoLogo'}
  })

  pane1:split({
    direction = "Right",
    size = 0.5,
  })
  
  -- Create second tab
  local tab2 = window:spawn_tab({
    args = {'pwsh.exe', '-NoLogo'}
  })
  
  -- Maximize the window and focus on the first tab
  window:gui_window():maximize()
  tab1:activate()
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

  -- Focus next pane with Ctrl+Tab
  { key = 'Tab', mods = 'CTRL', action = wezterm.action.ActivatePaneDirection 'Next' },
}

-- Switch to specific tabs with Ctrl + 1-9
for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'CTRL',
    action = wezterm.action.ActivateTab(i - 1),
  })
end


return config

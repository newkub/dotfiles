-- =============================================
-- WezTerm Configuration
-- Terminal: https://wezfurlong.org/wezterm/
-- =============================================

local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- =============================================
-- Load Plugins
-- =============================================

-- Add plugins directory to package path
package.path = package.path .. ';' .. os.getenv('USERPROFILE') .. '/.wezterm/plugins/?.lua'

-- Load plugins
local tab_icons = require 'tab_icons'
require 'right_status_bar'

-- =============================================
-- General Settings
-- =============================================

-- Default working directory when opening new tab/window
config.default_cwd = 'D:\\'

-- Default shell program (PowerShell 7 from mise)
config.default_prog = { 'C:\\Users\\Veerapong\\AppData\\Local\\mise\\installs\\powershell-core\\7.6.2\\pwsh.exe' }

-- =============================================
-- Launch Menu Profiles
-- =============================================

config.launch_menu = {
  {
    label = 'PowerShell 7',
    args = { 'C:\\Users\\Veerapong\\AppData\\Local\\mise\\installs\\powershell-core\\7.6.2\\pwsh.exe' },
    cwd = 'D:\\',
  },
  {
    label = 'Nushell',
    args = { 'C:\\Users\\Veerapong\\scoop\\shims\\nu.exe' },
    cwd = 'D:\\',
  },
  {
    label = 'CMD',
    args = { 'cmd.exe' },
    cwd = 'D:\\',
  },
  {
    label = 'WSL',
    args = { 'wsl.exe' },
    cwd = 'D:\\',
  },
}

-- Cursor style: SteadyBar | BlinkingBar | SteadyBlock | BlinkingBlock | SteadyUnderline | BlinkingUnderline
config.default_cursor_style = 'SteadyBar'

-- Font size in points
config.font_size = 15

-- Don't prompt when closing window with running processes
config.window_close_confirmation = 'NeverPrompt'

-- Disable cursor blinking to reduce CPU usage
config.cursor_blink_rate = 0

-- Reduce animation frame rate for better performance
config.animation_fps = 1

-- Maximum frame rate cap
config.max_fps = 60

-- Number of lines to keep in scrollback buffer (lower = less memory)
config.scrollback_lines = 10000
-- config.default_gui_startup_args = {'--fullscreen'}

-- =============================================
-- Font Configuration
-- =============================================

-- Use Sarabun for Thai text
config.font = wezterm.font_with_fallback({
  'JetBrains Mono',    -- Primary monospace font (programming)
  'Sarabun',           -- Thai font
})

-- Let WezTerm handle font rendering
config.harfbuzz_features = nil

-- Fix character width calculation
config.unicode_version = 14
-- =============================================
-- Rendering Backend
-- =============================================

-- wgpu rendering - GPU-accelerated for better performance
-- If Thai text rendering issues occur, change back to "Software"
config.front_end = "WebGpu"

-- Fix character width calculation for Thai
config.unicode_version = 14

-- Don't let wide characters overflow their cell width
config.allow_square_glyphs_to_overflow_width = "Never"

-- =============================================
-- Tab Bar & UI
-- =============================================

-- Use modern styled tab bar instead of simple text tabs
-- NOTE: fancy tab bar can cause rendering issues with some GPUs, set to false if problems persist
config.use_fancy_tab_bar = true

-- Hide scrollbar to save screen space
config.enable_scroll_bar = false

-- Maximum width for each tab label (characters)
config.tab_max_width = 15

-- Auto-hide tab bar when only one tab is open
config.hide_tab_bar_if_only_one_tab = true

-- =============================================
-- Color Scheme & Theming
-- =============================================

-- Custom color overrides
config.colors = {
  -- Tab bar styling (Modern gradient)
  tab_bar = {
    background = '#1e1e2e',
    active_tab = {
      bg_color = '#89b4fa',  -- Blue accent
      fg_color = '#1e1e2e',  -- Dark text
      intensity = 'Normal',
      italic = false,
      underline = 'None',
    },
    inactive_tab = {
      bg_color = '#181825',
      fg_color = '#a6adc8',
    },
    inactive_tab_hover = {
      bg_color = '#313244',
      fg_color = '#cdd6f4',
    },
    new_tab = {
      bg_color = '#181825',
      fg_color = '#a6adc8',
    },
    new_tab_hover = {
      bg_color = '#313244',
      fg_color = '#cdd6f4',
    },
  },
}

-- =============================================
-- Key Bindings
-- =============================================

-- Custom keyboard shortcuts
config.keys = {
  -- Command Palette: F1
  { key = 'F1', mods = 'NONE', action = wezterm.action.ActivateCommandPalette },

  -- Search: Ctrl+F (case-insensitive)
  { key = 'f', mods = 'CTRL', action = wezterm.action.Search { CaseInSensitiveString = '' } },

  -- Copy/Paste: Ctrl+Shift+C/V (terminal standard)
  { key = 'c', mods = 'CTRL|SHIFT', action = wezterm.action.CopyTo 'ClipboardAndPrimarySelection' },
  { key = 'v', mods = 'CTRL|SHIFT', action = wezterm.action.PasteFrom 'Clipboard' },

  -- Send SIGINT (Ctrl+C)
  { key = 'c', mods = 'CTRL', action = wezterm.action.SendString '\x03' },

  -- Tab Management
  { key = 't', mods = 'CTRL', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
  { key = 't', mods = 'CTRL|SHIFT', action = wezterm.action.ShowLauncher },
  { key = 'w', mods = 'CTRL', action = wezterm.action.CloseCurrentTab { confirm = true } },
  { key = 'Tab', mods = 'CTRL', action = wezterm.action.ActivateTabRelative(1) },
  { key = 'Tab', mods = 'CTRL|SHIFT', action = wezterm.action.ActivateTabRelative(-1) },

  -- Pane Navigation (Shift+Tab cycles panes)
  { key = 'Tab', mods = 'SHIFT', action = wezterm.action.ActivatePaneDirection 'Next' },

  -- Pane Splitting (Ctrl+Shift+Arrow)
  { key = 'UpArrow', mods = 'CTRL|SHIFT', action = wezterm.action.SplitPane { direction = 'Up' } },
  { key = 'DownArrow', mods = 'CTRL|SHIFT', action = wezterm.action.SplitPane { direction = 'Down' } },
  { key = 'LeftArrow', mods = 'CTRL|SHIFT', action = wezterm.action.SplitPane { direction = 'Left' } },
  { key = 'RightArrow', mods = 'CTRL|SHIFT', action = wezterm.action.SplitPane { direction = 'Right' } },

  -- Pane Focus (Alt+Arrow keys)
  { key = 'UpArrow', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'DownArrow', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Down' },
  { key = 'LeftArrow', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'RightArrow', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Right' },

  -- Quick Scroll (Ctrl+Up/Down jumps to top/bottom)
  { key = 'UpArrow', mods = 'CTRL', action = wezterm.action.ScrollToTop },
  { key = 'DownArrow', mods = 'CTRL', action = wezterm.action.ScrollToBottom },
}

-- Ctrl+1 through Ctrl+9: Jump directly to tab 1-9
for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'CTRL',
    action = wezterm.action.ActivateTab(i - 1),
  })
end

-- =============================================
-- Search Mode Key Bindings
-- Custom key table for search/copy mode
-- =============================================

-- When in search/copy mode, these keys control navigation
config.key_tables = {
  search_mode = {
    { key = 'Enter', mods = 'NONE', action = wezterm.action.CopyMode 'PriorMatch' },
    { key = 'Escape', mods = 'NONE', action = wezterm.action.CopyMode 'Close' },
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

-- =============================================
-- Tab Title with Icon (from plugin)
-- =============================================

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local pane = tab.active_pane
  local icon = tab_icons.get_tab_icon(pane)

  -- Get current working directory name
  local cwd = pane:get_current_working_dir()
  local title = ''
  if cwd then
    local path = cwd.file_path
    title = path:match('[^\\/]+$') or 'Terminal'
  else
    title = 'Terminal'
  end

  -- Format with icon
  return {
    { Text = icon .. ' ' .. title },
  }
end)

-- =============================================
-- Auto-Start Behavior
-- =============================================

-- On startup: open maximized window with 2 tabs
wezterm.on('gui-startup', function(cmd)
  -- Spawn initial window
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})

  -- Create second tab at D:\ drive
  local tab2 = window:spawn_tab { cwd = 'D:\\' }

  -- Keep first tab active
  tab:activate()

  -- Maximize the window
  window:gui_window():maximize()
end)

-- =============================================
-- Return Configuration
-- =============================================

return config

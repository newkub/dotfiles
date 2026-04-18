-- =============================================
-- WezTerm Configuration
-- Terminal: https://wezfurlong.org/wezterm/
-- =============================================

local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- =============================================
-- General Settings
-- =============================================

-- Default working directory when opening new tab/window
config.default_cwd = 'D:\\'

-- Default shell program (PowerShell 7+)
config.default_prog = { 'pwsh.exe' }

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

-- Primary font with fallback for Thai characters
config.font = wezterm.font_with_fallback({
  'JetBrains Mono',    -- Primary monospace font (programming)
  'Noto Sans Thai',    -- Fallback for Thai script support
})

-- Disable ligatures (font character combinations like != → ≠)
-- liga=0: standard ligatures off
-- clig=0: contextual ligatures off
-- calt=0: contextual alternates off
config.harfbuzz_features = { 'liga=0', 'clig=0', 'calt=0' }

-- Don't let wide characters (like emoji) overflow their cell width
config.allow_square_glyphs_to_overflow_width = "Never"

-- Suppress warnings when a glyph is not found in any font
config.warn_about_missing_glyphs = false

-- Fix character width calculation (prevents overlapping text in Helix on Windows)
config.unicode_version = 14
-- =============================================
-- Rendering Backend
-- =============================================

-- Available front_end options:
--   "Software"  - CPU rendering, most stable but slowest
--   "OpenGL"    - GPU accelerated, balanced performance
--   "WebGpu"    - Modern GPU API, fastest but may have driver issues
-- NOTE: WebGpu causes double rendering on some Windows GPUs, using Software for stability
config.front_end = "WebGpu"

-- Use dedicated GPU for rendering (if available)
config.webgpu_power_preference = "HighPerformance"

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
  -- Tab bar styling (RoyalBlue active tab)
  tab_bar = {
    active_tab = {
      bg_color = '#4169E1',  -- RoyalBlue background
      fg_color = '#FFFFFF',  -- White text
    },
  },
}

-- =============================================
-- Key Bindings
-- =============================================

-- Custom keyboard shortcuts
config.keys = {
  -- Search: Ctrl+F (case-insensitive)
  { key = 'f', mods = 'CTRL', action = wezterm.action.Search { CaseInSensitiveString = '' } },

  -- Copy/Paste: Ctrl+Shift+C/V (terminal standard)
  { key = 'c', mods = 'CTRL|SHIFT', action = wezterm.action.CopyTo 'ClipboardAndPrimarySelection' },
  { key = 'v', mods = 'CTRL|SHIFT', action = wezterm.action.PasteFrom 'Clipboard' },

  -- Tab Management
  { key = 't', mods = 'CTRL', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
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
-- Right Status Bar (Beautiful UX/UI)
-- =============================================

wezterm.on('update-right-status', function(window, pane)
  -- Build status line elements
  local elements = {}

  window:set_right_status(wezterm.format(elements))
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
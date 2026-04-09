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
config.front_end = "Software"

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

-- Color palette (Catppuccin Mocha inspired)
local colors = {
  path = '#fab387',      -- Peach
  path_icon = '#f5c2e7', -- Pink
  remote = '#89dceb',    -- Sky blue
  branch = '#b4befe',    -- Lavender
  commit = '#f9e2af',    -- Yellow
  time_ago = '#a6e3a1',  -- Green
  separator = '#6c7086', -- Gray
  clock = '#cba6f7',     -- Mauve
  icon = '#94e2d5',      -- Teal
}

-- Helper: Format relative time
local function format_relative_time(timestamp)
  if not timestamp or timestamp == '' then return '' end

  local now = os.time()
  local diff = now - tonumber(timestamp)

  if diff < 60 then
    return diff .. 's'
  elseif diff < 3600 then
    return math.floor(diff / 60) .. 'm'
  elseif diff < 86400 then
    return math.floor(diff / 3600) .. 'h'
  elseif diff < 604800 then
    return math.floor(diff / 86400) .. 'd'
  else
    return math.floor(diff / 604800) .. 'w'
  end
end

-- Helper: Get short path (last 2-3 components)
local function get_short_path(full_path)
  if not full_path or full_path == '' then return '~' end

  -- Replace home path with ~
  local home = os.getenv('USERPROFILE') or os.getenv('HOME') or ''
  local short = full_path:gsub('^' .. home:gsub('\\', '\\'), '~')

  -- Get last 2-3 parts
  local parts = {}
  for part in short:gmatch('([^\\/]+)') do
    table.insert(parts, part)
  end

  if #parts <= 3 then
    return short
  else
    return '.../' .. parts[#parts-1] .. '/' .. parts[#parts]
  end
end

wezterm.on('update-right-status', function(window, pane)
  -- Get current working directory
  local cwd_uri = pane:get_current_working_dir()
  local cwd = ''

  if cwd_uri then
    if type(cwd_uri) == 'userdata' then
      cwd = tostring(cwd_uri)
      cwd = cwd:gsub('^file:///', ''):gsub('^file://', '')
      cwd = cwd:gsub('/', '\\')
    elseif type(cwd_uri) == 'table' and cwd_uri.file_path then
      cwd = cwd_uri.file_path
    else
      cwd = tostring(cwd_uri)
    end
  end

  -- Get git info with timestamp
  local git_remote = ''
  local git_branch = ''
  local git_commit = ''
  local git_time = ''

  if cwd and cwd ~= '' then
    local safe_cwd = cwd:gsub('"', '`"')

    local ps_cmd = string.format(
      'Set-Location "%s"; $gitDir = git rev-parse --git-dir 2>$null; if ($LASTEXITCODE -eq 0) { '
      .. '$remote = git remote get-url origin 2>$null; '
      .. '$branch = git branch --show-current 2>$null; '
      .. '$commit = git log -1 --format="%%h" 2>$null; '
      .. '$ts = git log -1 --format="%%ct" 2>$null; '
      .. 'Write-Output "$remote|$branch|$commit|$ts" '
      .. '}',
      safe_cwd
    )

    local success, stdout, stderr = wezterm.run_child_process({
      'pwsh.exe', '-NoProfile', '-Command', ps_cmd
    })

    if success and stdout then
      local output = stdout:gsub('^%s+', ''):gsub('%s+$', ''):gsub('\r?\n', '')
      local parts = {}
      for part in output:gmatch('([^|]+)') do
        table.insert(parts, part)
      end

      if #parts >= 4 then
        git_remote = parts[1]
        git_branch = parts[2]
        git_commit = parts[3]
        git_time = format_relative_time(parts[4])
      end
    end
  end

  -- Get current time
  local time = wezterm.strftime('%H:%M')

  -- Build status line elements
  local elements = {}

  -- Section 1: Current Path
  local short_path = get_short_path(cwd)
  table.insert(elements, { Foreground = { Color = colors.path_icon } })
  table.insert(elements, { Text = ' ' }) -- spacing
  table.insert(elements, { Text = short_path })

  -- Separator between sections
  table.insert(elements, { Foreground = { Color = colors.separator } })
  table.insert(elements, { Text = ' | ' })

  -- Section 2: Git Info
  if git_remote ~= '' and git_remote ~= 'no remote' then
    -- Shorten remote URL
    local short_remote = git_remote:gsub('https://', ''):gsub('git@', ''):gsub('github.com:', 'github.com/'):gsub('%.git$', '')

    table.insert(elements, { Foreground = { Color = colors.remote } })
    table.insert(elements, { Text = short_remote })

    if git_branch ~= '' then
      table.insert(elements, { Foreground = { Color = colors.separator } })
      table.insert(elements, { Text = ' @ ' })
      table.insert(elements, { Foreground = { Color = colors.branch } })
      table.insert(elements, { Text = git_branch })
    end

    if git_commit ~= '' then
      table.insert(elements, { Foreground = { Color = colors.separator } })
      table.insert(elements, { Text = ' ' })
      table.insert(elements, { Foreground = { Color = colors.commit } })
      table.insert(elements, { Text = git_commit })
    end

    if git_time ~= '' then
      table.insert(elements, { Foreground = { Color = colors.separator } })
      table.insert(elements, { Text = ' ' })
      table.insert(elements, { Foreground = { Color = colors.time_ago } })
      table.insert(elements, { Text = git_time .. ' ago' })
    end
  end

  -- Separator before clock
  table.insert(elements, { Foreground = { Color = colors.separator } })
  table.insert(elements, { Text = ' | ' })

  -- Clock
  table.insert(elements, { Foreground = { Color = colors.clock } })
  table.insert(elements, { Text = time })
  table.insert(elements, { Text = ' ' }) -- spacing

  window:set_right_status(wezterm.format(elements))
end)

-- =============================================
-- Auto-Start Behavior
-- =============================================

-- On startup: open maximized window with 3 tabs
wezterm.on('gui-startup', function(cmd)
  -- Spawn initial window
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})

  -- Create second tab at D:\ drive
  local tab2 = window:spawn_tab { cwd = 'D:\\' }

  -- Create third tab at D:\ drive
  local tab3 = window:spawn_tab { cwd = 'D:\\' }

  -- Keep first tab active
  tab:activate()

  -- Maximize the window
  window:gui_window():maximize()
end)

-- =============================================
-- Return Configuration
-- =============================================

return config
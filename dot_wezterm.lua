local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- ======================
-- Constants
-- ======================
local COLORS = {
  tab_bg = '#084a85',
  tab_active = '#1877F2',
  tab_fg_active = '#FFFFFF',
  tab_fg_inactive = '#6b9dc8',
  cpu_green = '#a6e3a1',
  cpu_red = '#f38ba8',
  cpu_yellow = '#f9e2af',
  ram_green = '#a6e3a1',
  ram_red = '#f38ba8',
  ram_yellow = '#f9e2af',
  disk_green = '#a6e3a1',
  disk_red = '#f38ba8',
  disk_yellow = '#f9e2af',
  network_green = '#a6e3a1',
  network_red = '#f38ba8',
  temp_green = '#a6e3a1',
  temp_red = '#f38ba8',
  temp_yellow = '#f9e2af',
  background = '#1e1e2e',
  foreground = '#cdd6f4',
  accent = '#89b4fa'
}

local DEFAULTS = {
  cpu = 'CPU: N/A',
  ram = 'RAM: N/A',
  disk = 'Disk: N/A',
  cpu_pct = 0,
  ram_pct = 0,
  disk_pct = 100
}
config.default_cwd = 'D:\\'
config.default_prog = { 'pwsh.exe' }
config.default_cursor_style = 'SteadyBar'
config.font_size = 15
config.window_close_confirmation = 'NeverPrompt'
config.tab_max_width = 20

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
-- Helper Functions
-- ======================
local function get_ram_usage()
  local success, stdout, stderr = wezterm.run_child_process({
    'powershell.exe',
    '-Command',
    [[
      $ram = Get-WmiObject Win32_OperatingSystem
      $used = [math]::Round(($ram.TotalVisibleMemorySize - $ram.FreePhysicalMemory) / 1024 / 1024, 1)
      $total = [math]::Round($ram.TotalVisibleMemorySize / 1024 / 1024, 1)
      $pct = [math]::Round((($ram.TotalVisibleMemorySize - $ram.FreePhysicalMemory) / $ram.TotalVisibleMemorySize) * 100, 0)
      "$used/$total/$pct"
    ]]
  })
  local ram = 'N/A'
  local ram_pct = 0
  if success then
    local parts = {}
    for part in stdout:gsub('\n', ''):gmatch('([^/]+)') do
      table.insert(parts, part)
    end
    ram = parts[1] .. '/' .. parts[2] .. 'GB(' .. parts[3] .. '%)'
    ram_pct = tonumber(parts[3])
  end
  return ram, ram_pct
end

local function get_disk_usage()
  -- Get C: drive usage
  local success_c, stdout_c, stderr_c = wezterm.run_child_process({
    'powershell.exe',
    '-Command',
    [[
      $disk = Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'"
      $free_gb = [math]::Floor($disk.FreeSpace / 1024 / 1024 / 1024)
      $free_mb = [math]::Round(($disk.FreeSpace / 1024 / 1024 - $free_gb * 1024), 0)
      $pct = [math]::Round((($disk.Size - $disk.FreeSpace) / $disk.Size) * 100, 0)
      "$free_gb/$free_mb/$pct"
    ]]
  })
  
  -- Get D: drive usage
  local success_d, stdout_d, stderr_d = wezterm.run_child_process({
    'powershell.exe',
    '-Command',
    [[
      $disk = Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='D:'"
      if ($disk) {
        $free_gb = [math]::Floor($disk.FreeSpace / 1024 / 1024 / 1024)
        $free_mb = [math]::Round(($disk.FreeSpace / 1024 / 1024 - $free_gb * 1024), 0)
        $pct = [math]::Round((($disk.Size - $disk.FreeSpace) / $disk.Size) * 100, 0)
        "$free_gb/$free_mb/$pct"
      } else {
        "N/A/N/A/N/A"
      }
    ]]
  })
  
  local disk_c = 'N/A'
  local disk_d = 'N/A'
  local disk_pct = 100
  
  -- Process C: drive
  if success_c then
    local parts = {}
    for part in stdout_c:gsub('\n', ''):gmatch('([^/]+)') do
      table.insert(parts, part)
    end
    disk_c = 'C:' .. parts[1] .. 'GB'
    disk_pct = tonumber(parts[3]) or 100
  end
  
  -- Process D: drive
  if success_d then
    local parts = {}
    for part in stdout_d:gsub('\n', ''):gmatch('([^/]+)') do
      table.insert(parts, part)
    end
    if parts[1] ~= 'N/A' then
      disk_d = 'D:' .. parts[1] .. 'GB'
      -- Use the higher usage percentage for color coding
      local pct_d = tonumber(parts[3]) or 0
      if pct_d > disk_pct then
        disk_pct = pct_d
      end
    end
  end
  
  local disk_text = disk_c
  if disk_d ~= 'N/A' then
    disk_text = disk_text .. ' ' .. disk_d
  end
  
  return disk_text, disk_pct
end

-- ======================
-- Colors / Tab Bar
-- ======================
local tab_bg = '#084a85'
local tab_active = '#1877F2'
local tab_fg_active = '#FFFFFF'
local tab_fg_inactive = '#6b9dc8'

config.use_fancy_tab_bar = false

config.colors = {
  tab_bar = {
    active_tab = {
      bg_color = '#4169E1',
      fg_color = '#FFFFFF',
    },
  },
}

wezterm.on('update-status', function(window, pane)
  -- Function to create progress bar
  local function make_bar(pct)
    local filled = math.floor(pct * 6 / 100)
    return string.rep('█', filled) .. string.rep('░', 6 - filled)
  end

  local ram, ram_pct = get_ram_usage()
  local disk, disk_pct = get_disk_usage()

  local ram_color = COLORS.ram_green
  if ram_pct > 80 then
    ram_color = COLORS.ram_red
  elseif ram_pct > 60 then
    ram_color = COLORS.ram_yellow
  end

  local disk_color = COLORS.disk_green
  if disk_pct > 80 then
    disk_color = COLORS.disk_red
  elseif disk_pct > 60 then
    disk_color = COLORS.disk_yellow
  end

  window:set_status(wezterm.format({
    { Background = { Color = COLORS.background } },
    { Foreground = { Color = ram_color } },
    { Text = '🧠 ram [' .. make_bar(ram_pct) .. '] ' .. ram_pct .. '%' },
    { Foreground = { Color = COLORS.accent } },
    { Text = '| ' },
    { Foreground = { Color = disk_color } },
    { Text = '💾 disk [' .. make_bar(disk_pct) .. '] ' .. disk_pct .. '%' },
  }))

  -- Schedule next update in 1 seconds
  wezterm.time.call_after(1, function()
    wezterm.emit('update-status', window, pane)
  end)
end)

wezterm.on('update-right-status', function(window, pane)
  -- Function to create progress bar
  local function make_bar(pct)
    local filled = math.floor(pct * 6 / 100)
    return string.rep('█', filled) .. string.rep('░', 6 - filled)
  end

  -- Update CPU, RAM, Disk, Network and Temperature
  local cpu = 'N/A'
  local cpu_pct = 0
  local ram = 'N/A'
  local ram_pct = 0
  local disk = 'N/A'
  local disk_pct = 100
  local network = 'N/A'
  local temp = 'N/A'
  local temp_pct = 0

  -- Get CPU usage (Windows)
  local success_cpu, stdout_cpu, stderr_cpu = wezterm.run_child_process({
    'powershell.exe',
    '-Command',
    [[
      $cpu = (Get-WmiObject Win32_Processor | Select-Object -First 1).LoadPercentage
      [math]::Round($cpu, 0)
    ]]
  })
  if success_cpu then
    local cpu_value = stdout_cpu:gsub('\n', ''):gsub('%s+', '')
    cpu_pct = tonumber(cpu_value) or 0
  end

  -- Get Network usage (Windows)
  local success_net, stdout_net, stderr_net = wezterm.run_child_process({
    'powershell.exe',
    '-Command',
    [[
      $net = Get-Counter '\Network Interface(*)\Bytes Total/sec' -ErrorAction SilentlyContinue
      if ($net -and $net.CounterSamples) {
        $bytes = ($net.CounterSamples | Where-Object {$_.InstanceName -notlike '*Loopback*' -and $_.InstanceName -notlike '*isatap*' -and $_.InstanceName -notlike '*Teredo*'} | Measure-Object -Property CookedValue -Sum).Sum
        $mbps = [math]::Round($bytes / 1024 / 1024, 1)
        "$mbps"
      } else {
        "0"
      }
    ]]
  })
  if success_net then
    local net_value = stdout_net:gsub('\n', ''):gsub('%s+', '')
    network = net_value .. 'MB/s'
  end

  -- Get Temperature (Windows)
  local success_temp, stdout_temp, stderr_temp = wezterm.run_child_process({
    'powershell.exe',
    '-Command',
    [[
      $temp = Get-WmiObject MSAcpi_ThermalZoneTemperature -Namespace "root/wmi" -ErrorAction SilentlyContinue | Select-Object -First 1
      if ($temp) {
        $celsius = [math]::Round($temp.CurrentTemperature / 10 - 273.15, 0)
        "$celsius"
      } else {
        "N/A"
      }
    ]]
  })
  if success_temp then
    local temp_value = stdout_temp:gsub('\n', ''):gsub('%s+', '')
    if temp_value ~= 'N/A' then
      temp_pct = tonumber(temp_value) or 0
      temp = temp_value .. '°C'
    end
  end

  -- Get RAM usage (Windows)
  local success, stdout, stderr = wezterm.run_child_process({
    'powershell.exe',
    '-Command',
    [[
      $ram = Get-WmiObject Win32_OperatingSystem
      $used = [math]::Round(($ram.TotalVisibleMemorySize - $ram.FreePhysicalMemory) / 1024 / 1024, 1)
      $total = [math]::Round($ram.TotalVisibleMemorySize / 1024 / 1024, 1)
      $pct = [math]::Round((($ram.TotalVisibleMemorySize - $ram.FreePhysicalMemory) / $ram.TotalVisibleMemorySize) * 100, 0)
      "$used/$total/$pct"
    ]]
  })
  if success then
    local parts = {}
    for part in stdout:gsub('\n', ''):gmatch('([^/]+)') do
      table.insert(parts, part)
    end
    ram = parts[1] .. '/' .. parts[2] .. 'GB(' .. parts[3] .. '%)'
    ram_pct = tonumber(parts[3])
  end

  -- Get Disk usage for C: and D: drives
  local disk = 'N/A'
  local disk_pct = 100

  -- Get C: drive usage
  local success_c, stdout_c, stderr_c = wezterm.run_child_process({
    'powershell.exe',
    '-Command',
    [[
      $disk = Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'"
      $free_gb = [math]::Floor($disk.FreeSpace / 1024 / 1024 / 1024)
      $free_mb = [math]::Round(($disk.FreeSpace / 1024 / 1024 - $free_gb * 1024), 0)
      $pct = [math]::Round((($disk.Size - $disk.FreeSpace) / $disk.Size) * 100, 0)
      "$free_gb/$free_mb/$pct"
    ]]
  })
  
  -- Get D: drive usage
  local success_d, stdout_d, stderr_d = wezterm.run_child_process({
    'powershell.exe',
    '-Command',
    [[
      $disk = Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='D:'"
      if ($disk) {
        $free_gb = [math]::Floor($disk.FreeSpace / 1024 / 1024 / 1024)
        $free_mb = [math]::Round(($disk.FreeSpace / 1024 / 1024 - $free_gb * 1024), 0)
        $pct = [math]::Round((($disk.Size - $disk.FreeSpace) / $disk.Size) * 100, 0)
        "$free_gb/$free_mb/$pct"
      } else {
        "N/A/N/A/N/A"
      }
    ]]
  })
  
  local disk_c = 'N/A'
  local disk_d = 'N/A'
  local disk_pct = 100
  local disk_pct_d = 100
  
  -- Process C: drive
  if success_c then
    local parts = {}
    for part in stdout_c:gsub('\n', ''):gmatch('([^/]+)') do
      table.insert(parts, part)
    end
    disk_c = 'C:' .. parts[1] .. 'GB'
    disk_pct = tonumber(parts[3]) or 100
  end
  
  -- Process D: drive
  if success_d then
    local parts = {}
    for part in stdout_d:gsub('\n', ''):gmatch('([^/]+)') do
      table.insert(parts, part)
    end
    if parts[1] ~= 'N/A' then
      disk_d = 'D:' .. parts[1] .. 'GB'
      disk_pct_d = tonumber(parts[3]) or 100
    end
  end
  
  disk = disk_c
  if disk_d ~= 'N/A' then
    disk = disk .. ' ' .. disk_d
  end

  -- Color based on usage
  local cpu_color = '#a6e3a1' -- green
  if cpu_pct > 80 then
    cpu_color = '#f38ba8' -- red
  elseif cpu_pct > 60 then
    cpu_color = '#f9e2af' -- yellow
  end

  local ram_color = '#a6e3a1' -- green
  if ram_pct > 80 then
    ram_color = '#f38ba8' -- red
  elseif ram_pct > 60 then
    ram_color = '#f9e2af' -- yellow
  end

  local temp_color = '#a6e3a1' -- green
  if temp_pct > 70 then
    temp_color = '#f38ba8' -- red
  elseif temp_pct > 50 then
    temp_color = '#f9e2af' -- yellow
  end

  local disk_color = '#a6e3a1' -- green
  local max_disk_pct = math.max(disk_pct, disk_pct_d)
  if max_disk_pct > 80 then
    disk_color = '#f38ba8' -- red
  elseif max_disk_pct > 60 then
    disk_color = '#f9e2af' -- yellow
  end

  window:set_right_status(wezterm.format({
    { Background = { Color = '#1e1e2e' } },
    { Foreground = { Color = cpu_color } },
    { Text = 'CPU [' .. make_bar(cpu_pct) .. '] ' .. cpu_pct .. '%' },
    { Foreground = { Color = '#cdd6f4' } },
    { Text = ', ' },
    { Foreground = { Color = ram_color } },
    { Text = '🧠 ram [' .. make_bar(ram_pct) .. '] ' .. ram_pct .. '%' },
    { Foreground = { Color = '#cdd6f4' } },
    { Text = ', ' },
    { Foreground = { Color = disk_color } },
    { Text = '💾 C:[' .. make_bar(disk_pct) .. '] ' .. disk_pct .. '%' },
    { Foreground = { Color = '#cdd6f4' } },
    { Text = ', ' },
    { Foreground = { Color = disk_color } },
    { Text = 'D:[' .. make_bar(disk_pct_d) .. '] ' .. disk_pct_d .. '%' },
  }))

  -- Schedule next update in 1 seconds
  wezterm.time.call_after(1, function()
    wezterm.emit('update-right-status', window, pane)
  end)
end)

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
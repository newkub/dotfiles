local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- =====================================
-- Shell
-- =====================================

config.default_cwd = "D:\\"

config.default_prog = {
  "C:\\Users\\Veerapong\\AppData\\Local\\mise\\shims\\pwsh.exe",
}

config.launch_menu = {
  {
    label = "PowerShell 7",
    args = {
      "C:\\Users\\Veerapong\\AppData\\Local\\mise\\shims\\pwsh.exe",
    },
    cwd = "D:\\",
  },
  {
    label = "Nushell",
    args = {
      "C:\\Users\\Veerapong\\scoop\\shims\\nu.exe",
    },
    cwd = "D:\\",
  },
  {
    label = "CMD",
    args = { "cmd.exe" },
    cwd = "D:\\",
  },
  {
    label = "WSL",
    args = { "wsl.exe" },
    cwd = "D:\\",
  },
}

-- =====================================
-- Font
-- =====================================

config.font_size = 15

config.font = wezterm.font_with_fallback({
  {
    family = "JetBrains Mono",
    weight = "Regular",
  },

  {
    family = "Noto Sans Thai",
  },

  {
    family = "Segoe UI Emoji",
  },
})

-- สำคัญสำหรับภาษาไทย
config.harfbuzz_features = {}

-- =====================================
-- Rendering
-- =====================================

-- ถ้ายังมีปัญหาไทยเพี้ยน
-- เปลี่ยนเป็น "Software"
config.front_end = "WebGpu"

config.max_fps = 60
config.animation_fps = 1

-- =====================================
-- Cursor
-- =====================================

config.default_cursor_style = "SteadyBar"
config.cursor_blink_rate = 0

-- =====================================
-- Window
-- =====================================

config.window_close_confirmation = "NeverPrompt"

config.scrollback_lines = 10000

config.enable_scroll_bar = false

-- =====================================
-- Tab Bar
-- =====================================

config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 15

-- =====================================
-- Colors
-- =====================================

config.colors = {
  tab_bar = {
    background = "#1e1e2e",

    active_tab = {
      bg_color = "#89b4fa",
      fg_color = "#1e1e2e",
    },

    inactive_tab = {
      bg_color = "#181825",
      fg_color = "#a6adc8",
    },

    inactive_tab_hover = {
      bg_color = "#313244",
      fg_color = "#cdd6f4",
    },

    new_tab = {
      bg_color = "#181825",
      fg_color = "#a6adc8",
    },

    new_tab_hover = {
      bg_color = "#313244",
      fg_color = "#cdd6f4",
    },
  },
}

-- =====================================
-- Keys
-- =====================================

config.keys = {
  {
    key = ".",
    mods = "CTRL",
    action = wezterm.action.ActivateCommandPalette,
  },

  {
    key = "f",
    mods = "CTRL|SHIFT",
    action = wezterm.action.Search({
      CaseInSensitiveString = "",
    }),
  },

  {
    key = "c",
    mods = "CTRL|SHIFT",
    action = wezterm.action.CopyTo("Clipboard"),
  },

  {
    key = "v",
    mods = "CTRL|SHIFT",
    action = wezterm.action.PasteFrom("Clipboard"),
  },

  {
    key = "c",
    mods = "CTRL",
    action = wezterm.action.SendString("\x03"),
  },

  {
    key = "t",
    mods = "CTRL",
    action = wezterm.action.SpawnTab("CurrentPaneDomain"),
  },

  {
    key = "w",
    mods = "CTRL",
    action = wezterm.action.CloseCurrentTab({
      confirm = true,
    }),
  },

  {
    key = "Tab",
    mods = "CTRL",
    action = wezterm.action.ActivateTabRelative(1),
  },

  {
    key = "Tab",
    mods = "CTRL|SHIFT",
    action = wezterm.action.ActivateTabRelative(-1),
  },

  {
    key = "UpArrow",
    mods = "CTRL",
    action = wezterm.action_callback(function(window, pane)
      local dims = pane:get_dimensions()
      local text = pane:get_lines_as_text(dims.viewport_rows)
      local lines = {}
      for line in text:gmatch("[^\r\n]+") do
        table.insert(lines, line)
      end
      -- Find prompt lines (PowerShell: starts with "PS " or ends with ">")
      local last_prompt_idx = nil
      local second_last_prompt_idx = nil
      for i = #lines, 1, -1 do
        local line = lines[i]
        -- Match common PowerShell prompt patterns: "PS path>" or "❯" or custom prompts
        if line:match("^PS%s") or line:match("❯") or line:match("^➜") or line:match(">$") then
          if last_prompt_idx == nil then
            last_prompt_idx = i
          elseif second_last_prompt_idx == nil then
            second_last_prompt_idx = i
            break
          end
        end
      end
      -- If we found the second-to-last prompt, copy from there to end
      -- Otherwise just copy the whole viewport
      local start_idx = second_last_prompt_idx or last_prompt_idx or 1
      local result = {}
      for i = start_idx, #lines do
        table.insert(result, lines[i])
      end
      window:copy_to_clipboard(table.concat(result, "\n"), "Clipboard")
    end),
  },
}

-- Split pane with Ctrl+Shift+Arrow keys
table.insert(config.keys, {
  key = "UpArrow",
  mods = "CTRL|SHIFT",
  action = wezterm.action.SplitPane({
    direction = "Up",
    size = { Percent = 50 },
  }),
})
table.insert(config.keys, {
  key = "DownArrow",
  mods = "CTRL|SHIFT",
  action = wezterm.action.SplitPane({
    direction = "Down",
    size = { Percent = 50 },
  }),
})
table.insert(config.keys, {
  key = "LeftArrow",
  mods = "CTRL|SHIFT",
  action = wezterm.action.SplitPane({
    direction = "Left",
    size = { Percent = 50 },
  }),
})
table.insert(config.keys, {
  key = "RightArrow",
  mods = "CTRL|SHIFT",
  action = wezterm.action.SplitPane({
    direction = "Right",
    size = { Percent = 50 },
  }),
})

for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = "CTRL",
    action = wezterm.action.ActivateTab(i - 1),
  })
end

-- =====================================
-- Status Bar
-- =====================================

config.status_update_interval = 5000

local function append_all(dst, src)
  for _, v in ipairs(src) do
    table.insert(dst, v)
  end
end

local function format_metric(label, used, total, unit)
  if not used or not total or total == 0 then
    return nil
  end
  local percent = (used / total) * 100
  local color = "#a6e3a1"
  if percent >= 90 then
    color = "#f38ba8"
  elseif percent >= 70 then
    color = "#f9e2af"
  end
  return {
    { Foreground = { Color = "#cdd6f4" } },
    { Text = label .. " " },
    { Foreground = { Color = color } },
    { Attribute = { Intensity = "Bold" } },
    { Text = string.format("%.1f", used) },
    { Attribute = { Intensity = "Normal" } },
    { Foreground = { Color = "#6c7086" } },
    { Text = "/" .. string.format("%.1f", total) .. unit },
    { Foreground = { Color = "#a6adc8" } },
    { Text = string.format(" %.0f%%", percent) },
  }
end

local function get_ram_usage()
  local success, stdout, _ = wezterm.run_child_process({
    "powershell.exe",
    "-NoProfile",
    "-Command",
    [[Get-CimInstance Win32_OperatingSystem | ForEach-Object { "{0}:{1}" -f [math]::Round($_.TotalVisibleMemorySize/1024), [math]::Round($_.FreePhysicalMemory/1024) }]],
  })
  if success and stdout then
    local total_mb, free_mb = stdout:match("(%d+):(%d+)")
    if total_mb and free_mb then
      local total = tonumber(total_mb) / 1024
      local used = total - (tonumber(free_mb) / 1024)
      return format_metric("RAM", used, total, "GB")
    end
  end
  return nil
end

local function get_disk_usage(drive)
  drive = drive or "C:"
  local filter = [[Get-CimInstance Win32_LogicalDisk -Filter "DeviceID=']] .. drive .. [['" | ForEach-Object { "{0}:{1}" -f [math]::Round($_.Size/1MB), [math]::Round(($_.Size-$_.FreeSpace)/1MB) }]]
  local success, stdout, _ = wezterm.run_child_process({
    "powershell.exe",
    "-NoProfile",
    "-Command",
    filter,
  })
  if success and stdout then
    local total_mb, used_mb = stdout:match("(%d+):(%d+)")
    if total_mb and used_mb then
      local total = tonumber(total_mb) / 1024
      local used = tonumber(used_mb) / 1024
      return format_metric(drive, used, total, "GB")
    end
  end
  return nil
end

wezterm.on("update-status", function(window, pane)
  local cwd = pane:get_current_working_dir()
  local drive = "C:"
  if cwd and cwd.file_path then
    local letter = cwd.file_path:match("^([A-Za-z]):")
    if letter then
      drive = letter:upper() .. ":"
    end
  end

  local items = {
    { Background = { Color = "#313244" } },
    { Text = " " },
  }
  local first = true

  local ram = get_ram_usage()
  if ram then
    append_all(items, ram)
    first = false
  end

  local disk = get_disk_usage(drive)
  if disk then
    if not first then
      table.insert(items, { Foreground = { Color = "#6c7086" } })
      table.insert(items, { Text = " | " })
    end
    append_all(items, disk)
    first = false
  end

  if not first then
    table.insert(items, { Text = " " })
    table.insert(items, "ResetAttributes")
    window:set_right_status(wezterm.format(items))
  else
    window:set_right_status("")
  end
end)

-- =====================================
-- Startup
-- =====================================

wezterm.on("gui-startup", function(cmd)
  local tab, _, window = wezterm.mux.spawn_window(cmd or {})

  for _ = 1, 4 do
    window:spawn_tab({
      cwd = "D:\\",
    })
  end

  tab:activate()

  window:gui_window():maximize()
end)

return config
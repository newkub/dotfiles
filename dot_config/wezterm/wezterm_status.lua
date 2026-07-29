local wezterm = require("wezterm")

local M = {}

local function append_all(dst, src)
  for _, v in ipairs(src) do
    table.insert(dst, v)
  end
end

local function fmt(n)
  if n >= 100 then
    return string.format("%.0f", n)
  elseif n >= 10 then
    return string.format("%.1f", n)
  else
    return string.format("%.2f", n)
  end
end

local function format_relative(seconds)
  if seconds < 60 then
    return math.floor(seconds) .. "s"
  elseif seconds < 3600 then
    return math.floor(seconds / 60) .. "m"
  elseif seconds < 86400 then
    return math.floor(seconds / 3600) .. "h"
  elseif seconds < 604800 then
    return math.floor(seconds / 86400) .. "d"
  elseif seconds < 2592000 then
    return math.floor(seconds / 604800) .. "w"
  elseif seconds < 31536000 then
    return math.floor(seconds / 2592000) .. "mo"
  else
    return math.floor(seconds / 31536000) .. "y"
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

  local short_label = label:gsub(":", "")
  return {
    { Foreground = { Color = "#9399b2" } },
    { Text = short_label .. " " },
    { Foreground = { Color = color } },
    { Text = fmt(used) .. "/" .. fmt(total) .. unit },
  }
end

local function format_percent(label, percent)
  if not percent then
    return nil
  end
  if percent < 0 then
    percent = 0
  elseif percent > 100 then
    percent = 100
  end

  local color = "#a6e3a1"
  if percent >= 90 then
    color = "#f38ba8"
  elseif percent >= 70 then
    color = "#f9e2af"
  end

  return {
    { Foreground = { Color = "#9399b2" } },
    { Text = label .. " " },
    { Foreground = { Color = color } },
    { Text = string.format("%.0f%%", percent) },
  }
end

local function format_disk(label, used, total, unit)
  if not used or not total or total == 0 then
    return nil
  end

  local short_label = label:gsub(":", "")
  return {
    { Foreground = { Color = "#9399b2" } },
    { Text = short_label .. ": " },
    { Foreground = { Color = "#cdd6f4" } },
    { Text = fmt(used) .. "/" .. fmt(total) .. unit },
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

local function get_all_disk_usage()
  local success, stdout, _ = wezterm.run_child_process({
    "powershell.exe",
    "-NoProfile",
    "-Command",
    [[Get-CimInstance Win32_LogicalDisk | ForEach-Object { if ($_.Size -gt 0) { "{0}:{1}:{2}" -f ($_.DeviceID -replace ':$'), [math]::Round($_.Size/1MB), [math]::Round(($_.Size-$_.FreeSpace)/1MB) } }]],
  })
  if not success or not stdout then
    return nil
  end

  local segments = {}
  for line in stdout:gmatch("[^\r\n]+") do
    local drive, total_mb, used_mb = line:match("^([A-Z]):(%d+):(%d+)$")
    if drive and total_mb and used_mb then
      local total = tonumber(total_mb) / 1024
      local used = tonumber(used_mb) / 1024
      local seg = format_disk(drive, used, total, "GB")
      if seg then
        table.insert(segments, seg)
      end
    end
  end

  if #segments > 0 then
    return segments
  end
  return nil
end

local function get_cpu_usage()
  local success, stdout, _ = wezterm.run_child_process({
    "powershell.exe",
    "-NoProfile",
    "-Command",
    [[Get-CimInstance Win32_Processor | ForEach-Object { $_.LoadPercentage } | Measure-Object -Average | ForEach-Object { [math]::Round($_.Average) }]],
  })
  if success and stdout then
    local load = tonumber(stdout:match("%d+"))
    if load then
      return format_percent("CPU", load)
    end
  end
  return nil
end

local function get_gpu_usage()
  local nvidia_success, nvidia_stdout, _ = wezterm.run_child_process({
    "nvidia-smi",
    "--query-gpu=utilization.gpu",
    "--format=csv,noheader,nounits",
  })
  if nvidia_success and nvidia_stdout then
    local load = tonumber(nvidia_stdout:match("%d+"))
    if load then
      return format_percent("GPU", load)
    end
  end

  local success, stdout, _ = wezterm.run_child_process({
    "powershell.exe",
    "-NoProfile",
    "-Command",
    [[try { $avg = (Get-Counter '\GPU Engine(*)\Utilization Percentage' -ErrorAction SilentlyContinue).CounterSamples | Where-Object { $_.CookedValue -ge 0 } | ForEach-Object { $_.CookedValue } | Measure-Object -Average | ForEach-Object { $_.Average }; if ($avg -ne $null) { [math]::Round($avg) } } catch {}]],
  })
  if success and stdout then
    local load = tonumber(stdout:match("%d+"))
    if load then
      return format_percent("GPU", load)
    end
  end

  return nil
end

local function collect_pids(info, pids)
  if not info then
    return
  end
  table.insert(pids, info.pid)
  for _, child in pairs(info.children or {}) do
    collect_pids(child, pids)
  end
end

local function get_open_ports(pane)
  local info = pane:get_foreground_process_info()
  if not info then
    return nil
  end

  local pids = {}
  collect_pids(info, pids)
  if #pids == 0 then
    return nil
  end

  local pid_list = table.concat(pids, ",")
  local success, stdout, _ = wezterm.run_child_process({
    "powershell.exe",
    "-NoProfile",
    "-Command",
    "Get-NetTCPConnection -State Listen | Where-Object { $_.LocalAddress -in @('0.0.0.0','127.0.0.1','::','::1') -and $_.OwningProcess -in ("
      .. pid_list
      .. ") } | ForEach-Object { $_.LocalPort } | Sort-Object -Unique",
  })
  if not success or not stdout then
    return nil
  end

  local ports = {}
  for line in stdout:gmatch("[^\r\n]+") do
    local port = tonumber(line:match("^%s*(%d+)%s*$"))
    if port then
      table.insert(ports, "localhost:" .. tostring(port))
    end
  end

  if #ports == 0 then
    return nil
  end

  return {
    { Foreground = { Color = "#9399b2" } },
    { Text = "url " },
    { Foreground = { Color = "#cdd6f4" } },
    { Text = table.concat(ports, " ") },
  }
end

local function get_git_status(cwd)
  if not cwd or not cwd.file_path then
    return nil, false
  end
  local path = cwd.file_path:gsub("^/([A-Za-z]:)", "%1")

  local branch = ""
  local branch_ok, branch_out, _ = wezterm.run_child_process({
    "git",
    "-C",
    path,
    "branch",
    "--show-current",
  })
  if branch_ok and branch_out then
    branch = branch_out:gsub("%s+", "")
  end

  local last_commit = nil
  local last_ok, last_out, _ = wezterm.run_child_process({
    "git",
    "-C",
    path,
    "log",
    "-1",
    "--format=%ct",
  })
  if last_ok and last_out then
    local commit_ts = tonumber((last_out:gsub("%s+", "")))
    if commit_ts then
      local now_ts = wezterm.time.now():format("%s")
      local now = tonumber((now_ts))
      if now then
        last_commit = format_relative(now - commit_ts)
      end
    end
  end

  local success, stdout, _ = wezterm.run_child_process({
    "git",
    "-C",
    path,
    "status",
    "--short",
  })
  if not success or not stdout then
    return nil, false
  end

  local staged = 0
  local unstaged = 0
  local untracked = 0

  for line in stdout:gmatch("[^\r\n]+") do
    local index = line:sub(1, 1)
    local worktree = line:sub(2, 2)

    if index == "?" and worktree == "?" then
      untracked = untracked + 1
    else
      if index ~= " " then
        staged = staged + 1
      end
      if worktree ~= " " then
        unstaged = unstaged + 1
      end
    end
  end

  local dirty = staged + unstaged + untracked
  if dirty == 0 and branch == "" then
    return nil, true
  end

  local items = {}

  if branch ~= "" then
    local branch_color = "#a6e3a1"
    if staged + unstaged > 0 then
      branch_color = "#f38ba8"
    elseif untracked > 0 then
      branch_color = "#f9e2af"
    end
    table.insert(items, { Foreground = { Color = branch_color } })
    table.insert(items, { Text = branch })
  end

  if last_commit then
    if #items > 0 then
      table.insert(items, { Foreground = { Color = "#6c7086" } })
      table.insert(items, { Text = " · " })
    end
    table.insert(items, { Foreground = { Color = "#a6adc8" } })
    table.insert(items, { Text = "last " .. last_commit })
  end

  local function add_count(n, symbol, label, color)
    if n > 0 then
      if #items > 0 then
        table.insert(items, { Foreground = { Color = "#cdd6f4" } })
        table.insert(items, { Text = " " })
      end
      table.insert(items, { Foreground = { Color = color } })
      table.insert(items, { Text = symbol .. n .. " " .. label })
    end
  end

  add_count(staged, "+", "staged", "#a6e3a1")
  add_count(unstaged, "~", "unstaged", "#f9e2af")
  add_count(untracked, "?", "untracked", "#89b4fa")

  return items, true
end

local function build_status(segments)
  local items = {
    { Background = { Color = "#313244" } },
    { Text = " " },
  }
  for i, seg in ipairs(segments) do
    if i > 1 then
      table.insert(items, { Foreground = { Color = "#cdd6f4" } })
      table.insert(items, { Text = " | " })
    end
    append_all(items, seg)
  end
  table.insert(items, { Text = " " })
  table.insert(items, "ResetAttributes")
  return wezterm.format(items)
end

function M.apply_to_config(config)
  config.status_update_interval = 5000
end

function M.build(pane)
  local cwd = pane:get_current_working_dir()

  local segments = {}

  local ram = get_ram_usage()
  if ram then
    table.insert(segments, ram)
  end

  local disks = get_all_disk_usage()
  if disks then
    for _, disk in ipairs(disks) do
      table.insert(segments, disk)
    end
  end

  local cpu = get_cpu_usage()
  if cpu then
    table.insert(segments, cpu)
  end

  local gpu = get_gpu_usage()
  if gpu then
    table.insert(segments, gpu)
  end

  local ports = get_open_ports(pane)
  if ports then
    table.insert(segments, ports)
  end

  local git, cwd_is_repo = get_git_status(cwd)
  if git then
    table.insert(segments, git)
  elseif not cwd_is_repo then
    local dotfiles_git = get_git_status({
      file_path = wezterm.home_dir .. "/.local/share/chezmoi",
    })
    if dotfiles_git then
      table.insert(segments, dotfiles_git)
    end
  end

  if #segments > 0 then
    return build_status(segments)
  end
  return ""
end

return M

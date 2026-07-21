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
    key = "F1",
    mods = "NONE",
    action = wezterm.action.ActivateCommandPalette,
  },

  {
    key = "f",
    mods = "CTRL",
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

for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = "CTRL",
    action = wezterm.action.ActivateTab(i - 1),
  })
end

-- =====================================
-- Startup
-- =====================================

wezterm.on("gui-startup", function(cmd)
  local tab, _, window = wezterm.mux.spawn_window(cmd or {})

  window:spawn_tab({
    cwd = "D:\\",
  })

  tab:activate()

  window:gui_window():maximize()
end)

return config
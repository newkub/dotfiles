local wezterm = require 'wezterm'

-- ฟังก์ชันสำหรับสร้าง 2 tabs เมื่อเริ่มต้นโปรแกรม และทำให้ tab แรกเป็น active
wezterm.on("gui-startup", function()
    local tab, pane, window = wezterm.mux.spawn_window{}

    -- สร้าง tab ที่สอง โดยใช้ path เดียวกับ tab แรก (D:)
    local tab2 = window:spawn_tab{
        cwd = 'D:'
    }

    -- ทำให้ tab แรกเป็น active เสมอ
    tab:activate()

    -- Maximize window
    if window:gui_window() then
        window:gui_window():maximize()
    end
end)

return {
    default_cwd = 'D:',
    default_prog = {"nu"},
    font = wezterm.font("MesloLGL Nerd Font"),
    font_size = 14.0,

    scrollback_lines = 10000,
    enable_scroll_bar = true,

    default_cursor_style = "SteadyBar",

    colors = {
        tab_bar = {
            background = "#1e1e1e",
            active_tab = {
                bg_color = "#3182ce",
                fg_color = "#ffffff",
                intensity = "Bold",
            },
            inactive_tab = {
                bg_color = "#1e1e1e",
                fg_color = "#a0aec0",
            },
            inactive_tab_hover = {
                bg_color = "#63b3ed",
                fg_color = "#ffffff",
            },
            new_tab = {
                bg_color = "#1e1e1e",
                fg_color = "#a0aec0",
            },
            new_tab_hover = {
                bg_color = "#3182ce",
                fg_color = "#ffffff",
            },
        },
    },

    window_close_confirmation = "NeverPrompt",

    -- รวม key bindings ทั้งหมดไว้ที่นี่
    keys = {
        {key = "Tab", mods = "SHIFT", action = wezterm.action{ActivatePaneDirection = "Next"}},
        {key = "t", mods = "CTRL", action = wezterm.action_callback(function(window, pane)
            -- ดึง current working directory ของ pane ที่กำลัง active
            local current_dir = pane:get_current_working_dir()
            if current_dir then
                -- แปลงเป็น string path
                local cwd = current_dir.file_path or tostring(current_dir)
                -- เปิด tab ใหม่ด้วย path เดียวกับ current path
                window:perform_action(wezterm.action{SpawnTab = {DomainName = "local", Cwd = cwd}}, pane)
            else
                -- ถ้าไม่สามารถดึง current directory ได้ ให้ใช้ default behavior
                window:perform_action(wezterm.action{SpawnTab = "CurrentPaneDomain"}, pane)
            end
        end)},
        {key = "n", mods = "CTRL", action = wezterm.action{SplitHorizontal = {domain = "CurrentPaneDomain"}}},
        {key = "w", mods = "CTRL", action = wezterm.action{CloseCurrentTab = {confirm = false}}},
        {key = "v", mods = "CTRL", action = wezterm.action{PasteFrom = "Clipboard"}},
        {key = "c", mods = "CTRL|SHIFT", action = wezterm.action{CopyTo = "Clipboard"}},
        {key = "c", mods = "CTRL", action = wezterm.action_callback(function(window, pane)
            if window:get_selection_text_for_pane(pane) == "" then
                window:perform_action(wezterm.action{SendString = "\x03"}, pane)
            else
                window:perform_action(wezterm.action{CopyTo = "Clipboard"}, pane)
            end
        end)},
        -- Change search shortcut from Ctrl+F to Ctrl+Shift+F
        {key = "f", mods = "CTRL|SHIFT", action = wezterm.action.Search{CaseInSensitiveString = ""}},
        {key = "a", mods = "CTRL", action = wezterm.action{SendString = "\x01"}},
        -- ลบ ctrl + left 
        -- เปลี่ยน ctrl + right เป็น ctrl + shift right
        {key = "RightArrow", mods = "CTRL|SHIFT", action = wezterm.action{SplitHorizontal = {domain = "CurrentPaneDomain"}}},
        -- เปลี่ยน ctrl + down เป็น ctrl + shift + down
        {key = "DownArrow", mods = "CTRL|SHIFT", action = wezterm.action{SplitVertical = {domain = "CurrentPaneDomain"}}},
        -- เพิ่ม shortcut สำหรับ Shift+Enter
        {key = "Enter", mods = "SHIFT", action = wezterm.action{SendString = "\x1b\r"}},
    }
}
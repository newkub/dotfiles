-- config ของผม
local wezterm = require 'wezterm'
wezterm.on("gui-startup", function(cmd)
    local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
    --- pane:split { direction = "Right" }
    window:gui_window():maximize()
end)
return {
    
    default_cwd = 'D:\\learn-wrikka-com',
    default_prog = {"pwsh"},
    font = wezterm.font("MesloLGL Nerd Font Mono"),
    font_size = 12.0,
    -- color_scheme = "Gruvbox Dark",
    hide_tab_bar_if_only_one_tab = true,
    default_cursor_style = "SteadyBar",
    enable_scroll_bar = true,
    keys = {
        {key = "t",mods = "CTRL",action = wezterm.action { SpawnTab = "CurrentPaneDomain" }},
        {key = "n",mods = "CTRL",action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } }},
        {key = "w",mods = "CTRL",action = wezterm.action { CloseCurrentTab = { confirm = false } }},
        {key = "v",mods = "CTRL",action = wezterm.action { PasteFrom = "Clipboard" }},
        {key = "c",mods = "CTRL|SHIFT",action = wezterm.action { CopyTo = "Clipboard" }},
        {key = "c",mods = "CTRL",action = wezterm.action_callback(function(window, pane)
            if window:get_selection_text_for_pane(pane) == "" then
                window:perform_action(wezterm.action { SendString = "\x03" }, pane)
            else
                window:perform_action(wezterm.action { CopyTo = "Clipboard" }, pane)
            end
        end)},
        {key = "f",mods = "CTRL",action = wezterm.action.Search { CaseInSensitiveString = "CurrentSelectionOrEmptyString" }},
        {key = "a",mods = "CTRL",action = wezterm.action { SendString = "\x01" }}
    }
}
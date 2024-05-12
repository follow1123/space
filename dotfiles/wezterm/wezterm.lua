local wezterm = require("wezterm")

local local_config_state, local_config = pcall(require, "local_config")

local act = wezterm.action

local conf = {}

--#############################################################################
--#                                                                           #
--#                                 option                                    #
--#                                                                           #
--#############################################################################

conf.color_scheme = "SoftServer"                                -- 主题
conf.use_fancy_tab_bar = false                                  -- tab样式
-- conf.hide_tab_bar_if_only_one_tab = true                        -- 只有一个tab时不显示tab栏
conf.window_background_opacity = 0.95                           -- 背景透明度
conf.font = wezterm.font("JetBrainsMono Nerd Font")             -- 字体
conf.font_size = 12                                             -- 字体大小
conf.default_cursor_style = "BlinkingBar"                       -- 光标样式
conf.cursor_blink_rate = 700                                    -- 光标闪烁频率
conf.cursor_blink_ease_in = "Constant"                          -- 光标闪烁显示效果
conf.cursor_blink_ease_out = "Constant"                         -- 光标闪烁消失效果
conf.window_decorations = "INTEGRATED_BUTTONS|RESIZE"           -- 不显示系统自带的状态栏
conf.integrated_title_button_alignment = "Right"                -- 按钮位置
conf.integrated_title_button_color = "Auto"                     -- 按钮颜色
conf.integrated_title_button_style = "Windows"                  -- 按钮风格
conf.integrated_title_buttons = { "Close" }                     -- 按钮功能位置
conf.default_prog = { "pwsh" }                                  -- 默认shell
conf.scrollback_lines = 3000                                    -- 保持3000行历史记录
conf.default_workspace = "main"                                 -- 默认工作区名称
conf.disable_default_key_bindings = true                        -- 禁用所有默认快捷键
conf.use_ime = true                                             -- 使用输入法编辑器 (IME) 处理键盘输入，关闭则无法使用fcitx输入法
conf.status_update_interval = 1000                              -- 状态栏刷新间隔
conf.check_for_updates = false                                  -- 关闭自动检查更新
conf.audible_bell = "Disabled"                                  -- 关闭铃声
conf.initial_cols = 120                                         -- 初始列
conf.initial_rows = 30                                          -- 初始行
conf.animation_fps = 60                                         -- 动画帧率
conf.tab_max_width = 30                                         -- tab最大宽度
conf.window_padding = {                                         -- 内容边距
  left = 0, right = 0,
  top = 0, bottom = 0,
}
conf.inactive_pane_hsb = {                                      -- 非活动窗口样式
  saturation = 0.24,
  brightness = 0.5
}
conf.launch_menu = {
  { label = "PowerShell Core", args = { "pwsh" } },
  { label = "Windows PowerShell", args = { "powershell" } },
  { label = "Command Prompt", args = { "cmd" } },
  { label = "Windows Subsystem For Linux", args = { "wsl", "--cd", "~" }},
  { label = "Windows Subsystem For Linux(root)", args = { "wsl", "--cd", "~", "-u", "root" }},
}
-- powershell -Command { Start-Process -FilePath pwsh -Verb RunAs }
if local_config_state then
  local local_launch_menu = local_config.launch_menu
  if local_launch_menu then
    for _, launch_menu in ipairs(local_launch_menu) do
      table.insert(conf.launch_menu, launch_menu)
    end
  end
end
--#############################################################################
--#                                                                           #
--#                                 keymap                                    #
--#                                                                           #
--#############################################################################

-- leader key alt+x
conf.leader = { key = "x", mods = "ALT", timeout_milliseconds = 1000 }

conf.keys = {
  -- 按两次Alt+x才是Alt+x
  { key = "x",        mods = "LEADER",       action = act.SendKey { key = "a", mods = "ALT" } },
  -- Pane keybindings
  { key = "s",        mods = "LEADER",       action = act.SplitVertical { domain = "CurrentPaneDomain" } },
  { key = "v",        mods = "LEADER",       action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },

  { key = "h",        mods = "LEADER",       action = act.ActivatePaneDirection("Left") },
  { key = "l",        mods = "LEADER",       action = act.ActivatePaneDirection("Right") },
  { key = "j",        mods = "LEADER",       action = act.ActivatePaneDirection("Down") },
  { key = "k",        mods = "LEADER",       action = act.ActivatePaneDirection("Up") },

  { key = "l",        mods = "LEADER|ALT",   action = act.ActivatePaneDirection("Right") },
  { key = "h",        mods = "LEADER|ALT",   action = act.ActivatePaneDirection("Left") },
  { key = "j",        mods = "LEADER|ALT",   action = act.ActivatePaneDirection("Down") },
  { key = "k",        mods = "LEADER|ALT",   action = act.ActivatePaneDirection("Up") },

  { key = "z",        mods = "LEADER",       action = act.TogglePaneZoomState },
  { key = "j",        mods = "LEADER|SHIFT", action = act.RotatePanes "Clockwise" },
  { key = "r",        mods = "LEADER",       action = act.ActivateKeyTable { name = "resize_pane", one_shot = false } },

  -- Tab keybindings
  { key = "n",        mods = "LEADER",       action = act.SpawnTab("CurrentPaneDomain") },
  { key = "n",        mods = "LEADER|ALT",   action = act.SpawnTab("CurrentPaneDomain") },

  { key = "[",        mods = "LEADER",       action = act.ActivateTabRelative(-1) },
  { key = "]",        mods = "LEADER",       action = act.ActivateTabRelative(1) },
  { key = "Tab",      mods = "CTRL|SHIFT",   action = act.ActivateTabRelative(-1) },
  { key = "Tab",      mods = "CTRL",         action = act.ActivateTabRelative(1) },
  { key = "t",        mods = "LEADER",       action = act.ShowTabNavigator },
  { key = "m",        mods = "LEADER",       action = act.ActivateKeyTable { name = "move_tab", one_shot = false } },
  { key = "o",        mods = "LEADER",       action = act.ShowLauncherArgs { flags = "FUZZY|LAUNCH_MENU_ITEMS" } },

  { key = "1",        mods = "LEADER",       action = act.ActivateTab(0) },
  { key = "2",        mods = "LEADER",       action = act.ActivateTab(1) },
  { key = "3",        mods = "LEADER",       action = act.ActivateTab(2) },
  { key = "4",        mods = "LEADER",       action = act.ActivateTab(3) },
  { key = "5",        mods = "LEADER",       action = act.ActivateTab(4) },
  { key = "6",        mods = "LEADER",       action = act.ActivateTab(5) },
  { key = "7",        mods = "LEADER",       action = act.ActivateTab(6) },
  { key = "8",        mods = "LEADER",       action = act.ActivateTab(7) },
  { key = "9",        mods = "LEADER",       action = act.ActivateTab(8) },

  { key = "w",        mods = "LEADER",       action = act.ShowLauncherArgs { flags = "FUZZY|WORKSPACES" } },
  { key = "p",        mods = "CTRL|SHIFT",   action = act.ActivateCommandPalette },
  { key = "f",        mods = "LEADER",       action = act.Search{ CaseSensitiveString = "" } },
  { key = "F11",                             action = act.ToggleFullScreen },

  { key = "c",        mods = "CTRL|SHIFT",   action = act.CopyTo("Clipboard") },
  { key = "v",        mods = "CTRL|SHIFT",   action = act.PasteFrom("Clipboard") },

  -- font size
  { key = "-",        mods = "CTRL",         action = act.DecreaseFontSize },
  { key = "=",        mods = "CTRL",         action = act.IncreaseFontSize },
  { key = "0",        mods = "CTRL",         action = act.ResetFontSize },

  { key = "PageUp",   mods = "SHIFT",        action = act.ScrollByPage(-1)},
  { key = "PageDown", mods = "SHIFT",        action = act.ScrollByPage(1)},

}

conf.key_tables = {
  resize_pane = {
    { key = "h",      action = act.AdjustPaneSize { "Left", 1 } },
    { key = "j",      action = act.AdjustPaneSize { "Down", 1 } },
    { key = "k",      action = act.AdjustPaneSize { "Up", 1 } },
    { key = "l",      action = act.AdjustPaneSize { "Right", 1 } },
    { key = "Escape", action = "PopKeyTable" },
    { key = "Enter",  action = "PopKeyTable" },
  },
  move_tab = {
    { key = "h",      action = act.MoveTabRelative(-1) },
    { key = "j",      action = act.MoveTabRelative(-1) },
    { key = "k",      action = act.MoveTabRelative(1) },
    { key = "l",      action = act.MoveTabRelative(1) },
    { key = "Escape", action = "PopKeyTable" },
    { key = "Enter",  action = "PopKeyTable" },
  }
}

--#############################################################################
--#                                                                           #
--#                                   mouse                                   #
--#                                                                           #
--#############################################################################

conf.mouse_bindings = {
  { -- 禁用鼠标左键两下选中word时复制
    event = { Up = { streak = 2, button = "Left" } },
    mods = "NONE",
    action = act.Nop,
  },
  { -- 禁用鼠标左键三下选中line时复制
    event = { Up = { streak = 3, button = "Left" } },
    mods = "NONE",
    action = act.Nop,
  },
}

--#############################################################################
--#                                                                           #
--#                                  events                                   #
--#                                                                           #
--#############################################################################

local color_red1 = "#f7768e"
local color_blue1 = "#7dcfff"
local color_purple1 = "#bb9af7"

local function basename(s)
  local a = string.gsub(s, "(.*[/\\])(.*)", "%2")
  return a:gsub("%.exe$", "")
end


wezterm.on("update-status", function(window)
  local stat = window:active_workspace()
  local stat_color = color_red1

  if window:active_key_table() then
    stat = window:active_key_table()
    stat_color = color_blue1
  end

  if window:leader_is_active() then
    stat = "LDR"
    stat_color = color_purple1
  end

  window:set_right_status(wezterm.format({
    { Foreground = { Color = stat_color } },
    { Text = stat },
    { Text = " " },
  }))
end)

wezterm.on("format-tab-title", function(tab)
  local process_name = basename(tab.active_pane.foreground_process_name)
  local title = process_name:len() > 0 and process_name or basename(tab.active_pane.title)

  local def_attr = { Attribute = { Intensity = "Bold" } }
  local cells = {
    { Text = " " },
    def_attr,
    { Text = title },
    { Text = " " }
  }

  if tab.active_pane.title:match("^Administrator: ") then
    table.insert(cells, 2, " " .. wezterm.nerdfonts.md_shield)
  end

  return cells
end)

return conf

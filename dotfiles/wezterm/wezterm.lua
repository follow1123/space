local wezterm = require "wezterm"

local config = {
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,

  window_background_opacity = 0.9,
  

  color_scheme = "SoftServer",
  font = wezterm.font("JetBrainsMono Nerd Font"),
  font_size = 15,
  window_padding = {
      left = 2,
      right = 2,
      top = 0,
      bottom = 0,
  },
  cursor_blink_ease_in = "Linear",
  cursor_blink_ease_out = "Linear"
}

return config

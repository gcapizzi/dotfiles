local wezterm = require 'wezterm'

return {
  color_scheme = 'Catppuccin Macchiato',
  enable_tab_bar = false,
  font = wezterm.font 'FiraCode Nerd Font',
  font_size = 16,
  front_end = "WebGpu",
  window_padding = {
    left = 5,
    right = 5,
    top = 5,
    bottom = 5,
  }
}

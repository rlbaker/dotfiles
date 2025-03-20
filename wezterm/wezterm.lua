local wezterm = require('wezterm')
local config = wezterm.config_builder()

-- config.dpi = 92

config.font_size = 15
config.font = wezterm.font { family = 'IosevkaTerm Nerd Font Mono', weight = 'Light' }

config.animation_fps = 1
config.audible_bell = 'Disabled'
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'
config.cursor_blink_rate = 0
config.visual_bell = { target = 'CursorColor' }
config.window_decorations = 'RESIZE'
config.window_padding = { left = 4, right = 0, top = 4, bottom = 0 }

config.color_scheme = 'Gruvbox Material (Gogh)'

return config

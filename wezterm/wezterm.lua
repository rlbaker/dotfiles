local wezterm = require('wezterm')

local config = {}


config.animation_fps = 1
config.audible_bell = 'Disabled'
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'
config.cursor_blink_rate = 0
config.font = wezterm.font { family = 'Iosevka RLB', weight = 'Light' }
config.font_size = 12.0
config.visual_bell = { target = 'CursorColor' }
config.window_decorations = 'RESIZE'
config.window_padding = { left = 6, right = 0, top = 0, bottom = 0 }

config.colors = {
    foreground = '#d3c6aa',
    background = '#2d353b',
    cursor_fg = '#2d353b',
    cursor_bg = '#d3c6aa',
    cursor_border = '#d3c6aa',
    selection_fg = '#9da9a0',
    selection_bg = '#543a48',
    ansi = {
        '#3D484D', '#e67e80', '#a7c080', '#e69875', '#7fbbb3', '#d699b6', '#83c092', '#859289',
    },
    brights = {
        '#4F585E', '#e67e80', '#a7c080', '#dbbc7f', '#7fbbb3', '#d699b6', '#83c092', '#9da9a0',
    },
}

return config

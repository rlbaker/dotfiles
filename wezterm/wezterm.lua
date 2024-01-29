local wezterm = require('wezterm')
local config = wezterm.config_builder()

-- config.dpi = 92

config.font_size = 15
config.font = wezterm.font { family = 'Iosevka Term', weight = 'Light' }

config.animation_fps = 1
config.audible_bell = 'Disabled'
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'
config.cursor_blink_rate = 0
config.visual_bell = { target = 'CursorColor' }
config.window_decorations = 'RESIZE'
config.window_padding = { left = 4, right = 0, top = 4, bottom = 0 }

-- Everforest Theme: https://github.com/sainnhe/everforest
local forest = {
    bg_dim = '#232a2e',
    bg0 = '#2d353b',
    bg1 = '#343f44',
    bg2 = '#3d484d',
    bg3 = '#475258',
    bg4 = '#4f585e',
    bg5 = '#56635f',
    bg_red = '#543a48',
    bg_orange = '#514045',
    bg_yellow = '#4d4c43',
    bg_green = '#425047',
    bg_blue = '#3a515d',
    red = '#e67e80',
    orange = '#e69875',
    yellow = '#dbbc7f',
    green = '#a7c080',
    blue = '#7fbbb3',
    aqua = '#83c092',
    purple = '#d699b6',
    fg = '#d3c6aa',
    gray0 = '#7a8478',
    gray1 = '#859289',
    gray2 = '#9da9a0',
}

config.colors = {
    foreground = forest.fg,
    background = forest.bg0,
    cursor_fg = forest.bg0,
    cursor_bg = forest.fg,
    cursor_border = forest.fg,
    compose_cursor = forest.orange,
    selection_fg = forest.gray2,
    selection_bg = forest.bg_red,
    split = forest.bg5,
    ansi = {
        forest.bg2, forest.red, forest.green, forest.orange, forest.blue, forest.purple, forest.aqua, forest.gray1,
    },
    brights = {
        forest.bg3, forest.red, forest.green, forest.yellow, forest.blue, forest.purple, forest.aqua, forest.gray2,
    },
}

return config


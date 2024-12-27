local wezterm = require("wezterm")
local colors = require("colors")

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

config.font = wezterm.font("FiraCode Nerd Font Mono")
config.font_size = 12

config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true

config.colors = {
    foreground = colors.fg.bright,
    background = colors.bg.base,
    
    cursor_bg = colors.fg.dim,
    cursor_fg = colors.bg.base,
    cursor_border = colors.fg.dim,
    
    selection_fg = colors.fg.bright,
    selection_bg = colors.bg.selection,
    
    ansi = {
        colors.ansi.black,
        colors.ansi.red,
        colors.ansi.green,
        colors.ansi.yellow,
        colors.ansi.blue,
        colors.ansi.magenta,
        colors.ansi.cyan,
        colors.ansi.white,
    },
    
    brights = {
        colors.bright.black,
        colors.bright.red,
        colors.bright.green,
        colors.bright.yellow,
        colors.bright.blue,
        colors.bright.magenta,
        colors.bright.cyan,
        colors.bright.white,
    },
    
    tab_bar = {
        background = colors.bg.darker,
        
        active_tab = {
            bg_color = colors.bg.base,
            fg_color = colors.fg.bright,
            intensity = "Normal",
            underline = "None",
            italic = false,
            strikethrough = false,
        },
        
        inactive_tab = {
            bg_color = colors.bg.darker,
            fg_color = colors.fg.dimmer,
            intensity = "Normal",
            underline = "None",
            italic = false,
            strikethrough = false,
        },
        
        new_tab = {
            bg_color = colors.bg.darker,
            fg_color = colors.fg.dimmer,
        },
        
        new_tab_hover = {
            bg_color = colors.bg.selection,
            fg_color = colors.fg.bright,
            italic = false,
        }
    },
}

config.window_frame = {
    font = wezterm.font({ family = "FiraCode Nerd Font Mono", weight = "Bold" }),
    font_size = 12.0,
    active_titlebar_bg = colors.bg.darker,
    inactive_titlebar_bg = colors.bg.darker,
}

config.inactive_pane_hsb = {
    saturation = 0.9,
    brightness = 0.8,
}

config.window_background_opacity = 1.0
config.text_background_opacity = 1.0

return config


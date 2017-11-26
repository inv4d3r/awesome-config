---------------------------
-- Jellybean awesome theme --
---------------------------

local awful = require("awful")
awful.util = require("awful.util")

home = os.getenv("HOME")
config_dir = awful.util.get_configuration_dir()
theme_dir = config_dir .. "/themes/jellybean/"

theme = {}

theme.font = "Inconsolata 10"

-- Exportable fs variables
theme.wallpaper = theme_dir .. "pacman.jpg"
theme.awesome_icon = theme_dir .. "awesome_icon.png"

--theme.tasklist_sticky = " S "
--theme.tasklist_floating = " F "
--theme.tasklist_maximized_horizontal = " H "
--theme.tasklist_maximized_vertical = " V "
--theme.tasklist_maximized = " M "
theme.tasklist_disable_icon = true
theme.tasklist_align = "center"
theme.tasklist_plain_task_name = true
theme.useless_gap = 5
theme.gap_single_client = false
theme.apw_show_text = true

-- Jellybean
theme.green = "#99ad6a"
theme.orange = "#ff9500"
theme.red = "#cf6a4c"  -- red
theme.green = "#96ad6a" -- green
theme.yellow = "#d8ad4c"  -- yellow
theme.blue = "#597bc5" -- blue
theme.purple = "#a037b0" -- magenta
theme.aqua = "#71b9f8" -- cyan
theme.white = "#adadad" -- white

-- Twilight grayscale
theme.black = '#1a1a1a'
theme.gray = '#303030'
theme.lightgray = '#605958'
theme.darkgray = "#3b3b3b"

--// Generic colors
theme.nearblack = theme.black

--// Default Colors
theme.bg_normal = theme.black
theme.bg_focus = theme.darkgray
theme.bg_urgent = theme.orange
theme.bg_minimize = theme.lightgray
theme.bg_systray = theme.bg_normal

theme.fg_normal = theme.white
theme.fg_focus = theme.aqua
theme.fg_urgent = theme.black
theme.fg_minimize = theme.white

theme.hfill_bg_color = theme.gray
--
--// APW
theme.apw_bg_color = theme.black
theme.apw_fg_color = theme.red
theme.apw_text_color = theme.red

-- {{{ Textclock
theme.clock_bg_color = theme.black
theme.date_fg_color = theme.yellow
theme.time_fg_color = theme.red
-- }}

-- {{{ Net widget
theme.nonet_fg_color = theme.red
theme.netface_fg_color = theme.white
theme.netrate_fg_color = theme.green
theme.net_bg_color = theme.black
-- }}

-- {{{ Fs widgets
theme.fs_dir_fg_color = theme.orange
theme.fs_fg_color = theme.white
theme.fs_bg_color = theme.black
-- }}

--// APW
theme.apw_bg_color = theme.nearblack
theme.apw_fg_color = theme.darkgray
theme.apw_text_color = theme.aqua

--// Borders
theme.border_width = "0"
theme.border_normal = theme.nearblack
theme.border_focus = theme.gray
theme.border_marked = theme.white

-- Display the taglist squares
--theme.taglist_squares_sel = "taglist/square_bottom.png"
theme.taglist_squares_sel   = theme_dir .."taglist/square_bottom_sel.png"
theme.taglist_squares_unsel = theme_dir .."taglist/square_bottom_unsel.png"

---- Custom layouts
theme.layout_tile       = theme_dir .. "layouts/tile.png"
theme.layout_tileleft   = theme_dir .. "layouts/tileleft.png"
theme.layout_tilebottom = theme_dir .. "layouts/tilebottom.png"
theme.layout_tiletop    = theme_dir .. "layouts/tiletop.png"
theme.layout_fairv      = theme_dir .. "layouts/fairv.png"
theme.layout_fairh      = theme_dir .. "layouts/fairh.png"
theme.layout_spiral     = theme_dir .. "layouts/spiral.png"
theme.layout_dwindle    = theme_dir .. "layouts/dwindle.png"
theme.layout_max        = theme_dir .. "layouts/max.png"
theme.layout_fullscreen = theme_dir .. "layouts/fullscreen.png"
theme.layout_magnifier  = theme_dir .. "layouts/magnifier.png"
theme.layout_floating   = theme_dir .. "layouts/floating.png"

theme.icon_theme = nil

return theme

---------------------------
-- Nord awesome theme --
---------------------------

local awful = require("awful")
awful.util = require("awful.util")

-- {{ Initialization
home = os.getenv("HOME")
config_dir = awful.util.get_configuration_dir()
theme_dir = config_dir .. "/themes/nord/"
theme = {}
-- }}

-- {{ Exportable variables
theme.font = "Hack 8"
theme.wallpaper = theme_dir .. "background.jpg"
theme.awesome_icon = theme_dir .. "awesome_icon.png"
-- }}

-- {{ Configuration variables
theme.tasklist_sticky = "s/"
theme.tasklist_ontop = "o/"
theme.tasklist_above = "a/"
theme.tasklist_below = "b/"
theme.tasklist_floating = "f/"
theme.tasklist_maximized_horizontal = "h/"
theme.tasklist_maximized_vertical = "v/"
theme.tasklist_maximized = "M/"
theme.tasklist_disable_icon = true
theme.tasklist_align = "center"
theme.tasklist_font = "Hack Bold 9"
theme.tasklist_plain_task_name = false

theme.useless_gap = 2
theme.gap_single_client = false
-- }}

-- {{ Nord colors
theme.black     = "#2E3440"
theme.nearblack = "#3B4252"
theme.darkgray  = "#434C5E"
theme.gray      = "#4C566A"
theme.lightgray = "#D8DEE9"
theme.nearwhite = "#E5E9F0"
theme.white     = "#ECEFF4"
theme.aqua_dark = "#8FBCBB"
theme.aqua      = "#88C0D0"
theme.blue      = "#81A1C1"
theme.blue_dark = "#5E81AC"
theme.red       = "#BF616A"
theme.orange    = "#D08770"
theme.yellow    = "#EBCB8B"
theme.green     = "#A3BE8C"
theme.purple    = "#B48EAD"
-- }}

-- {{ Default Colors
theme.bg_normal = theme.nearblack
theme.bg_focus = theme.blue_dark
theme.bg_urgent = theme.orange
theme.bg_minimize = theme.gray
theme.bg_systray = theme.nearblack

theme.fg_normal = theme.white
theme.fg_focus = theme.white
theme.fg_urgent = theme.white
theme.fg_minimize = theme.white
-- }}

-- Horizontal fill color
theme.hfill_bg_color = theme.black

-- {{ APW
theme.apw_bg_color = theme.black
theme.apw_fg_color = theme.darkgray
theme.apw_show_text = true
theme.apw_text_color = theme.aqua_dark
theme.apw_text_weight = "bold"

-- {{ Battery
theme.bat_charging = theme.fg_normal
theme.bat_not_charging = theme.yellow
theme.bat_low = theme.red
theme.bat_medium = theme.blue
theme.bat_high = theme.green
-- }}

-- {{ Textclock
theme.clock_bg_color = theme.nearblack
theme.date_fg_color = theme.blue
theme.time_fg_color = theme.aqua
-- }}

-- {{ Net widget
theme.nonet_fg_color = theme.red
theme.netface_fg_color = theme.white
theme.netrate_fg_color = theme.blue
theme.net_bg_color = theme.nearblack
-- }}

-- {{ Fs widgets
theme.fs_dir_fg_color = theme.white
theme.fs_fg_color = theme.blue
theme.fs_bg_color = theme.nearblack
-- }}

-- {{ Borders
theme.border_width = "0"
theme.border_normal = theme.black
theme.border_focus = theme.gray
theme.border_marked = theme.white
-- }}

-- {{ Display the taglist squares
theme.taglist_squares_sel   = theme_dir .. "taglist/square_bottom_sel.png"
theme.taglist_squares_unsel = theme_dir .. "taglist/square_bottom_unsel.png"
theme.taglist_spacing = 1
-- }}

-- {{ Custom layouts
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
-- }}

theme.icon_theme = nil

return theme

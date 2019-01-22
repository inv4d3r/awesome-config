---------------------------
-- Grayscale awesome theme --
---------------------------

local awful = require("awful")
awful.util = require("awful.util")

-- {{ Initialization
home = os.getenv("HOME")
config_dir = awful.util.get_configuration_dir()
theme_dir = config_dir .. "/themes/grayscale/"
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

-- {{ Badwolf grayscale colors
theme.brightgravel   = "#d9cec3"
theme.lightgravel    = "#998f84"
theme.gravel         = "#857f78"
theme.mediumgravel   = "#666462"
theme.deepgravel     = "#45413b"
theme.deepergravel   = "#35322d"
theme.darkgravel     = "#242321"
theme.blackgravel    = "#1c1b1a"
theme.blackestgravel = "#141413"

-- {{ Default Colors
theme.bg_normal = theme.darkgravel
theme.bg_focus = theme.blackestgravel
theme.bg_urgent = theme.gravel
theme.bg_minimize = theme.darkgravel
theme.bg_systray = theme.bg_normal

theme.fg_normal = theme.gravel
theme.fg_focus = theme.brightgravel
theme.fg_urgent = theme.blackgravel
theme.fg_minimize = theme.mediumgravel
-- }}

-- Horizontal fill color
theme.hfill_bg_color = theme.blackestgravel

-- {{ Textclock
theme.clock_bg_color = theme.blackgravel
theme.date_fg_color = theme.lightgravel
theme.time_fg_color = theme.lightgravel
-- }}

-- {{ Net widget
theme.nonet_fg_color = theme.lightgravel
theme.netface_fg_color = theme.lightgravel
theme.netrate_fg_color = theme.lightgravel
theme.net_bg_color = theme.blackgravel
-- }}

-- {{ Fs widgets
theme.fs_dir_fg_color = theme.lightgravel
theme.fs_fg_color = theme.lightgravel
theme.fs_bg_color = theme.blackgravel
-- }}

-- {{ APW
theme.apw_bg_color = theme.blackgravel
theme.apw_fg_color = theme.lightgravel
theme.apw_show_text = true
theme.apw_text_color = theme.brightgravel
theme.apw_text_weight = 'bold'
-- }}

-- {{ Battery
theme.bat_bg = theme.blackgravel
theme.bat_charging = theme.brightgravel
theme.bat_not_charging = theme.fg_normal
theme.bat_low = theme.darkgravel
theme.bat_medium = theme.lightgravel
theme.bat_high = theme.brightgravel
-- }}

-- {{ Borders
theme.border_width = "0"
theme.border_normal = theme.blackgravel
theme.border_focus = theme.lightgravel
theme.border_marked = theme.brightgravel
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

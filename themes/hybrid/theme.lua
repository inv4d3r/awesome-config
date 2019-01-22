---------------------------
-- Hybrid awesome theme --
---------------------------

local awful = require("awful")
awful.util = require("awful.util")

-- {{ Initialization
home = os.getenv("HOME")
config_dir = awful.util.get_configuration_dir()
theme_dir = config_dir .. "/themes/hybrid/"
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

-- {{ Hybrid colors
theme.background = "#1d1f21"
theme.background_reduced = "#232c31"
theme.foreground = "#c5c8c6"
theme.selection = "#373b41"
theme.line = "#282a2e"
theme.comment = "#707880"
theme.red = "#cc6666"
theme.orange = "#de935f"
theme.yellow = "#f0c674"
theme.green = "#b5bd68"
theme.aqua = "#8abeb7"
theme.blue = "#81a2be"
theme.purple = "#b294bb"
theme.window = "#303030"
theme.darkcolumn = "#1c1c1c"
theme.addbg = "#5F875F"
theme.addfg = "#d7ffaf"
theme.changebg = "#5F5F87"
theme.changefg = "#d7d7ff"
theme.delbg = "#cc6666"
theme.darkblue = "#00005f"
theme.darkcyan = "#005f5f"
theme.darkred = "#5f0000"
theme.darkpurple = "#5f005f"

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
-- }}

-- {{ Generic colors
theme.white = "#ffffff"
theme.black = theme.background
theme.nearblack = theme.background_reduced
theme.gray = theme.foreground
-- }}

-- {{ Default Colors
theme.bg_normal = theme.background_reduced
theme.bg_focus = theme.black
theme.bg_urgent = theme.foreground
theme.bg_minimize = theme.background_reduced
theme.bg_systray = theme.bg_normal

theme.fg_normal = theme.foreground
theme.fg_focus = theme.white
theme.fg_urgent = theme.background_reduced
theme.fg_minimize = theme.foreground
-- }}

-- Horizontal fill color
theme.hfill_bg_color = theme.background

-- {{ Textclock
theme.clock_bg_color = theme.background_reduced
theme.date_fg_color = theme.foreground
theme.time_fg_color = theme.foreground
-- }}

-- {{ Net widget
theme.nonet_fg_color = theme.foreground
theme.netface_fg_color = theme.foreground
theme.netrate_fg_color = theme.foreground
theme.net_bg_color = theme.background_reduced
-- }}

-- {{ Fs widgets
theme.fs_dir_fg_color = theme.foreground
theme.fs_fg_color = theme.foreground
theme.fs_bg_color = theme.background_reduced
-- }}

-- {{ APW
theme.apw_bg_color = theme.background_reduced
theme.apw_fg_color = theme.comment
theme.apw_show_text = true
theme.apw_text_color = theme.foreground
theme.apw_text_weight = 'bold'
-- }}

-- {{ Battery
theme.bat_bg = theme.background_reduced
theme.bat_charging = theme.foreground
theme.bat_not_charging = theme.fg_normal
theme.bat_low = theme.background_reduced
theme.bat_medium = theme.foreground
theme.bat_high = theme.foreground
-- }}

-- {{ Borders
theme.border_width = "0"
theme.border_normal = theme.nearblack
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

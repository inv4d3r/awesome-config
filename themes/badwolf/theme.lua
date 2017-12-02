---------------------------
-- Badwolf awesome theme --
---------------------------

local awful = require("awful")
awful.util = require("awful.util")

-- {{ Initialization
home = os.getenv("HOME")
config_dir = awful.util.get_configuration_dir()
theme_dir = config_dir .. "/themes/badwolf/"
theme = {}
-- }}

-- {{ Exportable variables
theme.font = "Hack 8"
theme.wallpaper = theme_dir .. "background.jpg"
theme.awesome_icon = theme_dir .. "awesome_icon.png"
-- }}

-- {{ Configuration variables
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
-- }}

-- {{ Badwolf colors
theme.white = "#ffffff"
theme.black = "#000000"

theme.brightgravel   = "#d9cec3"
theme.lightgravel    = "#998f84"
theme.gravel         = "#857f78"
theme.mediumgravel   = "#666462"
theme.deepgravel     = "#45413b"
theme.deepergravel   = "#35322d"
theme.darkgravel     = "#242321"
theme.blackgravel    = "#1c1b1a"
theme.blackestgravel = "#141413"

theme.yellow = "#fade3e" -- dalespale
theme.dirty_yellow = "#f4cf86" -- dirtyblond
theme.red = "#ff2c4b" -- taffy
theme.aqua = "#8cffba" -- saltwater
theme.blue = "#0a9dff" -- tardis
theme.orange = "#ffa724"
theme.green = "#aeee00" -- lime
theme.pink = "#ff9eb8" -- dress
theme.brown = "#b88853" -- toffee
theme.other_brown = "#c7915b" -- coffee
theme.dark_brown = "#88633f" -- darkroast
-- }}

-- {{ Generic colors
theme.black = theme.coal
theme.nearblack = theme.blackestgravel
theme.gray = theme.mediumgravel
-- }}

-- {{ Default Colors
theme.bg_normal = theme.black
theme.bg_focus = theme.darkgravel
theme.bg_urgent = theme.orange
theme.bg_minimize = theme.darkgravel
theme.bg_systray = theme.bg_normal

theme.fg_normal = theme.lightgravel
theme.fg_focus = theme.green
theme.fg_urgent = theme.black
theme.fg_minimize = theme.white
-- }}

-- Horizontal fill color
theme.hfill_bg_color = theme.nearblack

-- {{ Textclock
theme.clock_bg_color = theme.darkgravel
theme.date_fg_color = theme.dirty_yellow
theme.time_fg_color = theme.pink
-- }}

-- {{ Net widget
theme.nonet_fg_color = theme.red
theme.netface_fg_color = theme.blue
theme.netrate_fg_color = theme.lightgravel
theme.net_bg_color = theme.darkgravel
-- }}

-- {{ Fs widgets
theme.fs_dir_fg_color = theme.orange
theme.fs_fg_color = theme.lightgravel
theme.fs_bg_color = theme.darkgravel
-- }}

-- {{ APW
theme.apw_bg_color = theme.nearblack
theme.apw_fg_color = theme.darkgravel
theme.apw_text_color = theme.aqua
-- }}

-- {{ Borders
theme.border_width = "0"
theme.border_normal = theme.nearblack
theme.border_focus = theme.gray
theme.border_marked = theme.white
-- }}

-- {{ Display the taglist squares
theme.taglist_squares_sel = "taglist/square_bottom.png"
theme.taglist_squares_sel   = theme_dir .. "taglist/square_bottom_sel.png"
theme.taglist_squares_unsel = theme_dir .. "taglist/square_bottom_unsel.png"
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

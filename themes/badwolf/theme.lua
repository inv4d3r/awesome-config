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
--theme.tasklist_sticky = "[S]"
--theme.tasklist_floating = "[F]"
--theme.tasklist_maximized_horizontal = "[H]"
--theme.tasklist_maximized_vertical = "[V]"
--theme.tasklist_maximized = "[M]"
theme.tasklist_disable_icon = true
theme.tasklist_align = "center"
theme.tasklist_plain_task_name = true
theme.useless_gap = 2
theme.gap_single_client = false
-- }}

-- {{ Badwolf colors
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
theme.white = "#ffffff"
theme.black = theme.blackestgravel
theme.nearblack = theme.blackgravel
theme.gray = theme.mediumgravel
-- }}

-- {{ Default Colors
theme.bg_normal = theme.darkgravel
theme.bg_focus = theme.deepgravel
theme.bg_urgent = theme.orange
theme.bg_minimize = theme.darkgravel
theme.bg_systray = theme.bg_normal

theme.fg_normal = theme.brightgravel
theme.fg_focus = theme.dirty_yellow
theme.fg_urgent = theme.orange
theme.fg_minimize = theme.mediumgravel
-- }}

-- Horizontal fill color
theme.hfill_bg_color = theme.blackestgravel

-- {{ Textclock
theme.clock_bg_color = theme.darkgravel
theme.date_fg_color = theme.blue
theme.time_fg_color = theme.green
-- }}

-- {{ Net widget
theme.nonet_fg_color = theme.red
theme.netface_fg_color = theme.other_brown
theme.netrate_fg_color = theme.dirty_yellow
theme.net_bg_color = theme.darkgravel
-- }}

-- {{ Fs widgets
theme.fs_dir_fg_color = theme.pink
theme.fs_fg_color = theme.brightgravel
theme.fs_bg_color = theme.deepergravel
-- }}

-- {{ APW
theme.apw_bg_color = theme.darkgravel
theme.apw_fg_color = theme.deepergravel
theme.apw_show_text = true
theme.apw_text_color = theme.yellow
theme.apw_text_weight = 'bold'
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

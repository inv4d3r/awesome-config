---------------------------
-- Dracula awesome theme --
---------------------------

local awful = require("awful")
awful.util = require("awful.util")

-- {{ Initialization
home = os.getenv("HOME")
config_dir = awful.util.get_configuration_dir()
theme_dir = config_dir .. "/themes/dracula/"
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

-- {{ Dracula colors
theme.realblack = "#000000"
theme.black = "#282a36"
theme.nearblack = "#44475a"
theme.white = "#f8f8f2"
theme.gray = "#6272a4"
theme.cyan = "#8be9fd"
theme.green = "#50fa7b"
theme.orange = "#ffb86c"
theme.pink = "#ff79c6"
theme.purple = "#bd93f9"
theme.red = "#ff5555"
theme.yellow = "#f1fa8c"
-- }}

-- {{ Default Colors
theme.bg_normal = theme.black
theme.bg_focus = theme.nearblack
theme.bg_urgent = theme.orange
theme.bg_minimize = theme.nearblack
theme.bg_systray = theme.bg_normal

theme.fg_normal = theme.white
theme.fg_focus = theme.white
theme.fg_urgent = theme.white
theme.fg_minimize = theme.white
-- }}

-- Horizontal fill color
theme.hfill_bg_color = theme.realblack

-- {{ APW
theme.apw_bg_color = theme.black
theme.apw_fg_color = theme.nearblack
theme.apw_show_text = true
theme.apw_text_color = theme.green
theme.apw_text_weight = "bold"
-- }}

-- {{ Battery
theme.bat_charging = theme.fg_normal
theme.bat_not_charging = theme.yellow
theme.bat_low = theme.red
theme.bat_medium = theme.cyan
theme.bat_high = theme.green
-- }}

-- {{ Textclock
theme.clock_bg_color = theme.black
theme.date_fg_color = theme.yellow
theme.time_fg_color = theme.pink
-- }}

-- {{ Net widget
theme.nonet_fg_color = theme.red
theme.netface_fg_color = theme.white
theme.netrate_fg_color = theme.cyan
theme.net_bg_color = theme.black
-- }}

-- {{ Fs widgets
theme.fs_dir_fg_color = theme.white
theme.fs_fg_color = theme.purple
theme.fs_bg_color = theme.black
-- }}

-- {{ Borders
theme.border_width = "0"
theme.border_normal = theme.nearblack
theme.border_focus = theme.gray
theme.border_marked = theme.white
-- {{

-- {{ Display the taglist squares
theme.taglist_squares_sel =   theme_dir .. "taglist/square_bottom_sel.png"
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

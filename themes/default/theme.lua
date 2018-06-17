---------------------------
-- Default awesome theme --
---------------------------

local awful = require("awful")
awful.util = require("awful.util")

-- {{ Initialization
home = os.getenv("HOME")
config_dir = awful.util.get_configuration_dir()
theme_dir = config_dir .. "/themes/default/"
theme = {}
-- }}

-- {{ Exportable fs variables
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
theme.useless_gap = 2
theme.gap_single_client = false
-- }}

-- {{ Deep-space
theme.deepspace_gray1  = "#1b202a"
theme.deepspace_gray2  = "#232936"
theme.deepspace_gray3  = "#323c4d"
theme.deepspace_gray4  = "#51617d"
theme.deepspace_gray5  = "#9aa7bd"
theme.deepspace_red    = "#b15e7c"
theme.deepspace_green  = "#709d6c"
theme.deepspace_yellow = "#b5a262"
theme.deepspace_blue   = "#608cc3"
theme.deepspace_purple = "#8f72bf"
theme.deepspace_cyan   = "#56adb7"
theme.deepspace_orange = "#b3785d"
theme.deepspace_pink   = "#c47ebd"
-- }}

-- {{ Default Colors
theme.bg_normal = theme.deepspace_gray2
theme.bg_focus = theme.deepspace_gray3
theme.bg_urgent = theme.deepspace_orange
theme.bg_minimize = theme.deepspace_gray1
theme.bg_systray = theme.bg_normal

theme.fg_normal = theme.deepspace_gray4
theme.fg_focus = theme.deepspace_gray5
theme.fg_urgent = theme.deepspace_gray1
theme.fg_minimize = theme.deepspace_gray5
-- }}

-- {{ APW
theme.apw_bg_color = theme.deepspace_gray2
theme.apw_fg_color = theme.deepspace_gray3
theme.apw_show_text = true
theme.apw_text_color = theme.deepspace_cyan
theme.apw_text_weight = "bold"
-- }}

-- {{ Textclock
theme.clock_bg_color = theme.deepspace_gray1
theme.date_fg_color = theme.deepspace_pink
theme.time_fg_color = theme.deepspace_yellow
-- }}

-- {{ Net widget
theme.nonet_fg_color = theme.deepspace_red
theme.netface_fg_color = theme.deepspace_green
theme.netrate_fg_color = theme.deepspace_gray5
theme.net_bg_color = theme.deepspace_gray2
-- }}

-- {{ Fs widgets
theme.fs_dir_fg_color = theme.deepspace_gray5
theme.fs_fg_color = theme.deepspace_gray4
theme.fs_bg_color = theme.deepspace_gray1
-- }}

-- {{ Borders
theme.border_width = "0"
theme.border_normal = theme.deepspace_gray1
theme.border_focus = theme.deepspace_gray3
theme.border_marked = theme.deepspace_gray5
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

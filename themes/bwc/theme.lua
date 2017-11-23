---------------------------
-- Badwolf awesome theme --
---------------------------

theme = {}

theme.font = "Inconsolata 10"

-- Exportable fs variables
theme.wallpaper = "~/pictures/wallpapers/tardis_doors.jpg"
theme.awesome_icon = "~/.config/awesome/themes/bwc/awesome_icon.png"

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

-- Badwolf
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

--// Generic colors
theme.black = theme.coal
theme.nearblack = theme.blackestgravel
theme.gray = theme.mediumgravel

--// Default Colors
theme.bg_normal = theme.black
theme.bg_focus = theme.darkgravel
theme.bg_urgent = theme.orange
theme.bg_minimize = theme.darkgravel
theme.bg_systray = theme.bg_normal

theme.fg_normal = theme.lightgravel
theme.fg_focus = theme.green
theme.fg_urgent = theme.black
theme.fg_minimize = theme.white

theme.hfill_bg_color = theme.nearblack

-- {{{ Textclock
theme.clock_bg_color = theme.darkgravel
theme.date_fg_color = theme.lightgravel
theme.time_fg_color = theme.pink
-- }}

-- {{{ Net widget
theme.nonet_fg_color = theme.red
theme.netface_fg_color = theme.blue
theme.netrate_fg_color = theme.lightgravel
theme.net_bg_color = theme.darkgravel
-- }}

-- {{{ Fs widgets
theme.fs_dir_fg_color = theme.orange
theme.fs_fg_color = theme.lightgravel
theme.fs_bg_color = theme.darkgravel
-- }}

-- {{{

-- {{{ APW
theme.apw_bg_color = theme.nearblack
theme.apw_fg_color = theme.darkgravel
theme.apw_text_color = theme.yellow
-- }}}

--// Borders
theme.border_width = "0"
theme.border_normal = theme.nearblack
theme.border_focus = theme.gray
theme.border_marked = theme.white

-- Display the taglist squares
--theme.taglist_squares_sel = "taglist/square_bottom.png"
theme.taglist_squares_sel = "taglist/square_bottom_sel.png"
theme.taglist_squares_unsel = "taglist/square_bottom_unsel.png"

---- Custom layouts
theme.layout_tile       = "layouts/tile.png"
theme.layout_tileleft   = "layouts/tileleft.png"
theme.layout_tilebottom = "layouts/tilebottom.png"
theme.layout_tiletop    = "layouts/tiletop.png"
theme.layout_fairv      = "layouts/fairv.png"
theme.layout_fairh      = "layouts/fairh.png"
theme.layout_spiral     = "layouts/spiral.png"
theme.layout_dwindle    = "layouts/dwindle.png"
theme.layout_max        = "layouts/max.png"
theme.layout_fullscreen = "layouts/fullscreen.png"
theme.layout_magnifier  = "layouts/magnifier.png"
theme.layout_floating   = "layouts/floating.png"

theme.icon_theme = nil

return theme

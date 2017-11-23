---------------------------
-- Gruvbox awesome theme --
---------------------------

theme = {}

theme.font = "Inconsolata 10"

-- Exportable fs variables
theme.wallpaper = "~/pictures/wallpapers/necromancer.jpg"
theme.awesome_icon = "~/.config/awesome/themes/gruvbox/awesome_icon.png"

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

-- Gruvbox colors
theme.bg0_h = "#1d2021"
theme.bg0_s = "#32302f"
theme.bg0 = "#282828"
theme.bg1 = "#3c3836"
theme.bg2 = "#504945"
theme.bg3 = "#665c54"
theme.bg4 = "#7c6f64"

theme.red = "#fb4934"
theme.green = "#b8bb26"
theme.yellow = "#fabd2f"
theme.blue = "#83a598"
theme.purple = "#d3869b"
theme.aqua = "#8ec07c"
theme.aqua_dark = "#689d6a"
theme.gray = "#a89984"
theme.orange = "#fe8019"
theme.white = "#fbf1c7"

--// Default Colors
theme.bg_normal = theme.bg0
theme.bg_focus = theme.bg1
theme.bg_urgent = theme.orange
theme.bg_minimize = theme.bg3
theme.bg_systray = theme.bg0

theme.fg_normal = theme.white
theme.fg_focus = theme.white
theme.fg_urgent = theme.bg0
theme.fg_minimize = theme.white

theme.hfill_bg_color = theme.bg0_h

--// APW
theme.apw_bg_color = theme.bg0_h
theme.apw_fg_color = theme.bg1
theme.apw_text_color = theme.aqua

-- {{{ Textclock
theme.clock_bg_color = theme.bg0
theme.date_fg_color = theme.gray
theme.time_fg_color = theme.aqua
-- }}

-- {{{ Net widget
theme.nonet_fg_color = theme.red
theme.netface_fg_color = theme.white
theme.netrate_fg_color = theme.gray
theme.net_bg_color = theme.bg0
-- }}

-- {{{ Fs widgets
theme.fs_dir_fg_color = theme.white
theme.fs_fg_color = theme.gray
theme.fs_bg_color = theme.bg0
-- }}

-- {{{

--// Borders
theme.border_width = "0"
theme.border_normal = theme.bg0_h
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

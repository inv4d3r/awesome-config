---------------------------
-- Default awesome theme --
---------------------------

theme = {}

theme.font = "Gros 6"
themedir = "~/.config/awesome/themes"

--// Wallpaper
theme.wallpaper = "~/.config/awesome/walls/archsome_min_gray.jpg"

--// Custom icons
theme.volume_icon = "~/.config/awesome/icons/color/volume.png"
theme.netdown_icon = "~/.config/awesome/icons/color/netdown.png"
theme.netup_icon = "~/.config/awesome/icons/color/netup.png"
theme.inbox_icon = "~/.config/awesome/icons/color/mail.png"
theme.bat_icon = "~/.config/awesome/icons/color/bat.png"
theme.windows_icon = "~/.config/awesome/icons/color/windows.png"
theme.tux_icon = "~/.config/awesome/icons/color/tux.png"

--// Custom Colors
theme.fg_green = "#80a673"
theme.fg_white = "#eeeeee"
theme.fg_black = "#111111"
theme.fg_nearblack = "#222222"
theme.fg_darkgray = "#444444"
theme.fg_lightgray = "#888888"

--// Default Colors
theme.bg_normal = theme.fg_nearblack
theme.bg_focus  = theme.fg_black
theme.bg_urgent = "#ffc0c0"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal

theme.fg_normal = "#808080"
theme.fg_focus  = theme.fg_white
theme.fg_urgent = "#000000"
theme.fg_minimize   = "#ffffff"

--// Borders
theme.border_width  = "1"
theme.border_normal = "#ffffff"
theme.border_focus  = theme.fg_focus
theme.border_marked = "#ffffff"

--// Titlebars
theme.titlebar_fg_normal = "#808080"
theme.titlebar_fg_focus	= "#ffffff"
theme.titlebar_bg_normal = "#363636ff"
theme.titlebar_bg_focus	= "#000000ff"
theme.titlebar_font = theme.font

-- Display the taglist squares
theme.taglist_squares_sel = "/home/invader/.config/awesome/themes/taglist/squaref_i.png"
theme.taglist_squares_unsel = "/home/invader/.config/awesome/themes/taglist/square_i.png"
---- Custom layouts
theme.layout_tile       = "/home/invader/.config/awesome/themes/layouts/tile.png"
theme.layout_tileleft   = "/home/invader/.config/awesome/themes/layouts/tileleft.png"
theme.layout_tilebottom = "/home/invader/.config/awesome/themes/layouts/tilebottom.png"
theme.layout_tiletop    = "/home/invader/.config/awesome/themes/layouts/tiletop.png"
theme.layout_fairv      = "/home/invader/.config/awesome/themes/layouts/fairv.png"
theme.layout_fairh      = "/home/invader/.config/awesome/themes/layouts/fairh.png"
theme.layout_spiral     = "/home/invader/.config/awesome/themes/layouts/spiral.png"
theme.layout_dwindle    = "/home/invader/.config/awesome/themes/layouts/dwindle.png"
theme.layout_max        = "/home/invader/.config/awesome/themes/layouts/max.png"
theme.layout_fullscreen = "/home/invader/.config/awesome/themes/layouts/fullscreen.png"
theme.layout_magnifier  = "/home/invader/.config/awesome/themes/layouts/magnifier.png"
theme.layout_floating   = "/home/invader/.config/awesome/themes/layouts/floating.png"

theme.icon_theme = nil

return theme

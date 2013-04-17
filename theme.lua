---------------------------
-- Default awesome theme --
---------------------------

theme = {}

theme.font = "Gros 6"
themedir = "~/.config/awesome/themes"

--// Wallpaper
theme.wallpaper = "~/.config/awesome/arch_min_gray.jpg"

--// Custom icons
theme.volume_icon = "~/.config/awesome/icons/gray/volume.png"
theme.netdown_icon = "~/.config/awesome/icons/gray/netdown.png"
theme.netup_icon = "~/.config/awesome/icons/gray/netup.png"
theme.inbox_icon = "~/.config/awesome/icons/gray/mail.png"
theme.bat_icon = "~/.config/awesome/icons/gray/bat.png"

--// Custom Colors
theme.fg_green = "#80a673"
theme.fg_white = "#ffffff"
theme.fg_black = "#000000"

--// Default Colors
theme.bg_normal = "#202020"
theme.bg_focus  = "#0f0f0f"
theme.bg_urgent = "#ffc0c0"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal

theme.fg_normal = "#808080"
theme.fg_focus  = "#ffffff"
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
theme.taglist_squares_sel = "/home/invader/.config/awesome/squaref_b.png"
theme.taglist_squares_unsel = "/home/invader/.config/awesome/square_b.png"

-- You can use your own layout icons like this:
theme.layout_tile       = "/usr/share/awesome/themes/zenburn/layouts/tile.png"
theme.layout_tileleft   = "/usr/share/awesome/themes/zenburn/layouts/tileleft.png"
theme.layout_tilebottom = "/usr/share/awesome/themes/zenburn/layouts/tilebottom.png"
theme.layout_tiletop    = "/usr/share/awesome/themes/zenburn/layouts/tiletop.png"
theme.layout_fairv      = "/usr/share/awesome/themes/zenburn/layouts/fairv.png"
theme.layout_fairh      = "/usr/share/awesome/themes/zenburn/layouts/fairh.png"
theme.layout_spiral     = "/usr/share/awesome/themes/zenburn/layouts/spiral.png"
theme.layout_dwindle    = "/usr/share/awesome/themes/zenburn/layouts/dwindle.png"
theme.layout_max        = "/usr/share/awesome/themes/zenburn/layouts/max.png"
theme.layout_fullscreen = "/usr/share/awesome/themes/zenburn/layouts/fullscreen.png"
theme.layout_magnifier  = "/usr/share/awesome/themes/zenburn/layouts/magnifier.png"
theme.layout_floating   = "/usr/share/awesome/themes/zenburn/layouts/floating.png"

-- theme.awesome_icon = "/home/invader/.config/awesome/awesome-icon.png"

-- Define the icon theme for application icons. If not set then the icons 
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

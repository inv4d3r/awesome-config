---------------------------
-- Default awesome theme --
---------------------------

theme = {}

theme.font = "DejaVuMonoSans for Powerline 7"
themedir = "~/.config/awesome/themes"

--// Custom icons
-- Left layout
theme.web = "~/.config/awesome/icons/color/cloud.png"
theme.mail = "~/.config/awesome/icons/color/email_icon.png"
theme.im = "~/.config/awesome/icons/color/community.png"
theme.music = "~/.config/awesome/icons/color/music.png"
theme.devel = "~/.config/awesome/icons/color/hammer.png"
theme.system = "~/.config/awesome/icons/color/gear.png"
theme.porn = "~/.config/awesome/icons/color/porn.png"
theme.misc = "~/.config/awesome/icons/color/rbpi.png"

theme.tasklist_sticky = " S "
theme.tasklist_floating = " F "
theme.tasklist_maximized_horizontal = " H "
theme.tasklist_maximized_vertical = " V "
theme.tasklist_disable_icon = true

--// Custom Colors
theme.fg_green = "#80a673"
theme.fg_white = "#eeeeee"
theme.fg_black = "#000000"
theme.fg_nearblack = "#111111"
theme.fg_darkgray = "#444444"
theme.fg_lightgray = "#888888"
theme.fg_solarized = "#2D7067"
theme.fg_jellybean_green = "#99ad6a" 
theme.fg_jellybean_orange = "#ff9500"
theme.fg_jellybean_grey = "#393939" -- grey
theme.fg_jellybean_red = "#cf6a4c"  -- red
theme.fg_jellybean_green = "#96ad6a" -- green
theme.fg_jellybean_yellow = "#d8ad4c"  -- yellow 
theme.fg_jellybean_blue = "#597bc5" -- blue 
theme.fg_jellybean_purple = "#a037b0" -- purple 
theme.fg_jellybean_turqoise = "#6eb5f3" -- light_blue
theme.fg_jellybean_white = "#adadad" -- white
theme.fg_red = "#a90000"
theme.fg_highlight = theme.fg_jellybean_green
theme.fg_turtlegreen = "#8cffba"

--// Default Colors
theme.bg_normal = theme.fg_nearblack
theme.bg_focus  = theme.fg_black
theme.bg_urgent = theme.fg_jellybean_orange
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal

theme.fg_normal = "#808080"
theme.fg_focus  = theme.fg_turtlegreen
theme.fg_urgent = "#000000"
theme.fg_minimize   = "#ffffff"

--// Borders
theme.border_width  = "1"
theme.border_normal = theme.fg_nearblack
theme.border_focus  = theme.fg_jellybean_grey
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
theme.layout_treesome   = "/home/invader/.config/awesome/themes/layouts/treesome.png"

theme.icon_theme = nil

return theme

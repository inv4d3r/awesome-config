---------------------------
-- Default awesome theme --
---------------------------

theme = {}

theme.font = "ProggyCleanTT 10"
themedir = "~/.config/awesome/themes"

theme.wallpaper = "~/wallpapers/arch_simplegray.jpg"

--theme.tasklist_sticky = " S "
--theme.tasklist_floating = " F "
--theme.tasklist_maximized_horizontal = " H "
--theme.tasklist_maximized_vertical = " V "
--theme.tasklist_maximized = " M "
theme.tasklist_disable_icon = true
theme.tasklist_align = "center"
theme.tasklist_plain_task_name = true
theme.awesome_icon = "~/.config/awesome/awesome32_gray.png"
theme.useless_gap = 5
theme.gap_single_client = false

--// Custom Colors
theme.fg_white = "#eeeeee"
theme.fg_black = "#000000"
theme.fg_red = "#a90000"
theme.fg_highlight = theme.fg_jellybean_green
theme.fg_turtlegreen = "#8cffba"
theme.fg_skyblue = "#0aa6f5"
theme.fg_nearblack = "#111111"
theme.fg_darkgray = "#444444"
theme.fg_lightgray = "#888888"

-- Jellybean
theme.fg_jellybean_green = "#99ad6a" 
theme.fg_jellybean_orange = "#ff9500"
theme.fg_jellybean_gray = "#393939" -- gray
theme.fg_jellybean_red = "#cf6a4c"  -- red
theme.fg_jellybean_green = "#96ad6a" -- green
theme.fg_jellybean_yellow = "#d8ad4c"  -- yellow 
theme.fg_jellybean_blue = "#597bc5" -- blue 
theme.fg_jellybean_purple = "#a037b0" -- purple 
theme.fg_jellybean_aqua = "#6eb5f3" -- light_blue
theme.fg_jellybean_white = "#adadad" -- white

-- Badwolf
theme.fg_bwc_dalespale = "#fade3e" -- yellow
theme.fg_bwc_dirtyblonde = "#f4cf86" -- dirty yellow
theme.fg_bwc_taffy = "#ff2c4b" -- red
theme.fg_bwc_saltwatertaffy = "#8cffba" -- aqua
theme.fg_bwc_tardis = "#0a9dff" -- blue
theme.fg_bwc_orange = "#ffa724" 
theme.fg_bwc_lime = "#aeee00" -- green
theme.fg_bwc_dress = "#ff9eb8" -- pink
theme.fg_bwc_toffee = "#b88853" -- brown
theme.fg_bwc_coffee = "#c7915b" -- brown
theme.fg_bwc_darkroast = "#88633f" -- dimmed brown

-- Gruvbox
theme.fg_gruvbox_red = "#fb4934"
theme.fg_gruvbox_green = "#b8bb26"
theme.fg_gruvbox_yellow = "#fabd2f"
theme.fg_gruvbox_blue = "#83a598"
theme.fg_gruvbox_purple = "#d3869b"
theme.fg_gruvbox_aqua = "#8ec07c"
theme.fg_gruvbox_gray = "#a89984"
theme.fg_gruvbox_orange = "#fe8019"
theme.fg_gruvbox_white = "#fbf1c7"

--// Default Colors
theme.bg_normal = theme.fg_black
theme.bg_focus  = theme.fg_darkgray
theme.bg_urgent = theme.fg_jellybean_orange
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal

theme.fg_normal = "#808080"
theme.fg_focus  = theme.fg_white
theme.fg_urgent = "#000000"
theme.fg_minimize   = "#ffffff"

--// Borders
theme.border_width  = "0"
theme.border_normal = theme.fg_nearblack
theme.border_focus  = theme.fg_jellybean_gray
theme.border_marked = "#ffffff"

--// Titlebars
theme.titlebar_fg_normal = "#808080"
theme.titlebar_fg_focus	= "#ffffff"
theme.titlebar_bg_normal = "#363636ff"
theme.titlebar_bg_focus	= "#000000ff"
theme.titlebar_font = theme.font

-- Display the taglist squares
theme.taglist_squares_sel = "/home/mzalewsk/.config/awesome/themes/taglist/square_bottom.png"
theme.taglist_squares_unsel = "/home/mzalewsk/.config/awesome/themes/taglist/square_bottom_gray.png"

---- Custom layouts
theme.layout_tile       = "/home/mzalewsk/.config/awesome/themes/layouts/tile.png"
theme.layout_tileleft   = "/home/mzalewsk/.config/awesome/themes/layouts/tileleft.png"
theme.layout_tilebottom = "/home/mzalewsk/.config/awesome/themes/layouts/tilebottom.png"
theme.layout_tiletop    = "/home/mzalewsk/.config/awesome/themes/layouts/tiletop.png"
theme.layout_fairv      = "/home/mzalewsk/.config/awesome/themes/layouts/fairv.png"
theme.layout_fairh      = "/home/mzalewsk/.config/awesome/themes/layouts/fairh.png"
theme.layout_spiral     = "/home/mzalewsk/.config/awesome/themes/layouts/spiral.png"
theme.layout_dwindle    = "/home/mzalewsk/.config/awesome/themes/layouts/dwindle.png"
theme.layout_max        = "/home/mzalewsk/.config/awesome/themes/layouts/max.png"
theme.layout_fullscreen = "/home/mzalewsk/.config/awesome/themes/layouts/fullscreen.png"
theme.layout_magnifier  = "/home/mzalewsk/.config/awesome/themes/layouts/magnifier.png"
theme.layout_floating   = "/home/mzalewsk/.config/awesome/themes/layouts/floating.png"
theme.layout_treesome   = "/home/mzalewsk/.config/awesome/themes/layouts/treesome.png"

theme.icon_theme = nil

return theme

---------------------------
-- Default awesome theme --
---------------------------

theme = {}

theme.font = "Inconsolata 10"

-- Exportable fs variables
theme.wallpaper = "~/pictures/wallpapers/necromancer.jpg"
theme.awesome_icon = "~/.config/awesome/themes/default/awesome_icon.png"

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

--// Custom Colors
theme.fg_highlight = theme.jellybean_green
theme.white = "#eeeeee"
theme.black = "#000000"
theme.red = "#a90000"
theme.skyblue = "#0aa6f5"
theme.nearblack = "#111111"
theme.darkgray = "#444444"
theme.lightgray = "#888888"

-- Jellybean
theme.jellybean_green = "#99ad6a" 
theme.jellybean_orange = "#ff9500"
theme.jellybean_gray = "#393939" -- gray
theme.jellybean_red = "#cf6a4c"  -- red
theme.jellybean_green = "#96ad6a" -- green
theme.jellybean_yellow = "#d8ad4c"  -- yellow 
theme.jellybean_blue = "#597bc5" -- blue 
theme.jellybean_purple = "#a037b0" -- purple 
theme.jellybean_aqua = "#6eb5f3" -- light_blue
theme.jellybean_white = "#adadad" -- white

-- Badwolf
theme.bwc_dalespale = "#fade3e" -- yellow
theme.bwc_dirtyblonde = "#f4cf86" -- dirty yellow
theme.bwc_taffy = "#ff2c4b" -- red
theme.bwc_saltwatertaffy = "#8cffba" -- aqua
theme.bwc_tardis = "#0a9dff" -- blue
theme.bwc_orange = "#ffa724" 
theme.bwc_lime = "#aeee00" -- green
theme.bwc_dress = "#ff9eb8" -- pink
theme.bwc_toffee = "#b88853" -- brown
theme.bwc_coffee = "#c7915b" -- brown
theme.bwc_darkroast = "#88633f" -- dimmed brown

-- Gruvbox
theme.gruvbox_aqua_dark = "#689d6a"

theme.gruvbox_red = "#fb4934"
theme.gruvbox_green = "#b8bb26"
theme.gruvbox_yellow = "#fabd2f"
theme.gruvbox_blue = "#83a598"
theme.gruvbox_purple = "#d3869b"
theme.gruvbox_aqua = "#8ec07c"
theme.gruvbox_gray = "#a89984"
theme.gruvbox_orange = "#fe8019"
theme.gruvbox_white = "#fbf1c7"
theme.gruvbox_bg0_h = "#1d2021"
theme.gruvbox_bg0_s = "#32302f"
theme.gruvbox_bg0 = "#282828"
theme.gruvbox_bg1 = "#3c3836"
theme.gruvbox_bg2 = "#504945"
theme.gruvbox_bg3 = "#665c54"
theme.gruvbox_bg4 = "#7c6f64"

--theme.mint = "#98ff98"
--theme.mint = "#c5e3bf"
theme.mint = "#b4d7bf"

--// Default Colors
theme.bg_normal = theme.black
theme.bg_focus = theme.darkgray
theme.bg_urgent = theme.jellybean_orange
theme.bg_minimize = "#444444"
theme.bg_systray = theme.bg_normal

theme.fg_normal = "#808080"
theme.fg_focus = theme.white
theme.fg_urgent = theme.black
theme.fg_minimize = theme.white

--// APW
theme.apw_bg_color = theme.gruvbox_bg0_h
theme.apw_fg_color = theme.gruvbox_bg1
theme.apw_text_color = theme.gruvbox_aqua

--// Borders
theme.border_width = "0"
theme.border_normal = theme.nearblack
theme.border_focus = theme.jellybean_gray
theme.border_marked = theme.white

--// Titlebars
theme.titlebar_fg_normal = "#808080"
theme.titlebar_fg_focus	= theme.white
theme.titlebar_bg_normal = "#363636ff"
theme.titlebar_bg_focus	= theme.black
theme.titlebar_font = theme.font

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
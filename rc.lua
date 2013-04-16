------------------------------------------------
--            Awesome 3.5 rc.lua              --    
--                by Invader                  --
------------------------------------------------


-- Standard awesome library
local vicious = require("vicious")
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
gears.wallpaper.centered(beautiful.wallpaper, nil, "")
-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- My definitions
local io = { popen = io.popen }

local function getIP(interface)
    if not interface then return end
    local f = io.popen("ip addr list "..interface .. " |grep 'inet ' |cut -d' ' -f6|cut -d/ -f1")
    local ip = f:read("*line")
    f:close()
    if ip then
      return ip
    else
      return 'no address'
    end
end

local function displaytransfer_rate(rate_kb)
  rate = tonumber(rate_kb)
  if rate > 1000 then return rate/1000 .. " mb"
  else return rate_kb .. " kb" end
end

local function colorify(text, color)
  return "<span color='" .. color .. "'>" .. text .. "</span>"
end

-- set the desired pixel coordinates:
--  if your screen is 1024x768 the this line sets the bottom right.
local safeCoords = {x=1280, y=800}
-- Flag to tell Awesome whether to do this at startup.
local moveMouseOnStartup = true

-- Simple function to move the mouse to the coordinates set above.
local function moveMouse(x_co, y_co)
    mouse.coords({ x=x_co, y=y_co })
end

-- Bind ''Meta4+Ctrl+m'' to move the mouse to the coordinates set above.
--   this is useful if you needed the mouse for something and now want it out of the way

-- Optionally move the mouse when rc.lua is read (startup)
if moveMouseOnStartup then
        moveMouse(safeCoords.x, safeCoords.y)
end

-- {{{ Variable definitions
-- Custom useful vars
configdir = "/home/invader/.config/awesome/"

-- Themes define colours, icons, and wallpapers
beautiful.init("/home/invader/.config/awesome/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}
-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
tagnames = {" web ", " im ", " music ", " work ", " system ", " porn ", " raspberry ", nil }
mylayouts = { layouts[1], layouts[2], layouts[8], layouts[2], layouts[2], layouts[12], layouts[2] }
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag(tagnames, s, mylayouts)
    
    -- Tag icons
    awful.tag.seticon(configdir .. "icons/color/firefox.png", tags[s][1])
    awful.tag.seticon(configdir .. "icons/color/IM.png", tags[s][2])
    awful.tag.seticon(configdir .. "icons/color/music.png", tags[s][3])
    awful.tag.seticon(configdir .. "icons/color/code.png", tags[s][4])
    awful.tag.seticon(configdir .. "icons/color/gear.png", tags[s][5])
    awful.tag.seticon(configdir .. "icons/color/porn.png", tags[s][6])
    awful.tag.seticon(configdir .. "icons/color/rbpi.png", tags[s][7])
    
  --awful.tag.seticon(configdir .. "icons/gray/firefox.png", tags[s][1])
  --awful.tag.seticon(configdir .. "icons/gray/IM.png", tags[s][2])
  --awful.tag.seticon(configdir .. "icons/gray/music.png", tags[s][3])
  --awful.tag.seticon(configdir .. "icons/gray/code.png", tags[s][4])
  --awful.tag.seticon(configdir .. "icons/gray/gear.png", tags[s][5])
  --awful.tag.seticon(configdir .. "icons/gray/porn.png", tags[s][6])
  --awful.tag.seticon(configdir .. "icons/gray/rbpi.png", tags[s][7])
--    awful.tag.seticon("/home/invader/rbpi_light.png", tags[s][6])
end
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock(" %a %d %b %y, %I:%M %p ")

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytasklist = {}
mystatusbar = {}
for s = 1, screen.count() do

    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()

    -- Create a layoutbox
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))

    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create spacer widget
    spacer = wibox.widget.textbox()
    spacer:set_markup(colorify(" | ", beautiful.fg_green))

    -- Create volume widget
    volume_widget = wibox.widget.textbox()
    vicious.register(volume_widget, vicious.widgets.volume, " $1% ", 1, "Master")
    volume_icon = wibox.widget.imagebox()
    volume_icon:set_image(beautiful.volume_icon)

    -- Create the top wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s, border_width = 2 })
    
    -- Create mail widget
    mail_widget = wibox.widget.textbox()
    vicious.register(mail_widget, vicious.widgets.gmail, 
      function(widget, args)
        return " " .. args["{count}"] .. " "
      end, 120)
    mail_icon = wibox.widget.imagebox()
    mail_icon:set_image(beautiful.inbox_icon)

    -- Create battery widget
    bat_widget = wibox.widget.textbox()
    vicious.register(bat_widget, vicious.widgets.bat,
      function(widget, args)
        if args[3] == "N/A" then
          return ""
        else
          return " " .. args[2] .. "% "
        end
      end, 60, "BAT0")
    bat_icon = wibox.widget.imagebox()
    bat_icon:set_image(beautiful.bat_icon)

    -- Create a net widget
    netdown_icon = wibox.widget.imagebox()
    netdown_icon:set_image(beautiful.netdown_icon)
    netup_icon = wibox.widget.imagebox()
    netup_icon:set_image(beautiful.netup_icon)
    --wifi_info = wibox.widget.textbox()
    --wifi_info:set_markup("wlan0" .. colorify(" [ ", beautiful.fg_green) .. getIP("wlan0") .. colorify(" ] ", beautiful.fg_green))
    wifitransfer_info = wibox.widget.textbox()
    if getIP("wlan0") ~= "no address" then
      vicious.register(wifitransfer_info, vicious.widgets.net, 
        function(widget, args) 
          rate_down = args["{wlan0 down_kb}"] 
          rate_up = args["{wlan0 up_kb}"] 
          return displaytransfer_rate(rate_down) .. "  " .. displaytransfer_rate(rate_up)
        end, 1)
    elseif getIP("eth0") ~= "no address" then
      vicious.register(wifitransfer_info, vicious.widgets.net, 
        function(widget, args) 
          rate_down = args["{eth0 down_kb}"] 
          rate_up = args["{eth0 up_kb}"] 
          return displaytransfer_rate(rate_down) .. "  " .. displaytransfer_rate(rate_up)
        end, 1)
    end

    -- Create a mpd widget
    mpd_widget = wibox.widget.textbox()
    vicious.register(mpd_widget, vicious.widgets.mpd,
      function(widget, args)
        str =  " " .. args["{Title}"] .. colorify(" [ ", beautiful.fg_green) .. args["{Artist}"] .. colorify(" ] ", beautiful.fg_green)

        -- play
        if (args["{state}"] == "Play") then
        return str

        -- pause
        elseif (args["{state}"] == "Pause") then
        return " mpd paused "

        -- stop
        elseif (args["{state}"] == "Stop") then
        return " mpd stopped "

        -- not running
        else
        return " mpd off"
      end

    end, 1)
    mpd_icon = wibox.widget.imagebox()
    mpd_icon:set_image(beautiful.mpd_icon)

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mytaglist[s])
    left_layout:add(spacer)
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    right_layout:add(spacer)
    right_layout:add(netdown_icon)
    right_layout:add(wifitransfer_info)
    right_layout:add(netup_icon)
    right_layout:add(spacer)
    right_layout:add(mail_icon)
    right_layout:add(mail_widget)
    right_layout:add(spacer)
    right_layout:add(mpd_icon)
    right_layout:add(mpd_widget)
    right_layout:add(spacer)
    right_layout:add(volume_icon)
    right_layout:add(volume_widget)
    right_layout:add(spacer)
    if bat_widget.text ~= nil then
      right_layout:add(bat_icon)
      right_layout:add(bat_widget)
      right_layout:add(spacer)
    end
    right_layout:add(mytextclock)
    right_layout:add(mylayoutbox[s])

    -- Now bring it all together
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
        
    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags)
    bottom_left_layout = wibox.layout.fixed.horizontal()
    
    bottom_right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then bottom_right_layout:add(wibox.widget.systray()) end

    local bottom_layout = wibox.layout.align.horizontal()
    bottom_layout:set_left(bottom_left_layout)
    bottom_layout:set_middle(mytasklist[s])
    bottom_layout:set_right(bottom_right_layout)

    -- Create bottom wibox
    mystatusbar[s] = awful.wibox({ position = "bottom", screen = s })
    mystatusbar[s]:set_widget(bottom_layout)    

end
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),
    -- Custom keys
    awful.key({}, "XF86AudioRaiseVolume", function () awful.util.spawn("amixer set Master 2+") end),
    awful.key({}, "XF86AudioLowerVolume", function () awful.util.spawn("amixer set Master 2-") end),
    awful.key({}, "XF86AudioPlay", function () awful.util.spawn("ncmpcpp toggle") end),
    awful.key({}, "XF86AudioStop", function () awful.util.spawn("ncmpcpp stop") end),
    awful.key({}, "XF86AudioNext", function () awful.util.spawn("ncmpcpp next") end),
    awful.key({}, "XF86AudioPrev", function () awful.util.spawn("ncmpcpp prev") end),
    awful.key({}, "Print", function () awful.util.spawn("shutter --select") end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),

    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey, "Shift"   }, ",",
    		function ()
			local tag = awful.tag.gettags(client.focus.screen)
        		local curidx = awful.tag.getidx(awful.tag.selected())
			if client.focus and tag then
			  if curidx == 1 then
			    awful.client.movetotag(tag[#tag])
			  else
			    awful.client.movetotag(tag[curidx - 1])
			  end
			end
        --awful.tag.viewprev()
    end),
    awful.key({ modkey, "Shift"   }, ".",
    		function ()
			local tag = awful.tag.gettags(client.focus.screen)
        		local curidx = awful.tag.getidx(awful.tag.selected())
			if client.focus and tag then
			  if curidx == #tag then
			    awful.client.movetotag(tag[1])
			  else
			    awful.client.movetotag(tag[curidx + 1])
			  end
			end
        --awful.tag.viewprev()
    end),
    awful.key({ modkey, "Control" }, "m",      function() moveMouse(safeCoords.x, safeCoords.y) end),
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      local tag = awful.tag.gettags(client.focus.screen)[i]
                      if client.focus and tag then
                          awful.client.movetotag(tag)
                     end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      local tag = awful.tag.gettags(client.focus.screen)[i]
                      if client.focus and tag then
                          awful.client.toggletag(tag)
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = 0,
                     border_color = beautiful.fg_green,
                     focus = awful.client.focus.filter,
                     size_hints_honor = false,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "URxvt" },
      properties = { border_width = 0 } },    
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
  -- Enable sloppy focus
  c:connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
    and awful.client.focus.filter(c) then
      client.focus = c
    end
  end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
           awful.placement.no_overlap(c)
           awful.placement.no_offscreen(c)
        end
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

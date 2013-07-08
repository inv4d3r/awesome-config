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
local treesome = require("treesome")
--local tyrannical = require("tyrannical")

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

-- {{ My definitions
local function debug(debug_string)
  naughty.notify({ preset = naughty.config.presets.normal,
                   title = nil,
                   text = debug_string,
                   timeout = 5 })
end

local function getvolume()
  local fd = io.popen("amixer sget Master")
  local status = fd:read("*all")
  fd:close()
          
  local volume = tonumber(string.match(status, "(%d?%d?%d)%%"))
  return volume
end
-- Widget utils
local function colorify(text, color)
  return "<span color='" .. color .. "'>" .. text .. "</span>"
end

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
  if rate > 1000 then return string.format("%.1f", rate/1000) .. " mb"
  else return string.format("%.1f", rate_kb) .. " kb" end
end

-- Mouse handling
local safeCoords = {x=0, y=800}
local moveMouseOnStartup = true
local function moveMouse(x_co, y_co)
    mouse.coords({ x=x_co, y=y_co })
end
if moveMouseOnStartup then
        moveMouse(safeCoords.x, safeCoords.y)
end

-- {{{ Variable definitions
configdir = "/home/invader/.config/awesome/"

-- Themes define colours, icons, and wallpapers
beautiful.init("/home/invader/.config/awesome/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
browser = "firefox"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
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
    --awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    --awful.layout.suit.magnifier
    treesome
}
-- }}}

-- {{{ Wallpaper
gears.wallpaper.maximized(beautiful.wallpaper, nil, true)
--gears.wallpaper.centered(beautiful.wallpaper, nil, "")
-- }}}


-- {{{ Tags

tags = {}
tagnames = {" web", " social", " music", " devel", " docs", " porn", nil }
for s = 1, screen.count() do
    tags[s] = awful.tag(tagnames, s, layouts[10])
end
 
-- }}}

-- {{{ Dynamic tags tyranical
--
--tyrannical.tags = { 
  --{
    --name = "web",
    --init = true, -- load the tag on startup
    --exclusive = false, -- refuse any other client classes
    --screen = 1,
    --layout = treesome,
    --class = { "Firefox" }
  --},
  --{
    --name = "im",
    --init = true, -- load the tag on startup
    --exclusive = false, -- refuse any other client classes
    --screen = 1,
    --layout = treesome
    ----class = { "urxvt" }
  --},
  --{
    --name = "mail",
    --init = false, -- load the tag on startup
    --exclusive = false, -- refuse any other client classes
    --screen = 1,
    --layout = treesome,
    --class = { "urxvt" }
  --},
  --{
    --name = "music",
    --init = false, -- load the tag on startup
    --exclusive = false, -- refuse any other client classes
    --screen = 1,
    --layout = treesome,
    --class = { "Spotify" }
  --}
--}

--tyrannical.properties.floating = {
  --"Firefox", "MPlayer"
--}
--tyrannical.settings.group_children = true

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock(" %a %d %b %y, %I:%M %p ")

-- Create a wibox for each screen and add it
mywibox = {}
mylayoutbox = {}
mytaglist = {}
mytasklist = {}
mystatusbar = {}

for s = 1, screen.count() do
    -- Create a layoutbox
    mylayoutbox[s] = awful.widget.layoutbox(s)
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)
    -- Create spacer widget
    spacer = wibox.widget.textbox()
    spacer:set_markup(colorify(" ¦ ", beautiful.fg_darkgray))

    -- Create the top wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s, border_width = 0, border_color = beautiful.fg_nearblack })

    -- Create a net widget
    netdown_icon = wibox.widget.imagebox()
    netup_icon = wibox.widget.imagebox()
    wifitransfer_info = wibox.widget.textbox()
      vicious.register(wifitransfer_info, vicious.widgets.net, 
        function(widget, args) 
          local rate_down, rate_up
          if getIP("wlan0") ~= "no address" then
            rate_down = args["{wlan0 down_kb}"] 
            rate_up = args["{wlan0 up_kb}"] 
          elseif getIP("eth0") ~= "no address" then
            rate_down = args["{eth0 down_kb}"] 
            rate_up = args["{eth0 up_kb}"] 
          else
            return "no network connection"
          end
          return "down " .. colorify(displaytransfer_rate(rate_down), beautiful.fg_highlight) .. "  up " .. colorify(displaytransfer_rate(rate_up), beautiful.fg_highlight)
        end, 1)

    -- Hard drives usage widgets
    windrive_icon = wibox.widget.imagebox()
    windrive_widget = wibox.widget.textbox()
    vicious.register(windrive_widget, vicious.widgets.fs, " windows " .. colorify(" ${/mnt/windows avail_gb} GB ", beautiful.fg_highlight), 10)

    homedrive_icon = wibox.widget.imagebox()
    homedrive_widget = wibox.widget.textbox()
    vicious.register(homedrive_widget, vicious.widgets.fs, " home " .. colorify(" ${/home avail_gb} GB ", beautiful.fg_highlight), 10)

    rootdrive_icon = wibox.widget.imagebox()
    rootdrive_widget = wibox.widget.textbox()
    vicious.register(rootdrive_widget, vicious.widgets.fs, " root " .. colorify(" ${/ avail_gb} GB ", beautiful.fg_highlight), 10)

    -- Mail widget
    mail_widget = wibox.widget.textbox()
    mail_icon = wibox.widget.imagebox()
    vicious.register(mail_widget, vicious.widgets.gmail, 
      function(widget, args)
        return " mail " .. colorify(args["{count}"], beautiful.fg_highlight) .. " "
      end, 120)
    -- Volume widget
    volume_widget = wibox.widget.textbox()
    volume_icon = wibox.widget.imagebox()
    vicious.register(volume_widget, vicious.widgets.volume, 
      function(widget, args)
        if args[1] <= 30 then
          volume_icon:set_image(beautiful.volume_low_icon)
        else if args[1] > 30 and args[1] < 70 then
          volume_icon:set_image(beautiful.volume_mid_icon)
        else 
          volume_icon:set_image(beautiful.volume_high_icon)
        end
      end
        return " vol" .. colorify(" " .. args[1] .. "% ", beautiful.fg_highlight) 
      end, 1, "Master")
    
    -- Battery widget
    no_bat = false
    bat_widget = wibox.widget.textbox()
    vicious.register(bat_widget, vicious.widgets.bat,
      function(widget, args)
        if args[2] == 0 then
          no_bat = true
          return ""
        else
          return " " .. args[2] .. "% "
        end
      end, 60, "BAT0")
    bat_icon = wibox.widget.imagebox()

    -- MPD widget
    -- local mpd_args = { host = "192.168.0.17" } -- raspberry 
    mpd_widget = wibox.widget.textbox()
    vicious.register(mpd_widget, vicious.widgets.mpd,
      function(widget, args)
        str =  " " .. args["{Title}"] .. colorify(" [ ", beautiful.fg_highlight) .. args["{Artist}"] .. colorify(" ] ", beautiful.fg_highlight)

        -- play
        if (args["{state}"] == "Play") then
        return str

        -- pause
        elseif (args["{state}"] == "Pause") then
        return " mpd " .. colorify(" paused ", beautiful.fg_highlight)

        -- stop
        elseif (args["{state}"] == "Stop") then
        return " mpd " .. colorify(" stopped ", beautiful.fg_highlight)

        -- not running
        else
        return " mpd off"
      end

    end, 1)--, mpd_args)

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mytaglist[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    right_layout:add(wifitransfer_info)
    right_layout:add(spacer)
    right_layout:add(rootdrive_widget)
    right_layout:add(spacer)
    right_layout:add(homedrive_widget)
    right_layout:add(spacer)
    right_layout:add(windrive_widget)
    right_layout:add(spacer)
    right_layout:add(mail_widget)
    right_layout:add(spacer)
    right_layout:add(mpd_widget)
    right_layout:add(spacer)
    right_layout:add(volume_widget)
    right_layout:add(spacer)
    if not no_bat then
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
    
    -- Systray widget
    systray = wibox.widget.systray()
    if s == 1 then bottom_right_layout:add(systray) end

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
    awful.key({}, "XF86AudioRaiseVolume", function () 
                                            awful.util.spawn("amixer set Master 10%+") 
                                            --debug("Volume: " .. getvolume() .. "%")
                                          end),
    awful.key({}, "XF86AudioLowerVolume", function () 
                                            awful.util.spawn("amixer set Master 10%-") 
                                            --debug("Volume: " .. getvolume() .. "%")
                                          end),
    awful.key({}, "XF86AudioPlay", function () awful.util.spawn("ncmpcpp toggle") end),
    awful.key({}, "XF86AudioStop", function () awful.util.spawn("ncmpcpp stop") end),
    awful.key({}, "XF86AudioNext", function () awful.util.spawn("ncmpcpp next") end),
    awful.key({}, "XF86AudioPrev", function () awful.util.spawn("ncmpcpp prev") end),
    awful.key({}, "Print", function () awful.util.spawn("shutter --select") end),
    awful.key({ modkey, "Mod1" }, "Left", function() awful.util.spawn("ncmpcpp volume -5") end),
    awful.key({ modkey, "Mod1" }, "Right", function() awful.util.spawn("ncmpcpp volume +5") end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey,           }, "t", function () awful.util.spawn(terminal) end),
    awful.key({ modkey,           }, "b", function () awful.util.spawn(browser) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),
    awful.key({ modkey, "Mod1"    }, "l",     function () awful.util.spawn("slimlock")    end),
    awful.key({ modkey, "Mod1"    }, "r",     function () awful.util.spawn("reboot")    end),
    awful.key({ modkey, "Mod1"    }, "p",     function () awful.util.spawn("poweroff")    end),
    awful.key({ modkey, "Shift"   }, "Left",     function () 
                                                c=client.focus 
                                                g=c:geometry() 
                                                g['x']=0
                                                c:geometry(g)     
                                              end),
    awful.key({ modkey, "Shift"   }, "Up",     function () 
                                                c=client.focus 
                                                g=c:geometry() 
                                                g['y']=16 + c.border_width
                                                c:geometry(g)     
                                              end),
    awful.key({ modkey, "Shift"   }, "Right",     function () 
                                                c=client.focus 
                                                g=c:geometry() 
                                                g['x']=1280 - g['width'] - 2*c.border_width 
                                                c:geometry(g)     
                                              end),
    awful.key({ modkey, "Shift"   }, "Down",     function () 
                                                c=client.focus 
                                                g=c:geometry() 
                                                g['y']=780 - g['height'] - 2*c.border_width 
                                                c:geometry(g)     
                                              end),
    awful.key({ modkey,           }, "w",     function () awful.client.moveresize(0,0,20,20)     end),
    awful.key({ modkey, "Shift"   }, "w",     function () awful.client.moveresize(0,0,-20,-20)     end),
    awful.key({ modkey, "Control"   }, "Left",     function () awful.client.moveresize(-20,0,0,0)     end),
    awful.key({ modkey, "Control"   }, "Right",     function () awful.client.moveresize(20,0,0,0)     end),
    awful.key({ modkey, "Control"   }, "Down",     function () awful.client.moveresize(0,20,0,0)     end),
    awful.key({ modkey, "Control"   }, "Up",     function () awful.client.moveresize(0,-20,0,0)     end),
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
    awful.key({ modkey },            "r",     function () awful.util.spawn("dmenu_run -nf '#666' -sb '#000' -sf '#99ad6a' -fn 'Gros-6'") end)
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
    end),
    awful.key({ modkey, "Control" }, "m",      function() moveMouse(safeCoords.x, safeCoords.y) end),
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey, "Control" }, "v",      treesome.vertical                                ),
    awful.key({ modkey, "Control" }, "h",      treesome.horizontal                              ),
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
  
   { rule = { },
     properties = { border_width = 0,
                    focus = awful.client.focus.filter,
                    size_hints_honor = false,
                    keys = clientkeys,
                    buttons = clientbuttons } },
   { rule = { class = "MPlayer" },
     properties = { floating = true, tag = tags[1][6] } },
   { rule = { class = "URxvt" },
     properties = { border_width = 2, } },    
   { rule = { class = "pinentry" },
     properties = { floating = true } },
   { rule = { class = "Gimp" },
       properties = { tag = tags[1][6] } },
   { rule = { class = "Firefox" },
     properties = { tag = tags[1][1] } },
   { rule = { class = "luakit" },
     properties = { tag = tags[1][1] } },
   { rule = { class = "Deluge" },
     properties = { tag = tags[1][1] } },
   { rule = { class = "Filezilla" },
     properties = { tag = tags[1][1] } },
   { rule = { class = "Spotify" },
     properties = { tag = tags[1][3] } },
   { rule = { class = "Skype" },
     properties = { tag = tags[1][2] } },
   { rule = { class = "libreoffice-startcenter" },
     properties = { tag = tags[1][5] } },
   { rule = { class = "Xpdf" },
     properties = { tag = tags[1][5] } },
   { rule = { class = "jetbrains-idea-ce" },
     properties = { tag = tags[1][4] } },
   { rule = { class = "MonoDevelop" },
     properties = { tag = tags[1][4] } },
   { rule = { class = "codeblocks" },
     properties = { tag = tags[1][4] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
      if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        --awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
           awful.placement.no_overlap(c)
           awful.placement.no_offscreen(c)
        end
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.fg_darkgray end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.fg_black end)
-- }}}

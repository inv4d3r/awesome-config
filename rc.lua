-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local vicious = require("vicious")
local hints = require("hints")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

local function debug(debug_string)
  naughty.notify({ preset = naughty.config.presets.normal,
                   title = nil,
                   text = debug_string,
                   timeout = 5 })
end

-- Widgets helper functions
local io = { popen = io.popen }

local function colorify(arg)
  if arg.fgcolor == nil then
    arg.fgcolor = beautiful.fg_normal
  end

  local font_weight = ""
  if arg.weight ~= nil then
    font_weight = " font_weight='" .. arg.weight .. "' "
  else 
    font_weight = " font_weight='bold' "
  end

  return "<span" .. font_weight .. " color='" .. arg.fgcolor .. "'>" .. arg.text .. "</span>"
end

local function displaytransfer_rate(rate_kb)
  rate = tonumber(rate_kb)
  if rate > 1000 then return string.format("%.1f", rate/1000) .. " mb"
  else return string.format("%.1f", rate_kb) .. " kb" end
end

local function get_interfaces()
  local f = io.popen("ip l | awk 'NR%2==1 {print substr($2, 0, length($2)-1)}'")
  local ifaces = {}
  local fline = f:read("*line")
  while fline do
    if fline ~= "lo" then
      table.insert(ifaces, fline)
    end
    fline = f:read("*line")
  end
  f:close()
  return ifaces
end

local function get_ip(interface)
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

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.

local config_dir = "~/.config/awesome/"
beautiful.init(config_dir .. "theme.lua")
local apw = require("apw/widget")
apwTimer = timer({ timeout = 5 }) -- seconds
apwTimer:connect_signal("timeout", apw.Update)
apwTimer:start()

hints.init()

-- This is used later as the default terminal and editor to run.
terminal = "termite"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
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
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Helper functions
local function client_menu_toggle_fn()
    local instance = nil

    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end
-- }}}

-- {{{ Wibar
-- Create a textclock widget
mytextclock = awful.widget.textclock(
  colorify{text = " %a %d %b %y ", 
           fgcolor = beautiful.gruvbox_white } ..
  colorify{text = " %I:%M %p ",
           fgcolor = beautiful.aqua })
mytextclock_bg = wibox.container.background(mytextclock, beautiful.gruvbox_bg0_h)

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    homefs_widget = wibox.widget.textbox()
    vicious.register(homefs_widget, vicious.widgets.fs, 
        colorify{text = " home ",
                  fgcolor = beautiful.gruvbox_white } ..
        colorify{text = " ${/home avail_gb} GB ",
                  fgcolor = beautiful.gruvbox_gray }, 10)
    homefs_widget_bg = wibox.container.background(homefs_widget, beautiful.gruvbox_bg0_h)

    rootfs_widget = wibox.widget.textbox()
    vicious.register(rootfs_widget, vicious.widgets.fs,
        colorify{text = " / ",
                  fgcolor = beautiful.gruvbox_white } ..

        colorify{text = " ${/ avail_gb} GB ", 
                  fgcolor = beautiful.gruvbox_gray }, 10)
    rootfs_widget_bg = wibox.container.background(rootfs_widget, beautiful.gruvbox_bg0_h)
        
    net_widget = wibox.widget.textbox()
    net_widget.forced_width = 200
    vicious.register(net_widget, vicious.widgets.net, 
      function(widget, args) 
        -- current ip search
        local network_interfaces = get_interfaces()
        local current_ip = ""
        local connected_interface = ""
        local net_text = ""
        for index,interface in pairs(network_interfaces) do
          ip = get_ip(interface)
          if ip ~= "no address" then
            connected_interface = interface
            current_ip = ip
          end
        end

        if current_ip ~= "" then
          local rate_down, rate_up, face_text, down_text, up_text
          rate_down = args["{" .. connected_interface .. " down_kb}"] 
          rate_up = args["{" .. connected_interface .. " up_kb}"] 
          
          --face_text = colorify{text = " " .. connected_interface .. " ",
          face_text = colorify{text = "  net ",
                                fgcolor = beautiful.gruvbox_white,
                                bgcolor = beautiful.gruvbox_bg0}

          down_text = colorify{text = " " .. displaytransfer_rate(rate_down) .. "  ", 
                                fgcolor = beautiful.gruvbox_gray,
                                bgcolor = beautiful.gruvbox_bg0}

          up_text = colorify{text = " " .. displaytransfer_rate(rate_up) .. "  ",
                              fgcolor = beautiful.gruvbox_gray,
                              bgcolor = beautiful.gruvbox_bg0}

          net_text = face_text .. down_text .. up_text
        else 
          net_text = colorify{text = " no network connection ",
                              fgcolor = beautiful.bwc_taffy}
        end
        return net_text
      end, 1)
    net_widget_bg = wibox.container.background(net_widget, beautiful.gruvbox_bg0_h)

    hfill = wibox.widget.textbox("")
    hfill.forced_width = 1
    hfill_bg = wibox.container.background(hfill, beautiful.nearblack)

    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({" 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 " }, s, awful.layout.layouts[2])

    -- Create a promptbox for each screen
    --s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)

    -- AwesomeWM icon
    s.awesome_icon = wibox.widget.imagebox(beautiful.awesome_icon, true, nil)
    
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.noempty)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 20 })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.awesome_icon,
            hfill_bg,
            s.mytaglist,
            hfill_bg
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            net_widget_bg,
            hfill_bg,
            homefs_widget_bg,
            hfill_bg,
            rootfs_widget_bg,
            hfill_bg,
            apw,
            hfill_bg,
            mytextclock_bg,
            hfill_bg,
            s.mylayoutbox,
            hfill_bg,
            wibox.widget.systray()
        },
    }
end)
-- }}}

alt_icon = false

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "a",      
                function() 
                  s = awful.screen.focused()
                  if(alt_icon) then
                    s.awesome_icon.image = beautiful.awesome_icon
                  else
                    s.awesome_icon.image = beautiful.awesome_icon_alt
                  end
                  alt_icon = not alt_icon
                end,
              {description="transform icon", group="awesome"}),
    awful.key({ modkey,           }, "[",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "]",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    -- Multimedia keys
    awful.key({}, "XF86AudioRaiseVolume", apw.Up),
    awful.key({}, "XF86AudioLowerVolume", apw.Down),
    awful.key({}, "XF86AudioMute", apw.ToggleMute),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey,           }, "t", function () awful.spawn(terminal .. " -e tmux") end,
              {description = "open a terminal + tmux", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Mod1"    }, "r",     function () awful.util.spawn("reboot")    end),
    awful.key({ modkey, "Mod1"    }, "p",     function () awful.util.spawn("poweroff")    end),
    awful.key({ modkey,           }, "Left",     function () 
                                                c=client.focus 
                                                g=c:geometry() 
                                                g['x']=0
                                                c:geometry(g)     
                                              end),
    awful.key({ modkey,           }, "Up",     function () 
                                                c=client.focus 
                                                g=c:geometry() 
                                                g['y'] = beautiful.get_font_height(beautiful.font) * 1.5
                                                c:geometry(g)     
                                              end),
    awful.key({ modkey,           }, "Right",     function () 
                                                c=client.focus 
                                                g=c:geometry() 
                                                g['x'] = screen[1].workarea.width- g['width'] - 2*c.border_width 
                                                c:geometry(g)     
                                              end),
    awful.key({ modkey,           }, "Down",     function () 
                                                c=client.focus 
                                                g=c:geometry() 
                                                local topwibox_height = beautiful.get_font_height(beautiful.font) * 1.5 
                                                local screen_height = screen[1].workarea.height
                                                g['y'] = screen_height - g['height'] - 2*c.border_width + topwibox_height
                                                c:geometry(g)     
                                              end),
    awful.key({ modkey, "Control"   }, "c",     function () 
                                                c=client.focus 
                                                g=c:geometry() 
                                                if awful.client.floating.get(client) then
                                                  awful.placement.centered(c, c.transient_for)
                                                end
                                              end),
    awful.key({ modkey,           }, "w",     function () awful.client.moveresize(0,0,20,20)     end),
    awful.key({ modkey, "Shift"   }, "w",     function () awful.client.moveresize(0,0,-20,-20)     end),
    awful.key({ modkey, "Control"   }, "a",     function () awful.client.moveresize(-20,0,0,0)     end),
    awful.key({ modkey, "Control"   }, "d",     function () awful.client.moveresize(20,0,0,0)     end),
    awful.key({ modkey, "Control"   }, "s",     function () awful.client.moveresize(0,20,0,0)     end),
    awful.key({ modkey, "Control"   }, "w",     function () awful.client.moveresize(0,-20,0,0)     end),
    awful.key({ modkey, "Shift"}, "c", function()
        local c = client.focus
        c:kill()
      end,
      {description = "toggle maximize", group = "client"}),

    awful.key({ modkey, }, "m", function()
        local c = client.focus
        if c then 
          c.maximized = not c.maximized
        end
        --c.sticky = not c.sticky
        --c.floating = not c.floating
      end,
      {description = "toggle maximize", group = "client"}),

    awful.key({ modkey, }, "f", function()
        local c = client.focus
        c.fullscreen = not c.fullscreen
        --c.sticky = not c.sticky
        --c.floating = not c.floating
      end,
      {description = "toggle fullscreen", group = "client"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),

    awful.key({ modkey, "Mod1" }, "l",     
              function () awful.util.spawn("slimlock") end),

    awful.key({ modkey, "Mod1" }, "j",     
              function () hints.focus() end),

    awful.key({ modkey }, "r",     
              function () awful.util.spawn("rofi -show run") end),

    awful.key({ modkey }, "b",     
              function () awful.util.spawn("qutebrowser") end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

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
    end))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                     keys = clientkeys
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
        },
        class = {
          "Arandr",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Wpa_gui",
          "pinentry",
          "veromix",
          "xtightvncviewer"},

        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

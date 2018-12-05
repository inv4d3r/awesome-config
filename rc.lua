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
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

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

-- {{{ Variable definitions
local config_dir = "~/.config/"
local themes_dir = "~/.config/awesome/themes/"
local theme_name = os.getenv("THEME") or "default"
if theme_name == "" then
  theme_name = "default"
end
-- Themes define colours, icons, font and wallpapers.
beautiful.init(themes_dir .. theme_name .. "/theme.lua")

local apw = require("apw/widget")
apwTimer = gears.timer({
  timeout = 5,
  call_now = true,
  autostart = true,
  callback = apw.Update }) -- seconds
--apwTimer:connect_signal("timeout", apw.Update)
--apwTimer:start()

hints.init()

-- This is used later as the default terminal and editor to run.
terminal = "termite"
editor = os.getenv("EDITOR") or "nvim"
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
mytextclock = wibox.widget.textclock(
  colorify{text = " %a %d %b %y ",
           fgcolor = beautiful.date_fg_color } ..
  colorify{text = " %I:%M %p ",
           fgcolor = beautiful.time_fg_color })
mytextclock_bg = wibox.container.background(mytextclock, beautiful.clock_bg_color)

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
    battery_widget = wibox.widget.textbox()
    vicious.register(battery_widget, vicious.widgets.bat,
      function(widget, args)
        -- "⌁" unknown
        -- "−" discharging
        -- "↯" fully charged
        -- "+" charging
        if args[1] == "-" or
           args[1] == "⌁" then
          bat_color = beautiful.bat_not_charging
        else
          bat_color = beautiful.bat_charging
        end

        local charge_num = tonumber(args[2])
        if charge_num < 30 then
          charge_color = beautiful.bat_low
        elseif charge_num < 70 then
          charge_color = beautiful.bat_medium
        else
          charge_color = beautiful.bat_high
        end

        return colorify{ text = " " .. args[1] .. " ",
                         fgcolor = bat_color } ..
               colorify{ text = args[2] .. "% ",
                         fgcolor = charge_color }
      end, 60, "BAT1")
    battery_widget_bg = wibox.container.background(battery_widget, beautiful.fs_bg_color)

    homefs_widget = wibox.widget.textbox()
    vicious.register(homefs_widget, vicious.widgets.fs,
        colorify{text = " home ",
                  fgcolor = beautiful.fs_dir_fg_color } ..
        colorify{text = " ${/home avail_gb} GB ",
                  fgcolor = beautiful.fs_fg_color }, 10)
    homefs_widget_bg = wibox.container.background(homefs_widget, beautiful.fs_bg_color)

    rootfs_widget = wibox.widget.textbox()
    vicious.register(rootfs_widget, vicious.widgets.fs,
        colorify{text = " / ",
                  fgcolor = beautiful.fs_dir_fg_color } ..

        colorify{text = " ${/ avail_gb} GB ",
                  fgcolor = beautiful.fs_fg_color }, 10)
    rootfs_widget_bg = wibox.container.background(rootfs_widget, beautiful.fs_bg_color)

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
                                fgcolor = beautiful.netface_fg_color,
                                bgcolor = beautiful.net_bg_color}

          down_text = colorify{text = " " .. displaytransfer_rate(rate_down) .. "  ",
                                fgcolor = beautiful.netrate_fg_color,
                                bgcolor = beautiful.net_bg_color}

          up_text = colorify{text = " " .. displaytransfer_rate(rate_up) .. "  ",
                              fgcolor = beautiful.netrate_fg_color,
                              bgcolor = beautiful.net_bg_color}

          net_text = face_text .. down_text .. up_text
        else
          net_text = colorify{text = " no network connection ",
                              fgcolor = beautiful.nonet_fg_color}
        end
        return net_text
      end, 1)
    net_widget_bg = wibox.container.background(net_widget, beautiful.net_bg_color)

    hfill = wibox.widget.textbox("")
    hfill.forced_width = 1
    hfill_bg = wibox.container.background(hfill, beautiful.hfill_bg_color)

    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({" 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 " }, s, awful.layout.layouts[6])
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
            hfill_bg,
            --s.mypromptbox
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
            battery_widget_bg,
            hfill_bg,
            apw,
            hfill_bg,
            mytextclock_bg,
            s.mylayoutbox,
            hfill_bg,
            wibox.widget.systray()
        },
    }
end)
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    -- Display hotkeys
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),

    -- Tag navigation
    awful.key({ modkey,           }, "[",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "]",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),

    -- Windows navigation
    awful.key({ modkey,           }, "j",
        function () awful.client.focus.byidx( 1) end,
        {description = "focus next by index", group = "client"}),

    awful.key({ modkey,           }, "k",
        function () awful.client.focus.byidx(-1) end,
        {description = "focus previous by index", group = "client"}),

    -- Multimedia keys
    awful.key({}, "XF86AudioRaiseVolume", apw.Up),
    awful.key({}, "XF86AudioLowerVolume", apw.Down),
    awful.key({}, "XF86AudioMute", apw.ToggleMute),
    awful.key({}, "XF86AudioPlay", function() awful.util.spawn("spotifycli --playpause") end),
    awful.key({}, "XF86AudioPrev", function() awful.util.spawn("spotifycli --prev") end),
    awful.key({}, "XF86AudioNext", function() awful.util.spawn("spotifycli --next") end),
    awful.key({}, "XF86Display",
      function()
        awful.util.spawn("~/scripts/setup-screen.sh")
        awesome.restart()
      end),

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

    -- Spawn apps
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
        {description = "open a terminal", group = "launcher"}),

    awful.key({ modkey, "Shift"   }, "Return", function ()
        awful.spawn(terminal, {
            floating  = true,
            tag       = awful.screen.focused().selected_tag,
            placement = awful.placement.centered}) end,
        {description = "open a floating terminal at the center", group = "launcher"}),

    awful.key({ modkey,    }, "t", function () awful.spawn(terminal .. " -e tmux") end,
        {description = "open a tmux terminal", group = "launcher"}),

    awful.key({ modkey, "Shift"   }, "t", function ()
        awful.spawn(terminal .. " -e tmux", {
            floating  = true,
            tag       = awful.screen.focused().selected_tag,
            placement = awful.placement.centered}) end,
        {description = "open a floating tmux terminal at the center", group = "launcher"}),

    awful.key({ modkey }, "b",
        function () awful.util.spawn("qutebrowser") end,
        {description = "open qutebrowser", group = "launcher"}),

    awful.key({ modkey, "Shift" }, "b",
        function () awful.util.spawn("firefox") end,
        {description = "open firefox", group = "launcher"}),

    awful.key({ modkey, "Mod1" }, "l",
        function () awful.util.spawn("gnome-screensaver-command -l") end,
        {description = "lock the screen", group = "launcher"}),

    awful.key({ modkey, "Mod1" }, "f",
        function () hints.focus() end,
        {description = "show hints", group = "client"}),


    awful.key({ modkey }, "r",
        function ()
          awful.util.spawn("dmenu_run -p 'run:' -fn '" .. beautiful.font .. "' " ..
                           "-nb '" .. beautiful.bg_normal .. "' " ..
                           "-sb '" .. beautiful.bg_focus .. "' " ..
                           "-nf '" .. beautiful.fg_normal .. "' " ..
                           "-sf '" .. beautiful.fg_focus .. "' ")
        end,
        {description = "run dmenu", group = "launcher"}),

    -- Sticky note
    awful.key({ modkey, "Mod1"   }, "s",
      function ()
        awful.spawn(terminal .. " -e " .. editor, {
            floating  = true,
            sticky = true,
            tag       = awful.screen.focused().selected_tag,
            placement = awful.placement.top_right})
      end,
      {description = "show sticky note", group = "launcher"}),

    -- AwesomeWM control
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    -- Power control
    awful.key({ modkey, "Mod1"    }, "r", function () awful.util.spawn("reboot") end,
      {description = "reboot", group = "launcher"}),
    awful.key({ modkey, "Mod1"    }, "p", function () awful.util.spawn("poweroff") end,
      {description = "poweroff", group = "launcher"}),

    -- Tiled clients manipulation
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

    -- Layout change
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
      function ()
        local c = awful.client.restore()
        -- Focus restored client
        if c then
          client.focus = c
          c:raise()
        end
      end,
      {description = "restore minimized", group = "client"})
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
    -- Windows manipulation
    awful.key({ modkey, "Shift"}, "c", function(c) c:kill() end,
      {description = "kill", group = "client"}),

    awful.key({ modkey, "Shift" }, "f",
      function(c)
        if c.maximized then
          c.maximized = false
        end
        awful.client.floating.toggle()
      end,
      {description = "toggle floating", group = "client"}),

    awful.key({ modkey, "Shift" }, "s", function(c) c.sticky = not c.sticky end,
      {description = "toggle sticky", group = "client"}),

    awful.key({ modkey, "Control" }, "Return",
      function (c) c:swap(awful.client.getmaster()) end,
      {description = "move to master", group = "client"}),

    awful.key({ modkey, "Control" }, "o", function (c) c:move_to_screen() end,
      {description = "move to screen", group = "client"}),

    awful.key({ modkey, "Control" }, "t", function (c) c.ontop = not c.ontop end,
      {description = "toggle keep on top", group = "client"}),

    awful.key({ modkey, "Shift" }, "n",
      function(c)
          -- The client currently has the input focus, so it cannot be
          -- minimized, since minimized clients can't have the focus.
          c.minimized = true
      end,
      {description = "minimize", group = "client"}),

    awful.key({ modkey, "Shift" }, "m",
      function(c)
          c.maximized = not c.maximized
          c:raise()
      end,
      {description = "toggle maximize", group = "client"}),

    awful.key({ modkey, }, "f", function(c) c.fullscreen = not c.fullscreen end,
      {description = "toggle fullscreen", group = "client"}),

  -- Window moving
  awful.key({ modkey, }, "Left",
    function (c)
      workarea = awful.screen.focused().workarea
      c.x = workarea.x
    end,
    {description = "move client to far left", group = "client"}),

  awful.key({ modkey, }, "Up",
    function (c)
      g=c:geometry()
      g['y'] = beautiful.get_font_height(beautiful.font) * 1.5
      c:geometry(g)
    end,
    {description = "move client to the top", group = "client"}),

  awful.key({ modkey, }, "Right",
    function (c)
      workarea = awful.screen.focused().workarea
      c.x = workarea.x + workarea.width - c.width - 2*c.border_width
    end,
    {description = "move client to far right", group = "client"}),

  awful.key({ modkey, }, "Down",
    function (c)
      g=c:geometry()
      local topwibox_height = beautiful.get_font_height(beautiful.font) * 1.5
      local screen_height = awful.screen.focused().workarea.height
      g['y'] = screen_height - g['height'] - 2*c.border_width + topwibox_height
      c:geometry(g)
    end,
  {description = "move client to the bottom", group = "client"}),

  awful.key({ modkey, "Control" }, "c", awful.placement.centered,
    {description = "move client to the center", group = "client"}),

  -- Relative moving
  awful.key({ modkey, "Control" }, "a",
    function (c) c:relative_move(-20,0,0,0) end,
    {description = "move client a little bit left", group = "client"}),

  awful.key({ modkey, "Control" }, "d",
    function (c) c:relative_move(20,0,0,0) end,
    {description = "move client a little bit right", group = "client"}),

  awful.key({ modkey, "Control" }, "s",
    function (c) c:relative_move(0,20,0,0) end,
    {description = "move client a little bit down", group = "client"}),

  awful.key({ modkey, "Control" }, "w",
    function (c) c:relative_move(0,-20,0,0) end,
    {description = "move client a little bit up", group = "client"}),

  -- Window resizing
  awful.key({ modkey,           }, "w",
    function (c) c:relative_move(0,0,20,20) end,
    {description = "enlarge client in both directions", group = "client"}),

  awful.key({ modkey, "Shift"   }, "w",
    function (c) c:relative_move(0,0,-20,-20) end,
    {description = "shrink client in both directions", group = "client"}),

  awful.key({ modkey, "Mod1"   }, "]",
    function (c) c:relative_move(0,0,0,20) end,
    {description = "increase height of the client", group = "client"}),

  awful.key({ modkey, "Control"   }, "]",
    function (c) c:relative_move(0,0,20,0) end,
    {description = "increase width of the client", group = "client"}),

  awful.key({ modkey, "Mod1"   }, "[",
    function (c) c:relative_move(0,0,0,-20) end,
    {description = "decrease height of the client", group = "client"}),

  awful.key({ modkey, "Control"   }, "[",
    function (c) c:relative_move(0,0,-20,0) end,
    {description = "decrease width of the client", group = "client"}),

  awful.key({ modkey, "Shift"   }, "[",
    function (c)
      local tags = c.screen.tags
      local curidx = awful.screen.focused().selected_tag.index
      if curidx == 1 then
        c:move_to_tag(tags[#tags])
      else
        c:move_to_tag(tags[curidx - 1])
      end
    end,
    {description = "move focused client to previous tag", group = "client" }),

  awful.key({ modkey, "Shift"   }, "]",
    function (c)
      local tags = client.focus.screen.tags
      local curidx = awful.screen.focused().selected_tag.index
      if curidx == #tags then
        c:move_to_tag(tags[1])
      else
        c:move_to_tag(tags[curidx + 1])
      end
    end,
    {description = "move focused client to next tag", group = "client" })
)

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

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
                     keys = clientkeys,
                     buttons = clientbuttons
     }
    },

    {
      rule_any = { class = { "Pidgin", "Evolution" } },
      properties = { tag = awful.screen.focused().tags[1], floating = true }
    },

    {
      rule = { class = "Pidgin", role = "buddy_list" },
      properties = { floating = true, maximized_vertical = true, placement = awful.placement.top_left, width = 320  }
    },

    {
      rule = { class = "Pidgin", role = "conversation" },
      properties = { floating = true, x = 320, width = 700, height = 600 }
    },

    {
      rule_any = { class = { "firefox", "Firefox", "qutebrowser" } },
      except = { type = "dialog" },
      properties = { tag = awful.screen.focused().tags[2], floating = true, maximized = true }
    },

    {
      rule = { type = "dialog" },
      properties = { floating = true, placement = awful.placement.centered }
    },

    {
      rule = { class = "Gcr-prompter" },
      properties = { floating = true, placement = awful.placement.centered }
    },

    {
      rule = { class = "Boostnote" },
      properties = { tag = awful.screen.focused().tags[3], floating = true, maximized = true }
    },

    {
      rule_any = { { class = "spotify", "Spotify" }, name = { "Spotify", "Spotify Premium" } },
      properties = { tag = awful.screen.focused().tags[9], floating = true, maximized = true }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
        },
        class = {
          "remmina",
          --"MuPDF",
          --"mpv",
          --"Pinentry",
          --"Zathura"
        },
        name = {
        },
        role = {
        }
      }, properties = { floating = true }},
}
-- }}}

tag.connect_signal("request::screen",
function(t)
  local fallback_tag = nil

  -- find tag with same name on any other screen
  for other_screen in screen do
    if other_screen ~= t.screen then
      fallback_tag = awful.tag.find_by_name(other_screen, t.name)
      if fallback_tag ~= nil then
        break
      end
    end
  end

  -- no tag with same name exists, chose random one
  if fallback_tag == nil then
    fallback_tag = awful.tag.find_fallback()
  end

  -- delete the tag and move it to other screen
  t:delete(fallback_tag, true)
end)

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

local spotify_rule_workaround
spotify_rule_workaround =  function(c)
    if c.name == "Spotify" then
        awful.rules.apply(c)
        c:disconnect_signal("property::name", spotify_rule_workaround)
    end
end
client.connect_signal("property::name", spotify_rule_workaround)
-- }}}

-- Autostart programs
awful.spawn.with_shell("~/scripts/autorun.sh")

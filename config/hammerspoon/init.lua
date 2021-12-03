-- Hammerspoon modifier
local hsModifier = { "ctrl", "cmd" }

local appList = {
  Alacritty = { binding = "a"},
  Firefox = { binding = "f" },
  Slack = { binding = "s" },
  Music = { binding = "m" },
  ["Brave Browser"] = { binding = "b" },
  -- ["Code"] = { binding = "e" },
}

-- Reload config
hs.hotkey.bind(hsModifier, "R", function()
  hs.reload()
  -- hs.notify.new({title="Hammerspoon", informativeText="Config loaded"}):send()
  hs.alert.show('Config Reloaded')
end)

alertId = nil
hs.application.enableSpotlightForNameSearches(true)

-- Attach app keybindings
for app, config in pairs(appList) do
  -- Bind the app
  if config.binding ~= nil then
    hs.hotkey.bind(hsModifier, config.binding, function()
      application = hs.application.find(app)
      if config.autoHide then
        -- Noop
      elseif application then
        hs.application.launchOrFocus(app)
      else
        hs.alert.closeSpecific(alertID, 0)
        alertID = hs.alert(app .. " not Running!", nil, nil, 1)
      end
    end)
  end
end

-- bind hotkey
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'n', function()
  -- get the focused window
  local win = hs.window.focusedWindow()
  -- get the screen where the focused window is displayed, a.k.a. current screen
  local screen = win:screen()
  -- compute the unitRect of the focused window relative to the current screen
  -- and move the window to the next screen setting the same unitRect
  win:move(win:frame():toUnitRect(screen:frame()), screen:next(), true, 0)
end)


-- Hammerspoon modifier
local hsModifier = { "ctrl", "cmd" }

local appList = {
  Alacritty = { binding = "a"},
  Firefox = { binding = "f" },
  Slack = { binding = "s" },
  Music = { binding = "m" },
  -- ["Code"] = { binding = "e" }
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

-- -------------------------------------------
-- 🔨🥄 Hammerspoon configuration file
-- -------------------------------------------

local wm = require('window-management')

-- Hammerspoon modifier
local hsModifier = { "ctrl", "cmd" }
local code = "/Applications/Visual Studio Code.app"

local appList = {
  Alacritty = { binding = "a"},
  Firefox = { binding = "f" },
  Slack = { binding = "s" },
  Music = { binding = "m" },
  ["Brave Browser"] = { binding = "b" },
  [code] = { binding = "e" },
  Insomnia = { binding = "i" },
  ["zoom.us"] = { binding = "z" },
  Obsidian = { binding = "o" },
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
      elseif app == code then -- hack! So that vscode can work
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

-- Send the window to the next screen
hs.hotkey.bind(hsModifier, ';', function()
    if hs.window.focusedWindow() then
        local win = hs.window.focusedWindow()
        local screen = win:screen()
        if #hs.screen.allScreens() > 1 then
			if win:isFullScreen() then
				win:setFullScreen(false):moveToScreen(screen:next())
				hs.timer.doAfter(0.6,function()
					win:setFullScreen(true)
				end)
			else
				win:moveToScreen(screen:next())
			end
        else
            hs.alert.show("Only one monitor")
        end
    else
        hs.alert.show("No active window")
    end
end)



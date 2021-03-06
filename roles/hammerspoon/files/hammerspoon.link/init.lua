spaces = require("hs._asm.undocumented.spaces")

local Audio = require "audio"
local Media = require "media"
local Switcher = require "switcher"

-- mash hotkeys
cmdAlt        = {"cmd", "alt"}
ctrlAlt       = {"ctrl", "alt"}
ctrlCmd       = {"ctrl", "cmd"}
mash 	        = {"cmd", "alt", "ctrl"}
mashShift     = {"ctrl", "alt", "shift"}
hyper         = {"cmd", "ctrl", "alt", "shift"}

-- require "pomodoor"
-- require "cheatsheet"
-- require "highlight"

-- require "redshift"
require "spaces"
require "layout"
require "window"

hs.window.animationDuration = 0

-- reload configurations
----------------------------------------------------------
function reloadConfig()
	hs.alert.show("Config loaded")
	hs.reload()
end

-- reload config
hs.hotkey.bind(mash, "R",  reloadConfig)
hs.hotkey.bind(mash, "C", hs.toggleConsole)
hs.pathwatcher.new(".", reloadConfig):start()

-- Hide Dock Icon.
hs.dockicon.hide()

-- Takitapart window commands
hs.hotkey.bind(mash, "home", function() takitapartWindowKeystroke("home") end)
hs.hotkey.bind(mash, "end", function() takitapartWindowKeystroke("end") end)
hs.hotkey.bind(mash, "help",  function() takitapartWindowKeystroke("help") end)
hs.hotkey.bind(mash, "pageup",  function() takitapartWindowKeystroke("pageup") end)
hs.hotkey.bind(mash, "forwarddelete",  function() takitapartWindowKeystroke("forwarddelete") end)
hs.hotkey.bind(mash, "pagedown",  function() takitapartWindowKeystroke("pagedown") end)

-- Move to next monitor / space
hs.hotkey.bind(mash, "up", function()
  local win = hs.window.focusedWindow()
  win:moveOneScreenWest()
  -- Move mouse with it, so we can use spaces commands on this screen.
  local rect = win:frame()
  local center = hs.geometry.rectMidPoint(rect)
  hs.mouse.setAbsolutePosition(center)
end)
hs.hotkey.bind(mash, "down", function()
  local win = hs.window.focusedWindow()
  win:moveOneScreenEast()
  -- Move mouse with it, so we can use spaces commands on this screen.
  local rect = win:frame()
  local center = hs.geometry.rectMidPoint(rect)
  hs.mouse.setAbsolutePosition(center)
end)
hs.hotkey.bind(mash, 'left', nil, function() moveToSpaceInDirection(hs.window.focusedWindow(), "west") end)
hs.hotkey.bind(mash, 'right', nil, function() moveToSpaceInDirection(hs.window.focusedWindow(), "east") end)

--
hs.hotkey.bind({ "alt" }, "tab", hs.hints.windowHints)

-- pomodoro key binding
hs.hotkey.bind(mash, "9", function() pom_enable() end)
hs.hotkey.bind(mash, "0", function() pom_disable() end)
hs.hotkey.bind(hyper, "0", function() pom_reset_work() end)

hs.hotkey.bind(mash, "tab", Switcher.activate)

-- volume keys
hs.hotkey.bind({}, "F13", Audio.toggleMute)
hs.hotkey.bind({}, "F14", Audio.decVolume)
hs.hotkey.bind({}, "F15", Audio.incVolume)

-- Spotify
hs.hotkey.bind(mash, "F13", Media.previous)
hs.hotkey.bind(mash, "F14", Media.playpause)
hs.hotkey.bind(mash, "F15", Media.next)

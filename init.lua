require("hs.ipc")
require("hs.screen")
require("hs.timer")
require("hs.window")
require("hs.window.filter")

-- auto reload
hs.loadSpoon("ReloadConfiguration")
hs.loadSpoon("PushToTalk") -- push to talk, otherwise mute system microphone
spoon.PushToTalk.detect_on_start = true
spoon.PushToTalk.app_switcher = {
    ['zoom.us'] = 'push-to-talk'
}
spoon.PushToTalk:start()
spoon.ReloadConfiguration:start()



-- Copied from https://github.com/Hammerspoon/Spoons/blob/4224cddc344198e086715a7c24983f90ec0f32fc/Source/PopupTranslateSelection.spoon/init.lua
function currentSelection()
   local elem=hs.uielement.focusedElement()
   local sel=nil
   if elem then
      sel=elem:selectedText()
   end
   if (not sel) or (sel == "") then
      hs.eventtap.keyStroke({"cmd"}, "c")
      hs.timer.usleep(20000)
      sel=hs.pasteboard.getContents()
   end
   return (sel or "")
end


function jiraToJiraLink()
    task_id = currentSelection()
    hs.pasteboard.setContents("https://blendlabs.atlassian.net/browse/" .. task_id)
    hs.timer.usleep(20000)
    hs.eventtap.keyStroke({"cmd"}, "v")
end


local hyper = { "cmd", "alt", "ctrl", "shift" }

local applicationHotkeys = {
  s = 'Brave Browser',
  a = 'iTerm',
}

-- for easy switching of apps
for key, app in pairs(applicationHotkeys) do
  hs.hotkey.bind(hyper, key, function()
    hs.application.launchOrFocus(app)
  end)
end

-- For easy select and make a ticket number into jira link
hs.hotkey.bind({'cmd', 'ctrl'}, 'j', jiraToJiraLink)
-- defeating paste blocking
hs.hotkey.bind({"cmd", "alt"}, "V", function() hs.eventtap.keyStrokes(hs.pasteboard.getContents()) end)
stackline = require "stackline"
stackline:init()

local application = require "mjolnir.application"
local hotkey = require "mjolnir.hotkey"
local window = require "mjolnir.window"
local fnutils = require "mjolnir.fnutils"

local key_app_map = {
  D = "Dash",
  C = "Google Chrome",
  T = "iTerm",
  S = "Slack",
  P = "Preview",
  R = "RubyMine"
}

for key, app in pairs(key_app_map) do
  hotkey.bind({"cmd", "ctrl"}, key, function()
      application.launchorfocus(app)
  end)
end

-- hotkey.bind({"cmd", "ctrl"}, "C", function()
--     local current_app = window.focusedwindow():application():title()
--     local next_app = {
--       ["Google Chrome"] = "CLion",
--       ["CLion"] = "Google Chrome"
--     }
--     application.launchorfocus(current_app and next_app[current_app] or "Google Chrome")
-- end)

hotkey.bind({"ctrl"}, "9", function()
    window.focusedwindow():movetounit({x=0, y=0, w=1, h=1})
end)

hotkey.bind({"ctrl"}, "8", function()
    window.focusedwindow():movetounit({x=0, y=0, w=0.5, h=1})
end)

hotkey.bind({"ctrl"}, "0", function()
    window.focusedwindow():movetounit({x=0.5, y=0, w=0.5, h=1})
end)

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
  N = "TweetDeck"
}

for key, app in pairs(key_app_map) do
  hotkey.bind({"cmd", "ctrl"}, key, function()
      application.launchorfocus(app)
  end)
end

local roundrobin = function(funcs)
  local i = 1
  return function()
    funcs[i]()
    i = i % #funcs + 1
  end
end

hotkey.bind({"ctrl"}, "9", function()
    window.focusedwindow():movetounit({x=0, y=0, w=1, h=1})
end)

hotkey.bind({"ctrl"}, "8", function()
    window.focusedwindow():movetounit({x=0, y=0, w=0.5, h=1})
end)

hotkey.bind({"ctrl"}, "0", function()
    window.focusedwindow():movetounit({x=0.5, y=0, w=0.5, h=1})
end)

-- 同一アプリケーション内のウインドウ移動
hotkey.bind({"alt"}, "o", function()
    local current_window = window.focusedwindow()
    local windows = current_window:application():allwindows()
    table.sort(windows, function(a, b) return a:id() < b:id() end)
    local index = fnutils.indexof(windows, current_window)
    if not index then return end
    for i = 1, #windows do
      if windows[(index + i) % #windows + 1]:focus() then break end
    end
end)

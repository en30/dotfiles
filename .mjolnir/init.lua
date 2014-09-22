local application = require "mjolnir.application"
local hotkey = require "mjolnir.hotkey"
local window = require "mjolnir.window"
local fnutils = require "mjolnir.fnutils"

local key_app_map = {
   D = "Dash",
   C = "Google Chrome",
   T = "iTerm",
   S = "Slack"
}

for key, app in pairs(key_app_map) do
   hotkey.bind({"cmd", "ctrl"}, key, function()
	 application.launchorfocus(app)
   end)
end

-- ウインドウを {左半分, 右半分, フル} にリサイズ
hotkey.bind({"ctrl"}, "9", fnutils.cycle({
	 function() window.focusedwindow():movetounit({x=0, y=0, w=0.5, h=1}) end,
	 function() window.focusedwindow():movetounit({x=0.5, y=0, w=0.5, h=1}) end,
	 function() window.focusedwindow():movetounit({x=0, y=0, w=1, h=1}) end
}))

-- 同一アプリケーション内のウインドウ移動
hotkey.bind({"alt"}, "o", function()
      local current_window = window.focusedwindow()
      local windows = current_window:application():allwindows()
      local index = fnutils.indexof(windows, current_window)
      if not index then return end
      for i = 1, #windows do
	 if windows[index % #windows + i]:focus() then break end
      end
end)

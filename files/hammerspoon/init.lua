-- Move Window to Screen Left/Right
hs.hotkey.bind({"ctrl", "shift", "cmd"}, "H", function()
    local win = hs.window.focusedWindow()
    if win then win:moveOneScreenWest() end
end)

hs.hotkey.bind({"ctrl", "shift", "cmd"}, ";", function()
    local win = hs.window.focusedWindow()
    if win then win:moveOneScreenEast() end
end)

-- Helper function to resize windows
local function resize(x, y, w, h)
    local win = hs.window.focusedWindow()
    if not win then return end
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x + (max.w * x)
    f.y = max.y + (max.h * y)
    f.w = max.w * w
    f.h = max.h * h
    win:setFrame(f)
end

-- Reload Config
hs.hotkey.bind({"ctrl", "shift", "alt"}, "R", function()
  hs.reload()
end)
hs.alert.show("Config loaded")

--------------------HALF--------------------
-- Left 1/2
hs.hotkey.bind({"ctrl", "shift"}, "H", function() resize(0, 0, 0.5, 1) end)

-- Right 1/2
hs.hotkey.bind({"ctrl", "shift"}, ";", function() resize(0.5, 0, 0.5, 1) end)

-- Top 1/2
hs.hotkey.bind({"ctrl", "shift"}, "T", function() resize(0, 0, 1, 0.5) end)

-- Bottom 1/2
hs.hotkey.bind({"ctrl", "shift"}, "B", function() resize(0, 0.5, 1, 0.5) end)
--------------------------------------------

--------------------QUAD--------------------
-- Top-Left 1/4
hs.hotkey.bind({"ctrl", "shift"}, "Y", function() resize(0, 0, 0.5, 0.5) end)

-- Top-Right 1/4
hs.hotkey.bind({"ctrl", "shift"}, "P", function() resize(0.5, 0, 0.5, 0.5) end)

-- Bottom-Left 1/4
hs.hotkey.bind({"ctrl", "shift"}, "N", function() resize(0, 0.5, 0.5, 0.5) end)

-- Bottom-Right 1/4
hs.hotkey.bind({"ctrl", "shift"}, "/", function() resize(0.5, 0.5, 0.5, 0.5) end)
--------------------------------------------

--------------------HEX---------------------
-- Left 1/3
hs.hotkey.bind({"ctrl", "shift"}, "J", function() resize(0, 0, 1/3, 1) end)

-- Middle 1/3
hs.hotkey.bind({"ctrl", "shift"}, "K", function() resize(1/3, 0, 1/3, 1) end)

-- Right 1/3
hs.hotkey.bind({"ctrl", "shift"}, "L", function() resize(2/3, 0, 1/3, 1) end)

-- Top 1/2 Left 1/3
hs.hotkey.bind({"ctrl", "shift"}, "U", function() resize(0, 0, 1/3, 0.5) end)

-- Top 1/2 Middle 1/3
hs.hotkey.bind({"ctrl", "shift"}, "I", function() resize(1/3, 0, 1/3, 0.5) end)

-- Top 1/2 Right 1/3
hs.hotkey.bind({"ctrl", "shift"}, "O", function() resize(2/3, 0, 1/3, 0.5) end)

-- Bottom 1/2 Left 1/3
hs.hotkey.bind({"ctrl", "shift"}, "M", function() resize(0, 0.5, 1/3, 0.5) end)

-- Bottom 1/2 Middle 1/3
hs.hotkey.bind({"ctrl", "shift"}, ",", function() resize(1/3, 0.5, 1/3, 0.5) end)

-- Bottom 1/2 Right 1/3
hs.hotkey.bind({"ctrl", "shift"}, ".", function() resize(2/3, 0.5, 1/3, 0.5) end)
-------------------------------------------

--------------------CMD--------------------
--------------------2/3--------------------
-- Left 2/3
hs.hotkey.bind({"ctrl", "shift", "cmd"}, "J", function() resize(0, 0, 2/3, 1) end)

-- Middle 2/3
hs.hotkey.bind({"ctrl", "shift", "cmd"}, "K", function() resize(1/6, 0, 2/3, 1) end)

-- Right 2/3
hs.hotkey.bind({"ctrl", "shift", "cmd"}, "L", function() resize(1/3, 0, 2/3, 1) end)
--------------------------------------------

--------------------OPT---------------------
-------------Vertical Middle----------------
-- Left
hs.hotkey.bind({"ctrl", "shift", "alt"}, "J", function() resize(0, 0.25, 1/3, 0.5) end)

-- Middle
hs.hotkey.bind({"ctrl", "shift", "alt"}, "K", function() resize(1/3, 0.25, 1/3, 0.5) end)

-- Right
hs.hotkey.bind({"ctrl", "shift", "alt"}, "L", function() resize(2/3, 0.25, 1/3, 0.5) end)

-- Full Screen
hs.hotkey.bind({"ctrl", "shift", "alt"}, "F", function() resize(0, 0, 1, 1) end)



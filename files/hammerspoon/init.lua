hs.loadSpoon("WindowScreenLeftAndRight")
spoon.WindowScreenLeftAndRight:bindHotkeys(spoon.WindowScreenLeftAndRight.defaultHotkeys)

--------------------HALF--------------------
-- Left 1/2
hs.hotkey.bind({"ctrl", "shift"}, "H", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    
    f.x = max.x
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    win:setFrame(f)
end)

-- Right 1/2
hs.hotkey.bind({"ctrl", "shift"}, ";", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    
    f.x = max.x + (max.w / 2)
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    win:setFrame(f)
end)

-- Top 1/2
hs.hotkey.bind({"ctrl", "shift"}, "T", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    
    f.x = max.x 
    f.y = max.y
    f.w = max.w
    f.h = max.h / 2
    win:setFrame(f)
end)

-- Bottom 1/2
hs.hotkey.bind({"ctrl", "shift"}, "B", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    
    f.x = max.x 
    f.y = max.y + (max.h / 2)
    f.w = max.w
    f.h = max.h / 2
    win:setFrame(f)
end)
--------------------------------------------

--------------------QUAD--------------------
-- Top-Left 1/4
hs.hotkey.bind({"ctrl", "shift"}, "Y", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    
    f.x = max.x
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h / 2
    win:setFrame(f)
end)

-- Top-Right 1/4
hs.hotkey.bind({"ctrl", "shift"}, "P", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    
    f.x = max.x + (max.w / 2)
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h / 2
    win:setFrame(f)
end)

-- Bottom-Left 1/4
hs.hotkey.bind({"ctrl", "shift"}, "N", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    
    f.x = max.x 
    f.y = max.y + (max.h / 2)
    f.w = max.w / 2
    f.h = max.h / 2
    win:setFrame(f)
end)

-- Bottom-Right 1/4
hs.hotkey.bind({"ctrl", "shift"}, "/", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    
    f.x = max.x + (max.w / 2)
    f.y = max.y + (max.h / 2)
    f.w = max.w / 2
    f.h = max.h / 2
    win:setFrame(f)
end)
--------------------------------------------

--------------------HEX---------------------
-- Left 1/3
hs.hotkey.bind({"ctrl", "shift"}, "J", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    
    f.x = max.x 
    f.y = max.y
    f.w = max.w / 3
    f.h = max.h
    win:setFrame(f)
end)

-- Middle 1/3
hs.hotkey.bind({"ctrl", "shift"}, "K", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    
    f.x = max.x + (max.w / 3)
    f.y = max.y
    f.w = max.w / 3
    f.h = max.h
    win:setFrame(f)
end)

-- Right 1/3
hs.hotkey.bind({"ctrl", "shift"}, "L", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    
    f.x = max.x + (2 * (max.w / 3))
    f.y = max.y
    f.w = max.w / 3
    f.h = max.h
    win:setFrame(f)
end)

-- Top 1/2 Left 1/3
hs.hotkey.bind({"ctrl", "shift"}, "U", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y
    f.w = max.w / 3
    f.h = max.h / 2
    win:setFrame(f)
end)

-- Top 1/2 Middle 1/3
hs.hotkey.bind({"ctrl", "shift"}, "I", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x + (max.w / 3)
    f.y = max.y
    f.w = max.w / 3
    f.h = max.h / 2
    win:setFrame(f)
end)

-- Top 1/2 Right 1/3
hs.hotkey.bind({"ctrl", "shift"}, "O", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x + (2 * (max.w / 3))
    f.y = max.y
    f.w = max.w / 3
    f.h = max.h / 2
    win:setFrame(f)
end)

-- Bottom 1/2 Left 1/3
hs.hotkey.bind({"ctrl", "shift"}, "M", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y + (max.h / 2)
    f.w = max.w / 3
    f.h = max.h / 2
    win:setFrame(f)
end)

-- Bottom 1/2 Middle 1/3
hs.hotkey.bind({"ctrl", "shift"}, ",", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x + (max.w / 3)
    f.y = max.y + (max.h / 2)
    f.w = max.w / 3
    f.h = max.h / 2
    win:setFrame(f)
end)

-- Bottom 1/2 Right 1/3
hs.hotkey.bind({"ctrl", "shift"}, ".", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x + (2 * (max.w / 3))
    f.y = max.y + (max.h / 2)
    f.w = max.w / 3
    f.h = max.h / 2
    win:setFrame(f)
end)
-------------------------------------------

--------------------CMD--------------------
--------------------2/3--------------------
-- Left 2/3
hs.hotkey.bind({"ctrl", "shift", "cmd"}, "J", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    
    f.x = max.x
    f.y = max.y
    f.w = 2 * (max.w / 3)
    f.h = max.h
    win:setFrame(f)
end)

-- Middle 2/3
hs.hotkey.bind({"ctrl", "shift", "cmd"}, "K", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    
    f.x = max.x + (max.w / 6)
    f.y = max.y
    f.w = 2 * (max.w / 3)
    f.h = max.h
    win:setFrame(f)
end)

-- Right 2/3
hs.hotkey.bind({"ctrl", "shift", "cmd"}, "L", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    
    f.x = max.x + (max.w / 3)
    f.y = max.y
    f.w = 2 * (max.w / 3)
    f.h = max.h
    win:setFrame(f)
end)
--------------------------------------------

--------------------OPT---------------------
-------------Vertical Middle----------------
-- Left
hs.hotkey.bind({"ctrl", "shift", "alt"}, "J", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y + (max.h / 4)
    f.w = max.w / 3
    f.h = max.h / 2
    win:setFrame(f)
end)

-- Middle
hs.hotkey.bind({"ctrl", "shift", "alt"}, "K", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    
    f.x = max.x + (max.w / 3)
    f.y = max.y + (max.h / 4)
    f.w = max.w / 3
    f.h = max.h / 2
    win:setFrame(f)
end)

-- Right
hs.hotkey.bind({"ctrl", "shift", "alt"}, "L", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x + (2 * (max.w / 3))
    f.y = max.y + (max.h / 4)
    f.w = max.w / 3
    f.h = max.h / 2
    win:setFrame(f)
end)

-- Full Screen
hs.hotkey.bind({"ctrl", "shift", "alt"}, "F", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    
    f.x = max.x 
    f.y = max.y
    f.w = max.w
    f.h = max.h
    win:setFrame(f)
end)



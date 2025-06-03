hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "R", function()
    hs.reload()
end)

require("terminal")

hs.alert.show("Hammerspoon config loaded")

print("Hammerspoon configuration loaded successfully")

local terminal = {}

local function launchGhostty()
    local app = hs.application.find("Ghostty")

    if app then
        local windows = app:allWindows()

        if #windows > 0 then
            local window = windows[1]
            window:focus()
            app:activate()
        else
            app:selectMenuItem({ "File", "New Window" })
        end
    else
        hs.application.launchOrFocus("Ghostty")
    end
end

hs.hotkey.bind({}, "§", function()
    launchGhostty()
end)

return terminal

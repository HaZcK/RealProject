loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "ChatUi",
    Icon = "wifi",
    Author = "by Khafidz_3",
    Folder = "ChatUiFolder",
        
    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
            print("Follow My Tiktok Khafidz_3 Plsss")
        end,
    },
})

local Main = Window:Tab({
    Title = "Main",
    Icon = "wifi-cog",
    Locked = false
})

Tab:Select() -- Select Tab

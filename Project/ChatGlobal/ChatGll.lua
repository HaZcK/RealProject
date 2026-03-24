local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/refs/heads/main/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "ChatUi",
    Icon = "wifi",
    Author = "by Khafidz_3",
    Folder = "ChatUiFolder",
    Background = "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e1/FullMoon2010.jpg/330px-FullMoon2010.jpg",
    User = {
        Enabled = true,
        Anonymous = true,
        Callback = function()
            print("Follow My Tiktok Khafidz_3 Plsss")
        end,
    },
    Thumbnail = {
        Image = "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e1/FullMoon2010.jpg/330px-FullMoon2010.jpg",
        Title = "Thumbnail"
    },
})

local Main = Window:Tab({
    Title = "Main",
    Icon = "wifi-cog",
    Locked = false,
})

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "ChatUi",
    Icon = "wifi", -- lucide icon
    Author = "by Khafidz_3",
    Folder = "ChatUiFolder",
    
    -- ↓ Optional. You can remove it.
    --You can set 'rbxassetid://' or video to Background.
        --'rbxassetid://':
            Background = "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e1/FullMoon2010.jpg/330px-FullMoon2010.jpg", -- rbxassetid
    
    -- ↓ Optional. You can remove it.
    User = {
        Enabled = true,
        Anonymous = true,
        Callback = function()
            print("Follow My Tiktok Khafidz_3 Plsss")
        end,
    },
    
    --       remove this all, 
    -- !  ↓  if you DON'T need the key syste
        -- ↓ Optional. You can remove it.
        Thumbnail = {
            Image = "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e1/FullMoon2010.jpg/330px-FullMoon2010.jpg",
            Title = "Thumbnail"
    },
 }

  local Main = Window:Tab({
    Title = "Main",
    Icon = "wifi-cog", -- optional
    Locked = false,
})

-- TrapLag v1.0
-- Anti-Lag Script by TrapLag
-- UI: WindUI

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

local App = WindUI:CreateApp({
    Title = "TrapLag",
    Icon = "zap",
    Author = "TrapLag v1.0",
    MobileOpen = Enum.KeyCode.RightControl,
    Open = Enum.KeyCode.RightControl,
    Resize = true,
    Theme = "Dark",
})

local Home = App:Tab({ Title = "Anti Lag", Icon = "cpu" })

Home:Section({ Title = "FPS & Render" })

Home:Button({
    Title = "FPS Unlocker",
    Description = "Unlock FPS hingga 240",
    Icon = "gauge",
    Callback = function()
        setfpscap(240)
        WindUI:Notify({ Title = "TrapLag", Content = "FPS di-unlock ke 240!", Duration = 3 })
    end,
})

Home:Button({
    Title = "Cap FPS 60",
    Description = "Batasi FPS ke 60 untuk hemat baterai",
    Icon = "battery",
    Callback = function()
        setfpscap(60)
        WindUI:Notify({ Title = "TrapLag", Content = "FPS di-cap ke 60!", Duration = 3 })
    end,
})

Home:Toggle({
    Title = "Reduce Render Distance",
    Description = "Kurangi jarak render objek",
    Icon = "eye",
    Default = false,
    Callback = function(state)
        settings().Rendering.QualityLevel = state and Enum.QualityLevel.Level01 or Enum.QualityLevel.Automatic
    end,
})

Home:Section({ Title = "Visual" })

Home:Toggle({
    Title = "Disable Shadows",
    Description = "Matikan shadow untuk boost FPS",
    Icon = "sun",
    Default = false,
    Callback = function(state)
        game:GetService("Lighting").GlobalShadows = not state
        WindUI:Notify({ Title = "TrapLag", Content = state and "Shadows dimatikan!" or "Shadows dinyalakan!", Duration = 2 })
    end,
})

Home:Toggle({
    Title = "Disable Atmosphere",
    Description = "Hapus fog & atmosphere Roblox",
    Icon = "cloud-off",
    Default = false,
    Callback = function(state)
        local atm = game:GetService("Lighting"):FindFirstChildOfClass("Atmosphere")
        if atm then atm.Density = state and 0 or 0.395 atm.Offset = state and 0 or 0.25 end
        game:GetService("Lighting").FogEnd = state and 9e9 or 100000
    end,
})

Home:Toggle({
    Title = "Disable PostFX",
    Description = "Hapus blur, bloom, color correction",
    Icon = "image-off",
    Default = false,
    Callback = function(state)
        for _, e in ipairs(game:GetService("Lighting"):GetChildren()) do
            if e:IsA("BlurEffect") or e:IsA("BloomEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("SunRaysEffect") or e:IsA("DepthOfFieldEffect") then
                e.Enabled = not state
            end
        end
    end,
})

Home:Button({
    Title = "Low Texture Quality",
    Description = "Set tekstur ke kualitas paling rendah",
    Icon = "image",
    Callback = function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        WindUI:Notify({ Title = "TrapLag", Content = "Texture quality diturunkan!", Duration = 3 })
    end,
})

Home:Section({ Title = "Player" })

Home:Toggle({
    Title = "Disable Particles",
    Description = "Matikan semua efek partikel di game",
    Icon = "sparkles",
    Default = false,
    Callback = function(state)
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                v.Enabled = not state
            end
        end
    end,
})

Home:Toggle({
    Title = "Hide Accessories",
    Description = "Sembunyikan aksesoris semua player",
    Icon = "shirt",
    Default = false,
    Callback = function(state)
        for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
            if player.Character then
                for _, v in ipairs(player.Character:GetDescendants()) do
                    if v:IsA("Accessory") then
                        v.Handle.Transparency = state and 1 or 0
                    end
                end
            end
        end
    end,
})

Home:Toggle({
    Title = "Disable Animations",
    Description = "Hentikan animasi semua player",
    Icon = "person-standing",
    Default = false,
    Callback = function(state)
        if state then
            for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
                if player.Character then
                    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        local animator = humanoid:FindFirstChildOfClass("Animator")
                        if animator then
                            pcall(function()
                                for _, track in ipairs(animator:GetPlayingAnimationTracks()) do track:Stop() end
                            end)
                        end
                    end
                end
            end
        end
    end,
})

Home:Section({ Title = "Sound" })

Home:Toggle({
    Title = "Disable All Sound",
    Description = "Matikan semua suara dalam game",
    Icon = "volume-x",
    Default = false,
    Callback = function(state)
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("Sound") then v.Volume = state and 0 or 1 end
        end
        game:GetService("SoundService").MusicVolume = state and 0 or 1
    end,
})

Home:Section({ Title = "Quick Actions" })

Home:Button({
    Title = "⚡ Full Anti Lag",
    Description = "Aktifkan SEMUA fitur anti-lag sekaligus",
    Icon = "zap",
    Callback = function()
        setfpscap(240)
        game:GetService("Lighting").GlobalShadows = false
        local atm = game:GetService("Lighting"):FindFirstChildOfClass("Atmosphere")
        if atm then atm.Density = 0 atm.Offset = 0 end
        game:GetService("Lighting").FogEnd = 9e9
        for _, e in ipairs(game:GetService("Lighting"):GetChildren()) do
            if e:IsA("BlurEffect") or e:IsA("BloomEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("SunRaysEffect") then
                e.Enabled = false
            end
        end
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then v.Enabled = false end
        end
        WindUI:Notify({ Title = "TrapLag ⚡", Content = "Semua fitur anti-lag aktif! Selamat main!", Duration = 4 })
    end,
})

Home:Button({
    Title = "🔄 Reset All",
    Description = "Kembalikan semua pengaturan ke default",
    Icon = "rotate-ccw",
    Callback = function()
        game:GetService("Lighting").GlobalShadows = true
        game:GetService("Lighting").FogEnd = 100000
        settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
        for _, e in ipairs(game:GetService("Lighting"):GetChildren()) do
            if e:IsA("BlurEffect") or e:IsA("BloomEffect") or e:IsA("ColorCorrectionEffect") then e.Enabled = true end
        end
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Trail") then v.Enabled = true end
        end
        WindUI:Notify({ Title = "TrapLag", Content = "Semua pengaturan direset!", Duration = 3 })
    end,
})

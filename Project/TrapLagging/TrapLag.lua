-- ╔══════════════════════════════════════╗
-- ║         TrapLag v2.1                 ║
-- ║   Anti-Lag & Config Script           ║
-- ║         UI: WindUI                   ║
-- ╚══════════════════════════════════════╝

local VERSION = "TL21"

-- ========================
-- BASE64 (pure Lua)
-- ========================
local b64chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

local function b64encode(data)
    local result = {}
    local padding = ""
    data = tostring(data)
    if #data % 3 == 1 then data = data .. "\0\0" padding = "=="
    elseif #data % 3 == 2 then data = data .. "\0" padding = "=" end
    for i = 1, #data, 3 do
        local a, b, c = data:byte(i, i+2)
        local i1 = math.floor(a/4)+1
        local i2 = (a%4)*16+math.floor(b/16)+1
        local i3 = (b%16)*4+math.floor(c/64)+1
        local i4 = c%64+1
        result[#result+1] = b64chars:sub(i1,i1)..b64chars:sub(i2,i2)..b64chars:sub(i3,i3)..b64chars:sub(i4,i4)
    end
    local encoded = table.concat(result)
    if padding ~= "" then encoded = encoded:sub(1,-(#padding+1))..padding end
    return encoded
end

local function b64decode(data)
    local lookup = {}
    for i = 1, #b64chars do lookup[b64chars:sub(i,i)] = i-1 end
    data = data:gsub("[^%w+/=]","")
    local result = {}
    for i = 1, #data, 4 do
        local a = lookup[data:sub(i,i)] or 0
        local b = lookup[data:sub(i+1,i+1)] or 0
        local c = lookup[data:sub(i+2,i+2)] or 0
        local d = lookup[data:sub(i+3,i+3)] or 0
        result[#result+1] = string.char(
            a*4+math.floor(b/16),
            (b%16)*16+math.floor(c/4),
            (c%4)*64+d
        )
    end
    return table.concat(result):gsub("\0+$","")
end

-- ========================
-- PLAYER CONFIG
-- ========================
local HS = game:GetService("HttpService")
local configPath = "TrapLag/config/player/settings.json"

local playerConfig = {
    cameraSensitivity = 2.5,
    fpsTarget         = 240,
    disableShadows    = false,
    disableAtmosphere = false,
    disablePostFX     = false,
    disableParticles  = false,
    hideAccessories   = false,
    disableAnimations = false,
    disableSound      = false,
    reduceRender      = false,
}

local function saveConfig()
    -- Pastikan subfolder ada (WindUI hanya buat folder utama)
    if not isfolder("TrapLag/config") then makefolder("TrapLag/config") end
    if not isfolder("TrapLag/config/player") then makefolder("TrapLag/config/player") end
    if not isfolder("TrapLag/config/fonts") then makefolder("TrapLag/config/fonts") end
    if not isfolder("TrapLag/config/crosshair") then makefolder("TrapLag/config/crosshair") end
    if not isfolder("TrapLag/config/image") then makefolder("TrapLag/config/image") end
    writefile(configPath, HS:JSONEncode(playerConfig))
end

local function loadConfig()
    if isfile(configPath) then
        local ok, data = pcall(function()
            return HS:JSONDecode(readfile(configPath))
        end)
        if ok and data then
            for k, v in pairs(data) do
                if playerConfig[k] ~= nil then playerConfig[k] = v end
            end
        end
    end
end

-- ========================
-- APPLY FUNCTIONS
-- ========================
local function applyCamera()
    pcall(function()
        UserSettings():GetService("UserGameSettings").MouseSensitivity = playerConfig.cameraSensitivity
    end)
end
local function applyShadows()
    game:GetService("Lighting").GlobalShadows = not playerConfig.disableShadows
end
local function applyAtmosphere()
    local atm = game:GetService("Lighting"):FindFirstChildOfClass("Atmosphere")
    if atm then
        atm.Density = playerConfig.disableAtmosphere and 0 or 0.395
        atm.Offset  = playerConfig.disableAtmosphere and 0 or 0.25
    end
    game:GetService("Lighting").FogEnd = playerConfig.disableAtmosphere and 9e9 or 100000
end
local function applyPostFX()
    for _, e in ipairs(game:GetService("Lighting"):GetChildren()) do
        if e:IsA("BlurEffect") or e:IsA("BloomEffect")
        or e:IsA("ColorCorrectionEffect") or e:IsA("SunRaysEffect")
        or e:IsA("DepthOfFieldEffect") then
            e.Enabled = not playerConfig.disablePostFX
        end
    end
end
local function applyParticles()
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
            v.Enabled = not playerConfig.disableParticles
        end
    end
end
local function applyAccessories()
    for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
        if player.Character then
            for _, v in ipairs(player.Character:GetDescendants()) do
                if v:IsA("Accessory") then
                    v.Handle.Transparency = playerConfig.hideAccessories and 1 or 0
                end
            end
        end
    end
end
local function applyAnimations()
    if playerConfig.disableAnimations then
        for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
            if player.Character then
                local hum = player.Character:FindFirstChildOfClass("Humanoid")
                if hum then
                    local anim = hum:FindFirstChildOfClass("Animator")
                    if anim then
                        pcall(function()
                            for _, t in ipairs(anim:GetPlayingAnimationTracks()) do t:Stop() end
                        end)
                    end
                end
            end
        end
    end
end
local function applySound()
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("Sound") then v.Volume = playerConfig.disableSound and 0 or 1 end
    end
    game:GetService("SoundService").MusicVolume = playerConfig.disableSound and 0 or 1
end
local function applyRender()
    settings().Rendering.QualityLevel = playerConfig.reduceRender
        and Enum.QualityLevel.Level01
        or Enum.QualityLevel.Automatic
end
local function applyFPS()
    setfpscap(playerConfig.fpsTarget)
end

local function applyAllConfig()
    applyCamera()
    applyShadows()
    applyAtmosphere()
    applyPostFX()
    applyParticles()
    applyAccessories()
    applyAnimations()
    applySound()
    applyRender()
end

-- ========================
-- EXPORT / IMPORT
-- ========================
local function exportConfig()
    local code = VERSION .. ":" .. b64encode(HS:JSONEncode(playerConfig))
    writefile("TrapLag/export.txt", code)
    return code
end

local function importConfig(code)
    local prefix = code:match("^([^:]+):")
    if prefix ~= VERSION then return false, "expired" end
    local encoded = code:match("^[^:]+:(.+)$")
    if not encoded then return false, "invalid" end
    local ok, data = pcall(function() return HS:JSONDecode(b64decode(encoded)) end)
    if not ok or not data then return false, "invalid" end
    for k, v in pairs(data) do
        if playerConfig[k] ~= nil then playerConfig[k] = v end
    end
    saveConfig()
    applyAllConfig()
    return true, "ok"
end

-- ========================
-- LOAD & APPLY ON STARTUP
-- ========================
loadConfig()
saveConfig() -- pastikan subfolder terbuat
applyAllConfig()

-- ========================
-- WINDUI INIT (FIXED)
-- ========================
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "TrapLag",
    Icon = "zap",
    Author = "TrapLag v2.1",
    Folder = "TrapLag",  -- WindUI auto-buat folder ini
    MobileOpen = Enum.KeyCode.RightControl,
    Open = Enum.KeyCode.RightControl,
    Resize = true,
    Theme = "Dark",
})

-- ========================
-- TAB 1: ANTI LAG
-- ========================
local LagTab = Window:Tab({ Title = "Anti Lag", Icon = "cpu" })

LagTab:Section({ Title = "FPS & Render" })

LagTab:Button({
    Title = "FPS Unlocker",
    Description = "Unlock FPS ke " .. playerConfig.fpsTarget,
    Icon = "gauge",
    Callback = function()
        applyFPS()
        WindUI:Notify({ Title = "TrapLag", Content = "FPS di-unlock ke " .. playerConfig.fpsTarget .. "!", Duration = 3 })
    end,
})

LagTab:Button({
    Title = "Cap FPS 60",
    Description = "Batasi FPS ke 60 untuk hemat baterai",
    Icon = "battery",
    Callback = function()
        setfpscap(60)
        WindUI:Notify({ Title = "TrapLag", Content = "FPS di-cap ke 60!", Duration = 3 })
    end,
})

LagTab:Toggle({
    Title = "Reduce Render Distance",
    Description = "Kurangi jarak render objek",
    Icon = "eye",
    Default = playerConfig.reduceRender,
    Callback = function(state)
        playerConfig.reduceRender = state
        applyRender() saveConfig()
    end,
})

LagTab:Section({ Title = "Visual" })

LagTab:Toggle({
    Title = "Disable Shadows",
    Description = "Matikan shadow untuk boost FPS",
    Icon = "sun",
    Default = playerConfig.disableShadows,
    Callback = function(state)
        playerConfig.disableShadows = state
        applyShadows() saveConfig()
        WindUI:Notify({ Title = "TrapLag", Content = state and "Shadows dimatikan!" or "Shadows dinyalakan!", Duration = 2 })
    end,
})

LagTab:Toggle({
    Title = "Disable Atmosphere",
    Description = "Hapus fog & atmosphere Roblox",
    Icon = "cloud-off",
    Default = playerConfig.disableAtmosphere,
    Callback = function(state)
        playerConfig.disableAtmosphere = state
        applyAtmosphere() saveConfig()
    end,
})

LagTab:Toggle({
    Title = "Disable PostFX",
    Description = "Hapus blur, bloom, color correction",
    Icon = "image-off",
    Default = playerConfig.disablePostFX,
    Callback = function(state)
        playerConfig.disablePostFX = state
        applyPostFX() saveConfig()
    end,
})

LagTab:Button({
    Title = "Low Texture Quality",
    Description = "Set tekstur ke kualitas paling rendah",
    Icon = "image",
    Callback = function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        WindUI:Notify({ Title = "TrapLag", Content = "Texture quality diturunkan!", Duration = 3 })
    end,
})

LagTab:Section({ Title = "Player" })

LagTab:Toggle({
    Title = "Disable Particles",
    Description = "Matikan semua efek partikel di game",
    Icon = "sparkles",
    Default = playerConfig.disableParticles,
    Callback = function(state)
        playerConfig.disableParticles = state
        applyParticles() saveConfig()
    end,
})

LagTab:Toggle({
    Title = "Hide Accessories",
    Description = "Sembunyikan aksesoris semua player",
    Icon = "shirt",
    Default = playerConfig.hideAccessories,
    Callback = function(state)
        playerConfig.hideAccessories = state
        applyAccessories() saveConfig()
    end,
})

LagTab:Toggle({
    Title = "Disable Animations",
    Description = "Hentikan animasi semua player",
    Icon = "person-standing",
    Default = playerConfig.disableAnimations,
    Callback = function(state)
        playerConfig.disableAnimations = state
        applyAnimations() saveConfig()
    end,
})

LagTab:Section({ Title = "Sound" })

LagTab:Toggle({
    Title = "Disable All Sound",
    Description = "Matikan semua suara dalam game",
    Icon = "volume-x",
    Default = playerConfig.disableSound,
    Callback = function(state)
        playerConfig.disableSound = state
        applySound() saveConfig()
    end,
})

LagTab:Section({ Title = "Quick Actions" })

LagTab:Button({
    Title = "⚡ Full Anti Lag",
    Description = "Aktifkan SEMUA fitur anti-lag sekaligus",
    Icon = "zap",
    Callback = function()
        playerConfig.disableShadows    = true
        playerConfig.disableAtmosphere = true
        playerConfig.disablePostFX     = true
        playerConfig.disableParticles  = true
        playerConfig.reduceRender      = true
        applyFPS() applyShadows() applyAtmosphere()
        applyPostFX() applyParticles() applyRender()
        saveConfig()
        WindUI:Notify({ Title = "TrapLag ⚡", Content = "Semua fitur anti-lag aktif!", Duration = 4 })
    end,
})

LagTab:Button({
    Title = "🔄 Reset All",
    Description = "Kembalikan semua pengaturan ke default",
    Icon = "rotate-ccw",
    Callback = function()
        playerConfig.disableShadows    = false
        playerConfig.disableAtmosphere = false
        playerConfig.disablePostFX     = false
        playerConfig.disableParticles  = false
        playerConfig.reduceRender      = false
        playerConfig.disableSound      = false
        playerConfig.hideAccessories   = false
        playerConfig.disableAnimations = false
        applyAllConfig() saveConfig()
        WindUI:Notify({ Title = "TrapLag", Content = "Semua pengaturan direset!", Duration = 3 })
    end,
})

-- ========================
-- TAB 2: CONFIG
-- ========================
local CfgTab = Window:Tab({ Title = "Config", Icon = "settings" })

CfgTab:Section({ Title = "Player Config" })

CfgTab:Slider({
    Title = "Camera Sensitivity",
    Description = "Atur sensitivitas kamera (0.1 - 7.0)",
    Icon = "move",
    Min = 0.1,
    Max = 7,
    Default = playerConfig.cameraSensitivity,
    Decimals = 1,
    Callback = function(value)
        playerConfig.cameraSensitivity = value
        applyCamera() saveConfig()
    end,
})

CfgTab:Slider({
    Title = "FPS Target",
    Description = "Target FPS saat FPS Unlocker diaktifkan",
    Icon = "gauge",
    Min = 30,
    Max = 240,
    Default = playerConfig.fpsTarget,
    Decimals = 0,
    Callback = function(value)
        playerConfig.fpsTarget = value
        saveConfig()
    end,
})

CfgTab:Section({ Title = "Fonts" })

CfgTab:Button({
    Title = "Lihat Font Tersedia",
    Description = "Cek file di TrapLag/config/fonts/",
    Icon = "type",
    Callback = function()
        local files = listfiles("TrapLag/config/fonts")
        local names = {}
        for _, f in ipairs(files) do
            if f:match("%.json$") then
                table.insert(names, f:match("([^/\\]+)%.json$") or f)
            end
        end
        if #names == 0 then
            WindUI:Notify({ Title = "Fonts", Content = "Belum ada font! Taruh .ttf & .json di config/fonts/", Duration = 5 })
        else
            WindUI:Notify({ Title = "Font Tersedia", Content = table.concat(names, ", "), Duration = 5 })
        end
    end,
})

CfgTab:Button({
    Title = "Apply Font Custom",
    Description = "Apply font pertama yang ditemukan",
    Icon = "type",
    Callback = function()
        local files = listfiles("TrapLag/config/fonts")
        local fontFile = nil
        for _, f in ipairs(files) do
            if f:match("%.ttf$") or f:match("%.otf$") then fontFile = f break end
        end
        if fontFile then
            local fontName = fontFile:match("([^/\\]+)$")
            local face = Font.new("rbxasset://fonts/" .. fontName)
            for _, obj in ipairs(game:GetDescendants()) do
                if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
                    pcall(function() obj.FontFace = face end)
                end
            end
            WindUI:Notify({ Title = "Font Applied", Content = fontName .. " berhasil!", Duration = 3 })
        else
            WindUI:Notify({ Title = "Font", Content = "Tidak ada file font di config/fonts/", Duration = 4 })
        end
    end,
})

CfgTab:Section({ Title = "Crosshair & Image" })

CfgTab:Button({
    Title = "Lihat Crosshair Tersedia",
    Description = "Cek file .png di TrapLag/config/crosshair/",
    Icon = "crosshair",
    Callback = function()
        local files = listfiles("TrapLag/config/crosshair")
        local names = {}
        for _, f in ipairs(files) do
            if f:match("%.png$") then table.insert(names, f:match("([^/\\]+)$") or f) end
        end
        if #names == 0 then
            WindUI:Notify({ Title = "Crosshair", Content = "Belum ada! Taruh .png di config/crosshair/", Duration = 5 })
        else
            WindUI:Notify({ Title = "Crosshair", Content = table.concat(names, ", "), Duration = 5 })
        end
    end,
})

CfgTab:Button({
    Title = "Cek Logo",
    Description = "Cek apakah TrapLag/logo.png ada",
    Icon = "image",
    Callback = function()
        if isfile("TrapLag/logo.png") then
            WindUI:Notify({ Title = "Logo", Content = "logo.png ditemukan! ✅", Duration = 3 })
        else
            WindUI:Notify({ Title = "Logo", Content = "logo.png belum ada! Taruh di folder TrapLag/", Duration = 4 })
        end
    end,
})

CfgTab:Section({ Title = "Export & Import Config" })

CfgTab:Button({
    Title = "📤 Export Config",
    Description = "Generate kode → simpan di TrapLag/export.txt",
    Icon = "share",
    Callback = function()
        local code = exportConfig()
        local preview = code:sub(1, 40) .. "..."
        WindUI:Notify({
            Title = "Config Exported! ✅",
            Content = "Disimpan di TrapLag/export.txt\n" .. preview,
            Duration = 6,
        })
    end,
})

CfgTab:Button({
    Title = "📋 Copy Kode Export",
    Description = "Copy kode ke clipboard",
    Icon = "copy",
    Callback = function()
        if isfile("TrapLag/export.txt") then
            local code = readfile("TrapLag/export.txt")
            setclipboard(code)
            WindUI:Notify({ Title = "Copied! ✅", Content = "Kode berhasil dicopy ke clipboard!", Duration = 3 })
        else
            WindUI:Notify({ Title = "Export dulu!", Content = "Klik Export Config terlebih dahulu.", Duration = 3 })
        end
    end,
})

CfgTab:Button({
    Title = "📥 Import Config",
    Description = "Paste kode di TrapLag/import.txt lalu klik ini",
    Icon = "download",
    Callback = function()
        if not isfile("TrapLag/import.txt") then
            writefile("TrapLag/import.txt", "")
            WindUI:Notify({
                Title = "Import",
                Content = "File import.txt dibuat! Paste kode di sana lalu klik Import lagi.",
                Duration = 5,
            })
            return
        end
        local code = readfile("TrapLag/import.txt"):gsub("%s+","")
        if code == "" then
            WindUI:Notify({ Title = "Import", Content = "import.txt kosong! Paste kode dulu.", Duration = 4 })
            return
        end
        local success, reason = importConfig(code)
        if success then
            WindUI:Notify({ Title = "Import Berhasil! ✅", Content = "Config berhasil diload & diapply!", Duration = 4 })
            writefile("TrapLag/import.txt", "")
        elseif reason == "expired" then
            WindUI:Notify({ Title = "❌ Kode Expired!", Content = "Kode dari versi lama TrapLag, tidak kompatibel.", Duration = 5 })
        else
            WindUI:Notify({ Title = "❌ Kode Tidak Valid!", Content = "Kode salah atau rusak. Cek kembali.", Duration = 5 })
        end
    end,
})

-- ========================
-- STARTUP NOTIFY
-- ========================
WindUI:Notify({
    Title = "TrapLag v2.1 ✅",
    Content = "Config berhasil diload & diapply otomatis!",
    Duration = 4,
})

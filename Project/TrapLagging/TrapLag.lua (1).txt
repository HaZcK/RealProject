-- ╔══════════════════════════════════════╗
-- ║         TrapLag v2.1                 ║
-- ║     Anti-Lag & Config Script         ║
-- ║           UI: WindUI                 ║
-- ╚══════════════════════════════════════╝

local TRAPLAG_VERSION = "2.1" -- Ganti ini setiap update format config

-- ========================
-- BASE64 ENCODE / DECODE
-- ========================
local b64chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

local function b64encode(data)
    return ((data:gsub(".", function(x)
        local r, b = "", x:byte()
        for i = 8, 1, -1 do r = r .. (b % 2^i - b % 2^(i-1) > 0 and "1" or "0") end
        return r
    end) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(x)
        if #x < 6 then return "" end
        local c = 0
        for i = 1, 6 do c = c + (x:sub(i,i) == "1" and 2^(6-i) or 0) end
        return b64chars:sub(c+1,c+1)
    end) .. ({"","==","="})[#data % 3 + 1])
end

local function b64decode(data)
    data = data:gsub("[^"..b64chars.."=]", "")
    return (data:gsub(".", function(x)
        if x == "=" then return "" end
        local r, f = "", (b64chars:find(x)-1)
        for i = 6, 1, -1 do r = r .. (f % 2^i - f % 2^(i-1) > 0 and "1" or "0") end
        return r
    end):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(x)
        if #x ~= 8 then return "" end
        local c = 0
        for i = 1, 8 do c = c + (x:sub(i,i) == "1" and 2^(8-i) or 0) end
        return string.char(c)
    end))
end

-- ========================
-- FOLDER SETUP
-- ========================
local function makeFolder(path)
    if not isfolder(path) then makefolder(path) end
end

makeFolder("TrapLag")
makeFolder("TrapLag/config")
makeFolder("TrapLag/config/fonts")
makeFolder("TrapLag/config/crosshair")
makeFolder("TrapLag/config/image")
makeFolder("TrapLag/config/player")

-- ========================
-- PLAYER CONFIG DEFAULT
-- ========================
local configPath = "TrapLag/config/player/settings.json"

local defaultConfig = {
    version           = TRAPLAG_VERSION,
    cameraSensitivity = 2.5,
    fpsTarget         = 240,
    -- Toggles
    reducedRender     = false,
    disableShadows    = false,
    disableAtmosphere = false,
    disablePostFX     = false,
    disableParticles  = false,
    hideAccessories   = false,
    disableAnimations = false,
    disableSound      = false,
}

local playerConfig = {}
for k, v in pairs(defaultConfig) do playerConfig[k] = v end

local HttpService = game:GetService("HttpService")

local function saveConfig()
    playerConfig.version = TRAPLAG_VERSION
    writefile(configPath, HttpService:JSONEncode(playerConfig))
end

local function loadConfig()
    if isfile(configPath) then
        local ok, data = pcall(function()
            return HttpService:JSONDecode(readfile(configPath))
        end)
        if ok and data then
            -- Cek versi
            if data.version ~= TRAPLAG_VERSION then
                warn("[TrapLag] Config lama ditemukan, direset ke default.")
                saveConfig()
                return false, "outdated"
            end
            for k, v in pairs(data) do
                playerConfig[k] = v
            end
            return true, "ok"
        end
    end
    return false, "notfound"
end

-- ========================
-- APPLY CONFIG (auto-apply semua setting)
-- ========================
local function applyAllSettings()
    -- Camera sensitivity
    pcall(function()
        UserSettings():GetService("UserGameSettings").MouseSensitivity = playerConfig.cameraSensitivity
    end)

    -- FPS
    pcall(function() setfpscap(playerConfig.fpsTarget) end)

    -- Render quality
    settings().Rendering.QualityLevel = playerConfig.reducedRender
        and Enum.QualityLevel.Level01 or Enum.QualityLevel.Automatic

    -- Shadows
    game:GetService("Lighting").GlobalShadows = not playerConfig.disableShadows

    -- Atmosphere
    local atm = game:GetService("Lighting"):FindFirstChildOfClass("Atmosphere")
    if atm then
        atm.Density = playerConfig.disableAtmosphere and 0 or 0.395
        atm.Offset  = playerConfig.disableAtmosphere and 0 or 0.25
    end
    game:GetService("Lighting").FogEnd = playerConfig.disableAtmosphere and 9e9 or 100000

    -- PostFX
    for _, e in ipairs(game:GetService("Lighting"):GetChildren()) do
        if e:IsA("BlurEffect") or e:IsA("BloomEffect")
        or e:IsA("ColorCorrectionEffect") or e:IsA("SunRaysEffect")
        or e:IsA("DepthOfFieldEffect") then
            e.Enabled = not playerConfig.disablePostFX
        end
    end

    -- Particles
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
            v.Enabled = not playerConfig.disableParticles
        end
    end

    -- Accessories
    for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
        if player.Character then
            for _, v in ipairs(player.Character:GetDescendants()) do
                if v:IsA("Accessory") then
                    v.Handle.Transparency = playerConfig.hideAccessories and 1 or 0
                end
            end
        end
    end

    -- Sound
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("Sound") then v.Volume = playerConfig.disableSound and 0 or 1 end
    end
    game:GetService("SoundService").MusicVolume = playerConfig.disableSound and 0 or 1
end

-- ========================
-- LOAD & AUTO-APPLY
-- ========================
local loadOk, loadStatus = loadConfig()

-- ========================
-- WINDUI INIT
-- ========================
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

local App = WindUI:CreateApp({
    Title = "TrapLag",
    Icon = "zap",
    Author = "TrapLag v" .. TRAPLAG_VERSION,
    MobileOpen = Enum.KeyCode.RightControl,
    Open = Enum.KeyCode.RightControl,
    Resize = true,
    Theme = "Dark",
})

-- Notifikasi status load
if loadOk then
    WindUI:Notify({ Title = "TrapLag ✅", Content = "Config berhasil diload & diapply!", Duration = 4 })
    applyAllSettings()
elseif loadStatus == "outdated" then
    WindUI:Notify({ Title = "TrapLag ⚠️", Content = "Config lama direset (versi berbeda).", Duration = 5 })
else
    WindUI:Notify({ Title = "TrapLag", Content = "Config baru dibuat. Selamat datang!", Duration = 3 })
    saveConfig()
end

-- ========================
-- EXPORT / IMPORT HELPER
-- ========================
local importCodeBuffer = ""

local function generateExportCode()
    local exportData = {}
    for k, v in pairs(playerConfig) do exportData[k] = v end
    exportData.version = TRAPLAG_VERSION
    local json = HttpService:JSONEncode(exportData)
    return "TRAPLAG-" .. TRAPLAG_VERSION .. "-" .. b64encode(json)
end

local function importFromCode(code)
    -- Validasi prefix
    if not code:match("^TRAPLAG%-") then
        return false, "invalid"
    end

    -- Cek versi dari kode
    local codeVer = code:match("^TRAPLAG%-([^%-]+)%-")
    if codeVer ~= TRAPLAG_VERSION then
        return false, "expired"
    end

    -- Ambil data setelah prefix TRAPLAG-VER-
    local encoded = code:match("^TRAPLAG%-.-%-(.*)")
    if not encoded or encoded == "" then
        return false, "invalid"
    end

    local ok, data = pcall(function()
        return HttpService:JSONDecode(b64decode(encoded))
    end)

    if not ok or not data then
        return false, "invalid"
    end

    -- Apply ke config
    for k, v in pairs(data) do
        playerConfig[k] = v
    end
    saveConfig()
    applyAllSettings()
    return true, "ok"
end

-- ========================
-- TAB 1: ANTI LAG
-- ========================
local LagTab = App:Tab({ Title = "Anti Lag", Icon = "cpu" })

LagTab:Section({ Title = "FPS & Render" })

LagTab:Button({
    Title = "FPS Unlocker",
    Description = "Unlock FPS ke target (" .. playerConfig.fpsTarget .. ")",
    Icon = "gauge",
    Callback = function()
        setfpscap(playerConfig.fpsTarget)
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
    Default = playerConfig.reducedRender,
    Callback = function(state)
        playerConfig.reducedRender = state
        settings().Rendering.QualityLevel = state and Enum.QualityLevel.Level01 or Enum.QualityLevel.Automatic
        saveConfig()
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
        game:GetService("Lighting").GlobalShadows = not state
        saveConfig()
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
        local atm = game:GetService("Lighting"):FindFirstChildOfClass("Atmosphere")
        if atm then
            atm.Density = state and 0 or 0.395
            atm.Offset  = state and 0 or 0.25
        end
        game:GetService("Lighting").FogEnd = state and 9e9 or 100000
        saveConfig()
    end,
})

LagTab:Toggle({
    Title = "Disable PostFX",
    Description = "Hapus blur, bloom, color correction",
    Icon = "image-off",
    Default = playerConfig.disablePostFX,
    Callback = function(state)
        playerConfig.disablePostFX = state
        for _, e in ipairs(game:GetService("Lighting"):GetChildren()) do
            if e:IsA("BlurEffect") or e:IsA("BloomEffect")
            or e:IsA("ColorCorrectionEffect") or e:IsA("SunRaysEffect")
            or e:IsA("DepthOfFieldEffect") then
                e.Enabled = not state
            end
        end
        saveConfig()
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
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                v.Enabled = not state
            end
        end
        saveConfig()
    end,
})

LagTab:Toggle({
    Title = "Hide Accessories",
    Description = "Sembunyikan aksesoris semua player",
    Icon = "shirt",
    Default = playerConfig.hideAccessories,
    Callback = function(state)
        playerConfig.hideAccessories = state
        for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
            if player.Character then
                for _, v in ipairs(player.Character:GetDescendants()) do
                    if v:IsA("Accessory") then
                        v.Handle.Transparency = state and 1 or 0
                    end
                end
            end
        end
        saveConfig()
    end,
})

LagTab:Toggle({
    Title = "Disable Animations",
    Description = "Hentikan animasi semua player",
    Icon = "person-standing",
    Default = playerConfig.disableAnimations,
    Callback = function(state)
        playerConfig.disableAnimations = state
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
        saveConfig()
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
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("Sound") then v.Volume = state and 0 or 1 end
        end
        game:GetService("SoundService").MusicVolume = state and 0 or 1
        saveConfig()
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
        playerConfig.reducedRender     = true
        applyAllSettings()
        saveConfig()
        WindUI:Notify({ Title = "TrapLag ⚡", Content = "Semua fitur anti-lag aktif!", Duration = 4 })
    end,
})

LagTab:Button({
    Title = "🔄 Reset All",
    Description = "Kembalikan semua pengaturan ke default",
    Icon = "rotate-ccw",
    Callback = function()
        for k, v in pairs(defaultConfig) do playerConfig[k] = v end
        applyAllSettings()
        saveConfig()
        WindUI:Notify({ Title = "TrapLag", Content = "Semua pengaturan direset ke default!", Duration = 3 })
    end,
})

-- ========================
-- TAB 2: CONFIG
-- ========================
local CfgTab = App:Tab({ Title = "Config", Icon = "settings" })

CfgTab:Section({ Title = "Player Config" })

CfgTab:Slider({
    Title = "Camera Sensitivity",
    Description = "Sensitivitas kamera (0.1 - 7.0)",
    Icon = "move",
    Min = 0.1,
    Max = 7,
    Default = playerConfig.cameraSensitivity,
    Decimals = 1,
    Callback = function(value)
        playerConfig.cameraSensitivity = value
        pcall(function()
            UserSettings():GetService("UserGameSettings").MouseSensitivity = value
        end)
        saveConfig()
    end,
})

CfgTab:Slider({
    Title = "FPS Target",
    Description = "Target FPS untuk FPS Unlocker (30-240)",
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
    Description = "Cek TrapLag/config/fonts/",
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
            WindUI:Notify({ Title = "Fonts", Content = "Belum ada font! Taruh .ttf & .json di TrapLag/config/fonts/", Duration = 5 })
        else
            WindUI:Notify({ Title = "Font Tersedia", Content = table.concat(names, ", "), Duration = 5 })
        end
    end,
})

CfgTab:Section({ Title = "Crosshair" })

CfgTab:Button({
    Title = "Lihat Crosshair Tersedia",
    Description = "Cek TrapLag/config/crosshair/",
    Icon = "crosshair",
    Callback = function()
        local files = listfiles("TrapLag/config/crosshair")
        local names = {}
        for _, f in ipairs(files) do
            if f:match("%.png$") then table.insert(names, f:match("([^/\\]+)$") or f) end
        end
        if #names == 0 then
            WindUI:Notify({ Title = "Crosshair", Content = "Belum ada crosshair! Taruh .png di TrapLag/config/crosshair/", Duration = 5 })
        else
            WindUI:Notify({ Title = "Crosshair Tersedia", Content = table.concat(names, ", "), Duration = 5 })
        end
    end,
})

CfgTab:Section({ Title = "Image / Logo" })

CfgTab:Button({
    Title = "Cek Logo",
    Description = "Cek apakah TrapLag/logo.png ada",
    Icon = "image",
    Callback = function()
        if isfile("TrapLag/logo.png") then
            WindUI:Notify({ Title = "Logo ✅", Content = "logo.png ditemukan!", Duration = 3 })
        else
            WindUI:Notify({ Title = "Logo ❌", Content = "logo.png belum ada! Taruh di folder TrapLag/", Duration = 4 })
        end
    end,
})

-- ========================
-- EXPORT / IMPORT SECTION
-- ========================
CfgTab:Section({ Title = "Export & Import Config" })

-- EXPORT
CfgTab:Button({
    Title = "📤 Export Config",
    Description = "Buat kode config untuk dibagikan ke player lain",
    Icon = "share-2",
    Callback = function()
        local code = generateExportCode()
        -- Copy ke clipboard kalau executor support
        pcall(function() setclipboard(code) end)
        -- Simpan ke file juga
        writefile("TrapLag/config/player/export.txt", code)
        WindUI:Notify({
            Title = "Export Berhasil! 📤",
            Content = "Kode disalin ke clipboard & disimpan di TrapLag/config/player/export.txt",
            Duration = 6,
        })
        warn("[TrapLag Export Code]\n" .. code)
    end,
})

-- IMPORT INPUT
CfgTab:Input({
    Title = "Import Code",
    Description = "Paste kode config dari player lain, lalu tekan Enter",
    Icon = "download",
    Placeholder = "Paste kode TRAPLAG-... disini",
    Callback = function(input)
        importCodeBuffer = input
    end,
})

-- IMPORT BUTTON
CfgTab:Button({
    Title = "📥 Apply Import",
    Description = "Tekan untuk apply kode yang sudah di-paste",
    Icon = "check-circle",
    Callback = function()
        if importCodeBuffer == "" then
            WindUI:Notify({ Title = "Import ❌", Content = "Kode kosong! Paste dulu kodenya.", Duration = 4 })
            return
        end

        local ok, status = importFromCode(importCodeBuffer)

        if ok then
            WindUI:Notify({
                Title = "Import Berhasil! ✅",
                Content = "Config berhasil diload & diapply!",
                Duration = 4,
            })
        elseif status == "expired" then
            WindUI:Notify({
                Title = "Import Gagal ⚠️",
                Content = "Kode sudah EXPIRED! TrapLag versi berbeda (v" .. TRAPLAG_VERSION .. ").",
                Duration = 6,
            })
        else
            WindUI:Notify({
                Title = "Import Gagal ❌",
                Content = "Kode tidak valid atau rusak. Cek ulang kodenya!",
                Duration = 5,
            })
        end

        importCodeBuffer = ""
    end,
})

--[[
  ChromaHub — TemplateScript.lua
  Template script dengan SEMUA contoh elemen WindUI
  Salin file ini untuk membuat game script baru!

  Cara pakai:
  1. Salin file ini → rename sesuai nama game (contoh: BloxFruits.lua)
  2. Tambahkan game ID di Gameid.json
  3. Sesuaikan logic di tiap Callback
  by HaZcK
--]]

-- ============================
-- LOAD LIBRARY
-- ============================
local RAW_URL = "https://raw.githubusercontent.com/HaZcK/ChromaHub/main/"

loadstring(game:HttpGet(RAW_URL .. "ScriptGame/LibraryScript.lua"))()

-- Ambil dari global env
local lib     = getgenv().ChromaLib
local WindUI  = getgenv().WindUI

if not lib then
    warn("[ChromaHub] LibraryScript gagal diload!")
    return
end

-- ============================
-- BUAT WINDOW
-- ============================
local Window = lib.CreateWindow({
    Title    = "ChromaHub",
    SubTitle = "Template Script",  -- ganti nama game di sini
    Acrylic  = true,
    Theme    = "Dark",
})

local Tabs = Window:CreateTabSection()

-- ============================
-- TABS
-- ============================
local MainTab   = Tabs:Add("Main",   "home")
local PlayerTab = Tabs:Add("Player", "user")
local VisualTab = Tabs:Add("Visual", "eye")
local MiscTab   = Tabs:Add("Misc",   "settings")
local InfoTab   = Tabs:Add("Info",   "info")

-- ============================================================
-- TAB: MAIN — Toggle & Button
-- ============================================================
MainTab:CreateSection("Contoh Toggle")

-- Toggle biasa
MainTab:CreateToggle("Auto Farm", false, function(state)
    print("Auto Farm:", state)
    lib.Notify("Auto Farm", state and "Aktif" or "Mati", 2, state and "success" or "error")
end)

MainTab:CreateToggle("Auto Collect", false, function(state)
    -- logic collect items here
    print("Auto Collect:", state)
end)

MainTab:CreateToggle("Auto Quest", false, function(state)
    -- logic auto quest here
    print("Auto Quest:", state)
end)

MainTab:CreateSection("Contoh Button")

-- Button biasa
MainTab:CreateButton("Teleport to Spawn", function()
    lib.TeleportTo(Vector3.new(0, 10, 0))
    lib.Notify("Teleport", "Teleported ke spawn!", 2, "success")
end)

-- Button dengan konfirmasi
MainTab:CreateButton("Rejoin Game", function()
    lib.Confirm("Rejoin", "Yakin mau rejoin server?", function(yes)
        if yes then
            game:GetService("TeleportService"):Teleport(game.PlaceId)
        end
    end)
end)

-- Button execute langsung
MainTab:CreateButton("Kill Aura (Test)", function()
    lib.Notify("Kill Aura", "Diaktifkan sementara!", 2, "warning")
    -- logic kill aura
end)

-- ============================================================
-- TAB: PLAYER — Slider, Input, Dropdown, Keybind
-- ============================================================
PlayerTab:CreateSection("Movement")

-- Slider
PlayerTab:CreateSlider("Walk Speed", {Min = 16, Max = 500, Default = 16}, function(val)
    local hum = lib.GetHumanoid()
    if hum then hum.WalkSpeed = val end
end)

PlayerTab:CreateSlider("Jump Power", {Min = 7, Max = 300, Default = 50}, function(val)
    local hum = lib.GetHumanoid()
    if hum then hum.JumpPower = val end
end)

PlayerTab:CreateSlider("Gravity", {Min = 10, Max = 196, Default = 196}, function(val)
    workspace.Gravity = val
end)

PlayerTab:CreateSection("Actions")

-- Toggle dengan built-in ChromaLib
PlayerTab:CreateToggle("No Clip", false, function(state)
    lib.SetNoclip(state)
    lib.Notify("No Clip", state and "ON" or "OFF", 2, state and "success" or "info")
end)

PlayerTab:CreateToggle("Infinite Jump", false, function(state)
    lib.SetInfJump(state)
    lib.Notify("Inf Jump", state and "ON" or "OFF", 2, state and "success" or "info")
end)

PlayerTab:CreateToggle("Anti AFK", true, function(state)
    if state then lib.AntiAFK() end
end)

PlayerTab:CreateSection("Input & Dropdown")

-- Input box
PlayerTab:CreateInput("Teleport ke Player", "Masukkan username...", function(text)
    if text == "" then return end
    local target = Players:FindFirstChild(text)
    if target and target.Character then
        lib.TeleportTo(target.Character.HumanoidRootPart.Position)
        lib.Notify("Teleport", "Teleported ke " .. text, 2, "success")
    else
        lib.Notify("Error", "Player '" .. text .. "' tidak ditemukan!", 3, "error")
    end
end)

-- Dropdown single
PlayerTab:CreateDropdown("Team Selector", {"Red Team", "Blue Team", "Green Team", "Spectator"}, function(selected)
    print("Team dipilih:", selected)
    lib.Notify("Team", "Dipilih: " .. selected, 2)
end)

-- Keybind
PlayerTab:CreateKeybind("Fly Toggle (Hotkey)", Enum.KeyCode.F, function()
    -- toggle fly logic here
    lib.Notify("Fly", "Toggled!", 2, "info")
end)

-- ============================================================
-- TAB: VISUAL — ColorPicker, ESP, dsb
-- ============================================================
VisualTab:CreateSection("ESP Settings")

-- Toggle ESP
local ESPEnabled = false
VisualTab:CreateToggle("Player ESP", false, function(state)
    ESPEnabled = state
    lib.Notify("ESP", state and "ESP ON" or "ESP OFF", 2, state and "success" or "info")
    -- Logic ESP di sini
end)

VisualTab:CreateToggle("Item ESP", false, function(state)
    -- Logic item esp
    print("Item ESP:", state)
end)

-- ColorPicker
local ESPColor = Color3.fromRGB(255, 50, 50)
VisualTab:CreateColorPicker("ESP Color", Color3.fromRGB(255, 50, 50), function(color)
    ESPColor = color
    -- update ESP color
end)

-- Slider opacity
VisualTab:CreateSlider("ESP Transparency", {Min = 0, Max = 100, Default = 0}, function(val)
    -- update transparency
    print("ESP Transparency:", val)
end)

VisualTab:CreateSection("Chams")

VisualTab:CreateToggle("Chams", false, function(state)
    lib.Notify("Chams", state and "ON" or "OFF", 2)
end)

VisualTab:CreateColorPicker("Chams Color", Color3.fromRGB(0, 170, 255), function(color)
    -- update chams color
end)

-- ============================================================
-- TAB: MISC — Label, Paragraph, Separator
-- ============================================================
MiscTab:CreateSection("Misc Features")

MiscTab:CreateToggle("Silent Aim", false, function(state)
    lib.Notify("Silent Aim", state and "ON" or "OFF", 2, state and "success" or "error")
end)

MiscTab:CreateToggle("Full Bright", false, function(state)
    game:GetService("Lighting").Brightness = state and 10 or 2
    game:GetService("Lighting").ClockTime  = state and 14 or 14
    lib.Notify("Full Bright", state and "ON" or "OFF", 2)
end)

MiscTab:CreateToggle("Auto Reconnect", false, function(state)
    -- logic auto reconnect
    print("Auto Reconnect:", state)
end)

MiscTab:CreateSection("UI Elemen Lainnya")

-- Label (teks static)
MiscTab:CreateLabel("Ini adalah contoh Label — teks statis.")

-- Separator / garis pembatas
MiscTab:CreateSeparator()

-- Paragraph (teks panjang / deskripsi)
MiscTab:CreateParagraph({
    Title   = "Catatan",
    Content = "TemplateScript.lua adalah boilerplate ChromaHub.\nSalin file ini untuk buat script game baru.\nSesuaikan Callback sesuai kebutuhan gamenya.",
})

MiscTab:CreateSeparator()

-- Notifikasi test button
MiscTab:CreateButton("Test Semua Notifikasi", function()
    task.spawn(function()
        lib.Notify("Info",    "Ini notifikasi info",    2, "info")    ; task.wait(1)
        lib.Notify("Success", "Ini notifikasi success", 2, "success") ; task.wait(1)
        lib.Notify("Warning", "Ini notifikasi warning", 2, "warning") ; task.wait(1)
        lib.Notify("Error",   "Ini notifikasi error",   2, "error")
    end)
end)

-- ============================================================
-- TAB: INFO
-- ============================================================
InfoTab:CreateSection("ChromaHub")

InfoTab:CreateParagraph({
    Title   = "About",
    Content = "ChromaHub v1.0.0\nDeveloper : HaZcK\nExecutor  : Delta Android\nGitHub    : github.com/HaZcK/ChromaHub",
})

InfoTab:CreateSeparator()

InfoTab:CreateLabel("Supported Games:")
InfoTab:CreateParagraph({
    Title   = "Games",
    Content = "• Blox Fruits\n• Pet Simulator X\n• Fruit Battlegrounds\n• Da Hood\n• Natural Disaster Survival",
})

InfoTab:CreateSeparator()

InfoTab:CreateButton("Discord (Coming Soon)", function()
    lib.Notify("Discord", "Link coming soon!", 2, "info")
end)

InfoTab:CreateButton("GitHub", function()
    lib.Notify("GitHub", "github.com/HaZcK/ChromaHub", 4, "info")
end)

-- ============================
-- DONE — Notif welcome
-- ============================
lib.Notify("ChromaHub", "Template berhasil diload!", 3, "success")
print("[ChromaHub] TemplateScript loaded ✓")

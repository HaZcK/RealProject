--[[
  ██████╗██╗  ██╗██████╗  ██████╗ ███╗   ███╗ █████╗ ██╗  ██╗██╗   ██╗██████╗
 ██╔════╝██║  ██║██╔══██╗██╔═══██╗████╗ ████║██╔══██╗██║  ██║██║   ██║██╔══██╗
 ██║     ███████║██████╔╝██║   ██║██╔████╔██║███████║███████║██║   ██║██████╔╝
 ██║     ██╔══██║██╔══██╗██║   ██║██║╚██╔╝██║██╔══██║██╔══██║██║   ██║██╔══██╗
 ╚██████╗██║  ██║██║  ██║╚██████╔╝██║ ╚═╝ ██║██║  ██║██║  ██║╚██████╔╝██████╔╝
  ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═════╝
  CoreScript.lua | by HaZcK
--]]

-- ============================
-- SERVICES
-- ============================
local TweenService   = game:GetService("TweenService")
local HttpService    = game:GetService("HttpService")
local Players        = game:GetService("Players")
local RunService     = game:GetService("RunService")
local LocalPlayer    = Players.LocalPlayer

-- ============================
-- CONFIG
-- ============================
local RAW_URL    = "https://raw.githubusercontent.com/HaZcK/ChromaHub/main/"
local GAMEID_URL = RAW_URL .. "Gameid.json"
local SCRIPT_URL = RAW_URL .. "ScriptGame/"

local COLOR_PURPLE  = Color3.fromRGB(150, 70, 255)
local COLOR_GREEN   = Color3.fromRGB(100, 220, 140)
local COLOR_RED     = Color3.fromRGB(255, 80, 80)
local COLOR_YELLOW  = Color3.fromRGB(255, 200, 60)
local COLOR_BG      = Color3.fromRGB(8, 8, 14)
local COLOR_DIM     = Color3.fromRGB(110, 110, 130)
local COLOR_TEXT    = Color3.fromRGB(200, 200, 215)

-- ============================
-- LOADING SCREEN GUI
-- ============================
local Gui = Instance.new("ScreenGui")
Gui.Name          = "ChromaHubLoader"
Gui.ResetOnSpawn  = false
Gui.DisplayOrder  = 999
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

pcall(function() Gui.Parent = game:GetService("CoreGui") end)
if not Gui.Parent then
    Gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- Background full screen
local BG = Instance.new("Frame")
BG.Size              = UDim2.fromScale(1, 1)
BG.BackgroundColor3  = COLOR_BG
BG.BorderSizePixel   = 0
BG.ZIndex            = 1
BG.Parent            = Gui

-- Gradient overlay background
local UIGrad = Instance.new("UIGradient")
UIGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 6, 20)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(6, 6, 12)),
})
UIGrad.Rotation = 135
UIGrad.Parent = BG

-- Center container
local Container = Instance.new("Frame")
Container.AnchorPoint      = Vector2.new(0.5, 0.5)
Container.Size             = UDim2.new(0, 420, 0, 220)
Container.Position         = UDim2.new(0.5, 0, 0.5, 0)
Container.BackgroundTransparency = 1
Container.Parent           = BG

-- Glow circle behind title (decorative)
local Glow = Instance.new("Frame")
Glow.AnchorPoint           = Vector2.new(0.5, 0)
Glow.Size                  = UDim2.new(0, 300, 0, 80)
Glow.Position              = UDim2.new(0.5, 0, 0, -10)
Glow.BackgroundTransparency = 1
Glow.Parent                = Container
local GlowGrad = Instance.new("UIGradient")
GlowGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 0, 180)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(160, 60, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 0, 180)),
})
GlowGrad.Rotation = 0
GlowGrad.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 1),
    NumberSequenceKeypoint.new(0.3, 0.85),
    NumberSequenceKeypoint.new(0.5, 0.80),
    NumberSequenceKeypoint.new(0.7, 0.85),
    NumberSequenceKeypoint.new(1, 1),
})
GlowGrad.Parent = Glow

-- Title "CHROMAHUB"
local Title = Instance.new("TextLabel")
Title.AnchorPoint         = Vector2.new(0.5, 0)
Title.Size                = UDim2.new(1, 0, 0, 55)
Title.Position            = UDim2.new(0.5, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text                = ""
Title.TextColor3          = COLOR_PURPLE
Title.Font                = Enum.Font.GothamBold
Title.TextSize            = 40
Title.TextTransparency    = 1
Title.Parent              = Container

-- Subtitle
local Sub = Instance.new("TextLabel")
Sub.AnchorPoint           = Vector2.new(0.5, 0)
Sub.Size                  = UDim2.new(1, 0, 0, 18)
Sub.Position              = UDim2.new(0.5, 0, 0, 58)
Sub.BackgroundTransparency = 1
Sub.Text                  = "universal script hub"
Sub.TextColor3            = COLOR_DIM
Sub.Font                  = Enum.Font.Gotham
Sub.TextSize              = 12
Sub.TextTransparency      = 1
Sub.LetterSpacing         = 2
Sub.Parent                = Container

-- Divider line (starts width 0)
local Line = Instance.new("Frame")
Line.AnchorPoint          = Vector2.new(0.5, 0)
Line.Size                 = UDim2.new(0, 0, 0, 1)
Line.Position             = UDim2.new(0.5, 0, 0, 85)
Line.BackgroundColor3     = COLOR_PURPLE
Line.BackgroundTransparency = 0.3
Line.BorderSizePixel      = 0
Line.Parent               = Container

-- Log frame (for step messages)
local LogFrame = Instance.new("Frame")
LogFrame.Size             = UDim2.new(1, 0, 0, 100)
LogFrame.Position         = UDim2.new(0, 0, 0, 96)
LogFrame.BackgroundTransparency = 1
LogFrame.ClipsDescendants = true
LogFrame.Parent           = Container

local UIList = Instance.new("UIListLayout")
UIList.SortOrder          = Enum.SortOrder.LayoutOrder
UIList.Padding            = UDim.new(0, 5)
UIList.Parent             = LogFrame

-- Version label bottom
local VerLabel = Instance.new("TextLabel")
VerLabel.AnchorPoint      = Vector2.new(0.5, 1)
VerLabel.Size             = UDim2.new(1, 0, 0, 16)
VerLabel.Position         = UDim2.new(0.5, 0, 1, -12)
VerLabel.BackgroundTransparency = 1
VerLabel.Text             = "v1.0.0  |  by HaZcK"
VerLabel.TextColor3       = Color3.fromRGB(60, 60, 75)
VerLabel.Font             = Enum.Font.Gotham
VerLabel.TextSize         = 10
VerLabel.Parent           = BG

-- ============================
-- HELPERS
-- ============================
local logOrder = 0

local function TweenObj(obj, props, t, style)
    local ti = TweenInfo.new(t or 0.4, style or Enum.EasingStyle.Quint)
    TweenService:Create(obj, ti, props):Play()
end

local function addLog(text, color)
    logOrder += 1
    local lbl = Instance.new("TextLabel")
    lbl.Size              = UDim2.new(1, -10, 0, 18)
    lbl.BackgroundTransparency = 1
    lbl.Text              = text
    lbl.TextColor3        = color or COLOR_TEXT
    lbl.Font              = Enum.Font.Gotham
    lbl.TextSize          = 12
    lbl.TextXAlignment    = Enum.TextXAlignment.Left
    lbl.TextTransparency  = 1
    lbl.LayoutOrder       = logOrder
    lbl.Parent            = LogFrame
    TweenObj(lbl, {TextTransparency = 0}, 0.25)
    return lbl
end

local function fadeAll()
    TweenObj(BG, {BackgroundTransparency = 1}, 0.55, Enum.EasingStyle.Quad)
    TweenObj(Title, {TextTransparency = 1}, 0.4)
    TweenObj(Sub, {TextTransparency = 1}, 0.4)
    TweenObj(Line, {BackgroundTransparency = 1}, 0.4)
    for _, v in ipairs(LogFrame:GetChildren()) do
        if v:IsA("TextLabel") then
            TweenObj(v, {TextTransparency = 1}, 0.35)
        end
    end
end

-- ============================
-- ANIMATION INTRO
-- ============================

-- Fade in title
TweenObj(Title, {TextTransparency = 0}, 0.5)
TweenObj(Sub,   {TextTransparency = 0}, 0.7)
task.wait(0.5)

-- Typewriter effect on title
local fullText = "CHROMAHUB"
Title.Text = ""
for i = 1, #fullText do
    Title.Text = string.sub(fullText, 1, i)
    task.wait(0.055)
end
task.wait(0.15)

-- Expand divider line
TweenObj(Line, {Size = UDim2.new(0.85, 0, 0, 1)}, 0.45)
task.wait(0.55)

-- ============================
-- STEP 1: loading Place..
-- ============================
local log1 = addLog("  › loading Place..")
task.wait(0.2)

local gameData = nil
local ok1, err1 = pcall(function()
    local raw = game:HttpGet(GAMEID_URL)
    gameData = HttpService:JSONDecode(raw)
end)

if not ok1 then
    log1.Text      = "  ✗ loading Place.. [FAILED]"
    log1.TextColor3 = COLOR_RED
    addLog("    " .. tostring(err1), COLOR_RED)
    task.wait(3)
    fadeAll()
    task.wait(0.6)
    Gui:Destroy()
    return
end

local gameCount = #gameData.games
log1.Text      = "  ✓ loading Place.. [" .. gameCount .. " games supported]"
log1.TextColor3 = COLOR_GREEN
task.wait(0.45)

-- ============================
-- STEP 2: loading Script..
-- ============================
local log2 = addLog("  › loading Script..")
task.wait(0.2)

local PlaceId   = game.PlaceId
local foundGame = nil

for _, entry in ipairs(gameData.games) do
    if tonumber(entry.id) == PlaceId then
        foundGame = entry
        break
    end
end

if not foundGame then
    log2.Text       = "  ✗ loading Script.. [GAME NOT SUPPORTED]"
    log2.TextColor3 = COLOR_YELLOW
    addLog("    PlaceId " .. PlaceId .. " tidak ditemukan.", COLOR_DIM)
    task.wait(3)
    fadeAll()
    task.wait(0.6)
    Gui:Destroy()
    return
end

log2.Text       = "  ✓ loading Script.. [" .. foundGame.name .. "]"
log2.TextColor3 = COLOR_GREEN
task.wait(0.45)

-- ============================
-- STEP 3: Installation Ui..
-- ============================
local log3 = addLog("  › Installation Ui..")
task.wait(0.2)

local scriptContent = nil
local ok3, err3 = pcall(function()
    scriptContent = game:HttpGet(SCRIPT_URL .. foundGame.script .. ".lua")
end)

if not ok3 then
    log3.Text       = "  ✗ Installation Ui.. [FAILED]"
    log3.TextColor3 = COLOR_RED
    addLog("    " .. tostring(err3), COLOR_RED)
    task.wait(3)
    fadeAll()
    task.wait(0.6)
    Gui:Destroy()
    return
end

log3.Text       = "  ✓ Installation Ui.. [ready]"
log3.TextColor3 = COLOR_GREEN
task.wait(0.5)

-- ============================
-- FADE OUT & EXECUTE
-- ============================
addLog("  ✓ Launching " .. foundGame.name .. "...", COLOR_PURPLE)
task.wait(0.4)

fadeAll()
task.wait(0.65)
Gui:Destroy()

-- Execute game script!
loadstring(scriptContent)()

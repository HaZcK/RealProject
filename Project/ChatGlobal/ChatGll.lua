--[[
    ╔═══════════════════════════════════════╗
    ║       ChatGlobal v1.0                 ║
    ║       by KHAFIDZKTP                   ║
    ║       Global Chat - Custom GUI        ║
    ╚═══════════════════════════════════════╝

    BACKEND SETUP (Gratis pakai Glitch.com):
    1. Buka glitch.com → New Project → Node.js
    2. Di server.js paste kode ini:

    const express = require('express');
    const app = express();
    app.use(express.json());
    let messages = [];
    let idCounter = 0;

    app.get('/messages', (req, res) => {
        const lang = req.query.lang || 'ALL';
        const sensor = req.query.sensor === 'true';
        const after = parseInt(req.query.after) || 0;
        let msgs = messages.filter(m => m.id > after);
        if (lang !== 'ALL') msgs = msgs.filter(m => m.lang === lang || m.lang === 'ALL');
        res.json(msgs);
    });

    app.post('/send', (req, res) => {
        const { user, message, lang } = req.body;
        if (!user || !message) return res.status(400).json({error:'missing fields'});
        const msg = { id: ++idCounter, user, message, lang: lang||'ALL', time: Date.now() };
        messages.push(msg);
        if (messages.length > 200) messages.shift();
        res.json({ok:true, id:msg.id});
    });

    app.listen(3000);

    3. Copy URL glitch kamu (contoh: https://my-chat.glitch.me)
    4. Ganti CFG.URL di bawah dengan URL itu
--]]

-- ══════════════════════════════════════
-- SERVICES
-- ══════════════════════════════════════
local Players        = game:GetService("Players")
local HttpService    = game:GetService("HttpService")
local TweenService   = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService     = game:GetService("RunService")

local LP    = Players.LocalPlayer
local PGui  = LP:WaitForChild("PlayerGui")

-- ══════════════════════════════════════
-- CONFIG (ubah sesuai kebutuhan)
-- ══════════════════════════════════════
local CFG = {
    URL      = "chatglobal-server-production.up.railway.app", -- ← ganti ini
    Lang     = "ALL",    -- ALL / ID / EN
    Sensor   = false,    -- false = no sensor
    Delay    = 3,        -- detik antar poll
    Username = LP.Name,
    Presets  = {
        "Halo semua! 👋",
        "GG bro!",
        "Ada yang main bareng?",
        "Ez pz lemon squeezy",
    },
    LastId   = 0,
}

-- Default tersimpan
local DEFAULT = {
    Lang   = "ALL",
    Sensor = false,
    Delay  = 3,
}

-- ══════════════════════════════════════
-- HTTP HELPER (kompatibel semua executor)
-- ══════════════════════════════════════
local function httpGet(url)
    local ok, res = pcall(function()
        return game:HttpGet(url, true)
    end)
    return ok and res or nil
end

local function httpPost(url, body)
    local json = HttpService:JSONEncode(body)
    local reqFn = (syn and syn.request)
        or (http and http.request)
        or (request)
        or nil

    if reqFn then
        local ok, res = pcall(reqFn, {
            Url    = url,
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body   = json,
        })
        return ok
    else
        -- fallback pakai HttpService (mungkin diblok executor)
        local ok = pcall(function()
            HttpService:PostAsync(url, json, Enum.HttpContentType.ApplicationJson)
        end)
        return ok
    end
end

-- ══════════════════════════════════════
-- WARNA & STYLE
-- ══════════════════════════════════════
local C = {
    BG       = Color3.fromRGB(13, 14, 22),
    Panel    = Color3.fromRGB(22, 23, 36),
    PanelAlt = Color3.fromRGB(28, 30, 46),
    Accent   = Color3.fromRGB(99, 102, 241),
    AccentHov= Color3.fromRGB(79, 82, 221),
    Green    = Color3.fromRGB(52, 211, 153),
    Red      = Color3.fromRGB(239, 68, 68),
    Yellow   = Color3.fromRGB(251, 191, 36),
    Text     = Color3.fromRGB(226, 232, 240),
    TextDim  = Color3.fromRGB(100, 116, 139),
    Border   = Color3.fromRGB(40, 42, 60),
    MsgSelf  = Color3.fromRGB(79, 82, 221),
    MsgOther = Color3.fromRGB(30, 32, 50),
}

local function tween(obj, props, t, style, dir)
    TweenService:Create(obj,
        TweenInfo.new(t or 0.2, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out),
        props
    ):Play()
end

-- ══════════════════════════════════════
-- GUI BUILDER
-- ══════════════════════════════════════

-- Hapus GUI lama
if PGui:FindFirstChild("ChatGlobalUI") then
    PGui.ChatGlobalUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name            = "ChatGlobalUI"
ScreenGui.ResetOnSpawn    = false
ScreenGui.ZIndexBehavior  = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder    = 999
ScreenGui.Parent          = PGui

-- ── Main Window ──────────────────────
local WIN_W, WIN_H = 480, 390

local MainFrame = Instance.new("Frame")
MainFrame.Name            = "MainFrame"
MainFrame.Size            = UDim2.new(0, WIN_W, 0, WIN_H)
MainFrame.Position        = UDim2.new(0.5, -WIN_W/2, 0.5, -WIN_H/2)
MainFrame.BackgroundColor3 = C.BG
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent          = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local Shadow = Instance.new("ImageLabel")
Shadow.Name               = "Shadow"
Shadow.Size               = UDim2.new(1, 30, 1, 30)
Shadow.Position           = UDim2.new(0, -15, 0, -10)
Shadow.BackgroundTransparency = 1
Shadow.Image              = "rbxassetid://6014261993"
Shadow.ImageColor3        = Color3.fromRGB(0,0,0)
Shadow.ImageTransparency  = 0.5
Shadow.ScaleType          = Enum.ScaleType.Slice
Shadow.SliceCenter        = Rect.new(49,49,450,450)
Shadow.ZIndex             = 0
Shadow.Parent             = MainFrame

-- Border glow
local BorderFrame = Instance.new("Frame")
BorderFrame.Size          = UDim2.new(1, 2, 1, 2)
BorderFrame.Position      = UDim2.new(0, -1, 0, -1)
BorderFrame.BackgroundColor3 = C.Accent
BorderFrame.BackgroundTransparency = 0.7
BorderFrame.ZIndex        = 0
BorderFrame.Parent        = MainFrame
Instance.new("UICorner", BorderFrame).CornerRadius = UDim.new(0, 13)

-- ── Title Bar ────────────────────────
local TitleBar = Instance.new("Frame")
TitleBar.Name             = "TitleBar"
TitleBar.Size             = UDim2.new(1, 0, 0, 44)
TitleBar.BackgroundColor3 = C.Panel
TitleBar.BorderSizePixel  = 0
TitleBar.Parent           = MainFrame

-- gradient
local TitleGrad = Instance.new("UIGradient")
TitleGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 32, 60)),
    ColorSequenceKeypoint.new(1, C.Panel),
})
TitleGrad.Rotation = 90
TitleGrad.Parent = TitleBar

local TitleIcon = Instance.new("TextLabel")
TitleIcon.Size            = UDim2.new(0, 30, 0, 30)
TitleIcon.Position        = UDim2.new(0, 12, 0.5, -15)
TitleIcon.BackgroundTransparency = 1
TitleIcon.Text            = "💬"
TitleIcon.TextSize        = 18
TitleIcon.Parent          = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size           = UDim2.new(0, 200, 1, 0)
TitleLabel.Position       = UDim2.new(0, 42, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text           = "ChatGlobal"
TitleLabel.TextColor3     = C.Text
TitleLabel.TextSize       = 15
TitleLabel.Font           = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent         = TitleBar

local StatusDot = Instance.new("Frame")
StatusDot.Size            = UDim2.new(0, 8, 0, 8)
StatusDot.Position        = UDim2.new(0, 42, 0.5, 4)
StatusDot.BackgroundColor3 = C.Yellow
StatusDot.BorderSizePixel = 0
StatusDot.Parent          = TitleBar
Instance.new("UICorner", StatusDot).CornerRadius = UDim.new(1, 0)

local SubLabel = Instance.new("TextLabel")
SubLabel.Size             = UDim2.new(0, 200, 0, 14)
SubLabel.Position         = UDim2.new(0, 54, 0.5, 4)
SubLabel.BackgroundTransparency = 1
SubLabel.Text             = "Menghubungkan..."
SubLabel.TextColor3       = C.TextDim
SubLabel.TextSize         = 11
SubLabel.Font             = Enum.Font.Gotham
SubLabel.TextXAlignment   = Enum.TextXAlignment.Left
SubLabel.Parent           = TitleBar

-- Close & Minimize buttons
local function makeWindowBtn(icon, xPos, color, callback)
    local btn = Instance.new("TextButton")
    btn.Size     = UDim2.new(0, 28, 0, 28)
    btn.Position = UDim2.new(1, xPos, 0.5, -14)
    btn.BackgroundColor3 = color
    btn.BackgroundTransparency = 0.5
    btn.Text     = icon
    btn.TextSize = 14
    btn.Font     = Enum.Font.GothamBold
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.BorderSizePixel = 0
    btn.Parent   = TitleBar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseEnter:Connect(function() tween(btn, {BackgroundTransparency=0.1}) end)
    btn.MouseLeave:Connect(function() tween(btn, {BackgroundTransparency=0.5}) end)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

makeWindowBtn("✕", -10, C.Red, function()
    tween(MainFrame, {Size=UDim2.new(0,WIN_W,0,0), Position=UDim2.new(0.5,-WIN_W/2,0.5,0)}, 0.25)
    task.delay(0.3, function() ScreenGui:Destroy() end)
end)

local minimized = false
local ContentHolder -- forward declare
makeWindowBtn("─", -44, C.Yellow, function()
    minimized = not minimized
    if minimized then
        tween(MainFrame, {Size=UDim2.new(0,WIN_W,0,44)}, 0.25)
    else
        tween(MainFrame, {Size=UDim2.new(0,WIN_W,0,WIN_H)}, 0.25)
    end
end)

-- ── Drag ─────────────────────────────
do
    local dragging, dragStart, startPos
    TitleBar.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragging  = true
            dragStart = i.Position
            startPos  = MainFrame.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            local delta = i.Position - dragStart
            MainFrame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

-- ── Tab Bar ──────────────────────────
local TabBar = Instance.new("Frame")
TabBar.Name             = "TabBar"
TabBar.Size             = UDim2.new(1, 0, 0, 38)
TabBar.Position         = UDim2.new(0, 0, 0, 44)
TabBar.BackgroundColor3 = C.Panel
TabBar.BorderSizePixel  = 0
TabBar.Parent           = MainFrame

local TabLayout = Instance.new("UIListLayout")
TabLayout.FillDirection  = Enum.FillDirection.Horizontal
TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
TabLayout.Padding        = UDim.new(0, 4)
TabLayout.Parent         = TabBar

Instance.new("UIPadding", TabBar).PaddingLeft = UDim.new(0, 8)

-- Divider bawah tab
local TabDivider = Instance.new("Frame")
TabDivider.Size          = UDim2.new(1, 0, 0, 1)
TabDivider.Position      = UDim2.new(0, 0, 1, -1)
TabDivider.BackgroundColor3 = C.Border
TabDivider.BorderSizePixel = 0
TabDivider.Parent        = TabBar

-- ── Content Area ─────────────────────
ContentHolder = Instance.new("Frame")
ContentHolder.Name          = "Content"
ContentHolder.Size          = UDim2.new(1, 0, 1, -82)
ContentHolder.Position      = UDim2.new(0, 0, 0, 82)
ContentHolder.BackgroundColor3 = C.BG
ContentHolder.BorderSizePixel = 0
ContentHolder.ClipsDescendants = true
ContentHolder.Parent        = MainFrame

-- ══════════════════════════════════════
-- TAB SYSTEM
-- ══════════════════════════════════════
local tabs = {}
local activeTab = nil

local function makeTab(name, icon)
    local btn = Instance.new("TextButton")
    btn.Size     = UDim2.new(0, 90, 1, -8)
    btn.BackgroundColor3 = C.BG
    btn.BackgroundTransparency = 1
    btn.Text     = icon .. " " .. name
    btn.TextSize = 12
    btn.Font     = Enum.Font.GothamSemibold
    btn.TextColor3 = C.TextDim
    btn.BorderSizePixel = 0
    btn.AutomaticSize = Enum.AutomaticSize.X
    btn.Parent   = TabBar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    Instance.new("UIPadding", btn).PaddingLeft = UDim.new(0, 8)

    local indicator = Instance.new("Frame")
    indicator.Size  = UDim2.new(1, -16, 0, 2)
    indicator.Position = UDim2.new(0, 8, 1, -3)
    indicator.BackgroundColor3 = C.Accent
    indicator.BorderSizePixel = 0
    indicator.BackgroundTransparency = 1
    indicator.Parent = btn
    Instance.new("UICorner", indicator).CornerRadius = UDim.new(1, 0)

    local page = Instance.new("Frame")
    page.Name   = name
    page.Size   = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.Visible = false
    page.Parent  = ContentHolder

    local tab = { btn=btn, page=page, indicator=indicator }
    tabs[name] = tab

    btn.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do
            t.page.Visible = false
            tween(t.btn, {TextColor3=C.TextDim})
            tween(t.indicator, {BackgroundTransparency=1})
        end
        page.Visible = true
        tween(btn, {TextColor3=C.Text})
        tween(indicator, {BackgroundTransparency=0})
        activeTab = name
    end)

    btn.MouseEnter:Connect(function()
        if activeTab ~= name then tween(btn, {TextColor3=C.Text}) end
    end)
    btn.MouseLeave:Connect(function()
        if activeTab ~= name then tween(btn, {TextColor3=C.TextDim}) end
    end)

    return page
end

-- ══════════════════════════════════════
-- HELPER WIDGETS
-- ══════════════════════════════════════
local function makeLabel(parent, text, size, pos, color, textSize, font)
    local l = Instance.new("TextLabel")
    l.Size     = size
    l.Position = pos
    l.BackgroundTransparency = 1
    l.Text     = text
    l.TextColor3 = color or C.TextDim
    l.TextSize = textSize or 12
    l.Font     = font or Enum.Font.Gotham
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent   = parent
    return l
end

local function makeButton(parent, text, size, pos, bg, callback)
    local btn = Instance.new("TextButton")
    btn.Size     = size
    btn.Position = pos
    btn.BackgroundColor3 = bg
    btn.Text     = text
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.TextSize = 12
    btn.Font     = Enum.Font.GothamSemibold
    btn.BorderSizePixel = 0
    btn.Parent   = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    btn.MouseEnter:Connect(function() tween(btn, {BackgroundColor3=Color3.new(
        bg.R*0.85, bg.G*0.85, bg.B*0.85)}) end)
    btn.MouseLeave:Connect(function() tween(btn, {BackgroundColor3=bg}) end)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local function makeToggle(parent, label, pos, default, callback)
    local holder = Instance.new("Frame")
    holder.Size  = UDim2.new(1, -24, 0, 34)
    holder.Position = pos
    holder.BackgroundColor3 = C.PanelAlt
    holder.BorderSizePixel = 0
    holder.Parent = parent
    Instance.new("UICorner", holder).CornerRadius = UDim.new(0, 8)

    makeLabel(holder, label, UDim2.new(1,-60,1,0), UDim2.new(0,12,0,0), C.Text, 12, Enum.Font.GothamSemibold)

    local state = default
    local trackBG = state and C.Green or C.PanelAlt
    local track = Instance.new("Frame")
    track.Size  = UDim2.new(0, 40, 0, 22)
    track.Position = UDim2.new(1, -52, 0.5, -11)
    track.BackgroundColor3 = trackBG
    track.BorderSizePixel = 0
    track.Parent = holder
    Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

    local knob = Instance.new("Frame")
    knob.Size   = UDim2.new(0, 18, 0, 18)
    knob.Position = state and UDim2.new(1,-20,0.5,-9) or UDim2.new(0,2,0.5,-9)
    knob.BackgroundColor3 = Color3.fromRGB(255,255,255)
    knob.BorderSizePixel = 0
    knob.Parent = track
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

    local btn = Instance.new("TextButton")
    btn.Size   = UDim2.new(1,0,1,0)
    btn.BackgroundTransparency = 1
    btn.Text   = ""
    btn.Parent = holder

    btn.MouseButton1Click:Connect(function()
        state = not state
        if state then
            tween(track, {BackgroundColor3=C.Green})
            tween(knob,  {Position=UDim2.new(1,-20,0.5,-9)})
        else
            tween(track, {BackgroundColor3=Color3.fromRGB(50,52,70)})
            tween(knob,  {Position=UDim2.new(0,2,0.5,-9)})
        end
        callback(state)
    end)

    return holder, function() return state end
end

-- ══════════════════════════════════════
-- TAB 1: MAIN (Chat)
-- ══════════════════════════════════════
local MainPage = makeTab("Chat", "💬")

-- Chat Display
local ChatScroll = Instance.new("ScrollingFrame")
ChatScroll.Size              = UDim2.new(1, -20, 1, -80)
ChatScroll.Position          = UDim2.new(0, 10, 0, 10)
ChatScroll.BackgroundColor3  = C.Panel
ChatScroll.BorderSizePixel   = 0
ChatScroll.ScrollBarThickness = 3
ChatScroll.ScrollBarImageColor3 = C.Accent
ChatScroll.CanvasSize        = UDim2.new(0,0,0,0)
ChatScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
ChatScroll.Parent            = MainPage
Instance.new("UICorner", ChatScroll).CornerRadius = UDim.new(0, 10)

local ChatLayout = Instance.new("UIListLayout")
ChatLayout.Padding           = UDim.new(0, 4)
ChatLayout.FillDirection     = Enum.FillDirection.Vertical
ChatLayout.SortOrder         = Enum.SortOrder.LayoutOrder
ChatLayout.Parent            = ChatScroll

local ChatPad = Instance.new("UIPadding")
ChatPad.PaddingTop    = UDim.new(0, 8)
ChatPad.PaddingBottom = UDim.new(0, 8)
ChatPad.PaddingLeft   = UDim.new(0, 8)
ChatPad.PaddingRight  = UDim.new(0, 8)
ChatPad.Parent        = ChatScroll

-- Input Bar
local InputBar = Instance.new("Frame")
InputBar.Size            = UDim2.new(1, -20, 0, 38)
InputBar.Position        = UDim2.new(0, 10, 1, -48)
InputBar.BackgroundColor3 = C.Panel
InputBar.BorderSizePixel = 0
InputBar.Parent          = MainPage
Instance.new("UICorner", InputBar).CornerRadius = UDim.new(0, 10)

local MsgInput = Instance.new("TextBox")
MsgInput.Size            = UDim2.new(1, -86, 1, -10)
MsgInput.Position        = UDim2.new(0, 12, 0, 5)
MsgInput.BackgroundTransparency = 1
MsgInput.Text            = ""
MsgInput.PlaceholderText = "Tulis pesan... (Enter kirim)"
MsgInput.PlaceholderColor3 = C.TextDim
MsgInput.TextColor3      = C.Text
MsgInput.TextSize        = 13
MsgInput.Font            = Enum.Font.Gotham
MsgInput.TextXAlignment  = Enum.TextXAlignment.Left
MsgInput.ClearTextOnFocus = false
MsgInput.Parent          = InputBar

local SendBtn = Instance.new("TextButton")
SendBtn.Size             = UDim2.new(0, 70, 0, 28)
SendBtn.Position         = UDim2.new(1, -74, 0.5, -14)
SendBtn.BackgroundColor3 = C.Accent
SendBtn.Text             = "Kirim ↗"
SendBtn.TextColor3       = Color3.fromRGB(255,255,255)
SendBtn.TextSize         = 12
SendBtn.Font             = Enum.Font.GothamSemibold
SendBtn.BorderSizePixel  = 0
SendBtn.Parent           = InputBar
Instance.new("UICorner", SendBtn).CornerRadius = UDim.new(0, 8)

-- Lang badge on chat
local LangBadge = Instance.new("TextLabel")
LangBadge.Size           = UDim2.new(0, 60, 0, 18)
LangBadge.Position       = UDim2.new(1, -70, 0, -22)
LangBadge.BackgroundColor3 = C.Accent
LangBadge.Text           = "🌐 ALL"
LangBadge.TextColor3     = Color3.fromRGB(255,255,255)
LangBadge.TextSize       = 10
LangBadge.Font           = Enum.Font.GothamBold
LangBadge.BorderSizePixel = 0
LangBadge.Parent         = ChatScroll
Instance.new("UICorner", LangBadge).CornerRadius = UDim.new(0, 5)

-- Action buttons (Load & Set Default)
local LoadBtn    = makeButton(MainPage, "⟳ Load",       UDim2.new(0,90,0,26),  UDim2.new(0,10,1,-48+8), C.Accent,  nil)
local DefBtn     = makeButton(MainPage, "★ Set Default", UDim2.new(0,110,0,26), UDim2.new(0,106,1,-48+8), C.Panel, nil)
LoadBtn.Position  = UDim2.new(0,10,1,-48) -- overlap, fix
-- reposition cleanly below chat:
LoadBtn.Size      = UDim2.new(0, 80, 0, 26)
LoadBtn.Position  = UDim2.new(0, 10, 1, -44)
DefBtn.Size       = UDim2.new(0, 110, 0, 26)
DefBtn.Position   = UDim2.new(0, 96, 1, -44)
-- move InputBar up a bit
InputBar.Position = UDim2.new(0, 210, 1, -44)
InputBar.Size     = UDim2.new(1, -220, 0, 36)

ChatScroll.Size   = UDim2.new(1, -20, 1, -90)

-- ══════════════════════════════════════
-- TAB 2: SETTINGS
-- ══════════════════════════════════════
local SettingsPage = makeTab("Settings", "⚙")

makeLabel(SettingsPage, "Server URL", UDim2.new(1,-24,0,16), UDim2.new(0,12,0,12), C.Text, 12, Enum.Font.GothamSemibold)

local URLBox = Instance.new("TextBox")
URLBox.Size            = UDim2.new(1, -24, 0, 34)
URLBox.Position        = UDim2.new(0, 12, 0, 34)
URLBox.BackgroundColor3 = C.PanelAlt
URLBox.Text            = CFG.URL
URLBox.PlaceholderText = "https://your-app.glitch.me"
URLBox.PlaceholderColor3 = C.TextDim
URLBox.TextColor3      = C.Text
URLBox.TextSize        = 11
URLBox.Font            = Enum.Font.Gotham
URLBox.BorderSizePixel = 0
URLBox.Parent          = SettingsPage
Instance.new("UICorner", URLBox).CornerRadius = UDim.new(0, 8)
Instance.new("UIPadding", URLBox).PaddingLeft = UDim.new(0, 10)

makeLabel(SettingsPage, "Bahasa / Language", UDim2.new(1,-24,0,16), UDim2.new(0,12,0,78), C.Text, 12, Enum.Font.GothamSemibold)

-- Language selector (3 buttons)
local langOptions = {"ALL", "ID", "EN"}
local langBtns = {}
local LangRow = Instance.new("Frame")
LangRow.Size             = UDim2.new(1,-24,0,32)
LangRow.Position         = UDim2.new(0,12,0,98)
LangRow.BackgroundTransparency = 1
LangRow.Parent           = SettingsPage

for i, lang in ipairs(langOptions) do
    local lb = Instance.new("TextButton")
    lb.Size              = UDim2.new(0, 72, 1, 0)
    lb.Position          = UDim2.new(0, (i-1)*78, 0, 0)
    lb.BackgroundColor3  = lang == CFG.Lang and C.Accent or C.PanelAlt
    lb.Text              = lang
    lb.TextColor3        = Color3.fromRGB(255,255,255)
    lb.TextSize          = 12
    lb.Font              = Enum.Font.GothamSemibold
    lb.BorderSizePixel   = 0
    lb.Parent            = LangRow
    Instance.new("UICorner", lb).CornerRadius = UDim.new(0, 8)
    langBtns[lang] = lb

    lb.MouseButton1Click:Connect(function()
        CFG.Lang = lang
        LangBadge.Text = "🌐 " .. lang
        for _, b in pairs(langBtns) do
            tween(b, {BackgroundColor3=C.PanelAlt})
        end
        tween(lb, {BackgroundColor3=C.Accent})
    end)
end

-- Sensor toggle
local sensorToggle, getSensor = makeToggle(
    SettingsPage, "🔒 Sensor (filter kata)", UDim2.new(0,12,0,142), CFG.Sensor,
    function(v) CFG.Sensor = v end
)

-- Delay slider label
makeLabel(SettingsPage, "Delay Poll: " .. CFG.Delay .. " detik", UDim2.new(1,-24,0,16), UDim2.new(0,12,0,186), C.Text, 12, Enum.Font.GothamSemibold)
local DelayLabel = SettingsPage:FindFirstChildWhichIsA("TextLabel", true) -- we'll update this

-- rewrite: just add a dedicated label
local DelayLbl = makeLabel(SettingsPage, "⏱  Delay Poll: 3 detik", UDim2.new(1,-24,0,18), UDim2.new(0,12,0,186), C.Text, 12, Enum.Font.GothamSemibold)

local SliderTrack = Instance.new("Frame")
SliderTrack.Size           = UDim2.new(1,-24,0,6)
SliderTrack.Position       = UDim2.new(0,12,0,212)
SliderTrack.BackgroundColor3 = C.PanelAlt
SliderTrack.BorderSizePixel = 0
SliderTrack.Parent         = SettingsPage
Instance.new("UICorner", SliderTrack).CornerRadius = UDim.new(1, 0)

local SliderFill = Instance.new("Frame")
SliderFill.Size            = UDim2.new((CFG.Delay-1)/9, 0, 1, 0)
SliderFill.BackgroundColor3 = C.Accent
SliderFill.BorderSizePixel = 0
SliderFill.Parent          = SliderTrack
Instance.new("UICorner", SliderFill).CornerRadius = UDim.new(1, 0)

local SliderKnob = Instance.new("TextButton")
SliderKnob.Size            = UDim2.new(0,16,0,16)
SliderKnob.Position        = UDim2.new((CFG.Delay-1)/9, -8, 0.5, -8)
SliderKnob.BackgroundColor3 = Color3.fromRGB(255,255,255)
SliderKnob.Text            = ""
SliderKnob.BorderSizePixel = 0
SliderKnob.ZIndex          = 2
SliderKnob.Parent          = SliderTrack
Instance.new("UICorner", SliderKnob).CornerRadius = UDim.new(1, 0)

-- Slider drag
do
    local dragging = false
    SliderKnob.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragging = true
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if dragging then
            local abs = SliderTrack.AbsolutePosition
            local w   = SliderTrack.AbsoluteSize.X
            local x   = math.clamp(i.Position.X - abs.X, 0, w)
            local pct = x / w
            local val = math.floor(pct * 9 + 1)
            CFG.Delay = val
            DelayLbl.Text = "⏱  Delay Poll: " .. val .. " detik"
            SliderFill.Size = UDim2.new(pct, 0, 1, 0)
            SliderKnob.Position = UDim2.new(pct, -8, 0.5, -8)
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

-- Save Settings Button
makeButton(SettingsPage, "💾  Simpan Pengaturan", UDim2.new(1,-24,0,34), UDim2.new(0,12,0,230), C.Accent, function()
    CFG.URL = URLBox.Text
end)

-- ══════════════════════════════════════
-- TAB 3: PRESETS
-- ══════════════════════════════════════
local PresetsPage = makeTab("Presets", "📋")

local PresetScroll = Instance.new("ScrollingFrame")
PresetScroll.Size              = UDim2.new(1,-20,1,-80)
PresetScroll.Position          = UDim2.new(0,10,0,10)
PresetScroll.BackgroundColor3  = C.Panel
PresetScroll.BorderSizePixel   = 0
PresetScroll.ScrollBarThickness = 3
PresetScroll.ScrollBarImageColor3 = C.Accent
PresetScroll.CanvasSize        = UDim2.new(0,0,0,0)
PresetScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
PresetScroll.Parent            = PresetsPage
Instance.new("UICorner", PresetScroll).CornerRadius = UDim.new(0, 10)

local PresetLayout = Instance.new("UIListLayout")
PresetLayout.Padding      = UDim.new(0, 4)
PresetLayout.Parent       = PresetScroll
Instance.new("UIPadding", PresetScroll).PaddingTop = UDim.new(0,8)

local function addPresetItem(text)
    local row = Instance.new("Frame")
    row.Size             = UDim2.new(1,-16,0,36)
    row.BackgroundColor3 = C.PanelAlt
    row.BorderSizePixel  = 0
    row.Parent           = PresetScroll
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 8)
    Instance.new("UIPadding", row).PaddingLeft = UDim.new(0, 10)

    makeLabel(row, text, UDim2.new(1,-70,1,0), UDim2.new(0,0,0,0), C.Text, 12, Enum.Font.Gotham)

    local sendBtn = Instance.new("TextButton")
    sendBtn.Size   = UDim2.new(0, 54, 0, 26)
    sendBtn.Position = UDim2.new(1,-60,0.5,-13)
    sendBtn.BackgroundColor3 = C.Accent
    sendBtn.Text   = "Kirim ↗"
    sendBtn.TextSize = 11
    sendBtn.Font   = Enum.Font.GothamSemibold
    sendBtn.TextColor3 = Color3.fromRGB(255,255,255)
    sendBtn.BorderSizePixel = 0
    sendBtn.Parent = row
    Instance.new("UICorner", sendBtn).CornerRadius = UDim.new(0, 6)

    sendBtn.MouseButton1Click:Connect(function()
        MsgInput.Text = text
    end)
end

for _, p in ipairs(CFG.Presets) do addPresetItem(p) end

-- Add preset input
local NewPresetBox = Instance.new("TextBox")
NewPresetBox.Size            = UDim2.new(1,-90,0,34)
NewPresetBox.Position        = UDim2.new(0,10,1,-46)
NewPresetBox.BackgroundColor3 = C.Panel
NewPresetBox.Text            = ""
NewPresetBox.PlaceholderText = "Pesan baru..."
NewPresetBox.PlaceholderColor3 = C.TextDim
NewPresetBox.TextColor3      = C.Text
NewPresetBox.TextSize        = 12
NewPresetBox.Font            = Enum.Font.Gotham
NewPresetBox.BorderSizePixel = 0
NewPresetBox.Parent          = PresetsPage
Instance.new("UICorner", NewPresetBox).CornerRadius = UDim.new(0, 8)
Instance.new("UIPadding", NewPresetBox).PaddingLeft = UDim.new(0, 10)

makeButton(PresetsPage, "+ Tambah", UDim2.new(0,70,0,34), UDim2.new(1,-80,1,-46), C.Green, function()
    local txt = NewPresetBox.Text
    if txt ~= "" then
        table.insert(CFG.Presets, txt)
        addPresetItem(txt)
        NewPresetBox.Text = ""
    end
end)

-- ══════════════════════════════════════
-- TAB 4: LOG
-- ══════════════════════════════════════
local LogPage = makeTab("Log", "📜")

local LogScroll = Instance.new("ScrollingFrame")
LogScroll.Size               = UDim2.new(1,-20,1,-20)
LogScroll.Position           = UDim2.new(0,10,0,10)
LogScroll.BackgroundColor3   = C.Panel
LogScroll.BorderSizePixel    = 0
LogScroll.ScrollBarThickness = 3
LogScroll.ScrollBarImageColor3 = C.Accent
LogScroll.CanvasSize         = UDim2.new(0,0,0,0)
LogScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
LogScroll.Parent             = LogPage
Instance.new("UICorner", LogScroll).CornerRadius = UDim.new(0, 10)

local LogLayout = Instance.new("UIListLayout")
LogLayout.Padding   = UDim.new(0, 2)
LogLayout.Parent    = LogScroll
Instance.new("UIPadding", LogScroll).PaddingTop = UDim.new(0, 6)

local function addLog(msg, color)
    local lbl = Instance.new("TextLabel")
    lbl.Size             = UDim2.new(1,-16,0,20)
    lbl.BackgroundTransparency = 1
    lbl.Text             = os.date("%H:%M:%S") .. "  " .. msg
    lbl.TextColor3       = color or C.TextDim
    lbl.TextSize         = 11
    lbl.Font             = Enum.Font.Code
    lbl.TextXAlignment   = Enum.TextXAlignment.Left
    lbl.Parent           = LogScroll
    lbl.LayoutOrder      = tick()
    -- auto scroll
    task.defer(function()
        LogScroll.CanvasPosition = Vector2.new(0, LogScroll.AbsoluteCanvasSize.Y)
    end)
end

addLog("ChatGlobal v1.0 dimulai", C.Green)
addLog("User: " .. LP.Name, C.Accent)

-- ══════════════════════════════════════
-- CHAT FUNCTIONS
-- ══════════════════════════════════════
local msgOrder = 0

local function addMessage(user, text, isOwn, lang)
    msgOrder = msgOrder + 1
    local isMe = isOwn or (user == LP.Name)

    local row = Instance.new("Frame")
    row.Size             = UDim2.new(1,-16,0,0)
    row.AutomaticSize    = Enum.AutomaticSize.Y
    row.BackgroundColor3 = isMe and C.MsgSelf or C.MsgOther
    row.BackgroundTransparency = isMe and 0.3 or 0
    row.BorderSizePixel  = 0
    row.LayoutOrder      = msgOrder
    row.Parent           = ChatScroll
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 8)

    local pad = Instance.new("UIPadding", row)
    pad.PaddingLeft   = UDim.new(0, 10)
    pad.PaddingRight  = UDim.new(0, 10)
    pad.PaddingTop    = UDim.new(0, 6)
    pad.PaddingBottom = UDim.new(0, 6)

    local layout2 = Instance.new("UIListLayout")
    layout2.FillDirection = Enum.FillDirection.Vertical
    layout2.Padding = UDim.new(0, 2)
    layout2.Parent = row

    local nameColor = isMe and C.Accent or C.Green
    local nameTag   = lang and ("[" .. lang .. "] ") or ""

    local nameLbl = Instance.new("TextLabel")
    nameLbl.Size             = UDim2.new(1,0,0,14)
    nameLbl.AutomaticSize    = Enum.AutomaticSize.Y
    nameLbl.BackgroundTransparency = 1
    nameLbl.Text             = nameTag .. user
    nameLbl.TextColor3       = nameColor
    nameLbl.TextSize         = 10
    nameLbl.Font             = Enum.Font.GothamBold
    nameLbl.TextXAlignment   = Enum.TextXAlignment.Left
    nameLbl.TextWrapped      = true
    nameLbl.Parent           = row

    local msgLbl = Instance.new("TextLabel")
    msgLbl.Size              = UDim2.new(1,0,0,0)
    msgLbl.AutomaticSize     = Enum.AutomaticSize.Y
    msgLbl.BackgroundTransparency = 1
    msgLbl.Text              = text
    msgLbl.TextColor3        = C.Text
    msgLbl.TextSize          = 12
    msgLbl.Font              = Enum.Font.Gotham
    msgLbl.TextXAlignment    = Enum.TextXAlignment.Left
    msgLbl.TextWrapped       = true
    msgLbl.Parent            = row

    -- auto scroll chat
    task.defer(function()
        ChatScroll.CanvasPosition = Vector2.new(0, ChatScroll.AbsoluteCanvasSize.Y)
    end)
end

local function setStatus(text, color)
    SubLabel.Text = text
    tween(StatusDot, {BackgroundColor3=color})
end

local isLoaded = false

local function sendMessage(text)
    if text == "" then return end
    if CFG.URL:find("YOUR%-GLITCH") then
        addLog("URL belum diset! Buka Settings.", C.Red)
        setStatus("URL belum diset", C.Red)
        return
    end
    local ok = httpPost(CFG.URL .. "/send", {
        user    = CFG.Username,
        message = text,
        lang    = CFG.Lang,
        sensor  = CFG.Sensor,
    })
    if ok then
        addMessage(LP.Name, text, true, CFG.Lang)
        addLog("Terkirim: " .. text:sub(1,40), C.Green)
    else
        addLog("Gagal kirim pesan", C.Red)
    end
end

local function pollMessages()
    if CFG.URL:find("YOUR%-GLITCH") then return end
    local url = CFG.URL .. "/messages?lang=" .. CFG.Lang
        .. "&sensor=" .. tostring(CFG.Sensor)
        .. "&after=" .. tostring(CFG.LastId)
    local raw = httpGet(url)
    if not raw then
        setStatus("Koneksi gagal", C.Red)
        addLog("Poll gagal - cek URL", C.Red)
        return
    end
    local ok, data = pcall(HttpService.JSONDecode, HttpService, raw)
    if not ok or type(data) ~= "table" then return end
    for _, msg in ipairs(data) do
        if msg.id > CFG.LastId then
            CFG.LastId = msg.id
            if msg.user ~= LP.Name then
                addMessage(msg.user, msg.message, false, msg.lang)
            end
        end
    end
    if not isLoaded then
        isLoaded = true
        setStatus("Terhubung · " .. CFG.Lang, C.Green)
        addLog("Terhubung ke server global", C.Green)
    end
end

-- ══════════════════════════════════════
-- BUTTON CALLBACKS
-- ══════════════════════════════════════

-- Load: apply settings dan mulai polling
LoadBtn.MouseButton1Click:Connect(function()
    CFG.URL    = URLBox.Text
    isLoaded   = false
    CFG.LastId = 0
    setStatus("Memuat ulang...", C.Yellow)
    addLog("Load: Lang=" .. CFG.Lang .. " Sensor=" .. tostring(CFG.Sensor), C.Accent)
    LangBadge.Text = "🌐 " .. CFG.Lang
    -- clear chat
    for _, c in ipairs(ChatScroll:GetChildren()) do
        if c:IsA("Frame") then c:Destroy() end
    end
    pollMessages()
    -- switch to Chat tab
    tabs["Chat"].btn.MouseButton1Click:Fire()
end)

-- Set Default
DefBtn.MouseButton1Click:Connect(function()
    DEFAULT.Lang   = CFG.Lang
    DEFAULT.Sensor = CFG.Sensor
    DEFAULT.Delay  = CFG.Delay
    addLog("Default disimpan: " .. CFG.Lang, C.Green)
end)

-- Send button
SendBtn.MouseButton1Click:Connect(function()
    sendMessage(MsgInput.Text)
    MsgInput.Text = ""
end)

MsgInput.FocusLost:Connect(function(enter)
    if enter and MsgInput.Text ~= "" then
        sendMessage(MsgInput.Text)
        MsgInput.Text = ""
    end
end)

-- ══════════════════════════════════════
-- POLLING LOOP
-- ══════════════════════════════════════
local lastPoll = 0
local pollConn
pollConn = RunService.Heartbeat:Connect(function()
    if tick() - lastPoll >= CFG.Delay then
        lastPoll = tick()
        task.spawn(pollMessages)
    end
end)

-- cleanup on destroy
ScreenGui.AncestryChanged:Connect(function()
    if not ScreenGui.Parent then
        pollConn:Disconnect()
    end
end)

-- ══════════════════════════════════════
-- ACTIVATE DEFAULT TAB
-- ══════════════════════════════════════
tabs["Chat"].btn.MouseButton1Click:Fire()

addMessage("System", "Selamat datang di ChatGlobal! Set URL server di Settings lalu tekan Load.", false, "SYS")
addLog("GUI berhasil dimuat", C.Green)

print("✅ ChatGlobal v1.0 by KHAFIDZKTP - loaded!")

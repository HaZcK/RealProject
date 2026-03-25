--[[
    ╔══════════════════════════════════════════╗
    ║      ChatGlobal v3.0 by KHAFIDZKTP       ║
    ║  Phase 1 → Rayfield Setup                ║
    ║  Phase 2 → Age Verification              ║
    ║  Phase 3 → Elegant Chat GUI              ║
    ╚══════════════════════════════════════════╝
--]]

-- ══════════════════════════════════════
-- SERVICES
-- ══════════════════════════════════════
local Players          = game:GetService("Players")
local HttpService      = game:GetService("HttpService")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService       = game:GetService("RunService")

local LP   = Players.LocalPlayer
local PGui = LP:WaitForChild("PlayerGui")

-- ══════════════════════════════════════
-- SERVER URL
-- ══════════════════════════════════════
local SERVER_URL = "https://chatglobal-server-production.up.railway.app"

-- ══════════════════════════════════════
-- CONFIG
-- ══════════════════════════════════════
local Config = {
    DisplayName = LP.Name,
    Lang        = nil,
    Region      = nil,
    Sensor      = false,
    SensorLink  = false,
    Theme       = "Default",
    FriendsOnly = false,
    GameOnly    = false,
    AgeMode     = "ADULT",
    LastId      = 0,
}
local hasCustomized = false

-- ══════════════════════════════════════
-- TEMA
-- ══════════════════════════════════════
local Themes = {
    Default = {
        BG       = Color3.fromRGB(12, 13, 20),
        Panel    = Color3.fromRGB(20, 21, 34),
        PanelAlt = Color3.fromRGB(26, 28, 44),
        Accent   = Color3.fromRGB(99, 102, 241),
        Green    = Color3.fromRGB(34, 197, 94),
        Red      = Color3.fromRGB(239, 68, 68),
        Yellow   = Color3.fromRGB(251, 191, 36),
        Blue     = Color3.fromRGB(59, 130, 246),
        Text     = Color3.fromRGB(226, 232, 240),
        TextDim  = Color3.fromRGB(100, 116, 139),
        MenuBG   = Color3.fromRGB(30, 32, 52),
    },
    Ocean = {
        BG       = Color3.fromRGB(6, 18, 30),
        Panel    = Color3.fromRGB(10, 28, 46),
        PanelAlt = Color3.fromRGB(14, 36, 58),
        Accent   = Color3.fromRGB(20, 184, 166),
        Green    = Color3.fromRGB(34, 197, 94),
        Red      = Color3.fromRGB(239, 68, 68),
        Yellow   = Color3.fromRGB(251, 191, 36),
        Blue     = Color3.fromRGB(56, 189, 248),
        Text     = Color3.fromRGB(210, 240, 255),
        TextDim  = Color3.fromRGB(70, 120, 150),
        MenuBG   = Color3.fromRGB(18, 40, 62),
    },
    Candy = {
        BG       = Color3.fromRGB(22, 10, 28),
        Panel    = Color3.fromRGB(36, 14, 48),
        PanelAlt = Color3.fromRGB(48, 18, 62),
        Accent   = Color3.fromRGB(236, 72, 153),
        Green    = Color3.fromRGB(134, 239, 172),
        Red      = Color3.fromRGB(239, 68, 68),
        Yellow   = Color3.fromRGB(251, 191, 36),
        Blue     = Color3.fromRGB(147, 197, 253),
        Text     = Color3.fromRGB(255, 220, 240),
        TextDim  = Color3.fromRGB(160, 100, 140),
        MenuBG   = Color3.fromRGB(50, 20, 65),
    },
    Aqua = {
        BG       = Color3.fromRGB(5, 18, 26),
        Panel    = Color3.fromRGB(10, 30, 42),
        PanelAlt = Color3.fromRGB(14, 40, 55),
        Accent   = Color3.fromRGB(6, 182, 212),
        Green    = Color3.fromRGB(34, 197, 94),
        Red      = Color3.fromRGB(239, 68, 68),
        Yellow   = Color3.fromRGB(251, 191, 36),
        Blue     = Color3.fromRGB(96, 165, 250),
        Text     = Color3.fromRGB(200, 240, 250),
        TextDim  = Color3.fromRGB(60, 130, 155),
        MenuBG   = Color3.fromRGB(16, 42, 58),
    },
}

-- ══════════════════════════════════════
-- HTTP
-- ══════════════════════════════════════
local function httpGet(url)
    local ok, r = pcall(function() return game:HttpGet(url, true) end)
    return ok and r or nil
end

local function httpPost(url, body)
    local json = HttpService:JSONEncode(body)
    local reqFn = (syn and syn.request) or (http and http.request) or (request) or nil
    if reqFn then
        local ok = pcall(reqFn, {
            Url     = url, Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body    = json,
        })
        return ok
    end
    return pcall(function()
        HttpService:PostAsync(url, json, Enum.HttpContentType.ApplicationJson)
    end)
end

-- ══════════════════════════════════════
-- CLIPBOARD
-- ══════════════════════════════════════
local function copyClip(text)
    pcall(setclipboard, text)
end

-- ══════════════════════════════════════
-- TWEEN
-- ══════════════════════════════════════
local function tw(obj, props, t, style)
    TweenService:Create(obj,
        TweenInfo.new(t or 0.2, style or Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        props
    ):Play()
end

-- ══════════════════════════════════════
-- TEXT PROCESSING
-- ══════════════════════════════════════
local BADWORDS = {
    "anjing","babi","bangsat","kontol","memek","jancok","bajingan",
    "keparat","asu","fuck","shit","bitch","dick","pussy","damn",
}

local LINK_PATTERN = "https?://[%w%-_%.%?%=%&%/%#%%]+"
local LINK_PATTERN2 = "www%.[%w%-_%.%?%=%&%/%#%%]+"

local function hasLink(text)
    return text:find(LINK_PATTERN) ~= nil or text:find(LINK_PATTERN2) ~= nil
end

local function extractLinks(text)
    local links = {}
    for l in text:gmatch(LINK_PATTERN)  do table.insert(links, l) end
    for l in text:gmatch(LINK_PATTERN2) do table.insert(links, l) end
    return links
end

-- Sensor kata kasar → "•••"
local function sensorBadWords(text)
    local r = text
    for _, w in ipairs(BADWORDS) do
        r = r:gsub(w,       function(m) return string.rep("•", #m) end)
        r = r:gsub(w:upper(),function(m) return string.rep("•", #m) end)
    end
    return r
end

-- Sensor link → "•••••"
local function sensorLinks(text)
    local r = text
    r = r:gsub(LINK_PATTERN,  function(m) return string.rep("•", #m) end)
    r = r:gsub(LINK_PATTERN2, function(m) return string.rep("•", #m) end)
    return r
end

-- Build JSON untuk satu pesan
local function buildMsgJSON(text)
    local isKids    = Config.AgeMode == "KIDS"
    local hasLnk    = hasLink(text)
    local msgType   = hasLnk and "String, Link" or "String"
    local sensorOn  = Config.Sensor or isKids
    local sensorLnk = Config.SensorLink or isKids

    local processedText = text
    if sensorOn      then processedText = sensorBadWords(processedText) end
    if sensorLnk     then processedText = sensorLinks(processedText)    end
    if isKids        then processedText = processedText:sub(1, 80)      end

    return {
        Type    = msgType,
        User    = Config.DisplayName,
        Context = processedText,
        Sensor  = sensorOn,
        Kids    = isKids,
    }, processedText
end

-- Parse incoming JSON message
local function parseMsgJSON(raw)
    if type(raw) == "table" then return raw end
    local ok, t = pcall(HttpService.JSONDecode, HttpService, tostring(raw))
    if ok and type(t) == "table" then return t end
    -- fallback: treat as plain text
    return {
        Type    = "String",
        User    = "?",
        Context = tostring(raw),
        Sensor  = false,
        Kids    = false,
    }
end

-- ══════════════════════════════════════
-- PHASE 3: CHAT GUI
-- ══════════════════════════════════════
local function launchChatGUI()
    local C      = Themes[Config.Theme] or Themes.Default
    local isKids = Config.AgeMode == "KIDS"
    if isKids then Config.Sensor = true; Config.SensorLink = true end

    if PGui:FindFirstChild("ChatGlobalUI") then PGui.ChatGlobalUI:Destroy() end

    local SG = Instance.new("ScreenGui")
    SG.Name           = "ChatGlobalUI"
    SG.ResetOnSpawn   = false
    SG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    SG.DisplayOrder   = 999
    SG.Parent         = PGui

    local WIN_W, WIN_H = 460, 440

    -- ── Main Frame ───────────────────────
    local Main = Instance.new("Frame")
    Main.Name             = "Main"
    Main.Size             = UDim2.new(0, WIN_W, 0, 0)
    Main.Position         = UDim2.new(0.5, -WIN_W/2, 0.5, -WIN_H/2)
    Main.BackgroundColor3 = C.BG
    Main.BorderSizePixel  = 0
    Main.ClipsDescendants = true
    Main.Parent           = SG
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 14)

    local BorderF = Instance.new("Frame")
    BorderF.Size                  = UDim2.new(1, 2, 1, 2)
    BorderF.Position              = UDim2.new(0, -1, 0, -1)
    BorderF.BackgroundColor3      = isKids and C.Yellow or C.Accent
    BorderF.BackgroundTransparency = 0.6
    BorderF.ZIndex                = 0
    BorderF.Parent                = Main
    Instance.new("UICorner", BorderF).CornerRadius = UDim.new(0, 15)

    tw(Main, {Size = UDim2.new(0, WIN_W, 0, WIN_H)}, 0.38, Enum.EasingStyle.Back)

    -- ── Header Bar (drag handle + minimize/close) ──
    local Header = Instance.new("Frame")
    Header.Name             = "Header"
    Header.Size             = UDim2.new(1, 0, 0, 36)
    Header.BackgroundColor3 = C.Panel
    Header.BorderSizePixel  = 0
    Header.Parent           = Main

    local HeaderGrad = Instance.new("UIGradient")
    HeaderGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(
            math.floor(C.Accent.R*255*0.15),
            math.floor(C.Accent.G*255*0.15),
            math.floor(C.Accent.B*255*0.15))),
        ColorSequenceKeypoint.new(1, C.Panel),
    })
    HeaderGrad.Rotation = 90
    HeaderGrad.Parent   = Header

    -- Window buttons
    local function winBtn(icon, xOff, bg, cb)
        local b = Instance.new("TextButton")
        b.Size             = UDim2.new(0, 22, 0, 22)
        b.Position         = UDim2.new(1, xOff, 0.5, -11)
        b.BackgroundColor3 = bg
        b.BackgroundTransparency = 0.35
        b.Text             = icon
        b.TextSize         = 11
        b.Font             = Enum.Font.GothamBold
        b.TextColor3       = Color3.fromRGB(255,255,255)
        b.BorderSizePixel  = 0
        b.Parent           = Header
        Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)
        b.MouseEnter:Connect(function() tw(b, {BackgroundTransparency=0.05}) end)
        b.MouseLeave:Connect(function() tw(b, {BackgroundTransparency=0.35}) end)
        b.MouseButton1Click:Connect(cb)
        return b
    end

    winBtn("✕", -10, C.Red, function()
        tw(Main, {Size=UDim2.new(0,WIN_W,0,0)}, 0.22)
        task.delay(0.25, function() SG:Destroy() end)
    end)
    local minimized = false
    winBtn("─", -36, C.Yellow, function()
        minimized = not minimized
        tw(Main, {Size = minimized and UDim2.new(0,WIN_W,0,36) or UDim2.new(0,WIN_W,0,WIN_H)}, 0.22)
    end)

    local HeaderLbl = Instance.new("TextLabel")
    HeaderLbl.Size             = UDim2.new(1, -100, 1, 0)
    HeaderLbl.Position         = UDim2.new(0, 12, 0, 0)
    HeaderLbl.BackgroundTransparency = 1
    HeaderLbl.Text             = "ChatGlobal" .. (isKids and "  ·  KIDS 👶" or "")
    HeaderLbl.TextColor3       = C.TextDim
    HeaderLbl.TextSize         = 11
    HeaderLbl.Font             = Enum.Font.GothamSemibold
    HeaderLbl.TextXAlignment   = Enum.TextXAlignment.Left
    HeaderLbl.Parent           = Header

    -- ── Connection Status Bar (center-top) ──
    local StatusBar = Instance.new("Frame")
    StatusBar.Name             = "StatusBar"
    StatusBar.Size             = UDim2.new(1, 0, 0, 40)
    StatusBar.Position         = UDim2.new(0, 0, 0, 36)
    StatusBar.BackgroundColor3 = C.Panel
    StatusBar.BorderSizePixel  = 0
    StatusBar.Parent           = Main

    local SBDiv = Instance.new("Frame")
    SBDiv.Size             = UDim2.new(1, 0, 0, 1)
    SBDiv.Position         = UDim2.new(0, 0, 1, -1)
    SBDiv.BackgroundColor3 = C.PanelAlt
    SBDiv.BorderSizePixel  = 0
    SBDiv.Parent           = StatusBar

    local StatusDot = Instance.new("Frame")
    StatusDot.Size            = UDim2.new(0, 8, 0, 8)
    StatusDot.Position        = UDim2.new(0.5, -80, 0.5, -4)
    StatusDot.BackgroundColor3 = C.Yellow
    StatusDot.BorderSizePixel = 0
    StatusDot.Parent          = StatusBar
    Instance.new("UICorner", StatusDot).CornerRadius = UDim.new(1, 0)

    local StatusTxt = Instance.new("TextLabel")
    StatusTxt.Name             = "StatusTxt"
    StatusTxt.Size             = UDim2.new(0, 240, 1, 0)
    StatusTxt.Position         = UDim2.new(0.5, -68, 0, 0)
    StatusTxt.BackgroundTransparency = 1
    StatusTxt.Text             = "Menghubungkan..."
    StatusTxt.TextColor3       = C.Yellow
    StatusTxt.TextSize         = 14
    StatusTxt.Font             = Enum.Font.GothamBold
    StatusTxt.TextXAlignment   = Enum.TextXAlignment.Left
    StatusTxt.Parent           = StatusBar

    local ReconnBtn = Instance.new("TextButton")
    ReconnBtn.Name             = "ReconnBtn"
    ReconnBtn.Size             = UDim2.new(0, 90, 0, 26)
    ReconnBtn.Position         = UDim2.new(1, -100, 0.5, -13)
    ReconnBtn.BackgroundColor3 = C.Accent
    ReconnBtn.Text             = "⟳ Reconnect"
    ReconnBtn.TextColor3       = Color3.fromRGB(255,255,255)
    ReconnBtn.TextSize         = 11
    ReconnBtn.Font             = Enum.Font.GothamSemibold
    ReconnBtn.BorderSizePixel  = 0
    ReconnBtn.Visible          = false
    ReconnBtn.Parent           = StatusBar
    Instance.new("UICorner", ReconnBtn).CornerRadius = UDim.new(0, 7)

    -- ── Info Badge Bar ────────────────────
    local InfoBar = Instance.new("Frame")
    InfoBar.Size             = UDim2.new(1, 0, 0, 24)
    InfoBar.Position         = UDim2.new(0, 0, 0, 76)
    InfoBar.BackgroundColor3 = C.PanelAlt
    InfoBar.BorderSizePixel  = 0
    InfoBar.ClipsDescendants = true
    InfoBar.Parent           = Main

    local IL = Instance.new("UIListLayout")
    IL.FillDirection     = Enum.FillDirection.Horizontal
    IL.VerticalAlignment = Enum.VerticalAlignment.Center
    IL.Padding           = UDim.new(0, 4)
    IL.Parent            = InfoBar
    Instance.new("UIPadding", InfoBar).PaddingLeft = UDim.new(0, 8)

    local function badge(txt, bg)
        local b = Instance.new("TextLabel")
        b.AutomaticSize     = Enum.AutomaticSize.X
        b.Size              = UDim2.new(0, 0, 0, 16)
        b.BackgroundColor3  = bg
        b.BackgroundTransparency = 0.3
        b.Text              = " " .. txt .. " "
        b.TextColor3        = Color3.fromRGB(255,255,255)
        b.TextSize          = 10
        b.Font              = Enum.Font.GothamBold
        b.BorderSizePixel   = 0
        b.Parent            = InfoBar
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
    end

    badge("🌐 " .. Config.Region, C.Accent)
    badge("💬 " .. Config.Lang,   Color3.fromRGB(59,130,246))
    badge("👤 " .. Config.DisplayName, C.TextDim)
    if isKids             then badge("👶 KIDS",    C.Yellow)                    end
    if Config.Sensor      then badge("🔒 SENSOR",  C.Red)                       end
    if Config.SensorLink  then badge("🔗 SENSOR",  Color3.fromRGB(249,115,22))  end
    if Config.FriendsOnly then badge("👥 TEMAN",   Color3.fromRGB(16,185,129))  end
    if Config.GameOnly    then badge("🎮 GAME",    Color3.fromRGB(139,92,246))  end

    -- ── Chat Scroll ───────────────────────
    local ChatScroll = Instance.new("ScrollingFrame")
    ChatScroll.Size               = UDim2.new(1, -16, 1, -158)
    ChatScroll.Position           = UDim2.new(0, 8, 0, 108)
    ChatScroll.BackgroundColor3   = C.Panel
    ChatScroll.BorderSizePixel    = 0
    ChatScroll.ScrollBarThickness = 3
    ChatScroll.ScrollBarImageColor3 = C.Accent
    ChatScroll.CanvasSize         = UDim2.new(0, 0, 0, 0)
    ChatScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    ChatScroll.Parent             = Main
    Instance.new("UICorner", ChatScroll).CornerRadius = UDim.new(0, 10)

    local CList = Instance.new("UIListLayout")
    CList.Padding   = UDim.new(0, 5)
    CList.SortOrder = Enum.SortOrder.LayoutOrder
    CList.Parent    = ChatScroll

    local CPad = Instance.new("UIPadding")
    CPad.PaddingTop    = UDim.new(0, 8)
    CPad.PaddingBottom = UDim.new(0, 8)
    CPad.PaddingLeft   = UDim.new(0, 8)
    CPad.PaddingRight  = UDim.new(0, 8)
    CPad.Parent        = ChatScroll

    -- ── Input Bar ─────────────────────────
    local InputBar = Instance.new("Frame")
    InputBar.Size             = UDim2.new(1, -16, 0, 40)
    InputBar.Position         = UDim2.new(0, 8, 1, -50)
    InputBar.BackgroundColor3 = C.Panel
    InputBar.BorderSizePixel  = 0
    InputBar.Parent           = Main
    Instance.new("UICorner", InputBar).CornerRadius = UDim.new(0, 10)

    local MsgBox = Instance.new("TextBox")
    MsgBox.Size             = UDim2.new(1, -86, 1, -12)
    MsgBox.Position         = UDim2.new(0, 12, 0, 6)
    MsgBox.BackgroundTransparency = 1
    MsgBox.Text             = ""
    MsgBox.PlaceholderText  = isKids and "Chat kids (max 80 karakter)..." or "Tulis pesan... (Enter = kirim)"
    MsgBox.PlaceholderColor3 = C.TextDim
    MsgBox.TextColor3       = C.Text
    MsgBox.TextSize         = 13
    MsgBox.Font             = Enum.Font.Gotham
    MsgBox.TextXAlignment   = Enum.TextXAlignment.Left
    MsgBox.ClearTextOnFocus = false
    MsgBox.Parent           = InputBar

    local SendBtn = Instance.new("TextButton")
    SendBtn.Size             = UDim2.new(0, 70, 0, 30)
    SendBtn.Position         = UDim2.new(1, -76, 0.5, -15)
    SendBtn.BackgroundColor3 = C.Accent
    SendBtn.Text             = "Kirim ↗"
    SendBtn.TextColor3       = Color3.fromRGB(255,255,255)
    SendBtn.TextSize         = 12
    SendBtn.Font             = Enum.Font.GothamSemibold
    SendBtn.BorderSizePixel  = 0
    SendBtn.Parent           = InputBar
    Instance.new("UICorner", SendBtn).CornerRadius = UDim.new(0, 8)
    SendBtn.MouseEnter:Connect(function() tw(SendBtn,{BackgroundTransparency=0.2}) end)
    SendBtn.MouseLeave:Connect(function() tw(SendBtn,{BackgroundTransparency=0}) end)

    -- ── Drag ──────────────────────────────
    do
        local drag, ds, sp
        Header.InputBegan:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1
            or i.UserInputType == Enum.UserInputType.Touch then
                drag=true; ds=i.Position; sp=Main.Position
            end
        end)
        UserInputService.InputChanged:Connect(function(i)
            if drag and (i.UserInputType==Enum.UserInputType.MouseMovement
            or i.UserInputType==Enum.UserInputType.Touch) then
                local d=i.Position-ds
                Main.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y)
            end
        end)
        UserInputService.InputEnded:Connect(function(i)
            if i.UserInputType==Enum.UserInputType.MouseButton1
            or i.UserInputType==Enum.UserInputType.Touch then drag=false end
        end)
    end

    -- ══════════════════════════════════════
    -- STATUS HELPERS
    -- ══════════════════════════════════════
    local isConnected = false

    local function setConnected(val)
        isConnected = val
        if val then
            StatusTxt.Text      = "Connected to server"
            StatusTxt.TextColor3 = C.Green
            tw(StatusDot, {BackgroundColor3=C.Green})
            ReconnBtn.Visible   = false
        else
            StatusTxt.Text      = "Cannot connect to server"
            StatusTxt.TextColor3 = C.Red
            tw(StatusDot, {BackgroundColor3=C.Red})
            ReconnBtn.Visible   = true
        end
    end

    -- ══════════════════════════════════════
    -- CONTEXT MENU
    -- ══════════════════════════════════════
    local activeMenu = nil

    local function closeMenu()
        if activeMenu then
            tw(activeMenu, {BackgroundTransparency=1})
            task.delay(0.15, function()
                if activeMenu then activeMenu:Destroy(); activeMenu=nil end
            end)
        end
    end

    -- Close menu kalau klik di luar
    UserInputService.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            if activeMenu then
                task.defer(closeMenu)
            end
        end
    end)

    local function showContextMenu(bubble, copyText, fullText)
        closeMenu()
        task.wait(0.01)

        local menuW, menuH = 220, 108
        local bPos  = bubble.AbsolutePosition
        local bSize = bubble.AbsoluteSize
        local sPos  = Main.AbsolutePosition
        local sSize = Main.AbsoluteSize

        -- posisi relatif terhadap SG
        local mx = bPos.X - sPos.X + bSize.X/2 - menuW/2
        local my = bPos.Y - sPos.Y + bSize.Y + 4
        -- clamp agar tidak keluar frame
        mx = math.clamp(mx, 4, sSize.X - menuW - 4)
        if my + menuH > sSize.Y - 8 then
            my = bPos.Y - sPos.Y - menuH - 4
        end

        local menu = Instance.new("Frame")
        menu.Size             = UDim2.new(0, menuW, 0, menuH)
        menu.Position         = UDim2.new(0, mx, 0, my)
        menu.BackgroundColor3 = C.MenuBG
        menu.BorderSizePixel  = 0
        menu.ZIndex           = 20
        menu.BackgroundTransparency = 1
        menu.Parent           = Main
        Instance.new("UICorner", menu).CornerRadius = UDim.new(0, 10)

        local mList = Instance.new("UIListLayout")
        mList.FillDirection = Enum.FillDirection.Vertical
        mList.Padding       = UDim.new(0, 1)
        mList.Parent        = menu

        local mPad = Instance.new("UIPadding")
        mPad.PaddingTop    = UDim.new(0, 5)
        mPad.PaddingBottom = UDim.new(0, 5)
        mPad.PaddingLeft   = UDim.new(0, 5)
        mPad.PaddingRight  = UDim.new(0, 5)
        mPad.Parent        = menu

        activeMenu = menu
        tw(menu, {BackgroundTransparency=0.05}, 0.15)

        local menuItems = {
            { icon="📋", label="Copy  (isi pesan)",            action=function() copyClip(copyText) end },
            { icon="🗑",  label="Delete For Me  (hanya kamu)", action=function() bubble:Destroy() end },
            { icon="📄",  label="Copy All  (User + ID + Pesan)", action=function() copyClip(fullText) end },
        }

        for _, item in ipairs(menuItems) do
            local btn = Instance.new("TextButton")
            btn.Size             = UDim2.new(1, 0, 0, 28)
            btn.BackgroundColor3 = C.PanelAlt
            btn.BackgroundTransparency = 0.3
            btn.Text             = item.icon .. "  " .. item.label
            btn.TextColor3       = C.Text
            btn.TextSize         = 12
            btn.Font             = Enum.Font.GothamSemibold
            btn.TextXAlignment   = Enum.TextXAlignment.Left
            btn.BorderSizePixel  = 0
            btn.ZIndex           = 21
            btn.Parent           = menu
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
            local bPad = Instance.new("UIPadding", btn)
            bPad.PaddingLeft = UDim.new(0, 8)
            btn.MouseEnter:Connect(function() tw(btn, {BackgroundTransparency=0}) end)
            btn.MouseLeave:Connect(function() tw(btn, {BackgroundTransparency=0.3}) end)
            btn.MouseButton1Click:Connect(function()
                item.action()
                closeMenu()
            end)
        end
    end

    -- ══════════════════════════════════════
    -- ADD MESSAGE BUBBLE
    -- ══════════════════════════════════════
    local msgOrder = 0

    local function addMessage(msgData, isOwn)
        msgOrder = msgOrder + 1

        local user    = msgData.User    or "?"
        local context = msgData.Context or ""
        local msgType = msgData.Type    or "String"
        local isMsgKids = msgData.Kids  or false

        local isMe = isOwn == true
        local containsLink = msgType:find("Link") ~= nil

        -- Bubble
        local bubble = Instance.new("Frame")
        bubble.Size              = UDim2.new(1, -8, 0, 0)
        bubble.AutomaticSize     = Enum.AutomaticSize.Y
        bubble.BackgroundColor3  = isMe and C.Accent or C.PanelAlt
        bubble.BackgroundTransparency = isMe and 0.7 or 0.2
        bubble.BorderSizePixel   = 0
        bubble.LayoutOrder       = msgOrder
        bubble.Parent            = ChatScroll
        Instance.new("UICorner", bubble).CornerRadius = UDim.new(0, 9)

        local bPad = Instance.new("UIPadding", bubble)
        bPad.PaddingLeft   = UDim.new(0, 10)
        bPad.PaddingRight  = UDim.new(0, 10)
        bPad.PaddingTop    = UDim.new(0, 6)
        bPad.PaddingBottom = UDim.new(0, 6)

        local bList = Instance.new("UIListLayout", bubble)
        bList.Padding = UDim.new(0, 3)

        -- Username row
        local nameRow = Instance.new("Frame")
        nameRow.Size             = UDim2.new(1, 0, 0, 14)
        nameRow.AutomaticSize    = Enum.AutomaticSize.X
        nameRow.BackgroundTransparency = 1
        nameRow.Parent           = bubble

        local nameList = Instance.new("UIListLayout", nameRow)
        nameList.FillDirection     = Enum.FillDirection.Horizontal
        nameList.VerticalAlignment = Enum.VerticalAlignment.Center
        nameList.Padding           = UDim.new(0, 5)

        local nameLbl = Instance.new("TextLabel")
        nameLbl.AutomaticSize   = Enum.AutomaticSize.X
        nameLbl.Size            = UDim2.new(0, 0, 1, 0)
        nameLbl.BackgroundTransparency = 1
        nameLbl.Text            = user
        nameLbl.TextColor3      = isMe and C.Accent or C.Green
        nameLbl.TextSize        = 10
        nameLbl.Font            = Enum.Font.GothamBold
        nameLbl.TextXAlignment  = Enum.TextXAlignment.Left
        nameLbl.Parent          = nameRow

        -- Badge type kalau ada link
        if containsLink and not (Config.SensorLink or isKids) then
            local typeBadge = Instance.new("TextLabel")
            typeBadge.AutomaticSize   = Enum.AutomaticSize.X
            typeBadge.Size            = UDim2.new(0, 0, 0, 13)
            typeBadge.BackgroundColor3 = Color3.fromRGB(59,130,246)
            typeBadge.BackgroundTransparency = 0.3
            typeBadge.Text            = " 🔗 Link "
            typeBadge.TextColor3      = Color3.fromRGB(255,255,255)
            typeBadge.TextSize        = 9
            typeBadge.Font            = Enum.Font.GothamBold
            typeBadge.BorderSizePixel = 0
            typeBadge.Parent          = nameRow
            Instance.new("UICorner", typeBadge).CornerRadius = UDim.new(0, 3)
        end

        -- Context text
        local ctxLbl = Instance.new("TextLabel")
        ctxLbl.Size             = UDim2.new(1, 0, 0, 0)
        ctxLbl.AutomaticSize    = Enum.AutomaticSize.Y
        ctxLbl.BackgroundTransparency = 1
        ctxLbl.Text             = context
        ctxLbl.TextColor3       = C.Text
        ctxLbl.TextSize         = 13
        ctxLbl.Font             = Enum.Font.Gotham
        ctxLbl.TextXAlignment   = Enum.TextXAlignment.Left
        ctxLbl.TextWrapped      = true
        ctxLbl.Parent           = bubble

        -- Tampilkan link sebagai tombol biru (kalau tidak disensor)
        if containsLink and not (Config.SensorLink or isMsgKids) then
            local links = extractLinks(context)
            for _, lnk in ipairs(links) do
                local linkBtn = Instance.new("TextButton")
                linkBtn.AutomaticSize   = Enum.AutomaticSize.X
                linkBtn.Size            = UDim2.new(0, 0, 0, 20)
                linkBtn.BackgroundColor3 = Color3.fromRGB(30, 58, 120)
                linkBtn.BackgroundTransparency = 0.2
                linkBtn.Text            = "🔗 " .. (lnk:sub(1, 45) .. (lnk:len()>45 and "..." or ""))
                linkBtn.TextColor3      = Color3.fromRGB(147, 197, 253)
                linkBtn.TextSize        = 11
                linkBtn.Font            = Enum.Font.GothamSemibold
                linkBtn.BorderSizePixel = 0
                linkBtn.Parent          = bubble
                Instance.new("UICorner", linkBtn).CornerRadius = UDim.new(0, 5)
                local lPad = Instance.new("UIPadding", linkBtn)
                lPad.PaddingLeft  = UDim.new(0, 6)
                lPad.PaddingRight = UDim.new(0, 6)
                linkBtn.MouseEnter:Connect(function()
                    tw(linkBtn, {BackgroundTransparency=0})
                    linkBtn.TextColor3 = Color3.fromRGB(255,255,255)
                end)
                linkBtn.MouseLeave:Connect(function()
                    tw(linkBtn, {BackgroundTransparency=0.2})
                    linkBtn.TextColor3 = Color3.fromRGB(147,197,253)
                end)
                linkBtn.MouseButton1Click:Connect(function()
                    copyClip(lnk)
                    linkBtn.Text = "✔ Tersalin!"
                    task.delay(1.5, function()
                        if linkBtn.Parent then
                            linkBtn.Text = "🔗 " .. (lnk:sub(1,45) .. (lnk:len()>45 and "..." or ""))
                        end
                    end)
                end)
            end
        end

        -- ── Context menu (long press + right click) ──
        local userId  = tostring(LP.UserId)
        local fullCopyText = user .. ", [" .. userId .. "]: " .. context
        local msgText = context

        -- Right click (PC)
        bubble.InputBegan:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton2 then
                showContextMenu(bubble, msgText, fullCopyText)
            end
        end)

        -- Long press (mobile + PC hold)
        local holdConn
        local holding = false
        bubble.InputBegan:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1
            or i.UserInputType == Enum.UserInputType.Touch then
                holding = true
                holdConn = task.delay(0.75, function()
                    if holding then
                        showContextMenu(bubble, msgText, fullCopyText)
                    end
                end)
            end
        end)
        bubble.InputEnded:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1
            or i.UserInputType == Enum.UserInputType.Touch then
                holding = false
            end
        end)

        -- Auto scroll
        task.defer(function()
            ChatScroll.CanvasPosition = Vector2.new(0, ChatScroll.AbsoluteCanvasSize.Y)
        end)

        return bubble
    end

    -- System message helper
    local function addSysMsg(text)
        addMessage({
            Type    = "String",
            User    = "System",
            Context = text,
            Sensor  = false,
            Kids    = false,
        }, false)
    end

    -- ══════════════════════════════════════
    -- SEND & POLL
    -- ══════════════════════════════════════
    local function sendMessage(rawText)
        if rawText == "" then return end
        local msgJSON, processedText = buildMsgJSON(rawText)

        -- Print raw JSON ke console
        print(HttpService:JSONEncode(msgJSON))

        local ok = httpPost(SERVER_URL .. "/send", {
            user    = Config.DisplayName,
            message = HttpService:JSONEncode(msgJSON),
            lang    = Config.Lang,
            region  = Config.Region,
            gameId  = Config.GameOnly and tostring(game.PlaceId) or "ANY",
        })

        if ok then
            addMessage(msgJSON, true)
        else
            addSysMsg("❌ Gagal kirim pesan. Cek koneksi server.")
        end
    end

    local function pollMessages()
        local url = SERVER_URL .. "/messages"
            .. "?lang="   .. Config.Lang
            .. "&region=" .. Config.Region
            .. "&after="  .. tostring(Config.LastId)
        if Config.GameOnly then
            url = url .. "&gameId=" .. tostring(game.PlaceId)
        end

        local raw = httpGet(url)
        if not raw then
            setConnected(false)
            return
        end

        local ok, data = pcall(HttpService.JSONDecode, HttpService, raw)
        if not ok or type(data) ~= "table" then
            setConnected(false)
            return
        end

        setConnected(true)

        for _, entry in ipairs(data) do
            if entry.id > Config.LastId then
                Config.LastId = entry.id
                if entry.user ~= Config.DisplayName then
                    -- Parse message JSON
                    local msgData = parseMsgJSON(entry.message)

                    -- Friends only check
                    if Config.FriendsOnly then
                        local fok, uid = pcall(Players.GetUserIdFromNameAsync, Players, entry.user)
                        if fok and uid and not LP:IsFriendsWith(uid) then
                            continue
                        end
                    end

                    addMessage(msgData, false)
                end
            end
        end
    end

    -- Send button & enter
    SendBtn.MouseButton1Click:Connect(function()
        local t = MsgBox.Text
        MsgBox.Text = ""
        sendMessage(t)
    end)
    MsgBox.FocusLost:Connect(function(enter)
        if enter and MsgBox.Text ~= "" then
            local t = MsgBox.Text
            MsgBox.Text = ""
            sendMessage(t)
        end
    end)

    -- Reconnect button
    ReconnBtn.MouseButton1Click:Connect(function()
        ReconnBtn.Text = "⟳ Mencoba..."
        task.spawn(function()
            pollMessages()
            task.wait(1)
            ReconnBtn.Text = "⟳ Reconnect"
        end)
    end)

    -- Poll loop
    local lastPoll = 0
    local pollConn
    pollConn = RunService.Heartbeat:Connect(function()
        if tick() - lastPoll >= 3 then
            lastPoll = tick()
            task.spawn(pollMessages)
        end
    end)
    SG.AncestryChanged:Connect(function()
        if not SG.Parent then pollConn:Disconnect() end
    end)

    -- Sambutan
    addSysMsg("Selamat datang " .. Config.DisplayName
        .. "  ·  " .. Config.Region .. "  ·  " .. Config.Lang
        .. (isKids and "  ·  KIDS MODE 👶" or ""))
    if isKids then
        addSysMsg("⚠ KIDS MODE: Sensor aktif, link diblok, max 80 karakter.")
    end

    -- First poll
    task.spawn(pollMessages)
    print("✅ ChatGlobal v3.0 Chat GUI launched!")
end

-- ══════════════════════════════════════
-- PHASE 2: AGE VERIFY
-- ══════════════════════════════════════
local function showAgeVerify(onDone)
    if PGui:FindFirstChild("AgeVerifyUI") then PGui.AgeVerifyUI:Destroy() end

    local AgeGui = Instance.new("ScreenGui")
    AgeGui.Name         = "AgeVerifyUI"
    AgeGui.ResetOnSpawn = false
    AgeGui.DisplayOrder = 10000
    AgeGui.Parent       = PGui

    local Overlay = Instance.new("Frame")
    Overlay.Size                  = UDim2.new(1,0,1,0)
    Overlay.BackgroundColor3      = Color3.fromRGB(0,0,0)
    Overlay.BackgroundTransparency = 0.44
    Overlay.BorderSizePixel       = 0
    Overlay.Parent                = AgeGui

    local Card = Instance.new("Frame")
    Card.Size             = UDim2.new(0,340,0,0)
    Card.Position         = UDim2.new(0.5,-170,0.5,-148)
    Card.BackgroundColor3 = Color3.fromRGB(14,15,26)
    Card.BorderSizePixel  = 0
    Card.ClipsDescendants = true
    Card.Parent           = AgeGui
    Instance.new("UICorner", Card).CornerRadius = UDim.new(0,14)

    local CB = Instance.new("Frame")
    CB.Size                  = UDim2.new(1,2,1,2)
    CB.Position              = UDim2.new(0,-1,0,-1)
    CB.BackgroundColor3      = Color3.fromRGB(251,191,36)
    CB.BackgroundTransparency = 0.45
    CB.ZIndex                = 0
    CB.Parent                = Card
    Instance.new("UICorner",CB).CornerRadius = UDim.new(0,15)

    tw(Card, {Size=UDim2.new(0,340,0,298)}, 0.4, Enum.EasingStyle.Back)

    local function albl(t,y,ts,col,f)
        local l = Instance.new("TextLabel")
        l.Size              = UDim2.new(1,-20,0,ts+4)
        l.Position          = UDim2.new(0,10,0,y)
        l.BackgroundTransparency = 1
        l.Text              = t
        l.TextColor3        = col or Color3.fromRGB(190,205,225)
        l.TextSize          = ts or 12
        l.Font              = f or Enum.Font.Gotham
        l.TextWrapped       = true
        l.AutomaticSize     = Enum.AutomaticSize.Y
        l.TextXAlignment    = Enum.TextXAlignment.Center
        l.Parent            = Card
        return l
    end

    albl("⚠️", 12, 30, Color3.fromRGB(251,191,36), Enum.Font.GothamBold)
    albl("Verifikasi Umur", 52, 17, Color3.fromRGB(255,220,80), Enum.Font.GothamBold)
    albl("ChatGlobal berisi percakapan global.\nKamu harus berumur minimal 13+ untuk akses penuh tanpa batasan.", 82, 12)

    local AgeFrame = Instance.new("Frame")
    AgeFrame.Size             = UDim2.new(1,-20,0,62)
    AgeFrame.Position         = UDim2.new(0,10,0,150)
    AgeFrame.BackgroundColor3 = Color3.fromRGB(22,24,40)
    AgeFrame.BorderSizePixel  = 0
    AgeFrame.Visible          = false
    AgeFrame.Parent           = Card
    Instance.new("UICorner",AgeFrame).CornerRadius = UDim.new(0,8)

    local AgeLbl = Instance.new("TextLabel")
    AgeLbl.Size             = UDim2.new(1,-12,0,22)
    AgeLbl.Position         = UDim2.new(0,8,0,6)
    AgeLbl.BackgroundTransparency = 1
    AgeLbl.Text             = "Masukkan umurmu:"
    AgeLbl.TextColor3       = Color3.fromRGB(180,190,210)
    AgeLbl.TextSize         = 12
    AgeLbl.Font             = Enum.Font.GothamSemibold
    AgeLbl.TextXAlignment   = Enum.TextXAlignment.Left
    AgeLbl.Parent           = AgeFrame

    local AgeBox = Instance.new("TextBox")
    AgeBox.Size             = UDim2.new(1,-16,0,26)
    AgeBox.Position         = UDim2.new(0,8,0,30)
    AgeBox.BackgroundColor3 = Color3.fromRGB(28,30,50)
    AgeBox.Text             = ""
    AgeBox.PlaceholderText  = "Contoh: 10"
    AgeBox.PlaceholderColor3 = Color3.fromRGB(90,105,130)
    AgeBox.TextColor3       = Color3.fromRGB(255,220,80)
    AgeBox.TextSize         = 14
    AgeBox.Font             = Enum.Font.GothamBold
    AgeBox.BorderSizePixel  = 0
    AgeBox.Parent           = AgeFrame
    Instance.new("UICorner",AgeBox).CornerRadius = UDim.new(0,6)
    Instance.new("UIPadding",AgeBox).PaddingLeft = UDim.new(0,8)

    local function aBtn(txt,y,bg,cb)
        local b = Instance.new("TextButton")
        b.Size             = UDim2.new(1,-20,0,36)
        b.Position         = UDim2.new(0,10,0,y)
        b.BackgroundColor3 = bg
        b.Text             = txt
        b.TextColor3       = Color3.fromRGB(255,255,255)
        b.TextSize         = 13
        b.Font             = Enum.Font.GothamSemibold
        b.BorderSizePixel  = 0
        b.Parent           = Card
        Instance.new("UICorner",b).CornerRadius = UDim.new(0,9)
        b.MouseEnter:Connect(function() tw(b,{BackgroundTransparency=0.15}) end)
        b.MouseLeave:Connect(function() tw(b,{BackgroundTransparency=0}) end)
        b.MouseButton1Click:Connect(cb)
        return b
    end

    local underBtn
    underBtn = aBtn("😔  Saya di bawah 13", 150, Color3.fromRGB(100,55,15), function()
        underBtn.Visible = false
        AgeFrame.Visible = true
        tw(Card, {Size=UDim2.new(0,340,0,375)}, 0.25)
        aBtn("✔  Konfirmasi", 228, Color3.fromRGB(200,150,20), function()
            local age = tonumber(AgeBox.Text)
            if not age or age<=0 or age>100 then
                AgeLbl.Text       = "⚠ Masukkan angka umur yang valid!"
                AgeLbl.TextColor3 = Color3.fromRGB(239,68,68)
                return
            end
            Config.AgeMode = "KIDS"
            tw(Card,{Size=UDim2.new(0,340,0,0)},0.22)
            task.delay(0.28, function() AgeGui:Destroy(); onDone() end)
        end)
    end)

    aBtn("✅  Saya sudah berumur 13+", 196, Color3.fromRGB(20,90,45), function()
        Config.AgeMode = "ADULT"
        tw(Card,{Size=UDim2.new(0,340,0,0)},0.22)
        task.delay(0.28, function() AgeGui:Destroy(); onDone() end)
    end)
end

-- ══════════════════════════════════════
-- PHASE 1: RAYFIELD SETUP
-- ══════════════════════════════════════
for _, g in ipairs(PGui:GetChildren()) do
    if g.Name=="ChatGlobalUI" or g.Name=="AgeVerifyUI" then g:Destroy() end
end

local rfOk, Rayfield = pcall(function()
    return loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
end)
if not rfOk or not Rayfield then
    error("❌ Gagal load Rayfield. Cek koneksi internet!")
end


-- Helper: Rayfield pass value sebagai table atau string
local function rv(v)
    if type(v) == "table" then return tostring(v[1] or "") end
    return tostring(v or "")
end

local Window = Rayfield:CreateWindow({
    Name            = "ChatGlobal  ·  Setup",
    LoadingTitle    = "ChatGlobal v3.0",
    LoadingSubtitle = "by KHAFIDZKTP",
    ConfigurationSaving = {Enabled=false},
    Discord         = {Enabled=false},
    KeySystem       = false,
})

local Tab = Window:CreateTab("⚙  Pengaturan", "settings")


-- ══════════════════════════════════════
-- LANGUAGE STRINGS (GUI Multilang)
-- ══════════════════════════════════════
local LANG_STRINGS = {
    ID = {
        title       = "ChatGlobal  ·  Setup",
        tabName     = "⚙  Pengaturan",
        secIdent    = "👤  Identitas",
        secRegion   = "🌍  Region & Bahasa  ←  WAJIB DIISI",
        secPrivacy  = "🔒  Privasi & Filter",
        secTheme    = "🎨  Tema Chat",
        secStart    = "🚀  Mulai Chat",
        lblWarn     = "⚠  Pilih Bahasa dan Region sebelum Load!",
        btnLoad     = "▶   Load Chat",
        btnDefault  = "★   Set Default & Load",
        notifTitle  = "⚠  Belum Dikustomisasi!",
        notifMsg    = "Pilih Bahasa dan Region terlebih dahulu sebelum memuat chat.",
    },
    EN = {
        title       = "ChatGlobal  ·  Setup",
        tabName     = "⚙  Settings",
        secIdent    = "👤  Identity",
        secRegion   = "🌍  Region & Language  ←  REQUIRED",
        secPrivacy  = "🔒  Privacy & Filter",
        secTheme    = "🎨  Chat Theme",
        secStart    = "🚀  Start Chat",
        lblWarn     = "⚠  Select Language and Region before Load!",
        btnLoad     = "▶   Load Chat",
        btnDefault  = "★   Set Default & Load",
        notifTitle  = "⚠  Not Customized!",
        notifMsg    = "Please select Language and Region before loading chat.",
    },
    RU = {
        title       = "ChatGlobal  ·  Настройка",
        tabName     = "⚙  Настройки",
        secIdent    = "👤  Личность",
        secRegion   = "🌍  Регион & Язык  ←  ОБЯЗАТЕЛЬНО",
        secPrivacy  = "🔒  Конфиденциальность",
        secTheme    = "🎨  Тема чата",
        secStart    = "🚀  Начать чат",
        lblWarn     = "⚠  Выбери язык и регион перед загрузкой!",
        btnLoad     = "▶   Загрузить чат",
        btnDefault  = "★   По умолчанию & Загрузить",
        notifTitle  = "⚠  Не настроено!",
        notifMsg    = "Выбери язык и регион перед загрузкой чата.",
    },
    TH = {
        title       = "ChatGlobal  ·  ตั้งค่า",
        tabName     = "⚙  การตั้งค่า",
        secIdent    = "👤  ตัวตน",
        secRegion   = "🌍  ภูมิภาค & ภาษา  ←  จำเป็น",
        secPrivacy  = "🔒  ความเป็นส่วนตัว",
        secTheme    = "🎨  ธีมแชท",
        secStart    = "🚀  เริ่มแชท",
        lblWarn     = "⚠  เลือกภาษาและภูมิภาคก่อนโหลด!",
        btnLoad     = "▶   โหลดแชท",
        btnDefault  = "★   ค่าเริ่มต้น & โหลด",
        notifTitle  = "⚠  ยังไม่ได้ตั้งค่า!",
        notifMsg    = "กรุณาเลือกภาษาและภูมิภาคก่อนโหลดแชท",
    },
    KZ = {
        title       = "ChatGlobal  ·  Баптау",
        tabName     = "⚙  Баптаулар",
        secIdent    = "👤  Жеке басы",
        secRegion   = "🌍  Аймақ & Тіл  ←  МІНДЕТТІ",
        secPrivacy  = "🔒  Құпиялылық",
        secTheme    = "🎨  Чат тақырыбы",
        secStart    = "🚀  Чатты бастау",
        lblWarn     = "⚠  Жүктемес бұрын тіл мен аймақты таңдаңыз!",
        btnLoad     = "▶   Чатты жүктеу",
        btnDefault  = "★   Әдепкі & Жүктеу",
        notifTitle  = "⚠  Реттелмеген!",
        notifMsg    = "Чатты жүктемес бұрын тіл мен аймақты таңдаңыз.",
    },
    JP = {
        title       = "ChatGlobal  ·  設定",
        tabName     = "⚙  設定",
        secIdent    = "👤  アイデンティティ",
        secRegion   = "🌍  地域 & 言語  ←  必須",
        secPrivacy  = "🔒  プライバシー",
        secTheme    = "🎨  チャートテーマ",
        secStart    = "🚀  チャット開始",
        lblWarn     = "⚠  ロード前に言語と地域を選択してください！",
        btnLoad     = "▶   チャット読み込み",
        btnDefault  = "★   デフォルト & 読み込み",
        notifTitle  = "⚠  カスタマイズされていません！",
        notifMsg    = "チャットを読み込む前に言語と地域を選択してください。",
    },
    AR = {
        title       = "ChatGlobal  ·  الإعداد",
        tabName     = "⚙  الإعدادات",
        secIdent    = "👤  الهوية",
        secRegion   = "🌍  المنطقة واللغة  ←  مطلوب",
        secPrivacy  = "🔒  الخصوصية",
        secTheme    = "🎨  سمة الدردشة",
        secStart    = "🚀  ابدأ الدردشة",
        lblWarn     = "⚠  اختر اللغة والمنطقة قبل التحميل!",
        btnLoad     = "▶   تحميل الدردشة",
        btnDefault  = "★   افتراضي & تحميل",
        notifTitle  = "⚠  لم يتم التخصيص!",
        notifMsg    = "الرجاء اختيار اللغة والمنطقة قبل تحميل الدردشة.",
    },
}
-- Fallback ke EN kalau tidak ada
setmetatable(LANG_STRINGS, {__index = function() return LANG_STRINGS.EN end})

-- GUI Language default = ID
local guiLang = "ID"
local function S(key)
    return (LANG_STRINGS[guiLang] or LANG_STRINGS.EN)[key] or key
end

-- Map kode bahasa chat ke kode GUI lang
local LANG_CODE_MAP = {
    ["ALL  -  Semua Bahasa / All Languages"] = "ALL",
    ["ID  -  Indonesia"]    = "ID",
    ["EN  -  English"]      = "EN",
    ["RU  -  Русский"]      = "RU",
    ["TH  -  ภาษาไทย"]    = "TH",
    ["KZ  -  Қазақша"]     = "KZ",
    ["JP  -  日本語"]       = "JP",
    ["AR  -  العربية"]     = "AR",
    ["ES  -  Español"]      = "ES",
    ["FR  -  Français"]     = "FR",
    ["PT  -  Português"]    = "PT",
    ["DE  -  Deutsch"]      = "DE",
    ["KR  -  한국어"]       = "KR",
    ["CN  -  中文"]         = "CN",
    ["TR  -  Türkçe"]      = "TR",
}

local REGION_CODE_MAP = {
    ["🌍  Global  -  Semua Dunia / Worldwide"] = "GLOBAL",
    ["🇮🇩  ID  -  Indonesia Only"]             = "ID",
    ["🇷🇺  RU  -  Russia Only"]                = "RU",
    ["🇹🇭  TH  -  Thailand Only"]              = "TH",
    ["🇰🇿  KZ  -  Kazakhstan Only"]            = "KZ",
    ["🇯🇵  JP  -  Japan Only"]                 = "JP",
    ["🇸🇦  AR  -  Arab Region Only"]           = "AR",
    ["🇺🇸  EN  -  English Speaking"]           = "EN",
}

local Window = Rayfield:CreateWindow({
    Name            = S("title"),
    LoadingTitle    = "ChatGlobal v3.0",
    LoadingSubtitle = "by KHAFIDZKTP",
    ConfigurationSaving = {Enabled=false},
    Discord         = {Enabled=false},
    KeySystem       = false,
})

local Tab = Window:CreateTab(S("tabName"), "settings")

-- GUI LANGUAGE SELECTOR (paling atas)
Tab:CreateSection("🗣  Bahasa Chat GUI  (berlaku setelah Load)")
Tab:CreateDropdown({
    Name          = "Bahasa Chat GUI",
    Options       = {"ID  -  Indonesia","EN  -  English","RU  -  Русский","TH  -  ภาษาไทย","KZ  -  Қазақша","JP  -  日本語","AR  -  العربية"},
    CurrentOption = {"ID  -  Indonesia"},
    Flag          = "GuiLang",
    Callback      = function(v)
        local sel = rv(v)
        local code = sel:match("^(%a+)") or "ID"
        guiLang = code
        -- Note: Rayfield tidak bisa re-render live, tapi config tersimpan
        -- untuk notifikasi dan label selanjutnya
    end,
})

Tab:CreateSection(S("secIdent"))
Tab:CreateInput({
    Name                   = "Display Name",
    PlaceholderText        = LP.Name,
    RemoveTextAfterFocusLost = false,
    Callback               = function(v)
        local val = rv(v)
        if val ~= "" then Config.DisplayName = val end
    end,
})

Tab:CreateSection(S("secRegion"))
Tab:CreateDropdown({
    Name          = "Bahasa Chat",
    Options       = {
        "ALL  -  Semua Bahasa / All Languages",
        "ID  -  Indonesia",
        "EN  -  English",
        "RU  -  Русский",
        "TH  -  ภาษาไทย",
        "KZ  -  Қазақша",
        "JP  -  日本語",
        "AR  -  العربية",
        "ES  -  Español",
        "FR  -  Français",
        "PT  -  Português",
        "DE  -  Deutsch",
        "KR  -  한국어",
        "CN  -  中文",
        "TR  -  Türkçe",
    },
    CurrentOption = {"ALL  -  Semua Bahasa / All Languages"},
    Flag          = "Lang",
    Callback      = function(v)
        local sel = rv(v)
        Config.Lang = LANG_CODE_MAP[sel] or sel:match("^(%a+)") or "ALL"
        hasCustomized = true
        print("✅ Bahasa dipilih: " .. Config.Lang)
    end,
})

Tab:CreateDropdown({
    Name          = "Region",
    Options       = {
        "🌍  Global  -  Semua Dunia / Worldwide",
        "🇮🇩  ID  -  Indonesia Only",
        "🇷🇺  RU  -  Russia Only",
        "🇹🇭  TH  -  Thailand Only",
        "🇰🇿  KZ  -  Kazakhstan Only",
        "🇯🇵  JP  -  Japan Only",
        "🇸🇦  AR  -  Arab Region Only",
        "🇺🇸  EN  -  English Speaking",
    },
    CurrentOption = {"🌍  Global  -  Semua Dunia / Worldwide"},
    Flag          = "Region",
    Callback      = function(v)
        local sel = rv(v)
        Config.Region = REGION_CODE_MAP[sel] or "GLOBAL"
        print("✅ Region dipilih: " .. Config.Region)
    end,
})

Tab:CreateSection(S("secPrivacy"))
Tab:CreateToggle({Name="Sensor Kata Kasar",       CurrentValue=false, Flag="Sensor",     Callback=function(v) Config.Sensor=v end})
Tab:CreateToggle({Name="🔗  Sensor Link (semua)", CurrentValue=false, Flag="SensorLink", Callback=function(v) Config.SensorLink=v end})
Tab:CreateToggle({Name="👥  Khusus Teman",         CurrentValue=false, Flag="Friends",   Callback=function(v) Config.FriendsOnly=v end})
Tab:CreateToggle({Name="🎮  Khusus Game Ini",      CurrentValue=false, Flag="GameOnly",  Callback=function(v) Config.GameOnly=v end})

Tab:CreateSection(S("secTheme"))
Tab:CreateDropdown({
    Name="Tema / Theme", Options={"Default","Ocean","Candy","Aqua"}, CurrentOption={"Default"}, Flag="Theme",
    Callback=function(v) Config.Theme = rv(v) end,
})

Tab:CreateSection(S("secStart"))
Tab:CreateLabel(S("lblWarn"))

local function tryLoad()
    -- Default: kalau belum dipilih sama sekali, pakai ALL + GLOBAL
    if Config.Lang == nil  then Config.Lang   = "ALL"    end
    if Config.Region == nil then Config.Region = "GLOBAL" end

    showAgeVerify(function()
        -- Sembunyikan Rayfield GUI
        local rfGui = PGui:FindFirstChild("Rayfield")
        if rfGui then rfGui:Destroy() end
        launchChatGUI()
    end)
end

Tab:CreateButton({Name=S("btnLoad"),    Callback=tryLoad})
Tab:CreateButton({Name=S("btnDefault"), Callback=tryLoad})

print("✅ ChatGlobal v3.0 by KHAFIDZKTP - Setup ready!")

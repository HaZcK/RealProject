--[[
    ╔══════════════════════════════════════════╗
    ║      ChatGlobal v4.0 by KHAFIDZKTP       ║
    ║  Phase 1 → Rayfield Setup                ║
    ║  Phase 2 → Age Verification              ║
    ║  Phase 3 → Elegant Chat GUI              ║
    ║                                          ║
    ║  Ketik /Setup di chat Roblox untuk       ║
    ║  membuka kembali Rayfield Setup          ║
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
local StarterGui       = game:GetService("StarterGui")

local LP   = Players.LocalPlayer
local PGui = LP:WaitForChild("PlayerGui")

-- ══════════════════════════════════════
-- SERVER
-- ══════════════════════════════════════
local SERVER_URL = "https://chatglobal-server-production.up.railway.app"

-- ══════════════════════════════════════
-- CONFIG
-- ══════════════════════════════════════
local Config = {
    DisplayName = LP.Name,
    Lang        = "ALL",
    Region      = "GLOBAL",
    Sensor      = false,
    SensorLink  = false,
    Theme       = "Midnight",
    FriendsOnly = false,
    GameOnly    = false,
    AgeMode     = "ADULT",
    GuiLang     = "ID",
    LastId      = 0,
}

-- ══════════════════════════════════════
-- THEMES (lebih banyak)
-- ══════════════════════════════════════
local Themes = {
    Midnight = {
        BG       = Color3.fromRGB(10, 11, 20),
        Panel    = Color3.fromRGB(18, 19, 34),
        PanelAlt = Color3.fromRGB(24, 26, 44),
        Accent   = Color3.fromRGB(99, 102, 241),
        MsgSelf  = Color3.fromRGB(79, 82, 180),
        Green    = Color3.fromRGB(34, 197, 94),
        Red      = Color3.fromRGB(239, 68, 68),
        Yellow   = Color3.fromRGB(251, 191, 36),
        Blue     = Color3.fromRGB(59, 130, 246),
        Text     = Color3.fromRGB(220, 226, 240),
        TextDim  = Color3.fromRGB(90, 106, 130),
        MenuBG   = Color3.fromRGB(26, 28, 50),
        Border   = Color3.fromRGB(40, 42, 70),
    },
    Ocean = {
        BG       = Color3.fromRGB(5, 16, 28),
        Panel    = Color3.fromRGB(8, 26, 44),
        PanelAlt = Color3.fromRGB(12, 34, 56),
        Accent   = Color3.fromRGB(20, 184, 166),
        MsgSelf  = Color3.fromRGB(14, 130, 118),
        Green    = Color3.fromRGB(34, 197, 94),
        Red      = Color3.fromRGB(239, 68, 68),
        Yellow   = Color3.fromRGB(251, 191, 36),
        Blue     = Color3.fromRGB(56, 189, 248),
        Text     = Color3.fromRGB(200, 235, 255),
        TextDim  = Color3.fromRGB(60, 110, 140),
        MenuBG   = Color3.fromRGB(14, 36, 58),
        Border   = Color3.fromRGB(20, 60, 90),
    },
    Candy = {
        BG       = Color3.fromRGB(20, 8, 28),
        Panel    = Color3.fromRGB(34, 12, 46),
        PanelAlt = Color3.fromRGB(46, 16, 60),
        Accent   = Color3.fromRGB(236, 72, 153),
        MsgSelf  = Color3.fromRGB(180, 50, 120),
        Green    = Color3.fromRGB(134, 239, 172),
        Red      = Color3.fromRGB(239, 68, 68),
        Yellow   = Color3.fromRGB(251, 191, 36),
        Blue     = Color3.fromRGB(147, 197, 253),
        Text     = Color3.fromRGB(255, 215, 235),
        TextDim  = Color3.fromRGB(150, 90, 130),
        MenuBG   = Color3.fromRGB(48, 16, 64),
        Border   = Color3.fromRGB(80, 20, 80),
    },
    Aqua = {
        BG       = Color3.fromRGB(4, 16, 24),
        Panel    = Color3.fromRGB(8, 28, 40),
        PanelAlt = Color3.fromRGB(12, 38, 54),
        Accent   = Color3.fromRGB(6, 182, 212),
        MsgSelf  = Color3.fromRGB(4, 130, 155),
        Green    = Color3.fromRGB(34, 197, 94),
        Red      = Color3.fromRGB(239, 68, 68),
        Yellow   = Color3.fromRGB(251, 191, 36),
        Blue     = Color3.fromRGB(96, 165, 250),
        Text     = Color3.fromRGB(195, 238, 250),
        TextDim  = Color3.fromRGB(55, 120, 148),
        MenuBG   = Color3.fromRGB(14, 40, 56),
        Border   = Color3.fromRGB(20, 70, 96),
    },
    Forest = {
        BG       = Color3.fromRGB(8, 16, 10),
        Panel    = Color3.fromRGB(14, 26, 16),
        PanelAlt = Color3.fromRGB(18, 34, 22),
        Accent   = Color3.fromRGB(74, 222, 128),
        MsgSelf  = Color3.fromRGB(50, 160, 90),
        Green    = Color3.fromRGB(74, 222, 128),
        Red      = Color3.fromRGB(239, 68, 68),
        Yellow   = Color3.fromRGB(251, 191, 36),
        Blue     = Color3.fromRGB(96, 165, 250),
        Text     = Color3.fromRGB(210, 240, 215),
        TextDim  = Color3.fromRGB(80, 120, 90),
        MenuBG   = Color3.fromRGB(20, 36, 24),
        Border   = Color3.fromRGB(30, 60, 38),
    },
    Lava = {
        BG       = Color3.fromRGB(18, 6, 4),
        Panel    = Color3.fromRGB(30, 10, 6),
        PanelAlt = Color3.fromRGB(40, 14, 8),
        Accent   = Color3.fromRGB(249, 115, 22),
        MsgSelf  = Color3.fromRGB(180, 80, 15),
        Green    = Color3.fromRGB(134, 239, 172),
        Red      = Color3.fromRGB(239, 68, 68),
        Yellow   = Color3.fromRGB(251, 191, 36),
        Blue     = Color3.fromRGB(96, 165, 250),
        Text     = Color3.fromRGB(255, 225, 200),
        TextDim  = Color3.fromRGB(140, 80, 50),
        MenuBG   = Color3.fromRGB(44, 16, 8),
        Border   = Color3.fromRGB(80, 30, 10),
    },
    Galaxy = {
        BG       = Color3.fromRGB(8, 6, 18),
        Panel    = Color3.fromRGB(14, 10, 30),
        PanelAlt = Color3.fromRGB(20, 14, 42),
        Accent   = Color3.fromRGB(167, 139, 250),
        MsgSelf  = Color3.fromRGB(120, 90, 200),
        Green    = Color3.fromRGB(134, 239, 172),
        Red      = Color3.fromRGB(239, 68, 68),
        Yellow   = Color3.fromRGB(251, 191, 36),
        Blue     = Color3.fromRGB(147, 197, 253),
        Text     = Color3.fromRGB(230, 220, 255),
        TextDim  = Color3.fromRGB(110, 90, 160),
        MenuBG   = Color3.fromRGB(26, 18, 52),
        Border   = Color3.fromRGB(50, 34, 90),
    },
    Snow = {
        BG       = Color3.fromRGB(240, 244, 252),
        Panel    = Color3.fromRGB(255, 255, 255),
        PanelAlt = Color3.fromRGB(230, 236, 248),
        Accent   = Color3.fromRGB(99, 102, 241),
        MsgSelf  = Color3.fromRGB(99, 102, 241),
        Green    = Color3.fromRGB(22, 163, 74),
        Red      = Color3.fromRGB(220, 38, 38),
        Yellow   = Color3.fromRGB(202, 138, 4),
        Blue     = Color3.fromRGB(37, 99, 235),
        Text     = Color3.fromRGB(30, 34, 60),
        TextDim  = Color3.fromRGB(120, 130, 160),
        MenuBG   = Color3.fromRGB(245, 248, 255),
        Border   = Color3.fromRGB(200, 208, 230),
    },
}

-- ══════════════════════════════════════
-- MULTILANG STRINGS
-- ══════════════════════════════════════
local STR = {
    ID = { welcome="Selamat datang", connected="Terhubung ke server",
           disconnected="Tidak dapat terhubung", reconnect="⟳ Hubungkan",
           send="Kirim", placeholder="Tulis pesan...",
           kidsPlaceholder="Chat (maks 80 karakter)...",
           sysKids="⚠ KIDS MODE: Sensor aktif, link diblok, maks 80 karakter.",
           copy="📋  Salin Pesan", delete="🗑  Hapus (hanya kamu)",
           copyAll="📄  Salin Semua", goLink="🔗  Buka Link",
           notifNotSet="⚠ Belum Dikonfigurasi!",
           notifMsg="Pilih Bahasa dan Region sebelum memuat chat." },
    EN = { welcome="Welcome", connected="Connected to server",
           disconnected="Cannot connect to server", reconnect="⟳ Reconnect",
           send="Send", placeholder="Type a message...",
           kidsPlaceholder="Chat (max 80 chars)...",
           sysKids="⚠ KIDS MODE: Sensor on, links blocked, max 80 chars.",
           copy="📋  Copy Message", delete="🗑  Delete For Me",
           copyAll="📄  Copy All", goLink="🔗  Open Link",
           notifNotSet="⚠ Not Configured!",
           notifMsg="Select Language and Region before loading chat." },
    RU = { welcome="Добро пожаловать", connected="Подключено к серверу",
           disconnected="Нет подключения", reconnect="⟳ Переподключить",
           send="Отправить", placeholder="Написать сообщение...",
           kidsPlaceholder="Чат (макс 80 символов)...",
           sysKids="⚠ РЕЖИМ ДЛЯ ДЕТЕЙ: Фильтр включён.",
           copy="📋  Копировать", delete="🗑  Удалить (только мне)",
           copyAll="📄  Копировать всё", goLink="🔗  Открыть ссылку",
           notifNotSet="⚠ Не настроено!", notifMsg="Выбери язык и регион." },
    TH = { welcome="ยินดีต้อนรับ", connected="เชื่อมต่อกับเซิร์ฟเวอร์แล้ว",
           disconnected="ไม่สามารถเชื่อมต่อได้", reconnect="⟳ เชื่อมต่อใหม่",
           send="ส่ง", placeholder="พิมพ์ข้อความ...",
           kidsPlaceholder="แชท (สูงสุด 80 ตัวอักษร)...",
           sysKids="⚠ โหมดเด็ก: เซ็นเซอร์เปิดอยู่",
           copy="📋  คัดลอก", delete="🗑  ลบ (เฉพาะฉัน)",
           copyAll="📄  คัดลอกทั้งหมด", goLink="🔗  เปิดลิงก์",
           notifNotSet="⚠ ยังไม่ได้ตั้งค่า!", notifMsg="เลือกภาษาและภูมิภาค" },
}
setmetatable(STR, {__index=function() return STR.EN end})

local function T(k) return (STR[Config.GuiLang] or STR.EN)[k] or k end

-- ══════════════════════════════════════
-- HTTP
-- ══════════════════════════════════════
local function httpGet(url)
    local ok,r = pcall(function() return game:HttpGet(url,true) end)
    return ok and r or nil
end
local function httpPost(url, body)
    local json = HttpService:JSONEncode(body)
    local fn = (syn and syn.request) or (http and http.request) or (request) or nil
    if fn then
        local ok = pcall(fn, {Url=url,Method="POST",Headers={["Content-Type"]="application/json"},Body=json})
        return ok
    end
    return pcall(function() HttpService:PostAsync(url,json,Enum.HttpContentType.ApplicationJson) end)
end

-- ══════════════════════════════════════
-- CLIPBOARD & BROWSER
-- ══════════════════════════════════════
local function copyClip(t) pcall(setclipboard, t) end
local function openUrl(url)
    -- executor open url
    pcall(function()
        if syn and syn.request then
            -- just copy as fallback on mobile
        end
        setclipboard(url)
    end)
    -- Roblox GuiService open browser
    pcall(function()
        game:GetService("GuiService"):OpenBrowserWindow(url)
    end)
end

-- ══════════════════════════════════════
-- TWEEN
-- ══════════════════════════════════════
local function tw(obj, props, t, style)
    TweenService:Create(obj,
        TweenInfo.new(t or 0.2, style or Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        props):Play()
end

-- ══════════════════════════════════════
-- FILTER & LINK
-- ══════════════════════════════════════
local BADWORDS = {"anjing","babi","bangsat","kontol","memek","jancok","bajingan","keparat","asu","fuck","shit","bitch","dick","pussy","damn"}
local LP1 = "https?://[%w%-_%.%?%=%&%/%#%%:%+]+"
local LP2 = "www%.[%w%-_%.%?%=%&%/%#%%:%+]+"

local function hasLink(t) return t:find(LP1)~=nil or t:find(LP2)~=nil end
local function extractLinks(t)
    local ls={}
    for l in t:gmatch(LP1) do table.insert(ls,l) end
    for l in t:gmatch(LP2) do table.insert(ls,l) end
    return ls
end
local function sensorWords(t)
    local r=t
    for _,w in ipairs(BADWORDS) do
        r=r:gsub(w, function(m) return string.rep("•",#m) end)
        r=r:gsub(w:upper(), function(m) return string.rep("•",#m) end)
    end
    return r
end
local function sensorLinks(t)
    local r=t
    r=r:gsub(LP1, function(m) return string.rep("•",#m) end)
    r=r:gsub(LP2, function(m) return string.rep("•",#m) end)
    return r
end

local function processOutgoing(raw)
    local isKids = Config.AgeMode=="KIDS"
    if isKids then raw=raw:sub(1,80) end
    local text = raw
    if Config.Sensor or isKids then text=sensorWords(text) end
    if Config.SensorLink or isKids then text=sensorLinks(text) end
    local tp = hasLink(raw) and "String, Link" or "String"
    return {
        Type    = tp,
        User    = Config.DisplayName,
        Context = text,
        Sensor  = Config.Sensor or isKids,
        Kids    = isKids,
    }, text
end

local function rv(v)
    if type(v)=="table" then return tostring(v[1] or "") end
    return tostring(v or "")
end

-- ══════════════════════════════════════
-- GET CURRENT LATEST ID (skip history)
-- ══════════════════════════════════════
local function fetchLatestId()
    local url = SERVER_URL.."/messages?lang="..Config.Lang.."&region="..Config.Region.."&after=0&limit=1&latest=true"
    local raw = httpGet(url)
    if not raw then return 0 end
    local ok,data = pcall(HttpService.JSONDecode, HttpService, raw)
    if not ok or type(data)~="table" then return 0 end
    local maxId = 0
    for _,m in ipairs(data) do
        if (m.id or 0) > maxId then maxId = m.id end
    end
    return maxId
end

-- ══════════════════════════════════════
-- PHASE 3: CHAT GUI
-- ══════════════════════════════════════
local chatGuiRef = nil
local floatBtnRef = nil

local function destroyChatGui()
    if chatGuiRef and chatGuiRef.Parent then chatGuiRef:Destroy() end
    if floatBtnRef and floatBtnRef.Parent then floatBtnRef:Destroy() end
    chatGuiRef = nil
    floatBtnRef = nil
end

local function launchChatGUI()
    destroyChatGui()

    local C      = Themes[Config.Theme] or Themes.Midnight
    local isKids = Config.AgeMode=="KIDS"
    if isKids then Config.Sensor=true; Config.SensorLink=true end

    -- Skip history: ambil ID terbaru dulu
    Config.LastId = fetchLatestId()

    local SG = Instance.new("ScreenGui")
    SG.Name           = "ChatGlobalUI"
    SG.ResetOnSpawn   = false
    SG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    SG.DisplayOrder   = 999
    SG.Parent         = PGui
    chatGuiRef        = SG

    local WIN_W, WIN_H = 480, 460

    -- ── Main Frame ───────────────────────
    local Main = Instance.new("Frame")
    Main.Name             = "Main"
    Main.Size             = UDim2.new(0, WIN_W, 0, 0)
    Main.Position         = UDim2.new(0.5,-WIN_W/2, 0.5,-WIN_H/2)
    Main.BackgroundColor3 = C.BG
    Main.BorderSizePixel  = 0
    Main.ClipsDescendants = true
    Main.Parent           = SG
    Instance.new("UICorner",Main).CornerRadius = UDim.new(0,14)

    -- Glow border
    local Glow = Instance.new("ImageLabel")
    Glow.Size             = UDim2.new(1,40,1,40)
    Glow.Position         = UDim2.new(0,-20,0,-20)
    Glow.BackgroundTransparency = 1
    Glow.Image            = "rbxassetid://6014261993"
    Glow.ImageColor3      = C.Accent
    Glow.ImageTransparency = 0.7
    Glow.ScaleType        = Enum.ScaleType.Slice
    Glow.SliceCenter      = Rect.new(49,49,450,450)
    Glow.ZIndex           = 0
    Glow.Parent           = Main

    tw(Main, {Size=UDim2.new(0,WIN_W,0,WIN_H)}, 0.4, Enum.EasingStyle.Back)

    -- ── Drag Handle ──────────────────────
    local DragBar = Instance.new("Frame")
    DragBar.Size             = UDim2.new(1,0,0,32)
    DragBar.BackgroundColor3 = C.Panel
    DragBar.BorderSizePixel  = 0
    DragBar.Parent           = Main

    local DragGrad = Instance.new("UIGradient")
    DragGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(math.clamp(math.floor(C.Accent.R*255*0.18),0,255),math.clamp(math.floor(C.Accent.G*255*0.18),0,255),math.clamp(math.floor(C.Accent.B*255*0.18),0,255))),
        ColorSequenceKeypoint.new(1, C.Panel),
    })
    DragGrad.Rotation = 90
    DragGrad.Parent   = DragBar

    -- Drag dots
    local DragDots = Instance.new("TextLabel")
    DragDots.Size             = UDim2.new(0,40,1,0)
    DragDots.Position         = UDim2.new(0.5,-20,0,0)
    DragDots.BackgroundTransparency = 1
    DragDots.Text             = "• • •"
    DragDots.TextColor3       = C.Border
    DragDots.TextSize         = 10
    DragDots.Font             = Enum.Font.GothamBold
    DragDots.Parent           = DragBar

    -- Window buttons
    local function winBtn(icon, xOff, bg, cb)
        local b=Instance.new("TextButton")
        b.Size=UDim2.new(0,20,0,20); b.Position=UDim2.new(1,xOff,0.5,-10)
        b.BackgroundColor3=bg; b.BackgroundTransparency=0.3
        b.Text=icon; b.TextSize=10; b.Font=Enum.Font.GothamBold
        b.TextColor3=Color3.fromRGB(255,255,255)
        b.BorderSizePixel=0; b.Parent=DragBar
        Instance.new("UICorner",b).CornerRadius=UDim.new(1,0)
        b.MouseEnter:Connect(function() tw(b,{BackgroundTransparency=0}) end)
        b.MouseLeave:Connect(function() tw(b,{BackgroundTransparency=0.3}) end)
        b.MouseButton1Click:Connect(cb)
        return b
    end

    winBtn("✕",-10,C.Red,function()
        tw(Main,{Size=UDim2.new(0,WIN_W,0,0)},0.22)
        task.delay(0.25, destroyChatGui)
    end)

    -- Minimize → floating bubble
    winBtn("─",-34,C.Yellow,function()
        tw(Main,{Size=UDim2.new(0,WIN_W,0,0),BackgroundTransparency=1},0.25)
        task.delay(0.28, function()
            Main.Visible = false

            -- Floating bubble button
            local FloatSG = Instance.new("ScreenGui")
            FloatSG.Name           = "ChatGlobalFloat"
            FloatSG.ResetOnSpawn   = false
            FloatSG.DisplayOrder   = 998
            FloatSG.Parent         = PGui
            floatBtnRef            = FloatSG

            local FBtn = Instance.new("TextButton")
            FBtn.Size             = UDim2.new(0,52,0,52)
            FBtn.Position         = UDim2.new(0,16,0.7,-26)
            FBtn.BackgroundColor3 = C.Accent
            FBtn.Text             = "💬"
            FBtn.TextSize         = 24
            FBtn.Font             = Enum.Font.Gotham
            FBtn.BorderSizePixel  = 0
            FBtn.Parent           = FloatSG
            Instance.new("UICorner",FBtn).CornerRadius=UDim.new(1,0)

            -- Glow
            local FGlow=Instance.new("UIStroke",FBtn)
            FGlow.Color           = C.Accent
            FGlow.Thickness       = 2
            FGlow.Transparency    = 0.4

            -- Pulse anim
            local pulse=true
            task.spawn(function()
                while pulse and FBtn.Parent do
                    tw(FBtn,{BackgroundTransparency=0.2},0.7)
                    task.wait(0.7)
                    tw(FBtn,{BackgroundTransparency=0},0.7)
                    task.wait(0.7)
                end
            end)

            -- Drag float btn
            do
                local drag,ds,sp
                FBtn.InputBegan:Connect(function(i)
                    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
                        drag=true; ds=i.Position; sp=FBtn.Position
                    end
                end)
                UserInputService.InputChanged:Connect(function(i)
                    if drag and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
                        local d=i.Position-ds
                        FBtn.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y)
                    end
                end)
                UserInputService.InputEnded:Connect(function(i)
                    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then drag=false end
                end)
            end

            -- Click → restore chat
            FBtn.MouseButton1Click:Connect(function()
                pulse=false
                FloatSG:Destroy()
                floatBtnRef=nil
                Main.Visible=true
                Main.BackgroundTransparency=0
                tw(Main,{Size=UDim2.new(0,WIN_W,0,WIN_H)},0.35,Enum.EasingStyle.Back)
            end)
        end)
    end)

    -- Drag main window
    do
        local drag,ds,sp
        DragBar.InputBegan:Connect(function(i)
            if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
                drag=true; ds=i.Position; sp=Main.Position
            end
        end)
        UserInputService.InputChanged:Connect(function(i)
            if drag and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
                local d=i.Position-ds
                Main.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y)
            end
        end)
        UserInputService.InputEnded:Connect(function(i)
            if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then drag=false end
        end)
    end

    -- ── Status Bar ───────────────────────
    local StatBar = Instance.new("Frame")
    StatBar.Size             = UDim2.new(1,0,0,42)
    StatBar.Position         = UDim2.new(0,0,0,32)
    StatBar.BackgroundColor3 = C.Panel
    StatBar.BorderSizePixel  = 0
    StatBar.Parent           = Main

    Instance.new("Frame",StatBar).Size=UDim2.new(1,0,0,1)
    local div=StatBar:FindFirstChildWhichIsA("Frame")
    if div then div.BackgroundColor3=C.Border; div.BorderSizePixel=0; div.Position=UDim2.new(0,0,1,-1) end

    local StatDot=Instance.new("Frame")
    StatDot.Size=UDim2.new(0,9,0,9); StatDot.Position=UDim2.new(0.5,-80,0.5,-4)
    StatDot.BackgroundColor3=C.Yellow; StatDot.BorderSizePixel=0; StatDot.Parent=StatBar
    Instance.new("UICorner",StatDot).CornerRadius=UDim.new(1,0)

    local StatTxt=Instance.new("TextLabel")
    StatTxt.Size=UDim2.new(0,260,1,0); StatTxt.Position=UDim2.new(0.5,-68,0,0)
    StatTxt.BackgroundTransparency=1
    StatTxt.Text=T("connected")
    StatTxt.TextColor3=C.Green; StatTxt.TextSize=14
    StatTxt.Font=Enum.Font.GothamBold
    StatTxt.TextXAlignment=Enum.TextXAlignment.Left
    StatTxt.Parent=StatBar

    local ReBtn=Instance.new("TextButton")
    ReBtn.Size=UDim2.new(0,92,0,26); ReBtn.Position=UDim2.new(1,-100,0.5,-13)
    ReBtn.BackgroundColor3=C.Accent; ReBtn.Text=T("reconnect")
    ReBtn.TextColor3=Color3.fromRGB(255,255,255); ReBtn.TextSize=11
    ReBtn.Font=Enum.Font.GothamSemibold; ReBtn.BorderSizePixel=0
    ReBtn.Visible=false; ReBtn.Parent=StatBar
    Instance.new("UICorner",ReBtn).CornerRadius=UDim.new(0,7)

    -- ── Badge Bar ─────────────────────────
    local BadgeBar=Instance.new("Frame")
    BadgeBar.Size=UDim2.new(1,0,0,22)
    BadgeBar.Position=UDim2.new(0,0,0,74)
    BadgeBar.BackgroundColor3=C.PanelAlt
    BadgeBar.BorderSizePixel=0; BadgeBar.ClipsDescendants=true
    BadgeBar.Parent=Main

    local BL=Instance.new("UIListLayout",BadgeBar)
    BL.FillDirection=Enum.FillDirection.Horizontal
    BL.VerticalAlignment=Enum.VerticalAlignment.Center
    BL.Padding=UDim.new(0,4)
    Instance.new("UIPadding",BadgeBar).PaddingLeft=UDim.new(0,8)

    local function badge(t,bg)
        local b=Instance.new("TextLabel")
        b.AutomaticSize=Enum.AutomaticSize.X
        b.Size=UDim2.new(0,0,0,15)
        b.BackgroundColor3=bg; b.BackgroundTransparency=0.25
        b.Text=" "..t.." "
        b.TextColor3=Color3.fromRGB(255,255,255)
        b.TextSize=9; b.Font=Enum.Font.GothamBold
        b.BorderSizePixel=0; b.Parent=BadgeBar
        Instance.new("UICorner",b).CornerRadius=UDim.new(0,4)
    end

    badge("🌐 "..Config.Region, C.Accent)
    badge("💬 "..Config.Lang, Color3.fromRGB(59,130,246))
    badge("👤 "..Config.DisplayName, C.TextDim)
    if isKids then badge("👶 KIDS",C.Yellow) end
    if Config.Sensor then badge("🔒 SENSOR",C.Red) end
    if Config.SensorLink then badge("🔗 SENSOR",Color3.fromRGB(249,115,22)) end
    if Config.FriendsOnly then badge("👥 TEMAN",Color3.fromRGB(16,185,129)) end
    if Config.GameOnly then badge("🎮 GAME",Color3.fromRGB(139,92,246)) end

    -- ── Chat Scroll ───────────────────────
    local ChatScroll=Instance.new("ScrollingFrame")
    ChatScroll.Size=UDim2.new(1,-16,1,-152)
    ChatScroll.Position=UDim2.new(0,8,0,104)
    ChatScroll.BackgroundColor3=C.Panel
    ChatScroll.BorderSizePixel=0
    ChatScroll.ScrollBarThickness=3
    ChatScroll.ScrollBarImageColor3=C.Accent
    ChatScroll.CanvasSize=UDim2.new(0,0,0,0)
    ChatScroll.AutomaticCanvasSize=Enum.AutomaticSize.Y
    ChatScroll.Parent=Main
    Instance.new("UICorner",ChatScroll).CornerRadius=UDim.new(0,10)

    local CList=Instance.new("UIListLayout",ChatScroll)
    CList.Padding=UDim.new(0,5); CList.SortOrder=Enum.SortOrder.LayoutOrder

    local CPad=Instance.new("UIPadding",ChatScroll)
    CPad.PaddingTop=UDim.new(0,8); CPad.PaddingBottom=UDim.new(0,8)
    CPad.PaddingLeft=UDim.new(0,8); CPad.PaddingRight=UDim.new(0,8)

    -- ── Input Bar ─────────────────────────
    local InpBar=Instance.new("Frame")
    InpBar.Size=UDim2.new(1,-16,0,42)
    InpBar.Position=UDim2.new(0,8,1,-50)
    InpBar.BackgroundColor3=C.Panel
    InpBar.BorderSizePixel=0; InpBar.Parent=Main
    Instance.new("UICorner",InpBar).CornerRadius=UDim.new(0,10)
    local IS=Instance.new("UIStroke",InpBar)
    IS.Color=C.Border; IS.Thickness=1; IS.Transparency=0.5

    local MsgBox=Instance.new("TextBox")
    MsgBox.Size=UDim2.new(1,-90,1,-12)
    MsgBox.Position=UDim2.new(0,12,0,6)
    MsgBox.BackgroundTransparency=1
    MsgBox.Text=""
    MsgBox.PlaceholderText=isKids and T("kidsPlaceholder") or T("placeholder")
    MsgBox.PlaceholderColor3=C.TextDim
    MsgBox.TextColor3=C.Text; MsgBox.TextSize=13
    MsgBox.Font=Enum.Font.Gotham
    MsgBox.TextXAlignment=Enum.TextXAlignment.Left
    MsgBox.ClearTextOnFocus=false; MsgBox.Parent=InpBar

    local SendBtn=Instance.new("TextButton")
    SendBtn.Size=UDim2.new(0,72,0,30)
    SendBtn.Position=UDim2.new(1,-78,0.5,-15)
    SendBtn.BackgroundColor3=C.Accent
    SendBtn.Text=T("send").." ↗"
    SendBtn.TextColor3=Color3.fromRGB(255,255,255)
    SendBtn.TextSize=12; SendBtn.Font=Enum.Font.GothamSemibold
    SendBtn.BorderSizePixel=0; SendBtn.Parent=InpBar
    Instance.new("UICorner",SendBtn).CornerRadius=UDim.new(0,8)
    SendBtn.MouseEnter:Connect(function() tw(SendBtn,{BackgroundTransparency=0.2}) end)
    SendBtn.MouseLeave:Connect(function() tw(SendBtn,{BackgroundTransparency=0}) end)

    -- ══════════════════════════════════════
    -- STATUS HELPERS
    -- ══════════════════════════════════════
    local isConnected=false
    local function setConnected(val)
        isConnected=val
        if val then
            StatTxt.Text=T("connected"); StatTxt.TextColor3=C.Green
            tw(StatDot,{BackgroundColor3=C.Green}); ReBtn.Visible=false
        else
            StatTxt.Text=T("disconnected"); StatTxt.TextColor3=C.Red
            tw(StatDot,{BackgroundColor3=C.Red}); ReBtn.Visible=true
        end
    end
    setConnected(false)

    -- ══════════════════════════════════════
    -- CONTEXT MENU
    -- ══════════════════════════════════════
    local activeMenu=nil
    local function closeMenu()
        if activeMenu then
            tw(activeMenu,{BackgroundTransparency=1},0.12)
            local m=activeMenu; activeMenu=nil
            task.delay(0.15, function() if m and m.Parent then m:Destroy() end end)
        end
    end
    UserInputService.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            task.defer(closeMenu)
        end
    end)

    local function showMenu(bubble, msgCtx, fullCopy, links)
        closeMenu()
        task.wait(0.01)
        local hasLnk = links and #links>0

        local items={
            {icon="📋", label=T("copy"),    act=function() copyClip(msgCtx) end},
            {icon="🗑",  label=T("delete"),  act=function() bubble:Destroy() end},
            {icon="📄", label=T("copyAll"), act=function() copyClip(fullCopy) end},
        }
        if hasLnk then
            table.insert(items, {icon="🔗", label=T("goLink"), act=function()
                openUrl(links[1])
            end, highlight=true})
        end

        local menuH = #items * 32 + 12
        local menuW = 210

        local bPos=bubble.AbsolutePosition
        local bSz=bubble.AbsoluteSize
        local mPos=Main.AbsolutePosition
        local mSz=Main.AbsoluteSize
        local mx=math.clamp(bPos.X-mPos.X, 4, mSz.X-menuW-4)
        local my=bPos.Y-mPos.Y+bSz.Y+4
        if my+menuH > mSz.Y-8 then my=bPos.Y-mPos.Y-menuH-4 end

        local menu=Instance.new("Frame")
        menu.Size=UDim2.new(0,menuW,0,menuH)
        menu.Position=UDim2.new(0,mx,0,my)
        menu.BackgroundColor3=C.MenuBG
        menu.BorderSizePixel=0; menu.ZIndex=20
        menu.BackgroundTransparency=1; menu.Parent=Main
        Instance.new("UICorner",menu).CornerRadius=UDim.new(0,10)
        local mS=Instance.new("UIStroke",menu)
        mS.Color=C.Border; mS.Thickness=1
        activeMenu=menu
        tw(menu,{BackgroundTransparency=0.05},0.15)

        local mList=Instance.new("UIListLayout",menu)
        mList.Padding=UDim.new(0,2)
        local mPad=Instance.new("UIPadding",menu)
        mPad.PaddingTop=UDim.new(0,6); mPad.PaddingBottom=UDim.new(0,6)
        mPad.PaddingLeft=UDim.new(0,6); mPad.PaddingRight=UDim.new(0,6)

        for _,item in ipairs(items) do
            local b=Instance.new("TextButton")
            b.Size=UDim2.new(1,0,0,28)
            b.BackgroundColor3=item.highlight and C.Blue or C.PanelAlt
            b.BackgroundTransparency=item.highlight and 0.4 or 0.5
            b.Text=item.icon.."  "..item.label
            b.TextColor3=item.highlight and Color3.fromRGB(147,197,253) or C.Text
            b.TextSize=12; b.Font=Enum.Font.GothamSemibold
            b.TextXAlignment=Enum.TextXAlignment.Left
            b.BorderSizePixel=0; b.ZIndex=21; b.Parent=menu
            Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
            Instance.new("UIPadding",b).PaddingLeft=UDim.new(0,10)
            b.MouseEnter:Connect(function() tw(b,{BackgroundTransparency=0.1}) end)
            b.MouseLeave:Connect(function() tw(b,{BackgroundTransparency=item.highlight and 0.4 or 0.5}) end)
            b.MouseButton1Click:Connect(function() item.act(); closeMenu() end)
        end
    end

    -- ══════════════════════════════════════
    -- ADD MESSAGE BUBBLE
    -- ══════════════════════════════════════
    local msgOrder=0
    local function addMsg(msgData, isOwn)
        msgOrder=msgOrder+1
        local user    = msgData.User    or "?"
        local ctx     = msgData.Context or ""
        local mtype   = msgData.Type    or "String"
        local isMKids = msgData.Kids    or false
        local isMe    = isOwn==true
        local hasLnk  = mtype:find("Link")~=nil
        local links   = (hasLnk and not (Config.SensorLink or isMKids)) and extractLinks(ctx) or {}

        local bubble=Instance.new("Frame")
        bubble.Size=UDim2.new(1,-8,0,0); bubble.AutomaticSize=Enum.AutomaticSize.Y
        bubble.BackgroundColor3=isMe and C.MsgSelf or C.PanelAlt
        bubble.BackgroundTransparency=isMe and 0.55 or 0.2
        bubble.BorderSizePixel=0; bubble.LayoutOrder=msgOrder
        bubble.Parent=ChatScroll
        Instance.new("UICorner",bubble).CornerRadius=UDim.new(0,9)
        if isMe then
            local bs=Instance.new("UIStroke",bubble)
            bs.Color=C.Accent; bs.Thickness=1; bs.Transparency=0.6
        end

        local bPad=Instance.new("UIPadding",bubble)
        bPad.PaddingLeft=UDim.new(0,10); bPad.PaddingRight=UDim.new(0,10)
        bPad.PaddingTop=UDim.new(0,6); bPad.PaddingBottom=UDim.new(0,6)

        local bList=Instance.new("UIListLayout",bubble)
        bList.Padding=UDim.new(0,3)

        -- Name + badge row
        local nRow=Instance.new("Frame")
        nRow.Size=UDim2.new(1,0,0,14); nRow.AutomaticSize=Enum.AutomaticSize.X
        nRow.BackgroundTransparency=1; nRow.Parent=bubble

        local nList=Instance.new("UIListLayout",nRow)
        nList.FillDirection=Enum.FillDirection.Horizontal
        nList.VerticalAlignment=Enum.VerticalAlignment.Center
        nList.Padding=UDim.new(0,5)

        local nLbl=Instance.new("TextLabel")
        nLbl.AutomaticSize=Enum.AutomaticSize.X
        nLbl.Size=UDim2.new(0,0,1,0)
        nLbl.BackgroundTransparency=1
        nLbl.Text=user
        nLbl.TextColor3=isMe and C.Accent or C.Green
        nLbl.TextSize=10; nLbl.Font=Enum.Font.GothamBold
        nLbl.TextXAlignment=Enum.TextXAlignment.Left
        nLbl.Parent=nRow

        if hasLnk and #links>0 then
            local lb=Instance.new("TextLabel")
            lb.AutomaticSize=Enum.AutomaticSize.X
            lb.Size=UDim2.new(0,0,0,13)
            lb.BackgroundColor3=Color3.fromRGB(37,99,235)
            lb.BackgroundTransparency=0.3
            lb.Text=" 🔗 Link "
            lb.TextColor3=Color3.fromRGB(255,255,255)
            lb.TextSize=9; lb.Font=Enum.Font.GothamBold
            lb.BorderSizePixel=0; lb.Parent=nRow
            Instance.new("UICorner",lb).CornerRadius=UDim.new(0,3)
        end

        -- Context text
        local ctxLbl=Instance.new("TextLabel")
        ctxLbl.Size=UDim2.new(1,0,0,0); ctxLbl.AutomaticSize=Enum.AutomaticSize.Y
        ctxLbl.BackgroundTransparency=1; ctxLbl.Text=ctx
        ctxLbl.TextColor3=C.Text; ctxLbl.TextSize=13; ctxLbl.Font=Enum.Font.Gotham
        ctxLbl.TextXAlignment=Enum.TextXAlignment.Left
        ctxLbl.TextWrapped=true; ctxLbl.Parent=bubble

        -- Link buttons (biru, klik = copy + open)
        for _,lnk in ipairs(links) do
            local lBtn=Instance.new("TextButton")
            lBtn.AutomaticSize=Enum.AutomaticSize.X
            lBtn.Size=UDim2.new(0,0,0,22)
            lBtn.BackgroundColor3=Color3.fromRGB(30,58,138)
            lBtn.BackgroundTransparency=0.2
            lBtn.Text="🔗 "..(lnk:sub(1,44)..(#lnk>44 and "…" or ""))
            lBtn.TextColor3=Color3.fromRGB(147,197,253)
            lBtn.TextSize=11; lBtn.Font=Enum.Font.GothamSemibold
            lBtn.BorderSizePixel=0; lBtn.Parent=bubble
            Instance.new("UICorner",lBtn).CornerRadius=UDim.new(0,5)
            local lP=Instance.new("UIPadding",lBtn)
            lP.PaddingLeft=UDim.new(0,7); lP.PaddingRight=UDim.new(0,7)
            lBtn.MouseEnter:Connect(function()
                tw(lBtn,{BackgroundTransparency=0}); lBtn.TextColor3=Color3.fromRGB(255,255,255)
            end)
            lBtn.MouseLeave:Connect(function()
                tw(lBtn,{BackgroundTransparency=0.2}); lBtn.TextColor3=Color3.fromRGB(147,197,253)
            end)
            lBtn.MouseButton1Click:Connect(function()
                openUrl(lnk)
                local orig=lBtn.Text
                lBtn.Text="✔ Membuka / Menyalin..."
                task.delay(2, function() if lBtn.Parent then lBtn.Text=orig end end)
            end)
        end

        -- Context menu
        local fullCopyTxt=user..", ["..tostring(LP.UserId).."]: "..ctx
        bubble.InputBegan:Connect(function(i)
            if i.UserInputType==Enum.UserInputType.MouseButton2 then
                showMenu(bubble,ctx,fullCopyTxt,links)
            end
        end)
        local holding=false
        bubble.InputBegan:Connect(function(i)
            if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
                holding=true
                task.delay(0.75, function()
                    if holding then showMenu(bubble,ctx,fullCopyTxt,links) end
                end)
            end
        end)
        bubble.InputEnded:Connect(function(i)
            if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then holding=false end
        end)

        task.defer(function()
            ChatScroll.CanvasPosition=Vector2.new(0,ChatScroll.AbsoluteCanvasSize.Y)
        end)
        return bubble
    end

    local function addSys(txt)
        addMsg({Type="String",User="System",Context=txt,Sensor=false,Kids=false},false)
    end

    -- ══════════════════════════════════════
    -- SEND & POLL
    -- ══════════════════════════════════════
    local function sendMsg(raw)
        if raw=="" then return end
        local msgJSON,_ = processOutgoing(raw)
        print(HttpService:JSONEncode(msgJSON)) -- debug print
        local ok=httpPost(SERVER_URL.."/send", {
            user=Config.DisplayName,
            message=HttpService:JSONEncode(msgJSON),
            lang=Config.Lang, region=Config.Region,
            gameId=Config.GameOnly and tostring(game.PlaceId) or "ANY",
        })
        if ok then addMsg(msgJSON,true)
        else addSys("❌ "..T("disconnected")) end
    end

    local function pollMsgs()
        local url=SERVER_URL.."/messages?lang="..Config.Lang.."&region="..Config.Region.."&after="..Config.LastId
        if Config.GameOnly then url=url.."&gameId="..game.PlaceId end
        local raw=httpGet(url)
        if not raw then setConnected(false); return end
        local ok,data=pcall(HttpService.JSONDecode,HttpService,raw)
        if not ok or type(data)~="table" then setConnected(false); return end
        setConnected(true)
        for _,entry in ipairs(data) do
            if (entry.id or 0)>Config.LastId then
                Config.LastId=entry.id
                if entry.user~=Config.DisplayName then
                    local msgD
                    if type(entry.message)=="string" and entry.message:sub(1,1)=="{" then
                        local ok2,p=pcall(HttpService.JSONDecode,HttpService,entry.message)
                        msgD=ok2 and p or {Type="String",User=entry.user,Context=entry.message,Sensor=false,Kids=false}
                    else
                        msgD={Type="String",User=entry.user or "?",Context=tostring(entry.message or ""),Sensor=false,Kids=false}
                    end
                    if Config.FriendsOnly then
                        local fok,uid=pcall(Players.GetUserIdFromNameAsync,Players,entry.user)
                        if fok and uid and not LP:IsFriendsWith(uid) then continue end
                    end
                    addMsg(msgD,false)
                end
            end
        end
    end

    SendBtn.MouseButton1Click:Connect(function()
        local t=MsgBox.Text; MsgBox.Text=""; sendMsg(t)
    end)
    MsgBox.FocusLost:Connect(function(enter)
        if enter and MsgBox.Text~="" then
            local t=MsgBox.Text; MsgBox.Text=""; sendMsg(t)
        end
    end)
    ReBtn.MouseButton1Click:Connect(function()
        ReBtn.Text="⟳ ..."; task.spawn(function()
            pollMsgs(); task.wait(1); ReBtn.Text=T("reconnect")
        end)
    end)

    -- Poll loop
    local lastPoll=0
    local pollConn
    pollConn=RunService.Heartbeat:Connect(function()
        if tick()-lastPoll>=3 then lastPoll=tick(); task.spawn(pollMsgs) end
    end)
    SG.AncestryChanged:Connect(function()
        if not SG.Parent then pollConn:Disconnect() end
    end)

    addSys(T("welcome").." "..Config.DisplayName.."  ·  "..Config.Region.."  ·  "..Config.Lang..(isKids and "  ·  KIDS 👶" or ""))
    if isKids then addSys(T("sysKids")) end
    task.spawn(pollMsgs)
    print("✅ ChatGlobal v4.0 Chat launched!")
end

-- ══════════════════════════════════════
-- PHASE 2: AGE VERIFY
-- ══════════════════════════════════════
local function showAgeVerify(onDone)
    if PGui:FindFirstChild("AgeVerifyUI") then PGui.AgeVerifyUI:Destroy() end
    local AgeGui=Instance.new("ScreenGui")
    AgeGui.Name="AgeVerifyUI"; AgeGui.ResetOnSpawn=false
    AgeGui.DisplayOrder=10000; AgeGui.Parent=PGui

    local Ov=Instance.new("Frame",AgeGui)
    Ov.Size=UDim2.new(1,0,1,0); Ov.BackgroundColor3=Color3.fromRGB(0,0,0)
    Ov.BackgroundTransparency=0.45; Ov.BorderSizePixel=0

    local Card=Instance.new("Frame",AgeGui)
    Card.Size=UDim2.new(0,340,0,0); Card.Position=UDim2.new(0.5,-170,0.5,-148)
    Card.BackgroundColor3=Color3.fromRGB(14,15,26); Card.BorderSizePixel=0
    Card.ClipsDescendants=true
    Instance.new("UICorner",Card).CornerRadius=UDim.new(0,14)

    local CB=Instance.new("Frame",Card)
    CB.Size=UDim2.new(1,2,1,2); CB.Position=UDim2.new(0,-1,0,-1)
    CB.BackgroundColor3=Color3.fromRGB(251,191,36); CB.BackgroundTransparency=0.45; CB.ZIndex=0
    Instance.new("UICorner",CB).CornerRadius=UDim.new(0,15)

    tw(Card,{Size=UDim2.new(0,340,0,300)},0.4,Enum.EasingStyle.Back)

    local function al(t,y,ts,col,f)
        local l=Instance.new("TextLabel",Card)
        l.Size=UDim2.new(1,-20,0,ts+4); l.Position=UDim2.new(0,10,0,y)
        l.BackgroundTransparency=1; l.Text=t
        l.TextColor3=col or Color3.fromRGB(190,205,225); l.TextSize=ts or 12
        l.Font=f or Enum.Font.Gotham; l.TextWrapped=true
        l.AutomaticSize=Enum.AutomaticSize.Y
        l.TextXAlignment=Enum.TextXAlignment.Center
        return l
    end

    al("⚠️",12,30,Color3.fromRGB(251,191,36),Enum.Font.GothamBold)
    al("Verifikasi Umur",52,17,Color3.fromRGB(255,220,80),Enum.Font.GothamBold)
    al("ChatGlobal berisi percakapan global.\nKamu harus berumur minimal 13+ untuk akses penuh.",82,12)

    local AgeFrame=Instance.new("Frame",Card)
    AgeFrame.Size=UDim2.new(1,-20,0,62); AgeFrame.Position=UDim2.new(0,10,0,152)
    AgeFrame.BackgroundColor3=Color3.fromRGB(22,24,40); AgeFrame.BorderSizePixel=0
    AgeFrame.Visible=false
    Instance.new("UICorner",AgeFrame).CornerRadius=UDim.new(0,8)

    local AgeLbl=Instance.new("TextLabel",AgeFrame)
    AgeLbl.Size=UDim2.new(1,-12,0,22); AgeLbl.Position=UDim2.new(0,8,0,6)
    AgeLbl.BackgroundTransparency=1; AgeLbl.Text="Masukkan umurmu:"
    AgeLbl.TextColor3=Color3.fromRGB(180,190,210); AgeLbl.TextSize=12
    AgeLbl.Font=Enum.Font.GothamSemibold; AgeLbl.TextXAlignment=Enum.TextXAlignment.Left

    local AgeBox=Instance.new("TextBox",AgeFrame)
    AgeBox.Size=UDim2.new(1,-16,0,26); AgeBox.Position=UDim2.new(0,8,0,30)
    AgeBox.BackgroundColor3=Color3.fromRGB(28,30,50); AgeBox.Text=""
    AgeBox.PlaceholderText="Contoh: 10"; AgeBox.PlaceholderColor3=Color3.fromRGB(90,105,130)
    AgeBox.TextColor3=Color3.fromRGB(255,220,80); AgeBox.TextSize=14
    AgeBox.Font=Enum.Font.GothamBold; AgeBox.BorderSizePixel=0
    Instance.new("UICorner",AgeBox).CornerRadius=UDim.new(0,6)
    Instance.new("UIPadding",AgeBox).PaddingLeft=UDim.new(0,8)

    local function aBtn(t,y,bg,cb)
        local b=Instance.new("TextButton",Card)
        b.Size=UDim2.new(1,-20,0,36); b.Position=UDim2.new(0,10,0,y)
        b.BackgroundColor3=bg; b.Text=t; b.TextColor3=Color3.fromRGB(255,255,255)
        b.TextSize=13; b.Font=Enum.Font.GothamSemibold; b.BorderSizePixel=0
        Instance.new("UICorner",b).CornerRadius=UDim.new(0,9)
        b.MouseEnter:Connect(function() tw(b,{BackgroundTransparency=0.15}) end)
        b.MouseLeave:Connect(function() tw(b,{BackgroundTransparency=0}) end)
        b.MouseButton1Click:Connect(cb)
        return b
    end

    local ub
    ub=aBtn("😔  Saya di bawah 13",152,Color3.fromRGB(100,55,15),function()
        ub.Visible=false; AgeFrame.Visible=true
        tw(Card,{Size=UDim2.new(0,340,0,378)},0.25)
        aBtn("✔  Konfirmasi",228,Color3.fromRGB(200,150,20),function()
            local age=tonumber(AgeBox.Text)
            if not age or age<=0 or age>100 then
                AgeLbl.Text="⚠ Masukkan angka yang valid!"; AgeLbl.TextColor3=Color3.fromRGB(239,68,68); return
            end
            Config.AgeMode="KIDS"
            tw(Card,{Size=UDim2.new(0,340,0,0)},0.22)
            task.delay(0.28,function() AgeGui:Destroy(); onDone() end)
        end)
    end)

    aBtn("✅  Saya sudah berumur 13+",198,Color3.fromRGB(20,90,45),function()
        Config.AgeMode="ADULT"
        tw(Card,{Size=UDim2.new(0,340,0,0)},0.22)
        task.delay(0.28,function() AgeGui:Destroy(); onDone() end)
    end)
end

-- ══════════════════════════════════════
-- PHASE 1: RAYFIELD SETUP
-- ══════════════════════════════════════
local rayGui=nil

local function launchRayfield()
    -- Bersihkan chat GUI kalau ada
    destroyChatGui()
    if PGui:FindFirstChild("AgeVerifyUI") then PGui.AgeVerifyUI:Destroy() end

    local rfOk,Rayfield=pcall(function()
        return loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
    end)
    if not rfOk or not Rayfield then error("❌ Gagal load Rayfield!") end

    local function rv(v)
        if type(v)=="table" then return tostring(v[1] or "") end
        return tostring(v or "")
    end

    local Win=Rayfield:CreateWindow({
        Name="ChatGlobal  ·  Setup v4.0",
        LoadingTitle="ChatGlobal v4.0",
        LoadingSubtitle="by KHAFIDZKTP  ·  ketik /Setup untuk buka kembali",
        ConfigurationSaving={Enabled=false},
        Discord={Enabled=false},
        KeySystem=false,
    })

    -- Store ref
    task.wait(0.5)
    rayGui = PGui:FindFirstChild("Rayfield")

    local Tab=Win:CreateTab("⚙  Setup","settings")

    Tab:CreateSection("🗣  Bahasa GUI Chat  (berlaku setelah Load)")
    Tab:CreateDropdown({
        Name="Bahasa Tampilan Chat",
        Options={"ID  -  Indonesia","EN  -  English","RU  -  Русский","TH  -  ภาษาไทย"},
        CurrentOption={"ID  -  Indonesia"}, Flag="GuiLang",
        Callback=function(v)
            local s=rv(v); Config.GuiLang=s:match("^(%a+)") or "ID"
        end,
    })

    Tab:CreateSection("👤  Identitas")
    Tab:CreateInput({
        Name="Display Name", PlaceholderText=LP.Name,
        RemoveTextAfterFocusLost=false,
        Callback=function(v) local s=rv(v); if s~="" then Config.DisplayName=s end end,
    })

    Tab:CreateSection("🌍  Region & Bahasa Chat  ←  WAJIB")
    Tab:CreateDropdown({
        Name="Bahasa Chat",
        Options={
            "ALL  -  Semua Bahasa","ID  -  Indonesia","EN  -  English",
            "RU  -  Русский","TH  -  ภาษาไทย","KZ  -  Қазақша",
            "JP  -  日本語","AR  -  العربية","ES  -  Español",
            "FR  -  Français","DE  -  Deutsch","KR  -  한국어",
            "CN  -  中文","PT  -  Português","TR  -  Türkçe",
        },
        CurrentOption={"ALL  -  Semua Bahasa"}, Flag="Lang",
        Callback=function(v)
            local s=rv(v)
            local code=s:match("^(%a+)") or "ALL"
            Config.Lang= code
            print("✅ Lang: "..Config.Lang)
        end,
    })
    Tab:CreateDropdown({
        Name="Region",
        Options={
            "GLOBAL  -  Semua Dunia","ID  -  Indonesia Only",
            "RU  -  Russia Only","TH  -  Thailand Only",
            "KZ  -  Kazakhstan Only","JP  -  Japan Only",
            "AR  -  Arab Region","EN  -  English Speaking",
        },
        CurrentOption={"GLOBAL  -  Semua Dunia"}, Flag="Region",
        Callback=function(v)
            local s=rv(v)
            Config.Region=s:match("^(%a+)") or "GLOBAL"
            print("✅ Region: "..Config.Region)
        end,
    })

    Tab:CreateSection("🔒  Privasi")
    Tab:CreateToggle({Name="Sensor Kata Kasar",CurrentValue=false,Flag="S1",Callback=function(v) Config.Sensor=v end})
    Tab:CreateToggle({Name="🔗 Sensor Semua Link",CurrentValue=false,Flag="S2",Callback=function(v) Config.SensorLink=v end})
    Tab:CreateToggle({Name="👥 Khusus Teman",CurrentValue=false,Flag="S3",Callback=function(v) Config.FriendsOnly=v end})
    Tab:CreateToggle({Name="🎮 Khusus Game Ini",CurrentValue=false,Flag="S4",Callback=function(v) Config.GameOnly=v end})

    Tab:CreateSection("🎨  Tema")
    Tab:CreateDropdown({
        Name="Tema Chat",
        Options={"Midnight","Ocean","Candy","Aqua","Forest","Lava","Galaxy","Snow"},
        CurrentOption={"Midnight"}, Flag="Theme",
        Callback=function(v) Config.Theme=rv(v) end,
    })

    Tab:CreateSection("🚀  Mulai")
    Tab:CreateLabel("Klik Load untuk mulai. Kosong = ALL + GLOBAL otomatis.")

    local function doLoad()
        if Config.Lang=="" or Config.Lang==nil then Config.Lang="ALL" end
        if Config.Region=="" or Config.Region==nil then Config.Region="GLOBAL" end

        showAgeVerify(function()
            -- Sembunyikan Rayfield
            if rayGui and rayGui.Parent then
                tw(rayGui,{BackgroundTransparency=1},0.3)
                task.delay(0.35,function()
                    if rayGui and rayGui.Parent then rayGui.Enabled=false end
                end)
            end
            launchChatGUI()
        end)
    end

    Tab:CreateButton({Name="▶  Load Chat", Callback=doLoad})
    Tab:CreateButton({Name="★  Set Default & Load", Callback=doLoad})

    print("✅ ChatGlobal v4.0 Setup ready!  Ketik /Setup untuk buka kembali.")
end

-- ══════════════════════════════════════
-- /Setup COMMAND LISTENER
-- ══════════════════════════════════════
LP.Chatted:Connect(function(msg)
    if msg:lower()=="/setup" then
        -- Sembunyikan chat GUI, buka rayfield
        if chatGuiRef and chatGuiRef.Parent then
            tw(chatGuiRef:FindFirstChild("Main"),{Size=UDim2.new(0,480,0,0)},0.25)
            task.delay(0.3, function()
                destroyChatGui()
            end)
        end
        -- Tampilkan kembali rayfield kalau masih ada
        if rayGui and rayGui.Parent then
            rayGui.Enabled=true
            tw(rayGui,{BackgroundTransparency=0},0.3)
        else
            -- Re-launch rayfield
            task.spawn(launchRayfield)
        end
    end
end)

-- ══════════════════════════════════════
-- START
-- ══════════════════════════════════════
task.spawn(launchRayfield)

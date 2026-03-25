--[[
    ╔══════════════════════════════════════════╗
    ║      ChatGlobal v5.0 by KHAFIDZKTP       ║
    ║  /Setup  → Buka Rayfield kembali         ║
    ╚══════════════════════════════════════════╝
    Types: String | Link | Code | Image | Voice | Id
--]]

local Players          = game:GetService("Players")
local HttpService      = game:GetService("HttpService")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService       = game:GetService("RunService")
local Workspace        = game:GetService("Workspace")

local LP   = Players.LocalPlayer
local PGui = LP:WaitForChild("PlayerGui")
local Char = LP.Character or LP.CharacterAdded:Wait()

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
    IsVIP       = false,
    VIPStyle    = "rainbow", -- "rainbow" | "gold"
    CoinsFound  = 0,
}

-- ══════════════════════════════════════
-- VIP STATE
-- ══════════════════════════════════════
local VIPCoinsTotal = 3
local vipCoinParts  = {}

-- ══════════════════════════════════════
-- PROFILE THUMBNAIL CACHE
-- ══════════════════════════════════════
local thumbCache = {}
local function getThumb(userId)
    if thumbCache[userId] then return thumbCache[userId] end
    local ok, url = pcall(function()
        return Players:GetUserThumbnailAsync(
            userId,
            Enum.ThumbnailType.HeadShot,
            Enum.ThumbnailSize.Size100x100
        )
    end)
    local result = (ok and url) or "rbxassetid://0"
    thumbCache[userId] = result
    return result
end

-- ══════════════════════════════════════
-- THEMES
-- ══════════════════════════════════════
local Themes = {
    Midnight = { BG=Color3.fromRGB(10,11,20), Panel=Color3.fromRGB(18,19,34), PanelAlt=Color3.fromRGB(24,26,44), Accent=Color3.fromRGB(99,102,241), MsgSelf=Color3.fromRGB(70,74,180), Green=Color3.fromRGB(34,197,94), Red=Color3.fromRGB(239,68,68), Yellow=Color3.fromRGB(251,191,36), Blue=Color3.fromRGB(59,130,246), Purple=Color3.fromRGB(168,85,247), Text=Color3.fromRGB(220,226,240), TextDim=Color3.fromRGB(90,106,130), MenuBG=Color3.fromRGB(26,28,50), Border=Color3.fromRGB(40,42,70), CodeBG=Color3.fromRGB(14,16,30) },
    Ocean    = { BG=Color3.fromRGB(5,16,28), Panel=Color3.fromRGB(8,26,44), PanelAlt=Color3.fromRGB(12,34,56), Accent=Color3.fromRGB(20,184,166), MsgSelf=Color3.fromRGB(14,130,118), Green=Color3.fromRGB(34,197,94), Red=Color3.fromRGB(239,68,68), Yellow=Color3.fromRGB(251,191,36), Blue=Color3.fromRGB(56,189,248), Purple=Color3.fromRGB(168,85,247), Text=Color3.fromRGB(200,235,255), TextDim=Color3.fromRGB(60,110,140), MenuBG=Color3.fromRGB(14,36,58), Border=Color3.fromRGB(20,60,90), CodeBG=Color3.fromRGB(6,20,36) },
    Candy    = { BG=Color3.fromRGB(20,8,28), Panel=Color3.fromRGB(34,12,46), PanelAlt=Color3.fromRGB(46,16,60), Accent=Color3.fromRGB(236,72,153), MsgSelf=Color3.fromRGB(180,50,120), Green=Color3.fromRGB(134,239,172), Red=Color3.fromRGB(239,68,68), Yellow=Color3.fromRGB(251,191,36), Blue=Color3.fromRGB(147,197,253), Purple=Color3.fromRGB(216,180,254), Text=Color3.fromRGB(255,215,235), TextDim=Color3.fromRGB(150,90,130), MenuBG=Color3.fromRGB(48,16,64), Border=Color3.fromRGB(80,20,80), CodeBG=Color3.fromRGB(24,8,36) },
    Aqua     = { BG=Color3.fromRGB(4,16,24), Panel=Color3.fromRGB(8,28,40), PanelAlt=Color3.fromRGB(12,38,54), Accent=Color3.fromRGB(6,182,212), MsgSelf=Color3.fromRGB(4,130,155), Green=Color3.fromRGB(34,197,94), Red=Color3.fromRGB(239,68,68), Yellow=Color3.fromRGB(251,191,36), Blue=Color3.fromRGB(96,165,250), Purple=Color3.fromRGB(168,85,247), Text=Color3.fromRGB(195,238,250), TextDim=Color3.fromRGB(55,120,148), MenuBG=Color3.fromRGB(14,40,56), Border=Color3.fromRGB(20,70,96), CodeBG=Color3.fromRGB(4,16,28) },
    Forest   = { BG=Color3.fromRGB(8,16,10), Panel=Color3.fromRGB(14,26,16), PanelAlt=Color3.fromRGB(18,34,22), Accent=Color3.fromRGB(74,222,128), MsgSelf=Color3.fromRGB(50,160,90), Green=Color3.fromRGB(74,222,128), Red=Color3.fromRGB(239,68,68), Yellow=Color3.fromRGB(251,191,36), Blue=Color3.fromRGB(96,165,250), Purple=Color3.fromRGB(168,85,247), Text=Color3.fromRGB(210,240,215), TextDim=Color3.fromRGB(80,120,90), MenuBG=Color3.fromRGB(20,36,24), Border=Color3.fromRGB(30,60,38), CodeBG=Color3.fromRGB(8,16,10) },
    Lava     = { BG=Color3.fromRGB(18,6,4), Panel=Color3.fromRGB(30,10,6), PanelAlt=Color3.fromRGB(40,14,8), Accent=Color3.fromRGB(249,115,22), MsgSelf=Color3.fromRGB(180,80,15), Green=Color3.fromRGB(134,239,172), Red=Color3.fromRGB(239,68,68), Yellow=Color3.fromRGB(251,191,36), Blue=Color3.fromRGB(96,165,250), Purple=Color3.fromRGB(168,85,247), Text=Color3.fromRGB(255,225,200), TextDim=Color3.fromRGB(140,80,50), MenuBG=Color3.fromRGB(44,16,8), Border=Color3.fromRGB(80,30,10), CodeBG=Color3.fromRGB(14,4,2) },
    Galaxy   = { BG=Color3.fromRGB(8,6,18), Panel=Color3.fromRGB(14,10,30), PanelAlt=Color3.fromRGB(20,14,42), Accent=Color3.fromRGB(167,139,250), MsgSelf=Color3.fromRGB(120,90,200), Green=Color3.fromRGB(134,239,172), Red=Color3.fromRGB(239,68,68), Yellow=Color3.fromRGB(251,191,36), Blue=Color3.fromRGB(147,197,253), Purple=Color3.fromRGB(216,180,254), Text=Color3.fromRGB(230,220,255), TextDim=Color3.fromRGB(110,90,160), MenuBG=Color3.fromRGB(26,18,52), Border=Color3.fromRGB(50,34,90), CodeBG=Color3.fromRGB(8,6,22) },
    Snow     = { BG=Color3.fromRGB(240,244,252), Panel=Color3.fromRGB(255,255,255), PanelAlt=Color3.fromRGB(230,236,248), Accent=Color3.fromRGB(99,102,241), MsgSelf=Color3.fromRGB(99,102,241), Green=Color3.fromRGB(22,163,74), Red=Color3.fromRGB(220,38,38), Yellow=Color3.fromRGB(202,138,4), Blue=Color3.fromRGB(37,99,235), Purple=Color3.fromRGB(124,58,237), Text=Color3.fromRGB(30,34,60), TextDim=Color3.fromRGB(120,130,160), MenuBG=Color3.fromRGB(245,248,255), Border=Color3.fromRGB(200,208,230), CodeBG=Color3.fromRGB(220,228,245) },
}

-- ══════════════════════════════════════
-- STRINGS
-- ══════════════════════════════════════
local STR = {
    ID = { connected="Terhubung ke server", disconnected="Tidak dapat terhubung",
           reconnect="⟳ Hubungkan", send="Kirim", placeholder="Tulis pesan...",
           kidsPlaceholder="Chat (maks 80 karakter)...",
           copy="📋  Salin Pesan", delete="🗑  Hapus (hanya kamu)",
           copyAll="📄  Salin Semua", goLink="🔗  Buka Link",
           voiceHold="🎙 Tahan = Rekam", voiceNoSupport="🎙 Game tidak support Voice",
           imageBtn="🖼 Gambar", codeBtn="</> Kode",
           vipFound="🪙 Koin ditemukan!", vipUnlocked="👑 Kamu sekarang VIP!" },
    EN = { connected="Connected to server", disconnected="Cannot connect to server",
           reconnect="⟳ Reconnect", send="Send", placeholder="Type a message...",
           kidsPlaceholder="Chat (max 80 chars)...",
           copy="📋  Copy Message", delete="🗑  Delete For Me",
           copyAll="📄  Copy All", goLink="🔗  Open Link",
           voiceHold="🎙 Hold = Record", voiceNoSupport="🎙 Voice not supported",
           imageBtn="🖼 Image", codeBtn="</> Code",
           vipFound="🪙 Coin found!", vipUnlocked="👑 You are now VIP!" },
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
local function rv(v)
    if type(v)=="table" then return tostring(v[1] or "") end
    return tostring(v or "")
end
local function copyClip(t) pcall(setclipboard,t) end
local function openUrl(url)
    pcall(function() game:GetService("GuiService"):OpenBrowserWindow(url) end)
    pcall(setclipboard, url)
end

-- ══════════════════════════════════════
-- TWEEN
-- ══════════════════════════════════════
local function tw(obj,props,t,style)
    TweenService:Create(obj,TweenInfo.new(t or 0.2,style or Enum.EasingStyle.Quad,Enum.EasingDirection.Out),props):Play()
end

-- ══════════════════════════════════════
-- FILTER
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
        r=r:gsub(w,function(m) return string.rep("•",#m) end)
        r=r:gsub(w:upper(),function(m) return string.rep("•",#m) end)
    end
    return r
end
local function sensorLinks(t)
    return t:gsub(LP1,function(m) return string.rep("•",#m) end)
           :gsub(LP2,function(m) return string.rep("•",#m) end)
end

-- ══════════════════════════════════════
-- TYPE DETECTION
-- ══════════════════════════════════════
-- Deteksi apakah teks adalah kode
local CODE_PATTERNS = {
    json = { pat='^%s*[%{%[]', name="JSON Code" },
    lua  = { pat='local%s+%w+|function%s+%w+|require%(|game:Get', name="Lua Code" },
    js   = { pat='const%s+%w+|let%s+%w+|var%s+%w+|=>|console%.log', name="JavaScript" },
    py   = { pat='def%s+%w+|import%s+%w+|print%(|%#%s', name="Python" },
    html = { pat='<html|<div|<script|<!DOCTYPE', name="HTML" },
    css  = { pat='%{%s*color:|%{%s*margin:|%{%s*padding:', name="CSS" },
    token= { pat='ghp_[%w]+|Bearer%s+[%w]+|sk%-[%w]+|AIza[%w]+', name="Token / API Key" },
    id   = { pat='^%d%d%d%d%d%d%d%d%d+$|^%+?%d[%d%s%-%(%)]+$', name="ID / Phone" },
}

local function detectType(text)
    -- Link check
    if hasLink(text) then return "String, Link", nil end
    -- ID/Phone
    if text:match("^%d%d%d%d%d%d%d%d%d+$") or text:match("^%+?%d[%d%-%s%(%)]+%d$") then
        return "String, Id", nil
    end
    -- Code checks
    if text:match("^%s*[%{%[]") then return "String, Code", "JSON Code" end
    if text:match("ghp_[%w]+") or text:match("Bearer%s+[%w]+") or text:match("sk%-[%w]+") or text:match("AIza[%w]+") then
        return "String, Code", "Token / API Key"
    end
    if text:match("local%s+%w+") or text:match("function%s+%w+%(") or text:match("game:GetService") then
        return "String, Code", "Lua Code"
    end
    if text:match("const%s+%w+") or text:match("let%s+%w+") or text:match("=>%s*{") then
        return "String, Code", "JavaScript"
    end
    if text:match("def%s+%w+%(") or text:match("import%s+%w+") then
        return "String, Code", "Python"
    end
    if text:match("^<") or text:match("<!DOCTYPE") then
        return "String, Code", "HTML"
    end
    return "String", nil
end

-- ══════════════════════════════════════
-- LATEST ID
-- ══════════════════════════════════════
local function fetchLatestId()
    local raw = httpGet(SERVER_URL.."/messages?lang="..Config.Lang.."&region="..Config.Region.."&after=0")
    if not raw then return 0 end
    local ok,data = pcall(HttpService.JSONDecode,HttpService,raw)
    if not ok or type(data)~="table" then return 0 end
    local mx=0
    for _,m in ipairs(data) do if (m.id or 0)>mx then mx=m.id end end
    return mx
end

-- ══════════════════════════════════════
-- VIP COINS SPAWNER
-- ══════════════════════════════════════
local coinNotifCallback = nil -- set after GUI launch

local function spawnVIPCoins()
    -- Cleanup old coins
    for _,p in ipairs(vipCoinParts) do
        if p and p.Parent then p:Destroy() end
    end
    vipCoinParts = {}
    Config.CoinsFound = 0

    local root = Char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local basePos = root.Position

    -- 3 positions scattered 50-150 studs away
    local offsets = {
        Vector3.new(math.random(50,150), 2, math.random(50,150)),
        Vector3.new(-math.random(50,150), 2, math.random(30,100)),
        Vector3.new(math.random(30,100), 2, -math.random(50,150)),
    }

    for i, offset in ipairs(offsets) do
        local coin = Instance.new("Part")
        coin.Name         = "VIPCoin_"..i
        coin.Size         = Vector3.new(2, 0.3, 2)
        coin.Shape        = Enum.PartType.Cylinder
        coin.BrickColor   = BrickColor.new("Bright yellow")
        coin.Material     = Enum.Material.Neon
        coin.CFrame       = CFrame.new(basePos + offset) * CFrame.Angles(0, 0, math.pi/2)
        coin.CanCollide   = false
        coin.Anchored     = true
        coin.Parent       = Workspace

        -- Billboard label
        local bb = Instance.new("BillboardGui")
        bb.Size          = UDim2.new(0,60,0,60)
        bb.StudsOffset   = Vector3.new(0,2,0)
        bb.AlwaysOnTop   = true
        bb.Parent        = coin

        local lbl = Instance.new("TextLabel",bb)
        lbl.Size             = UDim2.new(1,0,1,0)
        lbl.BackgroundTransparency = 1
        lbl.Text             = "🪙\nVIP"
        lbl.TextColor3       = Color3.fromRGB(255,220,50)
        lbl.TextSize         = 14
        lbl.Font             = Enum.Font.GothamBold
        lbl.TextStrokeTransparency = 0.3

        -- Spin animation
        task.spawn(function()
            while coin and coin.Parent do
                coin.CFrame = coin.CFrame * CFrame.Angles(0, math.rad(2), 0)
                task.wait(0.03)
            end
        end)

        -- Touch detection
        local touched = false
        coin.Touched:Connect(function(hit)
            if touched then return end
            local char = hit:FindFirstAncestorWhichIsAClass("Model")
            if char == LP.Character then
                touched = true
                Config.CoinsFound += 1
                coin:Destroy()

                if coinNotifCallback then
                    coinNotifCallback(T("vipFound").." ("..Config.CoinsFound.."/"..VIPCoinsTotal..")")
                end

                if Config.CoinsFound >= VIPCoinsTotal then
                    Config.IsVIP = true
                    if coinNotifCallback then
                        task.wait(0.5)
                        coinNotifCallback(T("vipUnlocked"))
                    end
                end
            end
        end)

        table.insert(vipCoinParts, coin)
    end
end

-- ══════════════════════════════════════
-- VOICE RECORDER
-- ══════════════════════════════════════
local voiceSupported = false
local voiceRecorder  = nil
local isRecording    = false
local lastVoiceData  = nil

local function initVoice()
    if Config.AgeMode ~= "ADULT" then return false end
    local ok, rec = pcall(function()
        local r = Instance.new("AudioRecorder")
        r.Parent = LP
        return r
    end)
    if ok and rec then
        voiceRecorder   = rec
        voiceSupported  = true
        return true
    end
    return false
end

local function startRecording()
    if not voiceSupported or not voiceRecorder then return false end
    local ok = pcall(function() voiceRecorder:Start() end)
    isRecording = ok
    return ok
end

local function stopRecording()
    if not isRecording or not voiceRecorder then return nil end
    isRecording = false
    local ok, result = pcall(function() return voiceRecorder:Stop() end)
    if ok and result then
        -- result is AudioClip asset id or similar
        return tostring(result)
    end
    return nil
end

-- ══════════════════════════════════════
-- RAINBOW TEXT
-- ══════════════════════════════════════
local RAINBOW_COLORS = {
    Color3.fromRGB(255,80,80),  Color3.fromRGB(255,160,60),
    Color3.fromRGB(255,230,50), Color3.fromRGB(80,230,80),
    Color3.fromRGB(60,180,255), Color3.fromRGB(180,80,255),
}
local GOLD_COLORS = {
    Color3.fromRGB(255,220,50), Color3.fromRGB(255,190,30),
    Color3.fromRGB(255,240,100),Color3.fromRGB(220,160,20),
}

local function animateVIP(lbl, style)
    if style == "gold" then
        local i=0
        task.spawn(function()
            while lbl and lbl.Parent do
                i=(i%#GOLD_COLORS)+1
                tw(lbl, {TextColor3=GOLD_COLORS[i]}, 0.5)
                task.wait(0.5)
            end
        end)
    else -- rainbow
        local i=0
        task.spawn(function()
            while lbl and lbl.Parent do
                i=(i%#RAINBOW_COLORS)+1
                tw(lbl, {TextColor3=RAINBOW_COLORS[i]}, 0.4)
                task.wait(0.4)
            end
        end)
    end
end

-- ══════════════════════════════════════
-- GUI REFS
-- ══════════════════════════════════════
local chatGuiRef  = nil
local floatBtnRef = nil
local rayGui      = nil

local function destroyChatGui()
    if chatGuiRef and chatGuiRef.Parent then chatGuiRef:Destroy() end
    if floatBtnRef and floatBtnRef.Parent then floatBtnRef:Destroy() end
    chatGuiRef  = nil
    floatBtnRef = nil
end

-- ══════════════════════════════════════
-- PHASE 3: CHAT GUI
-- ══════════════════════════════════════
local function launchChatGUI()
    destroyChatGui()
    local C      = Themes[Config.Theme] or Themes.Midnight
    local isKids = Config.AgeMode=="KIDS"
    if isKids then Config.Sensor=true; Config.SensorLink=true end
    Config.LastId = fetchLatestId()

    -- Init voice
    local voiceOk = false
    if Config.AgeMode=="ADULT" then
        voiceOk = initVoice()
    end

    -- Spawn VIP coins
    task.spawn(spawnVIPCoins)

    local SG = Instance.new("ScreenGui")
    SG.Name="ChatGlobalUI"; SG.ResetOnSpawn=false
    SG.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
    SG.DisplayOrder=999; SG.Parent=PGui
    chatGuiRef=SG

    local WIN_W, WIN_H = 500, 480

    -- ── Main Frame ───────────────────────
    local Main=Instance.new("Frame")
    Main.Name="Main"; Main.Size=UDim2.new(0,WIN_W,0,0)
    Main.Position=UDim2.new(0.5,-WIN_W/2,0.5,-WIN_H/2)
    Main.BackgroundColor3=C.BG; Main.BorderSizePixel=0
    Main.ClipsDescendants=true; Main.Parent=SG
    Instance.new("UICorner",Main).CornerRadius=UDim.new(0,14)
    local Glow=Instance.new("ImageLabel",Main)
    Glow.Size=UDim2.new(1,50,1,50); Glow.Position=UDim2.new(0,-25,0,-25)
    Glow.BackgroundTransparency=1; Glow.Image="rbxassetid://6014261993"
    Glow.ImageColor3=C.Accent; Glow.ImageTransparency=0.75
    Glow.ScaleType=Enum.ScaleType.Slice; Glow.SliceCenter=Rect.new(49,49,450,450)
    Glow.ZIndex=0
    tw(Main,{Size=UDim2.new(0,WIN_W,0,WIN_H)},0.4,Enum.EasingStyle.Back)

    -- ── Drag Bar ─────────────────────────
    local DragBar=Instance.new("Frame",Main)
    DragBar.Size=UDim2.new(1,0,0,32); DragBar.BackgroundColor3=C.Panel
    DragBar.BorderSizePixel=0
    local DG=Instance.new("UIGradient",DragBar)
    DG.Color=ColorSequence.new({
        ColorSequenceKeypoint.new(0,Color3.fromRGB(
            math.clamp(math.floor(C.Accent.R*255*0.15),0,255),
            math.clamp(math.floor(C.Accent.G*255*0.15),0,255),
            math.clamp(math.floor(C.Accent.B*255*0.15),0,255))),
        ColorSequenceKeypoint.new(1,C.Panel)})
    DG.Rotation=90
    local DDots=Instance.new("TextLabel",DragBar)
    DDots.Size=UDim2.new(0,40,1,0); DDots.Position=UDim2.new(0.5,-20,0,0)
    DDots.BackgroundTransparency=1; DDots.Text="· · ·"
    DDots.TextColor3=C.Border; DDots.TextSize=12; DDots.Font=Enum.Font.GothamBold

    -- VIP badge in drag bar
    local VIPBadge=Instance.new("TextLabel",DragBar)
    VIPBadge.Size=UDim2.new(0,70,0,20); VIPBadge.Position=UDim2.new(0,10,0.5,-10)
    VIPBadge.BackgroundColor3=Color3.fromRGB(180,140,0); VIPBadge.BackgroundTransparency=0.3
    VIPBadge.Text=" 👑 VIP "; VIPBadge.TextColor3=Color3.fromRGB(255,220,50)
    VIPBadge.TextSize=11; VIPBadge.Font=Enum.Font.GothamBold
    VIPBadge.BorderSizePixel=0; VIPBadge.Visible=Config.IsVIP
    Instance.new("UICorner",VIPBadge).CornerRadius=UDim.new(0,6)

    local function winBtn(icon,xOff,bg,cb)
        local b=Instance.new("TextButton",DragBar)
        b.Size=UDim2.new(0,20,0,20); b.Position=UDim2.new(1,xOff,0.5,-10)
        b.BackgroundColor3=bg; b.BackgroundTransparency=0.3
        b.Text=icon; b.TextSize=10; b.Font=Enum.Font.GothamBold
        b.TextColor3=Color3.fromRGB(255,255,255); b.BorderSizePixel=0
        Instance.new("UICorner",b).CornerRadius=UDim.new(1,0)
        b.MouseEnter:Connect(function() tw(b,{BackgroundTransparency=0}) end)
        b.MouseLeave:Connect(function() tw(b,{BackgroundTransparency=0.3}) end)
        b.MouseButton1Click:Connect(cb)
        return b
    end

    winBtn("✕",-10,C.Red,function()
        tw(Main,{Size=UDim2.new(0,WIN_W,0,0)},0.22)
        task.delay(0.25,destroyChatGui)
    end)

    local minimized=false
    winBtn("─",-34,C.Yellow,function()
        minimized=not minimized
        if minimized then
            -- Collapse to floating bubble
            tw(Main,{Size=UDim2.new(0,WIN_W,0,0),BackgroundTransparency=1},0.25)
            task.delay(0.28,function()
                Main.Visible=false
                local FSG=Instance.new("ScreenGui",PGui)
                FSG.Name="ChatGlobalFloat"; FSG.ResetOnSpawn=false; FSG.DisplayOrder=998
                floatBtnRef=FSG
                local FB=Instance.new("TextButton",FSG)
                FB.Size=UDim2.new(0,52,0,52); FB.Position=UDim2.new(0,16,0.7,-26)
                FB.BackgroundColor3=C.Accent; FB.Text="💬"; FB.TextSize=24
                FB.Font=Enum.Font.Gotham; FB.BorderSizePixel=0
                Instance.new("UICorner",FB).CornerRadius=UDim.new(1,0)
                Instance.new("UIStroke",FB).Color=C.Accent
                local pulse=true
                task.spawn(function()
                    while pulse and FB.Parent do
                        tw(FB,{BackgroundTransparency=0.25},0.7)
                        task.wait(0.7)
                        tw(FB,{BackgroundTransparency=0},0.7)
                        task.wait(0.7)
                    end
                end)
                do -- drag float
                    local fd,fds,fsp
                    FB.InputBegan:Connect(function(i)
                        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
                            fd=true; fds=i.Position; fsp=FB.Position
                        end
                    end)
                    UserInputService.InputChanged:Connect(function(i)
                        if fd and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
                            local d=i.Position-fds
                            FB.Position=UDim2.new(fsp.X.Scale,fsp.X.Offset+d.X,fsp.Y.Scale,fsp.Y.Offset+d.Y)
                        end
                    end)
                    UserInputService.InputEnded:Connect(function(i)
                        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then fd=false end
                    end)
                end
                FB.MouseButton1Click:Connect(function()
                    pulse=false; FSG:Destroy(); floatBtnRef=nil
                    minimized=false; Main.Visible=true; Main.BackgroundTransparency=0
                    tw(Main,{Size=UDim2.new(0,WIN_W,0,WIN_H)},0.35,Enum.EasingStyle.Back)
                end)
            end)
        else
            Main.Visible=true; Main.BackgroundTransparency=0
            tw(Main,{Size=UDim2.new(0,WIN_W,0,WIN_H)},0.35,Enum.EasingStyle.Back)
        end
    end)

    -- Drag window
    do
        local dg,ds,sp
        DragBar.InputBegan:Connect(function(i)
            if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dg=true;ds=i.Position;sp=Main.Position end
        end)
        UserInputService.InputChanged:Connect(function(i)
            if dg and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
                local d=i.Position-ds
                Main.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y)
            end
        end)
        UserInputService.InputEnded:Connect(function(i)
            if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dg=false end
        end)
    end

    -- ── Status Bar ───────────────────────
    local StatBar=Instance.new("Frame",Main)
    StatBar.Size=UDim2.new(1,0,0,40); StatBar.Position=UDim2.new(0,0,0,32)
    StatBar.BackgroundColor3=C.Panel; StatBar.BorderSizePixel=0
    local StatDot=Instance.new("Frame",StatBar)
    StatDot.Size=UDim2.new(0,9,0,9); StatDot.Position=UDim2.new(0.5,-85,0.5,-4)
    StatDot.BackgroundColor3=C.Yellow; StatDot.BorderSizePixel=0
    Instance.new("UICorner",StatDot).CornerRadius=UDim.new(1,0)
    local StatTxt=Instance.new("TextLabel",StatBar)
    StatTxt.Size=UDim2.new(0,280,1,0); StatTxt.Position=UDim2.new(0.5,-73,0,0)
    StatTxt.BackgroundTransparency=1; StatTxt.Text=T("connected")
    StatTxt.TextColor3=C.Green; StatTxt.TextSize=14; StatTxt.Font=Enum.Font.GothamBold
    StatTxt.TextXAlignment=Enum.TextXAlignment.Left
    local ReBtn=Instance.new("TextButton",StatBar)
    ReBtn.Size=UDim2.new(0,92,0,26); ReBtn.Position=UDim2.new(1,-100,0.5,-13)
    ReBtn.BackgroundColor3=C.Accent; ReBtn.Text=T("reconnect")
    ReBtn.TextColor3=Color3.fromRGB(255,255,255); ReBtn.TextSize=11
    ReBtn.Font=Enum.Font.GothamSemibold; ReBtn.BorderSizePixel=0; ReBtn.Visible=false
    Instance.new("UICorner",ReBtn).CornerRadius=UDim.new(0,7)

    -- In-GUI Notification
    local NotifLbl=Instance.new("TextLabel",StatBar)
    NotifLbl.Size=UDim2.new(1,-110,0,18); NotifLbl.Position=UDim2.new(0,8,1,2)
    NotifLbl.BackgroundTransparency=1; NotifLbl.Text=""
    NotifLbl.TextColor3=C.Yellow; NotifLbl.TextSize=11; NotifLbl.Font=Enum.Font.GothamBold
    NotifLbl.TextXAlignment=Enum.TextXAlignment.Left; NotifLbl.Visible=false

    coinNotifCallback=function(msg)
        NotifLbl.Text=msg; NotifLbl.Visible=true
        if Config.IsVIP then
            NotifLbl.TextColor3=Color3.fromRGB(255,220,50)
            VIPBadge.Visible=true
        end
        task.delay(4,function() if NotifLbl.Parent then NotifLbl.Visible=false end end)
    end

    -- ── Badge Bar ─────────────────────────
    local BadgeBar=Instance.new("Frame",Main)
    BadgeBar.Size=UDim2.new(1,0,0,22); BadgeBar.Position=UDim2.new(0,0,0,72)
    BadgeBar.BackgroundColor3=C.PanelAlt; BadgeBar.BorderSizePixel=0; BadgeBar.ClipsDescendants=true
    local BL=Instance.new("UIListLayout",BadgeBar)
    BL.FillDirection=Enum.FillDirection.Horizontal; BL.VerticalAlignment=Enum.VerticalAlignment.Center
    BL.Padding=UDim.new(0,4)
    Instance.new("UIPadding",BadgeBar).PaddingLeft=UDim.new(0,8)
    local function badge(t,bg)
        local b=Instance.new("TextLabel",BadgeBar)
        b.AutomaticSize=Enum.AutomaticSize.X; b.Size=UDim2.new(0,0,0,15)
        b.BackgroundColor3=bg; b.BackgroundTransparency=0.25
        b.Text=" "..t.." "; b.TextColor3=Color3.fromRGB(255,255,255)
        b.TextSize=9; b.Font=Enum.Font.GothamBold; b.BorderSizePixel=0
        Instance.new("UICorner",b).CornerRadius=UDim.new(0,4)
    end
    badge("🌐 "..Config.Region,C.Accent)
    badge("💬 "..Config.Lang,Color3.fromRGB(59,130,246))
    badge("👤 "..Config.DisplayName,C.TextDim)
    if Config.IsVIP then badge("👑 VIP",Color3.fromRGB(180,140,0)) end
    if isKids then badge("👶 KIDS",C.Yellow) end
    if Config.Sensor then badge("🔒 SENSOR",C.Red) end
    if voiceOk then badge("🎙 VOICE",Color3.fromRGB(16,185,129)) end

    -- ── Chat Scroll ───────────────────────
    local ChatScroll=Instance.new("ScrollingFrame",Main)
    ChatScroll.Size=UDim2.new(1,-16,1,-168); ChatScroll.Position=UDim2.new(0,8,0,102)
    ChatScroll.BackgroundColor3=C.Panel; ChatScroll.BorderSizePixel=0
    ChatScroll.ScrollBarThickness=3; ChatScroll.ScrollBarImageColor3=C.Accent
    ChatScroll.CanvasSize=UDim2.new(0,0,0,0); ChatScroll.AutomaticCanvasSize=Enum.AutomaticSize.Y
    Instance.new("UICorner",ChatScroll).CornerRadius=UDim.new(0,10)
    local CList=Instance.new("UIListLayout",ChatScroll)
    CList.Padding=UDim.new(0,5); CList.SortOrder=Enum.SortOrder.LayoutOrder
    local CPad=Instance.new("UIPadding",ChatScroll)
    CPad.PaddingTop=UDim.new(0,8); CPad.PaddingBottom=UDim.new(0,8)
    CPad.PaddingLeft=UDim.new(0,8); CPad.PaddingRight=UDim.new(0,8)

    -- ── Input Area ────────────────────────
    -- Extra button row (Image, Code, Voice)
    local ExtraBar=Instance.new("Frame",Main)
    ExtraBar.Size=UDim2.new(1,-16,0,28); ExtraBar.Position=UDim2.new(0,8,1,-86)
    ExtraBar.BackgroundTransparency=1; ExtraBar.BorderSizePixel=0
    local EL=Instance.new("UIListLayout",ExtraBar)
    EL.FillDirection=Enum.FillDirection.Horizontal; EL.Padding=UDim.new(0,4)

    local function extraBtn(label,bg,cb)
        local b=Instance.new("TextButton",ExtraBar)
        b.AutomaticSize=Enum.AutomaticSize.X; b.Size=UDim2.new(0,0,1,0)
        b.BackgroundColor3=bg; b.BackgroundTransparency=0.3
        b.Text=" "..label.." "; b.TextColor3=Color3.fromRGB(255,255,255)
        b.TextSize=11; b.Font=Enum.Font.GothamSemibold; b.BorderSizePixel=0
        Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
        b.MouseEnter:Connect(function() tw(b,{BackgroundTransparency=0.05}) end)
        b.MouseLeave:Connect(function() tw(b,{BackgroundTransparency=0.3}) end)
        b.MouseButton1Click:Connect(cb)
        return b
    end

    -- Image button
    extraBtn(T("imageBtn"),C.Blue,function()
        -- Prompt user to paste image URL in input
        MsgBox.Text="https://i.imgur.com/..."
        MsgBox:CaptureFocus()
    end)

    -- Code button
    extraBtn(T("codeBtn"),C.Purple,function()
        -- Open code input modal
        local codeSG=Instance.new("ScreenGui",PGui)
        codeSG.Name="CodeInputUI"; codeSG.DisplayOrder=2000

        local overlay=Instance.new("Frame",codeSG)
        overlay.Size=UDim2.new(1,0,1,0); overlay.BackgroundColor3=Color3.fromRGB(0,0,0)
        overlay.BackgroundTransparency=0.5; overlay.BorderSizePixel=0

        local codeCard=Instance.new("Frame",codeSG)
        codeCard.Size=UDim2.new(0,420,0,0); codeCard.Position=UDim2.new(0.5,-210,0.5,-170)
        codeCard.BackgroundColor3=C.BG; codeCard.BorderSizePixel=0; codeCard.ClipsDescendants=true
        Instance.new("UICorner",codeCard).CornerRadius=UDim.new(0,12)
        tw(codeCard,{Size=UDim2.new(0,420,0,340)},0.3,Enum.EasingStyle.Back)

        local cTitle=Instance.new("TextLabel",codeCard)
        cTitle.Size=UDim2.new(1,-20,0,36); cTitle.Position=UDim2.new(0,10,0,10)
        cTitle.BackgroundTransparency=1; cTitle.Text="</> Code Box"
        cTitle.TextColor3=C.Purple; cTitle.TextSize=16; cTitle.Font=Enum.Font.GothamBold
        cTitle.TextXAlignment=Enum.TextXAlignment.Left

        local cLangDrop=Instance.new("TextButton",codeCard)
        cLangDrop.Size=UDim2.new(0,120,0,26); cLangDrop.Position=UDim2.new(0,10,0,52)
        cLangDrop.BackgroundColor3=C.PanelAlt; cLangDrop.Text="Lua ▼"
        cLangDrop.TextColor3=C.Text; cLangDrop.TextSize=12; cLangDrop.Font=Enum.Font.GothamSemibold
        cLangDrop.BorderSizePixel=0
        Instance.new("UICorner",cLangDrop).CornerRadius=UDim.new(0,6)

        local codeLang="Lua"
        local langOpts={"Lua","JSON","JavaScript","Python","HTML","CSS","Other"}
        local langIdx=1
        cLangDrop.MouseButton1Click:Connect(function()
            langIdx=(langIdx%#langOpts)+1
            codeLang=langOpts[langIdx]
            cLangDrop.Text=codeLang.." ▼"
        end)

        local cBox=Instance.new("TextBox",codeCard)
        cBox.Size=UDim2.new(1,-20,0,220); cBox.Position=UDim2.new(0,10,0,86)
        cBox.BackgroundColor3=C.CodeBG; cBox.TextColor3=Color3.fromRGB(170,220,160)
        cBox.PlaceholderText="-- Tulis kode di sini..."; cBox.PlaceholderColor3=C.TextDim
        cBox.Text=""; cBox.TextSize=12; cBox.Font=Enum.Font.Code
        cBox.MultiLine=true; cBox.ClearTextOnFocus=false; cBox.BorderSizePixel=0
        cBox.TextXAlignment=Enum.TextXAlignment.Left; cBox.TextYAlignment=Enum.TextYAlignment.Top
        Instance.new("UICorner",cBox).CornerRadius=UDim.new(0,8)
        Instance.new("UIPadding",cBox).PaddingLeft=UDim.new(0,8)

        local cSend=Instance.new("TextButton",codeCard)
        cSend.Size=UDim2.new(0,120,0,32); cSend.Position=UDim2.new(0,10,0,314)
        cSend.BackgroundColor3=C.Accent; cSend.Text="✔ Kirim Kode"
        cSend.TextColor3=Color3.fromRGB(255,255,255); cSend.TextSize=12
        cSend.Font=Enum.Font.GothamSemibold; cSend.BorderSizePixel=0
        Instance.new("UICorner",cSend).CornerRadius=UDim.new(0,8)

        local cClose=Instance.new("TextButton",codeCard)
        cClose.Size=UDim2.new(0,80,0,32); cClose.Position=UDim2.new(0,138,0,314)
        cClose.BackgroundColor3=C.PanelAlt; cClose.Text="✕ Batal"
        cClose.TextColor3=C.Text; cClose.TextSize=12; cClose.Font=Enum.Font.GothamSemibold
        cClose.BorderSizePixel=0
        Instance.new("UICorner",cClose).CornerRadius=UDim.new(0,8)

        cClose.MouseButton1Click:Connect(function() codeSG:Destroy() end)
        overlay.MouseButton1Click:Connect(function() codeSG:Destroy() end)

        cSend.MouseButton1Click:Connect(function()
            local code=cBox.Text
            if code=="" then return end
            codeSG:Destroy()
            -- Send as code message
            local msgJSON={
                Type="String, Code",
                User=Config.DisplayName,
                Context=code,
                CodeLang=codeLang,
                Sensor=Config.Sensor,
                Kids=isKids,
                VIP=Config.IsVIP,
                VIPStyle=Config.IsVIP and Config.VIPStyle or nil,
            }
            print(HttpService:JSONEncode(msgJSON))
            local ok=httpPost(SERVER_URL.."/send",{
                user=Config.DisplayName,
                message=HttpService:JSONEncode(msgJSON),
                lang=Config.Lang, region=Config.Region,
                gameId=Config.GameOnly and tostring(game.PlaceId) or "ANY",
            })
            if ok then addMsgFwd(msgJSON,true) end
        end)
    end)

    -- Voice button (only if age verified)
    local voiceBtn
    if Config.AgeMode=="ADULT" then
        voiceBtn=extraBtn(T("voiceHold"),Color3.fromRGB(16,185,129),function() end)
        if not voiceOk then
            voiceBtn.Text=" "..T("voiceNoSupport").." "
            voiceBtn.BackgroundColor3=C.TextDim
        else
            -- Hold to record
            local recStart
            voiceBtn.InputBegan:Connect(function(i)
                if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
                    if startRecording() then
                        recStart=tick()
                        voiceBtn.BackgroundColor3=C.Red
                        voiceBtn.Text=" 🔴 Merekam... "
                    end
                end
            end)
            voiceBtn.InputEnded:Connect(function(i)
                if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
                    local dur=tick()-(recStart or tick())
                    local result=stopRecording()
                    voiceBtn.BackgroundColor3=Color3.fromRGB(16,185,129)
                    voiceBtn.Text=" "..T("voiceHold").." "
                    if result and dur>0.5 then
                        lastVoiceData=result
                        local msgJSON={
                            Type="String, Voice",
                            User=Config.DisplayName,
                            Context="[Voice "..math.floor(dur).."s]",
                            VoiceId=result,
                            Sensor=Config.Sensor,
                            Kids=isKids,
                            VIP=Config.IsVIP,
                        }
                        print(HttpService:JSONEncode(msgJSON))
                        httpPost(SERVER_URL.."/send",{
                            user=Config.DisplayName,
                            message=HttpService:JSONEncode(msgJSON),
                            lang=Config.Lang, region=Config.Region,
                            gameId=Config.GameOnly and tostring(game.PlaceId) or "ANY",
                        })
                        addMsgFwd(msgJSON,true)
                    end
                end
            end)
        end
    end

    -- ── Input Bar ─────────────────────────
    local InpBar=Instance.new("Frame",Main)
    InpBar.Size=UDim2.new(1,-16,0,42); InpBar.Position=UDim2.new(0,8,1,-50)
    InpBar.BackgroundColor3=C.Panel; InpBar.BorderSizePixel=0
    Instance.new("UICorner",InpBar).CornerRadius=UDim.new(0,10)
    Instance.new("UIStroke",InpBar).Color=C.Border

    MsgBox=Instance.new("TextBox",InpBar)
    MsgBox.Size=UDim2.new(1,-90,1,-12); MsgBox.Position=UDim2.new(0,12,0,6)
    MsgBox.BackgroundTransparency=1; MsgBox.Text=""
    MsgBox.PlaceholderText=isKids and T("kidsPlaceholder") or T("placeholder")
    MsgBox.PlaceholderColor3=C.TextDim; MsgBox.TextColor3=C.Text
    MsgBox.TextSize=13; MsgBox.Font=Enum.Font.Gotham
    MsgBox.TextXAlignment=Enum.TextXAlignment.Left; MsgBox.ClearTextOnFocus=false

    local SendBtn=Instance.new("TextButton",InpBar)
    SendBtn.Size=UDim2.new(0,72,0,30); SendBtn.Position=UDim2.new(1,-78,0.5,-15)
    SendBtn.BackgroundColor3=C.Accent; SendBtn.Text=T("send").." ↗"
    SendBtn.TextColor3=Color3.fromRGB(255,255,255); SendBtn.TextSize=12
    SendBtn.Font=Enum.Font.GothamSemibold; SendBtn.BorderSizePixel=0
    Instance.new("UICorner",SendBtn).CornerRadius=UDim.new(0,8)

    -- ══════════════════════════════════════
    -- STATUS HELPERS
    -- ══════════════════════════════════════
    local function setConnected(val)
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
            tw(activeMenu,{BackgroundTransparency=1},0.1)
            local m=activeMenu; activeMenu=nil
            task.delay(0.15,function() if m and m.Parent then m:Destroy() end end)
        end
    end
    UserInputService.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            task.defer(closeMenu)
        end
    end)

    local function showMenu(bubble,msgCtx,fullCopy,links,voiceId,codeText,codeLang2)
        closeMenu(); task.wait(0.01)
        local hasLnk = links and #links>0
        local hasVoice= voiceId~=nil and voiceId~=""
        local hasCode = codeText~=nil and codeText~=""

        local items={
            {icon="📋",label=T("copy"),act=function() copyClip(msgCtx) end},
            {icon="🗑", label=T("delete"),act=function() bubble:Destroy() end},
            {icon="📄",label=T("copyAll"),act=function() copyClip(fullCopy) end},
        }
        if hasLnk then table.insert(items,{icon="🔗",label=T("goLink"),act=function() openUrl(links[1]) end,highlight=true}) end
        if hasCode then table.insert(items,{icon="📋",label="Copy Kode",act=function() copyClip(codeText) end}) end

        local menuH=#items*32+12; local menuW=210
        local bPos=bubble.AbsolutePosition; local bSz=bubble.AbsoluteSize
        local mPos=Main.AbsolutePosition; local mSz=Main.AbsoluteSize
        local mx=math.clamp(bPos.X-mPos.X,4,mSz.X-menuW-4)
        local my=bPos.Y-mPos.Y+bSz.Y+4
        if my+menuH>mSz.Y-8 then my=bPos.Y-mPos.Y-menuH-4 end

        local menu=Instance.new("Frame",Main)
        menu.Size=UDim2.new(0,menuW,0,menuH); menu.Position=UDim2.new(0,mx,0,my)
        menu.BackgroundColor3=C.MenuBG; menu.BorderSizePixel=0; menu.ZIndex=20
        menu.BackgroundTransparency=1
        Instance.new("UICorner",menu).CornerRadius=UDim.new(0,10)
        Instance.new("UIStroke",menu).Color=C.Border
        activeMenu=menu; tw(menu,{BackgroundTransparency=0.05},0.15)
        local mList=Instance.new("UIListLayout",menu); mList.Padding=UDim.new(0,2)
        local mPad=Instance.new("UIPadding",menu)
        mPad.PaddingTop=UDim.new(0,6); mPad.PaddingBottom=UDim.new(0,6)
        mPad.PaddingLeft=UDim.new(0,6); mPad.PaddingRight=UDim.new(0,6)

        for _,item in ipairs(items) do
            local b=Instance.new("TextButton",menu)
            b.Size=UDim2.new(1,0,0,28)
            b.BackgroundColor3=item.highlight and C.Blue or C.PanelAlt
            b.BackgroundTransparency=item.highlight and 0.4 or 0.5
            b.Text=item.icon.."  "..item.label
            b.TextColor3=item.highlight and Color3.fromRGB(147,197,253) or C.Text
            b.TextSize=12; b.Font=Enum.Font.GothamSemibold
            b.TextXAlignment=Enum.TextXAlignment.Left
            b.BorderSizePixel=0; b.ZIndex=21
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

    function addMsgFwd(msgData, isOwn)
        msgOrder=msgOrder+1
        local user    = msgData.User    or "?"
        local ctx     = msgData.Context or ""
        local mtype   = msgData.Type    or "String"
        local isMKids = msgData.Kids    or false
        local isMe    = isOwn==true
        local isVIPMsg= msgData.VIP     or false
        local vipStyle= msgData.VIPStyle or "rainbow"
        local codeLang2=msgData.CodeLang or "Code"
        local voiceId = msgData.VoiceId
        local hasLnk  = mtype:find("Link")~=nil
        local hasCode = mtype:find("Code")~=nil
        local hasVoice= mtype:find("Voice")~=nil
        local hasId   = mtype:find("Id")~=nil
        local links   = (hasLnk and not (Config.SensorLink or isMKids)) and extractLinks(ctx) or {}

        -- Get profile thumb async
        local thumbUrl="rbxassetid://0"
        task.spawn(function()
            local uid
            if isMe then uid=LP.UserId
            else
                local ok2,id=pcall(Players.GetUserIdFromNameAsync,Players,user)
                if ok2 then uid=id end
            end
            if uid then thumbUrl=getThumb(uid) end
        end)

        -- Bubble row (avatar + content)
        local row=Instance.new("Frame",ChatScroll)
        row.Size=UDim2.new(1,-8,0,0); row.AutomaticSize=Enum.AutomaticSize.Y
        row.BackgroundTransparency=1; row.BorderSizePixel=0; row.LayoutOrder=msgOrder

        local rList=Instance.new("UIListLayout",row)
        rList.FillDirection=Enum.FillDirection.Horizontal; rList.Padding=UDim.new(0,6)
        rList.VerticalAlignment=Enum.VerticalAlignment.Top

        -- Avatar circle
        local avatarFrame=Instance.new("Frame",row)
        avatarFrame.Size=UDim2.new(0,34,0,34); avatarFrame.BackgroundColor3=C.Accent
        avatarFrame.BorderSizePixel=0
        Instance.new("UICorner",avatarFrame).CornerRadius=UDim.new(1,0)
        local avatarImg=Instance.new("ImageLabel",avatarFrame)
        avatarImg.Size=UDim2.new(1,0,1,0); avatarImg.BackgroundTransparency=1
        avatarImg.Image=thumbUrl; avatarImg.ScaleType=Enum.ScaleType.Crop
        Instance.new("UICorner",avatarImg).CornerRadius=UDim.new(1,0)

        -- Update thumb when loaded
        task.spawn(function()
            task.wait(0.5)
            local uid
            if isMe then uid=LP.UserId
            else pcall(function()
                uid=Players:GetUserIdFromNameAsync(user)
            end) end
            if uid then
                local t2=getThumb(uid)
                if avatarImg and avatarImg.Parent then avatarImg.Image=t2 end
            end
        end)

        -- Bubble content
        local bubble=Instance.new("Frame",row)
        bubble.Size=UDim2.new(1,-44,0,0); bubble.AutomaticSize=Enum.AutomaticSize.Y
        bubble.BackgroundColor3=isMe and C.MsgSelf or C.PanelAlt
        bubble.BackgroundTransparency=isMe and 0.55 or 0.2
        bubble.BorderSizePixel=0
        Instance.new("UICorner",bubble).CornerRadius=UDim.new(0,9)
        if isMe then
            local bs=Instance.new("UIStroke",bubble)
            bs.Color=C.Accent; bs.Thickness=1; bs.Transparency=0.6
        end
        local bPad=Instance.new("UIPadding",bubble)
        bPad.PaddingLeft=UDim.new(0,10); bPad.PaddingRight=UDim.new(0,10)
        bPad.PaddingTop=UDim.new(0,6); bPad.PaddingBottom=UDim.new(0,6)
        local bList=Instance.new("UIListLayout",bubble); bList.Padding=UDim.new(0,3)

        -- Name row
        local nRow=Instance.new("Frame",bubble)
        nRow.Size=UDim2.new(1,0,0,14); nRow.BackgroundTransparency=1; nRow.AutomaticSize=Enum.AutomaticSize.X
        local nList=Instance.new("UIListLayout",nRow)
        nList.FillDirection=Enum.FillDirection.Horizontal; nList.VerticalAlignment=Enum.VerticalAlignment.Center
        nList.Padding=UDim.new(0,5)

        local nLbl=Instance.new("TextLabel",nRow)
        nLbl.AutomaticSize=Enum.AutomaticSize.X; nLbl.Size=UDim2.new(0,0,1,0)
        nLbl.BackgroundTransparency=1; nLbl.Text=user
        nLbl.TextSize=10; nLbl.Font=Enum.Font.GothamBold
        nLbl.TextXAlignment=Enum.TextXAlignment.Left

        if isVIPMsg then
            nLbl.TextColor3=Color3.fromRGB(255,220,50)
            animateVIP(nLbl, vipStyle)
            local vb=Instance.new("TextLabel",nRow)
            vb.AutomaticSize=Enum.AutomaticSize.X; vb.Size=UDim2.new(0,0,0,13)
            vb.BackgroundColor3=Color3.fromRGB(180,140,0); vb.BackgroundTransparency=0.3
            vb.Text=" 👑 VIP "; vb.TextColor3=Color3.fromRGB(255,220,50)
            vb.TextSize=9; vb.Font=Enum.Font.GothamBold; vb.BorderSizePixel=0
            Instance.new("UICorner",vb).CornerRadius=UDim.new(0,3)
        else
            nLbl.TextColor3=isMe and C.Accent or C.Green
        end

        -- Type badges
        local function typeBadge(t2,bg2)
            local tb=Instance.new("TextLabel",nRow)
            tb.AutomaticSize=Enum.AutomaticSize.X; tb.Size=UDim2.new(0,0,0,13)
            tb.BackgroundColor3=bg2; tb.BackgroundTransparency=0.3
            tb.Text=" "..t2.." "; tb.TextColor3=Color3.fromRGB(255,255,255)
            tb.TextSize=9; tb.Font=Enum.Font.GothamBold; tb.BorderSizePixel=0
            Instance.new("UICorner",tb).CornerRadius=UDim.new(0,3)
        end

        if hasLnk and #links>0 then typeBadge("🔗 Link",Color3.fromRGB(37,99,235)) end
        if hasCode then typeBadge("</> "..codeLang2,C.Purple) end
        if hasVoice then typeBadge("🎙 Voice",Color3.fromRGB(16,185,129)) end
        if hasId then typeBadge("🆔 ID",C.Purple) end

        -- Context text
        local ctxLbl=Instance.new("TextLabel",bubble)
        ctxLbl.Size=UDim2.new(1,0,0,0); ctxLbl.AutomaticSize=Enum.AutomaticSize.Y
        ctxLbl.BackgroundTransparency=1; ctxLbl.Text=ctx
        ctxLbl.TextSize=13; ctxLbl.Font=Enum.Font.Gotham
        ctxLbl.TextXAlignment=Enum.TextXAlignment.Left; ctxLbl.TextWrapped=true
        ctxLbl.TextColor3=hasId and C.Purple or C.Text

        -- Code Box (collapsed → "Open Code Box" button)
        if hasCode then
            ctxLbl.Visible=false -- hide raw code from main bubble
            local openCodeBtn=Instance.new("TextButton",bubble)
            openCodeBtn.AutomaticSize=Enum.AutomaticSize.X; openCodeBtn.Size=UDim2.new(0,0,0,24)
            openCodeBtn.BackgroundColor3=C.Purple; openCodeBtn.BackgroundTransparency=0.3
            openCodeBtn.Text="</> Open Code Box  ·  "..codeLang2
            openCodeBtn.TextColor3=Color3.fromRGB(216,180,254)
            openCodeBtn.TextSize=11; openCodeBtn.Font=Enum.Font.GothamSemibold
            openCodeBtn.BorderSizePixel=0
            Instance.new("UICorner",openCodeBtn).CornerRadius=UDim.new(0,6)
            Instance.new("UIPadding",openCodeBtn).PaddingLeft=UDim.new(0,8)

            local codeBoxFrame=Instance.new("Frame",bubble)
            codeBoxFrame.Size=UDim2.new(1,0,0,0); codeBoxFrame.AutomaticSize=Enum.AutomaticSize.Y
            codeBoxFrame.BackgroundColor3=C.CodeBG; codeBoxFrame.BorderSizePixel=0
            codeBoxFrame.Visible=false
            Instance.new("UICorner",codeBoxFrame).CornerRadius=UDim.new(0,8)

            local codeFull=Instance.new("TextLabel",codeBoxFrame)
            codeFull.Size=UDim2.new(1,-16,0,0); codeFull.AutomaticSize=Enum.AutomaticSize.Y
            codeFull.Position=UDim2.new(0,8,0,8)
            codeFull.BackgroundTransparency=1; codeFull.Text=ctx
            codeFull.TextColor3=Color3.fromRGB(170,220,160); codeFull.TextSize=11
            codeFull.Font=Enum.Font.Code; codeFull.TextWrapped=true
            codeFull.TextXAlignment=Enum.TextXAlignment.Left

            local copyCodeBtn=Instance.new("TextButton",codeBoxFrame)
            copyCodeBtn.Size=UDim2.new(0,90,0,22); copyCodeBtn.Position=UDim2.new(1,-98,0,4)
            copyCodeBtn.BackgroundColor3=C.PanelAlt; copyCodeBtn.BackgroundTransparency=0.3
            copyCodeBtn.Text="📋 Copy"; copyCodeBtn.TextColor3=C.Text
            copyCodeBtn.TextSize=10; copyCodeBtn.Font=Enum.Font.GothamSemibold
            copyCodeBtn.BorderSizePixel=0
            Instance.new("UICorner",copyCodeBtn).CornerRadius=UDim.new(0,5)
            copyCodeBtn.MouseButton1Click:Connect(function()
                copyClip(ctx); copyCodeBtn.Text="✔ Tersalin!"
                task.delay(1.5,function() if copyCodeBtn.Parent then copyCodeBtn.Text="📋 Copy" end end)
            end)

            local codeOpen=false
            openCodeBtn.MouseButton1Click:Connect(function()
                codeOpen=not codeOpen
                codeBoxFrame.Visible=codeOpen
                openCodeBtn.Text=codeOpen and "</> Close Code Box" or ("</> Open Code Box  ·  "..codeLang2)
            end)
        end

        -- Voice player
        if hasVoice and voiceId then
            local playBtn=Instance.new("TextButton",bubble)
            playBtn.AutomaticSize=Enum.AutomaticSize.X; playBtn.Size=UDim2.new(0,0,0,26)
            playBtn.BackgroundColor3=Color3.fromRGB(16,185,129); playBtn.BackgroundTransparency=0.3
            playBtn.Text="▶  Play Voice  ·  "..ctx
            playBtn.TextColor3=Color3.fromRGB(255,255,255)
            playBtn.TextSize=11; playBtn.Font=Enum.Font.GothamSemibold; playBtn.BorderSizePixel=0
            Instance.new("UICorner",playBtn).CornerRadius=UDim.new(0,6)
            Instance.new("UIPadding",playBtn).PaddingLeft=UDim.new(0,8)

            local playing=false
            local sound=nil
            playBtn.MouseButton1Click:Connect(function()
                if playing then
                    if sound then sound:Stop() end
                    playing=false; playBtn.Text="▶  Play Voice  ·  "..ctx
                    playBtn.BackgroundColor3=Color3.fromRGB(16,185,129)
                else
                    playing=true; playBtn.Text="⏸  Memutar..."; playBtn.BackgroundColor3=C.Red
                    local ok2,s=pcall(function()
                        local snd=Instance.new("Sound"); snd.SoundId=voiceId; snd.Parent=Workspace
                        snd:Play(); return snd
                    end)
                    if ok2 then
                        sound=s
                        s.Ended:Connect(function()
                            playing=false
                            if playBtn.Parent then playBtn.Text="▶  Play Voice  ·  "..ctx; playBtn.BackgroundColor3=Color3.fromRGB(16,185,129) end
                        end)
                    else
                        playing=false; playBtn.Text="⚠ Tidak bisa putar"
                    end
                end
            end)
        end

        -- Link buttons
        if hasLnk and #links>0 then
            for _,lnk in ipairs(links) do
                local lBtn=Instance.new("TextButton",bubble)
                lBtn.AutomaticSize=Enum.AutomaticSize.X; lBtn.Size=UDim2.new(0,0,0,22)
                lBtn.BackgroundColor3=Color3.fromRGB(30,58,138); lBtn.BackgroundTransparency=0.2
                lBtn.Text="🔗 "..(lnk:sub(1,44)..(#lnk>44 and "…" or ""))
                lBtn.TextColor3=Color3.fromRGB(147,197,253); lBtn.TextSize=11
                lBtn.Font=Enum.Font.GothamSemibold; lBtn.BorderSizePixel=0
                Instance.new("UICorner",lBtn).CornerRadius=UDim.new(0,5)
                Instance.new("UIPadding",lBtn).PaddingLeft=UDim.new(0,7)
                lBtn.MouseButton1Click:Connect(function()
                    openUrl(lnk); lBtn.Text="✔ Membuka..."
                    task.delay(2,function() if lBtn.Parent then lBtn.Text="🔗 "..(lnk:sub(1,44)..(#lnk>44 and "…" or "")) end end)
                end)
            end
        end

        -- Context menu
        local fullCopyTxt=user..", ["..tostring(LP.UserId).."]: "..ctx
        bubble.InputBegan:Connect(function(i)
            if i.UserInputType==Enum.UserInputType.MouseButton2 then
                showMenu(bubble,ctx,fullCopyTxt,links,voiceId,hasCode and ctx or nil,codeLang2)
            end
        end)
        local holding=false
        bubble.InputBegan:Connect(function(i)
            if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
                holding=true
                task.delay(0.75,function() if holding then showMenu(bubble,ctx,fullCopyTxt,links,voiceId,hasCode and ctx or nil,codeLang2) end end)
            end
        end)
        bubble.InputEnded:Connect(function(i)
            if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then holding=false end
        end)

        task.defer(function()
            ChatScroll.CanvasPosition=Vector2.new(0,ChatScroll.AbsoluteCanvasSize.Y)
        end)
    end

    local function addSys(t2)
        addMsgFwd({Type="String",User="System",Context=t2,Sensor=false,Kids=false,VIP=false},false)
    end

    -- ══════════════════════════════════════
    -- SEND & POLL
    -- ══════════════════════════════════════
    local function sendMsg(raw)
        if raw=="" then return end
        if isKids then raw=raw:sub(1,80) end
        local processed=raw
        if Config.Sensor or isKids then processed=sensorWords(processed) end
        if Config.SensorLink or isKids then processed=sensorLinks(processed) end

        local tp, codeLang3 = detectType(raw)
        -- Check image URL
        if raw:match("%.png$") or raw:match("%.jpg$") or raw:match("%.jpeg$") or raw:match("%.gif$") or raw:match("%.webp$") then
            tp="String, Link, Image"
        end

        local msgJSON={
            Type=tp,
            User=Config.DisplayName,
            Context=processed,
            CodeLang=codeLang3,
            Sensor=Config.Sensor or isKids,
            Kids=isKids,
            VIP=Config.IsVIP,
            VIPStyle=Config.IsVIP and Config.VIPStyle or nil,
        }
        print(HttpService:JSONEncode(msgJSON))
        local ok=httpPost(SERVER_URL.."/send",{
            user=Config.DisplayName,
            message=HttpService:JSONEncode(msgJSON),
            lang=Config.Lang, region=Config.Region,
            gameId=Config.GameOnly and tostring(game.PlaceId) or "ANY",
        })
        if ok then addMsgFwd(msgJSON,true)
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
                        msgD=ok2 and type(p)=="table" and p or {Type="String",User=entry.user,Context=entry.message,Sensor=false,Kids=false}
                    else
                        msgD={Type="String",User=entry.user or "?",Context=tostring(entry.message or ""),Sensor=false,Kids=false}
                    end
                    if Config.FriendsOnly then
                        local fok,uid=pcall(Players.GetUserIdFromNameAsync,Players,entry.user)
                        if fok and uid and not LP:IsFriendsWith(uid) then continue end
                    end
                    addMsgFwd(msgD,false)
                end
            end
        end
    end

    SendBtn.MouseButton1Click:Connect(function()
        local t2=MsgBox.Text; MsgBox.Text=""; sendMsg(t2)
    end)
    MsgBox.FocusLost:Connect(function(enter)
        if enter and MsgBox.Text~="" then
            local t2=MsgBox.Text; MsgBox.Text=""; sendMsg(t2)
        end
    end)
    ReBtn.MouseButton1Click:Connect(function()
        ReBtn.Text="⟳ ..."; task.spawn(function()
            pollMsgs(); task.wait(1); if ReBtn.Parent then ReBtn.Text=T("reconnect") end
        end)
    end)

    local lastPoll=0
    local pollConn
    pollConn=RunService.Heartbeat:Connect(function()
        if tick()-lastPoll>=3 then lastPoll=tick(); task.spawn(pollMsgs) end
    end)
    SG.AncestryChanged:Connect(function()
        if not SG.Parent then
            pollConn:Disconnect()
            -- cleanup coins
            for _,p in ipairs(vipCoinParts) do if p and p.Parent then p:Destroy() end end
        end
    end)

    -- Watch VIP state change (update badge)
    task.spawn(function()
        while SG.Parent do
            task.wait(1)
            VIPBadge.Visible=Config.IsVIP
        end
    end)

    addSys("v5.0  ·  "..Config.DisplayName.."  ·  "..Config.Region.."  ·  "..Config.Lang..(isKids and "  ·  KIDS 👶" or "").."  ·  3 🪙 tersebar di map!")
    task.spawn(pollMsgs)
    print("✅ ChatGlobal v5.0 launched!")
end

-- Declare MsgBox at outer scope so code button can use it
local MsgBox

-- ══════════════════════════════════════
-- PHASE 2: AGE VERIFY
-- ══════════════════════════════════════
local function showAgeVerify(onDone)
    if PGui:FindFirstChild("AgeVerifyUI") then PGui.AgeVerifyUI:Destroy() end
    local AgeGui=Instance.new("ScreenGui",PGui)
    AgeGui.Name="AgeVerifyUI"; AgeGui.ResetOnSpawn=false; AgeGui.DisplayOrder=10000

    local Ov=Instance.new("Frame",AgeGui)
    Ov.Size=UDim2.new(1,0,1,0); Ov.BackgroundColor3=Color3.fromRGB(0,0,0)
    Ov.BackgroundTransparency=0.45; Ov.BorderSizePixel=0

    local Card=Instance.new("Frame",AgeGui)
    Card.Size=UDim2.new(0,340,0,0); Card.Position=UDim2.new(0.5,-170,0.5,-148)
    Card.BackgroundColor3=Color3.fromRGB(14,15,26); Card.BorderSizePixel=0; Card.ClipsDescendants=true
    Instance.new("UICorner",Card).CornerRadius=UDim.new(0,14)
    local CB=Instance.new("Frame",Card)
    CB.Size=UDim2.new(1,2,1,2); CB.Position=UDim2.new(0,-1,0,-1)
    CB.BackgroundColor3=Color3.fromRGB(251,191,36); CB.BackgroundTransparency=0.45; CB.ZIndex=0
    Instance.new("UICorner",CB).CornerRadius=UDim.new(0,15)
    tw(Card,{Size=UDim2.new(0,340,0,300)},0.4,Enum.EasingStyle.Back)

    local function al(t2,y,ts,col,f)
        local l=Instance.new("TextLabel",Card)
        l.Size=UDim2.new(1,-20,0,ts+4); l.Position=UDim2.new(0,10,0,y)
        l.BackgroundTransparency=1; l.Text=t2; l.TextColor3=col or Color3.fromRGB(190,205,225)
        l.TextSize=ts or 12; l.Font=f or Enum.Font.Gotham; l.TextWrapped=true
        l.AutomaticSize=Enum.AutomaticSize.Y; l.TextXAlignment=Enum.TextXAlignment.Center
        return l
    end
    al("⚠️",12,30,Color3.fromRGB(251,191,36),Enum.Font.GothamBold)
    al("Verifikasi Umur",52,17,Color3.fromRGB(255,220,80),Enum.Font.GothamBold)
    al("ChatGlobal berisi percakapan global. Fitur Voice Chat hanya untuk 18+.",82,12)

    local AgeFrame=Instance.new("Frame",Card)
    AgeFrame.Size=UDim2.new(1,-20,0,62); AgeFrame.Position=UDim2.new(0,10,0,152)
    AgeFrame.BackgroundColor3=Color3.fromRGB(22,24,40); AgeFrame.BorderSizePixel=0; AgeFrame.Visible=false
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

    local function aBtn(t2,y,bg,cb)
        local b=Instance.new("TextButton",Card)
        b.Size=UDim2.new(1,-20,0,36); b.Position=UDim2.new(0,10,0,y)
        b.BackgroundColor3=bg; b.Text=t2; b.TextColor3=Color3.fromRGB(255,255,255)
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
            if not age or age<=0 or age>100 then AgeLbl.Text="⚠ Angka tidak valid!"; AgeLbl.TextColor3=Color3.fromRGB(239,68,68); return end
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
local function launchRayfield()
    destroyChatGui()
    if PGui:FindFirstChild("AgeVerifyUI") then PGui.AgeVerifyUI:Destroy() end
    local rfOk,Rayfield=pcall(function()
        return loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
    end)
    if not rfOk or not Rayfield then error("❌ Gagal load Rayfield!") end

    local Win=Rayfield:CreateWindow({
        Name="ChatGlobal  ·  Setup v5.0",
        LoadingTitle="ChatGlobal v5.0",
        LoadingSubtitle="by KHAFIDZKTP  ·  ketik /Setup untuk buka kembali",
        ConfigurationSaving={Enabled=false}, Discord={Enabled=false}, KeySystem=false,
    })
    task.wait(0.5); rayGui=PGui:FindFirstChild("Rayfield")

    local Tab=Win:CreateTab("⚙  Setup","settings")

    Tab:CreateSection("🗣  Bahasa Chat GUI")
    Tab:CreateDropdown({Name="Bahasa Tampilan",Options={"ID  -  Indonesia","EN  -  English","RU  -  Русский","TH  -  ภาษาไทย"},CurrentOption={"ID  -  Indonesia"},Flag="GL",Callback=function(v) Config.GuiLang=rv(v):match("^(%a+)") or "ID" end})

    Tab:CreateSection("👤  Identitas")
    Tab:CreateInput({Name="Display Name",PlaceholderText=LP.Name,RemoveTextAfterFocusLost=false,Callback=function(v) local s=rv(v); if s~="" then Config.DisplayName=s end end})

    Tab:CreateSection("🌍  Region & Bahasa  ←  WAJIB")
    Tab:CreateDropdown({Name="Bahasa Chat",Options={"ALL  -  Semua Bahasa","ID  -  Indonesia","EN  -  English","RU  -  Русский","TH  -  ภาษาไทย","KZ  -  Қазақша","JP  -  日本語","AR  -  العربية","ES  -  Español","FR  -  Français","DE  -  Deutsch","KR  -  한국어","CN  -  中文","PT  -  Português","TR  -  Türkçe"},CurrentOption={"ALL  -  Semua Bahasa"},Flag="Lang",Callback=function(v) Config.Lang=rv(v):match("^(%a+)") or "ALL"; print("✅ Lang: "..Config.Lang) end})
    Tab:CreateDropdown({Name="Region",Options={"GLOBAL  -  Semua Dunia","ID  -  Indonesia Only","RU  -  Russia Only","TH  -  Thailand Only","KZ  -  Kazakhstan Only","JP  -  Japan Only","AR  -  Arab Region","EN  -  English Speaking"},CurrentOption={"GLOBAL  -  Semua Dunia"},Flag="Region",Callback=function(v) Config.Region=rv(v):match("^(%a+)") or "GLOBAL"; print("✅ Region: "..Config.Region) end})

    Tab:CreateSection("🔒  Privasi")
    Tab:CreateToggle({Name="Sensor Kata Kasar",CurrentValue=false,Flag="S1",Callback=function(v) Config.Sensor=v end})
    Tab:CreateToggle({Name="🔗 Sensor Semua Link",CurrentValue=false,Flag="S2",Callback=function(v) Config.SensorLink=v end})
    Tab:CreateToggle({Name="👥 Khusus Teman",CurrentValue=false,Flag="S3",Callback=function(v) Config.FriendsOnly=v end})
    Tab:CreateToggle({Name="🎮 Khusus Game Ini",CurrentValue=false,Flag="S4",Callback=function(v) Config.GameOnly=v end})

    Tab:CreateSection("🎨  Tema  (8 pilihan)")
    Tab:CreateDropdown({Name="Tema Chat",Options={"Midnight","Ocean","Candy","Aqua","Forest","Lava","Galaxy","Snow"},CurrentOption={"Midnight"},Flag="Theme",Callback=function(v) Config.Theme=rv(v) end})

    Tab:CreateSection("👑  VIP Style  (setelah kumpulkan 3 coin)")
    Tab:CreateDropdown({Name="VIP Text Style",Options={"rainbow","gold"},CurrentOption={"rainbow"},Flag="VIPStyle",Callback=function(v) Config.VIPStyle=rv(v) end})

    Tab:CreateSection("🚀  Mulai")
    Tab:CreateLabel("Kosong = ALL + GLOBAL. Coin VIP tersebar di map game!")

    local function doLoad()
        if Config.Lang=="" or Config.Lang==nil then Config.Lang="ALL" end
        if Config.Region=="" or Config.Region==nil then Config.Region="GLOBAL" end
        showAgeVerify(function()
            if rayGui and rayGui.Parent then
                rayGui.Enabled=false
            end
            launchChatGUI()
        end)
    end
    Tab:CreateButton({Name="▶  Load Chat",Callback=doLoad})
    Tab:CreateButton({Name="★  Set Default & Load",Callback=doLoad})
    print("✅ ChatGlobal v5.0 Setup ready!")
end

-- ══════════════════════════════════════
-- /Setup LISTENER
-- ══════════════════════════════════════
LP.Chatted:Connect(function(msg)
    if msg:lower()=="/setup" then
        if chatGuiRef and chatGuiRef.Parent then
            local m=chatGuiRef:FindFirstChild("Main")
            if m then tw(m,{Size=UDim2.new(0,500,0,0)},0.25) end
            task.delay(0.3,destroyChatGui)
        end
        task.wait(0.35)
        if rayGui and rayGui.Parent then
            rayGui.Enabled=true
        else
            task.spawn(launchRayfield)
        end
    end
end)

-- ══════════════════════════════════════
-- START
-- ══════════════════════════════════════
task.spawn(launchRayfield)

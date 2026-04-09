-- ╔══════════════════════════════════════════╗
-- ║           TrapLag v4.0                   ║
-- ║  Anti-Lag · Shader · BloxStrap · Chat    ║
-- ║            UI: WindUI                    ║
-- ╚══════════════════════════════════════════╝

local VERSION     = "TL40"
local RS          = game:GetService("RunService")
local HS          = game:GetService("HttpService")
local Players     = game:GetService("Players")
local Lighting    = game:GetService("Lighting")
local UIS         = game:GetService("UserInputService")
local LP          = Players.LocalPlayer
local Camera      = workspace.CurrentCamera

-- ========================
-- BASE64
-- ========================
local b64c = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
local function b64e(s)
    local r,p="",""
    s=tostring(s)
    if #s%3==1 then s=s.."\0\0" p="==" elseif #s%3==2 then s=s.."\0" p="=" end
    for i=1,#s,3 do
        local a,b,c=s:byte(i,i+2)
        r=r..b64c:sub(math.floor(a/4)+1,math.floor(a/4)+1)
             ..b64c:sub((a%4)*16+math.floor(b/16)+1,(a%4)*16+math.floor(b/16)+1)
             ..b64c:sub((b%16)*4+math.floor(c/64)+1,(b%16)*4+math.floor(c/64)+1)
             ..b64c:sub(c%64+1,c%64+1)
    end
    if p~="" then r=r:sub(1,-(#p+1))..p end
    return r
end
local function b64d(s)
    local lu={}
    for i=1,#b64c do lu[b64c:sub(i,i)]=i-1 end
    s=s:gsub("[^%w+/=]","")
    local r=""
    for i=1,#s,4 do
        local a=lu[s:sub(i,i)]or 0
        local b=lu[s:sub(i+1,i+1)]or 0
        local c=lu[s:sub(i+2,i+2)]or 0
        local d=lu[s:sub(i+3,i+3)]or 0
        r=r..string.char(a*4+math.floor(b/16),(b%16)*16+math.floor(c/4),(c%4)*64+d)
    end
    return r:gsub("\0+$","")
end

-- ========================
-- PROFANITY FILTER
-- ========================
local badWords = {
    "fuck","shit","bitch","asshole","bastard","damn","crap","dick","pussy","faggot",
    "nigger","nigga","whore","slut","cunt","ass","piss","cock","retard","idiot",
    -- bahasa Indonesia
    "anjing","bangsat","babi","kontol","memek","bajingan","tolol","goblok","kampret","keparat"
}
local replacements = {
    "COOL!","NICE!","WOW!","GREAT!","AWESOME!","OK!","SURE!","FINE!","YEAH!","OKAY!"
}
local function filterText(text)
    local filtered = text
    for _, word in ipairs(badWords) do
        local pattern = word:gsub("(%a)", function(c)
            return "["..c:upper()..c:lower().."]"
        end)
        local replacement = replacements[math.random(1, #replacements)]
        filtered = filtered:gsub(pattern, replacement)
    end
    return filtered
end

-- ========================
-- CONFIG
-- ========================
local configPath = "TrapLag/config/player/settings.json"
local playerConfig = {
    cameraSensitivity = 25,
    fpsTarget         = 240,
    disableShadows    = false,
    disableAtmosphere = false,
    disablePostFX     = false,
    disableParticles  = false,
    hideAccessories   = false,
    disableAnimations = false,
    disableSound      = false,
    reduceRender      = false,
    bloxstrapEnabled  = false,
    antiAfk           = false,
    fullbright        = false,
    noFog             = false,
    walkSpeed         = 16,
    jumpPower         = 50,
    infiniteJump      = false,
    chatFilterEnabled = true,
}

local function saveConfig()
    for _, f in ipairs({
        "TrapLag/config","TrapLag/config/player","TrapLag/config/fonts",
        "TrapLag/config/crosshair","TrapLag/config/image","TrapLag/config/BloxStrap"
    }) do if not isfolder(f) then makefolder(f) end end
    writefile(configPath, HS:JSONEncode(playerConfig))
end

local function loadConfig()
    if isfile(configPath) then
        local ok,d=pcall(function() return HS:JSONDecode(readfile(configPath)) end)
        if ok and d then
            for k,v in pairs(d) do if playerConfig[k]~=nil then playerConfig[k]=v end end
        end
    end
end

-- ========================
-- APPLY FUNCTIONS
-- ========================
local function applyCamera()
    pcall(function()
        local ugs = UserSettings():GetService("UserGameSettings")
        ugs.MouseSensitivity = playerConfig.cameraSensitivity * 0.0032
    end)
end

local function applyShadows()
    Lighting.GlobalShadows = not playerConfig.disableShadows
end

local function applyAtmosphere()
    local atm = Lighting:FindFirstChildOfClass("Atmosphere")
    if atm then
        atm.Density = playerConfig.disableAtmosphere and 0 or 0.395
        atm.Offset  = playerConfig.disableAtmosphere and 0 or 0.25
    end
    Lighting.FogEnd = playerConfig.disableAtmosphere and 9e9 or 100000
end

local function applyPostFX()
    for _,e in ipairs(Lighting:GetChildren()) do
        if e:IsA("BlurEffect")or e:IsA("BloomEffect")or e:IsA("ColorCorrectionEffect")
        or e:IsA("SunRaysEffect")or e:IsA("DepthOfFieldEffect") then
            e.Enabled = not playerConfig.disablePostFX
        end
    end
end

local function applyParticles()
    for _,v in ipairs(workspace:GetDescendants()) do
        if v:IsA("ParticleEmitter")or v:IsA("Trail")or v:IsA("Beam") then
            v.Enabled = not playerConfig.disableParticles
        end
    end
end

-- FIX: handle accessories dengan pcall per part
local function applyAccessories()
    for _,player in ipairs(Players:GetPlayers()) do
        if player.Character then
            for _,v in ipairs(player.Character:GetDescendants()) do
                if v:IsA("Accessory") then
                    pcall(function()
                        for _,part in ipairs(v:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.Transparency = playerConfig.hideAccessories and 1 or 0
                            end
                        end
                    end)
                end
            end
        end
    end
end

local function applyAnimations()
    if playerConfig.disableAnimations then
        for _,player in ipairs(Players:GetPlayers()) do
            if player.Character then
                local hum = player.Character:FindFirstChildOfClass("Humanoid")
                if hum then
                    local anim = hum:FindFirstChildOfClass("Animator")
                    if anim then
                        pcall(function()
                            for _,t in ipairs(anim:GetPlayingAnimationTracks()) do t:Stop() end
                        end)
                    end
                end
            end
        end
    end
end

local function applySound()
    for _,v in ipairs(workspace:GetDescendants()) do
        if v:IsA("Sound") then v.Volume = playerConfig.disableSound and 0 or 1 end
    end
    for _,v in ipairs(game:GetService("SoundService"):GetDescendants()) do
        if v:IsA("Sound") then v.Volume = playerConfig.disableSound and 0 or 1 end
    end
end

local function applyRender()
    settings().Rendering.QualityLevel = playerConfig.reduceRender
        and Enum.QualityLevel.Level01 or Enum.QualityLevel.Automatic
end

local function applyFPS() pcall(function() setfpscap(playerConfig.fpsTarget) end) end

local function applyFullbright()
    if playerConfig.fullbright then
        Lighting.Ambient = Color3.fromRGB(255,255,255)
        Lighting.OutdoorAmbient = Color3.fromRGB(255,255,255)
        Lighting.Brightness = 5
        Lighting.GlobalShadows = false
    else
        Lighting.Ambient = Color3.fromRGB(70,70,70)
        Lighting.OutdoorAmbient = Color3.fromRGB(128,128,128)
        Lighting.Brightness = 2
        Lighting.GlobalShadows = true
    end
end

local function applyWalkSpeed()
    pcall(function()
        local char = LP.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = playerConfig.walkSpeed end
        end
    end)
end

local function applyJumpPower()
    pcall(function()
        local char = LP.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.JumpPower = playerConfig.jumpPower
                hum.JumpHeight = playerConfig.jumpPower * 0.5
            end
        end
    end)
end

local function applyAllConfig()
    applyCamera() applyShadows() applyAtmosphere() applyPostFX()
    applyParticles() applyAccessories() applyAnimations()
    applySound() applyRender() applyFullbright()
    applyWalkSpeed() applyJumpPower()
end

-- ========================
-- EXPORT / IMPORT
-- ========================
local function exportConfig()
    local code = VERSION..":"..b64e(HS:JSONEncode(playerConfig))
    writefile("TrapLag/export.txt", code)
    return code
end
local function importConfig(code)
    local prefix = code:match("^([^:]+):")
    if prefix~=VERSION then return false,"expired" end
    local encoded = code:match("^[^:]+:(.+)$")
    if not encoded then return false,"invalid" end
    local ok,data = pcall(function() return HS:JSONDecode(b64d(encoded)) end)
    if not ok or not data then return false,"invalid" end
    for k,v in pairs(data) do if playerConfig[k]~=nil then playerConfig[k]=v end end
    saveConfig() applyAllConfig()
    return true,"ok"
end

-- ========================
-- ANTI-AFK
-- ========================
local afkConn
local function startAntiAfk()
    afkConn = RS.Heartbeat:Connect(function()
        pcall(function()
            local VirtualUser = game:GetService("VirtualUser")
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end)
end
local function stopAntiAfk()
    if afkConn then afkConn:Disconnect() afkConn=nil end
end

-- ========================
-- INFINITE JUMP
-- ========================
local jumpConn
local function startInfiniteJump()
    jumpConn = UIS.JumpRequest:Connect(function()
        pcall(function()
            if LP.Character then
                local hum = LP.Character:FindFirstChildOfClass("Humanoid")
                if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
            end
        end)
    end)
end
local function stopInfiniteJump()
    if jumpConn then jumpConn:Disconnect() jumpConn=nil end
end

-- ========================
-- FPS + PING SYSTEM
-- ========================
local fpsGui, fpsLabel, pingLabel, detailLabel
local fpsConn
local clientFPS, serverFPS, renderFPS, moveFPS = 60,60,60,60

-- Ghost Part vars
local ghostPart, ghostConn
local realFpsMode = "none" -- "none","body","allplayers"
local currentPovPlayer = nil
local povConn

local function getPing()
    local ok, ping = pcall(function()
        return LP:GetNetworkPing and math.round(LP:GetNetworkPing()*1000) or 0
    end)
    return ok and ping or 0
end

local function createFpsGui()
    if fpsGui then fpsGui:Destroy() end
    fpsGui = Instance.new("ScreenGui")
    fpsGui.Name = "TrapLagFPS"
    fpsGui.ResetOnSpawn = false
    fpsGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    fpsGui.Parent = LP.PlayerGui

    -- FPS + Ping bar (kanan atas, draggable)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0,200,0,32)
    frame.Position = UDim2.new(1,-210,0,10)
    frame.BackgroundColor3 = Color3.fromRGB(10,10,10)
    frame.BackgroundTransparency = 0.35
    frame.BorderSizePixel = 0
    frame.Parent = fpsGui
    Instance.new("UICorner",frame).CornerRadius = UDim.new(0,8)

    fpsLabel = Instance.new("TextLabel")
    fpsLabel.Size = UDim2.new(0.55,0,1,0)
    fpsLabel.BackgroundTransparency = 1
    fpsLabel.TextColor3 = Color3.fromRGB(80,255,80)
    fpsLabel.TextScaled = true
    fpsLabel.Font = Enum.Font.GothamBold
    fpsLabel.Text = "FPS: --"
    fpsLabel.Parent = frame

    pingLabel = Instance.new("TextLabel")
    pingLabel.Size = UDim2.new(0.45,0,1,0)
    pingLabel.Position = UDim2.new(0.55,0,0,0)
    pingLabel.BackgroundTransparency = 1
    pingLabel.TextColor3 = Color3.fromRGB(80,200,255)
    pingLabel.TextScaled = true
    pingLabel.Font = Enum.Font.GothamBold
    pingLabel.Text = "Ping: --"
    pingLabel.Parent = frame

    -- Drag
    local dragging,dragStart,startPos
    frame.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then
            dragging=true dragStart=i.Position startPos=frame.Position
        end
    end)
    frame.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMovement) then
            local d=i.Position-dragStart
            frame.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)
        end
    end)
    frame.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end
    end)

    -- Detail panel (kiri atas)
    local detailFrame = Instance.new("Frame")
    detailFrame.Name = "DetailFrame"
    detailFrame.Size = UDim2.new(0,210,0,120)
    detailFrame.Position = UDim2.new(0,10,0,10)
    detailFrame.BackgroundColor3 = Color3.fromRGB(10,10,10)
    detailFrame.BackgroundTransparency = 0.35
    detailFrame.BorderSizePixel = 0
    detailFrame.Visible = false
    detailFrame.Parent = fpsGui
    Instance.new("UICorner",detailFrame).CornerRadius = UDim.new(0,8)

    detailLabel = Instance.new("TextLabel")
    detailLabel.Size = UDim2.new(1,-8,1,-8)
    detailLabel.Position = UDim2.new(0,4,0,4)
    detailLabel.BackgroundTransparency = 1
    detailLabel.TextColor3 = Color3.fromRGB(180,255,180)
    detailLabel.TextSize = 12
    detailLabel.Font = Enum.Font.GothamBold
    detailLabel.TextXAlignment = Enum.TextXAlignment.Left
    detailLabel.TextYAlignment = Enum.TextYAlignment.Top
    detailLabel.TextWrapped = true
    detailLabel.Text = "Detail FPS loading..."
    detailLabel.Parent = detailFrame
end

local function startFpsCounter()
    if fpsConn then fpsConn:Disconnect() end
    local frames,elapsed = 0,0
    local moveFrames,serverElapsed = 0,0

    fpsConn = RS.RenderStepped:Connect(function(dt)
        frames+=1 elapsed+=dt
        if elapsed>=0.5 then
            clientFPS = math.round(frames/elapsed)
            renderFPS = clientFPS
            frames,elapsed = 0,0
            local ping = getPing()
            local col = clientFPS>=50 and Color3.fromRGB(80,255,80)
                or clientFPS>=30 and Color3.fromRGB(255,200,0)
                or Color3.fromRGB(255,60,60)
            local pingCol = ping<80 and Color3.fromRGB(80,255,80)
                or ping<150 and Color3.fromRGB(255,200,0)
                or Color3.fromRGB(255,60,60)
            if fpsLabel then fpsLabel.Text="FPS: "..clientFPS fpsLabel.TextColor3=col end
            if pingLabel then pingLabel.Text="Ping: "..ping.."ms" pingLabel.TextColor3=pingCol end
            if detailLabel and detailLabel.Parent.Visible then
                detailLabel.Text = string.format(
                    "📊 TrapLag Detail\n🖥 Render: %d fps\n🏃 Move: %d fps\n🌐 Server: ~%d fps\n💻 Client: %d fps\n📶 Ping: %dms",
                    renderFPS,moveFPS,serverFPS,clientFPS,ping
                )
            end
        end
    end)

    RS.Stepped:Connect(function(_,dt)
        moveFrames+=1 serverElapsed+=dt
        if serverElapsed>=0.5 then
            moveFPS = math.round(moveFrames/serverElapsed)
            serverFPS = moveFPS
            moveFrames,serverElapsed = 0,0
        end
    end)
end

local function stopFpsCounter()
    if fpsConn then fpsConn:Disconnect() fpsConn=nil end
    if fpsGui then fpsGui:Destroy() fpsGui=nil end
end

-- ========================
-- REAL FPS GHOST PART
-- ========================
local function clearGhost()
    if ghostConn then ghostConn:Disconnect() ghostConn=nil end
    if ghostPart then ghostPart:Destroy() ghostPart=nil end
    if povConn then povConn:Disconnect() povConn=nil end
    currentPovPlayer = nil
    if detailLabel then detailLabel.Parent.Visible=false end
end

local function makeGhost(targetChar, color)
    if ghostPart then ghostPart:Destroy() end
    ghostPart = Instance.new("Part")
    ghostPart.Name = "TrapLagGhost"
    ghostPart.Size = Vector3.new(2,3,1)
    ghostPart.Anchored = true
    ghostPart.CanCollide = false
    ghostPart.CastShadow = false
    ghostPart.Material = Enum.Material.Neon
    ghostPart.Color = color or Color3.fromRGB(0,255,80)
    ghostPart.Transparency = 0.6
    ghostPart.Parent = workspace

    if detailLabel then detailLabel.Parent.Visible=true end

    local lastCF = CFrame.new()
    -- Server tick via Heartbeat
    RS.Heartbeat:Connect(function()
        pcall(function()
            local hrp = targetChar:FindFirstChild("HumanoidRootPart")
            if hrp then lastCF = hrp.CFrame end
        end)
    end)

    -- Ghost lerp dengan rotation (pakai CFrame penuh!)
    ghostConn = RS.RenderStepped:Connect(function()
        if not ghostPart or not ghostPart.Parent then return end
        ghostPart.CFrame = ghostPart.CFrame:Lerp(lastCF, 0.15)
    end)
end

local function startRealFpsBody()
    clearGhost()
    realFpsMode = "body"
    if not LP.Character then return end
    if not fpsGui then createFpsGui() startFpsCounter() end
    makeGhost(LP.Character, Color3.fromRGB(0,255,80))
end

-- POV player lain
local function startRealFpsPlayer(player)
    clearGhost()
    realFpsMode = "allplayers"
    currentPovPlayer = player
    if not player.Character then return end
    if not fpsGui then createFpsGui() startFpsCounter() end
    makeGhost(player.Character, Color3.fromRGB(80,200,255))

    -- Masuk ke POV player
    pcall(function() Camera.CameraSubject = player.Character:FindFirstChildOfClass("Humanoid") end)

    -- Tombol X untuk keluar POV
    local exitGui = Instance.new("ScreenGui")
    exitGui.Name = "TrapLagPovExit"
    exitGui.ResetOnSpawn = false
    exitGui.Parent = LP.PlayerGui

    local exitBtn = Instance.new("TextButton")
    exitBtn.Size = UDim2.new(0,80,0,36)
    exitBtn.Position = UDim2.new(0.5,-40,0,60)
    exitBtn.BackgroundColor3 = Color3.fromRGB(200,40,40)
    exitBtn.TextColor3 = Color3.fromRGB(255,255,255)
    exitBtn.Font = Enum.Font.GothamBold
    exitBtn.TextScaled = true
    exitBtn.Text = "✕ Exit POV"
    exitBtn.Parent = exitGui
    Instance.new("UICorner",exitBtn).CornerRadius = UDim.new(0,8)

    exitBtn.MouseButton1Click:Connect(function()
        clearGhost()
        pcall(function()
            if LP.Character then
                Camera.CameraSubject = LP.Character:FindFirstChildOfClass("Humanoid")
            end
        end)
        exitGui:Destroy()
    end)
end

-- ========================
-- BLOXSTRAP WARNING
-- ========================
local bloxstrapActive = false

local function showBsWarning(onYes, onNo)
    local wg = Instance.new("ScreenGui")
    wg.Name = "TrapLagWarn"
    wg.ResetOnSpawn = false
    wg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    wg.Parent = LP.PlayerGui

    local ov = Instance.new("Frame")
    ov.Size = UDim2.new(1,0,1,0)
    ov.BackgroundColor3 = Color3.fromRGB(0,0,0)
    ov.BackgroundTransparency = 0.5
    ov.BorderSizePixel = 0
    ov.Parent = wg

    local box = Instance.new("Frame")
    box.Size = UDim2.new(0,320,0,280)
    box.Position = UDim2.new(0.5,-160,0.5,-140)
    box.BackgroundColor3 = Color3.fromRGB(18,18,28)
    box.BorderSizePixel = 0
    box.Parent = ov
    Instance.new("UICorner",box).CornerRadius = UDim.new(0,14)

    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(1,0,0,44)
    t.BackgroundTransparency = 1
    t.TextColor3 = Color3.fromRGB(255,80,80)
    t.TextScaled = true
    t.Font = Enum.Font.GothamBold
    t.Text = "⚠️ PERINGATAN BLOXSTRAP"
    t.Parent = box

    local m = Instance.new("TextLabel")
    m.Size = UDim2.new(1,-20,0,180)
    m.Position = UDim2.new(0,10,0,48)
    m.BackgroundTransparency = 1
    m.TextColor3 = Color3.fromRGB(210,210,210)
    m.TextSize = 13
    m.TextWrapped = true
    m.Font = Enum.Font.Gotham
    m.TextXAlignment = Enum.TextXAlignment.Left
    m.TextYAlignment = Enum.TextYAlignment.Top
    m.Text = "Kamu akan mengaktifkan mode BloxStrap!\n\n"
        .."⚠️ Beberapa fitur Anti-Lag mungkin bentrok dengan BloxStrap mode.\n\n"
        .."⚠️ FFlag dan grafis akan diambil alih oleh config BloxStrap.\n\n"
        .."⚠️ Backup settingmu terlebih dahulu sebelum lanjut.\n\n"
        .."Apakah kamu yakin ingin melanjutkan?"
    m.Parent = box

    local btnY = Instance.new("TextButton")
    btnY.Size = UDim2.new(0,135,0,38)
    btnY.Position = UDim2.new(0,10,1,-50)
    btnY.BackgroundColor3 = Color3.fromRGB(35,160,70)
    btnY.TextColor3 = Color3.fromRGB(255,255,255)
    btnY.Font = Enum.Font.GothamBold
    btnY.TextScaled = true
    btnY.Text = "✅ Ya, Aktifkan"
    btnY.Parent = box
    Instance.new("UICorner",btnY).CornerRadius = UDim.new(0,9)

    local btnN = Instance.new("TextButton")
    btnN.Size = UDim2.new(0,135,0,38)
    btnN.Position = UDim2.new(1,-145,1,-50)
    btnN.BackgroundColor3 = Color3.fromRGB(160,35,35)
    btnN.TextColor3 = Color3.fromRGB(255,255,255)
    btnN.Font = Enum.Font.GothamBold
    btnN.TextScaled = true
    btnN.Text = "❌ Batal"
    btnN.Parent = box
    Instance.new("UICorner",btnN).CornerRadius = UDim.new(0,9)

    btnY.MouseButton1Click:Connect(function() wg:Destroy() onYes() end)
    btnN.MouseButton1Click:Connect(function() wg:Destroy() onNo() end)
end

-- ========================
-- LOAD & STARTUP
-- ========================
loadConfig()
saveConfig()
applyAllConfig()

if playerConfig.antiAfk then startAntiAfk() end
if playerConfig.infiniteJump then startInfiniteJump() end

-- Load ChatGlobal
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HaZcK/RealProject/refs/heads/main/Project/ChatGlobal/ChatGll.lua"))()
    end)
end)

-- ========================
-- WINDUI
-- ========================
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "TrapLag",
    Icon = "zap",
    Author = "TrapLag v4.0",
    Folder = "TrapLag",
    MobileOpen = Enum.KeyCode.RightControl,
    Open = Enum.KeyCode.RightControl,
    Resize = true,
    Theme = "Dark",
})

-- ========================
-- TAB 1: ANTI LAG
-- ========================
local LagTab = Window:Tab({ Title = "Anti Lag", Icon = "cpu" })

LagTab:Section({ Title = "Player Config" })

LagTab:Slider({ Title="Camera Sensitivity", Description="Sensitivitas kamera (1-100)", Icon="move",
    Min=1, Max=100, Default=playerConfig.cameraSensitivity, Increment=1,
    Callback=function(v) playerConfig.cameraSensitivity=v applyCamera() saveConfig() end })

LagTab:Slider({ Title="Walk Speed", Description="Kecepatan berjalan (8-100)", Icon="zap",
    Min=8, Max=100, Default=playerConfig.walkSpeed, Increment=1,
    Callback=function(v) playerConfig.walkSpeed=v applyWalkSpeed() saveConfig() end })

LagTab:Slider({ Title="Jump Power", Description="Tinggi lompatan (10-200)", Icon="chevrons-up",
    Min=10, Max=200, Default=playerConfig.jumpPower, Increment=5,
    Callback=function(v) playerConfig.jumpPower=v applyJumpPower() saveConfig() end })

LagTab:Toggle({ Title="Infinite Jump", Description="Lompat terus tanpa batas", Icon="arrow-up",
    Default=playerConfig.infiniteJump,
    Callback=function(s) playerConfig.infiniteJump=s saveConfig()
        if s then startInfiniteJump() else stopInfiniteJump() end end })

LagTab:Toggle({ Title="Anti-AFK", Description="Cegah kick karena AFK", Icon="shield",
    Default=playerConfig.antiAfk,
    Callback=function(s) playerConfig.antiAfk=s saveConfig()
        if s then startAntiAfk() else stopAntiAfk() end end })

LagTab:Section({ Title = "FPS & Render" })

LagTab:Button({ Title="FPS Unlocker", Description="Unlock FPS ke "..playerConfig.fpsTarget, Icon="gauge",
    Callback=function() applyFPS() WindUI:Notify({Title="TrapLag",Content="FPS di-unlock ke "..playerConfig.fpsTarget.."!",Duration=3}) end })

LagTab:Button({ Title="Cap FPS 60", Description="Batasi FPS ke 60", Icon="battery",
    Callback=function() setfpscap(60) WindUI:Notify({Title="TrapLag",Content="FPS di-cap ke 60!",Duration=3}) end })

LagTab:Slider({ Title="FPS Target", Description="Target FPS untuk FPS Unlocker", Icon="gauge",
    Min=30, Max=240, Default=playerConfig.fpsTarget, Increment=10,
    Callback=function(v) playerConfig.fpsTarget=v saveConfig() end })

LagTab:Toggle({ Title="Reduce Render Distance", Description="Kurangi jarak render objek", Icon="eye",
    Default=playerConfig.reduceRender,
    Callback=function(s) playerConfig.reduceRender=s applyRender() saveConfig() end })

LagTab:Section({ Title = "Visual" })

LagTab:Toggle({ Title="Disable Shadows", Description="Matikan shadow untuk boost FPS", Icon="sun",
    Default=playerConfig.disableShadows,
    Callback=function(s) playerConfig.disableShadows=s applyShadows() saveConfig()
        WindUI:Notify({Title="TrapLag",Content=s and "Shadows dimatikan!" or "Shadows dinyalakan!",Duration=2}) end })

LagTab:Toggle({ Title="Disable Atmosphere", Description="Hapus fog & atmosphere", Icon="cloud-off",
    Default=playerConfig.disableAtmosphere,
    Callback=function(s) playerConfig.disableAtmosphere=s applyAtmosphere() saveConfig() end })

LagTab:Toggle({ Title="Disable PostFX", Description="Hapus blur, bloom, color correction", Icon="image-off",
    Default=playerConfig.disablePostFX,
    Callback=function(s) playerConfig.disablePostFX=s applyPostFX() saveConfig() end })

LagTab:Toggle({ Title="Fullbright", Description="Terangkan semua area gelap", Icon="sun",
    Default=playerConfig.fullbright,
    Callback=function(s) playerConfig.fullbright=s applyFullbright() saveConfig() end })

LagTab:Button({ Title="Low Texture Quality", Description="Set tekstur ke kualitas terendah", Icon="image",
    Callback=function()
        settings().Rendering.QualityLevel=Enum.QualityLevel.Level01
        WindUI:Notify({Title="TrapLag",Content="Texture quality diturunkan!",Duration=3}) end })

LagTab:Section({ Title = "Player" })

LagTab:Toggle({ Title="Disable Particles", Description="Matikan semua efek partikel", Icon="sparkles",
    Default=playerConfig.disableParticles,
    Callback=function(s) playerConfig.disableParticles=s applyParticles() saveConfig() end })

LagTab:Toggle({ Title="Hide Accessories", Description="Sembunyikan aksesoris semua player", Icon="shirt",
    Default=playerConfig.hideAccessories,
    Callback=function(s) playerConfig.hideAccessories=s applyAccessories() saveConfig() end })

LagTab:Toggle({ Title="Disable Animations", Description="Hentikan animasi semua player", Icon="person-standing",
    Default=playerConfig.disableAnimations,
    Callback=function(s) playerConfig.disableAnimations=s applyAnimations() saveConfig() end })

LagTab:Section({ Title = "Sound" })

LagTab:Toggle({ Title="Disable All Sound", Description="Matikan semua suara dalam game", Icon="volume-x",
    Default=playerConfig.disableSound,
    Callback=function(s) playerConfig.disableSound=s applySound() saveConfig() end })

LagTab:Section({ Title = "Quick Actions" })

LagTab:Button({ Title="⚡ Full Anti Lag", Description="Aktifkan SEMUA fitur anti-lag", Icon="zap",
    Callback=function()
        playerConfig.disableShadows=true playerConfig.disableAtmosphere=true
        playerConfig.disablePostFX=true playerConfig.disableParticles=true playerConfig.reduceRender=true
        applyFPS() applyShadows() applyAtmosphere() applyPostFX() applyParticles() applyRender()
        saveConfig()
        WindUI:Notify({Title="TrapLag ⚡",Content="Semua fitur anti-lag aktif!",Duration=4}) end })

LagTab:Button({ Title="🔄 Reset All", Description="Kembalikan semua ke default", Icon="rotate-ccw",
    Callback=function()
        playerConfig.disableShadows=false playerConfig.disableAtmosphere=false
        playerConfig.disablePostFX=false playerConfig.disableParticles=false
        playerConfig.reduceRender=false playerConfig.disableSound=false
        playerConfig.hideAccessories=false playerConfig.disableAnimations=false
        playerConfig.fullbright=false playerConfig.walkSpeed=16
        playerConfig.jumpPower=50 playerConfig.infiniteJump=false
        applyAllConfig() stopAntiAfk() stopInfiniteJump() saveConfig()
        WindUI:Notify({Title="TrapLag",Content="Semua pengaturan direset!",Duration=3}) end })

-- ========================
-- TAB 2: BLOXSHADER
-- ========================
local ShadeTab = Window:Tab({ Title = "BloxShader", Icon = "sparkles" })

ShadeTab:Section({ Title = "PShade Ultimate" })

ShadeTab:Button({ Title="🎨 Load PShade Ultimate", Description="Load shader lengkap dari PShade Ultimate", Icon="wand",
    Callback=function()
        WindUI:Notify({Title="BloxShader",Content="Loading PShade Ultimate...",Duration=3})
        local ok,err=pcall(function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/randomstring0/pshade-ultimate/refs/heads/main/src/cd.lua'))()
        end)
        if not ok then WindUI:Notify({Title="❌ Gagal",Content=tostring(err):sub(1,80),Duration=5}) end end })

ShadeTab:Section({ Title = "Manual Shader Presets" })

ShadeTab:Toggle({ Title="🎬 Cinematic Mode", Description="DOF + Color Grade sinematik", Icon="film", Default=false,
    Callback=function(s)
        local dof=Lighting:FindFirstChildOfClass("DepthOfFieldEffect")or Instance.new("DepthOfFieldEffect",Lighting)
        dof.Enabled=s dof.FarIntensity=s and 0.5 or 0 dof.NearIntensity=s and 0.3 or 0 dof.FocusDistance=s and 50 or 0
        local cc=Lighting:FindFirstChildOfClass("ColorCorrectionEffect")or Instance.new("ColorCorrectionEffect",Lighting)
        cc.Enabled=s cc.Contrast=s and 0.2 or 0 cc.Saturation=s and -0.1 or 0
        cc.TintColor=s and Color3.fromRGB(200,210,255) or Color3.fromRGB(255,255,255) end })

ShadeTab:Toggle({ Title="🌅 Golden Hour", Description="Nuansa senja yang hangat", Icon="sun", Default=false,
    Callback=function(s)
        local cc=Lighting:FindFirstChildOfClass("ColorCorrectionEffect")or Instance.new("ColorCorrectionEffect",Lighting)
        cc.Enabled=s cc.Saturation=s and 0.3 or 0 cc.TintColor=s and Color3.fromRGB(255,210,160) or Color3.fromRGB(255,255,255)
        if s then Lighting.Ambient=Color3.fromRGB(255,180,100) Lighting.TimeOfDay="17:30:00"
        else Lighting.Ambient=Color3.fromRGB(70,70,70) end end })

ShadeTab:Toggle({ Title="🌙 Night Mode", Description="Suasana malam gelap misterius", Icon="moon", Default=false,
    Callback=function(s)
        if s then Lighting.TimeOfDay="00:00:00" Lighting.Ambient=Color3.fromRGB(20,20,40) Lighting.Brightness=0.5
        else Lighting.TimeOfDay="14:00:00" Lighting.Ambient=Color3.fromRGB(70,70,70) Lighting.Brightness=2 end end })

ShadeTab:Toggle({ Title="📼 Retro VHS", Description="Efek warna retro tahun 80an", Icon="tv", Default=false,
    Callback=function(s)
        local cc=Lighting:FindFirstChildOfClass("ColorCorrectionEffect")or Instance.new("ColorCorrectionEffect",Lighting)
        cc.Enabled=s cc.Saturation=s and -0.4 or 0 cc.Contrast=s and 0.3 or 0
        local blur=Lighting:FindFirstChildOfClass("BlurEffect")or Instance.new("BlurEffect",Lighting)
        blur.Enabled=s blur.Size=s and 4 or 0 end })

ShadeTab:Toggle({ Title="🌆 Neon City", Description="Cyberpunk neon biru-ungu", Icon="zap", Default=false,
    Callback=function(s)
        local cc=Lighting:FindFirstChildOfClass("ColorCorrectionEffect")or Instance.new("ColorCorrectionEffect",Lighting)
        cc.Enabled=s cc.Saturation=s and 0.5 or 0 cc.TintColor=s and Color3.fromRGB(160,180,255) or Color3.fromRGB(255,255,255)
        if s then Lighting.Ambient=Color3.fromRGB(60,0,120) Lighting.TimeOfDay="22:00:00"
        else Lighting.Ambient=Color3.fromRGB(70,70,70) end end })

ShadeTab:Toggle({ Title="✨ Enhanced Bloom", Description="Efek bloom yang kuat dan indah", Icon="star", Default=false,
    Callback=function(s)
        local bloom=Lighting:FindFirstChildOfClass("BloomEffect")or Instance.new("BloomEffect",Lighting)
        bloom.Enabled=s bloom.Intensity=s and 1.2 or 0.5 bloom.Size=s and 30 or 24 bloom.Threshold=s and 0.8 or 0.95 end })

ShadeTab:Toggle({ Title="🎭 Horror Mode", Description="Suasana gelap mencekam", Icon="ghost", Default=false,
    Callback=function(s)
        if s then
            Lighting.TimeOfDay="23:00:00" Lighting.Ambient=Color3.fromRGB(5,0,10)
            Lighting.OutdoorAmbient=Color3.fromRGB(5,0,5) Lighting.Brightness=0.2
            local cc=Lighting:FindFirstChildOfClass("ColorCorrectionEffect")or Instance.new("ColorCorrectionEffect",Lighting)
            cc.Enabled=true cc.Saturation=-0.8 cc.Contrast=0.5 cc.TintColor=Color3.fromRGB(180,100,100)
            local fog=Lighting:FindFirstChildOfClass("Atmosphere") or Instance.new("Atmosphere",Lighting)
            fog.Density=0.7 fog.Color=Color3.fromRGB(20,0,0)
        else
            Lighting.TimeOfDay="14:00:00" Lighting.Ambient=Color3.fromRGB(70,70,70)
            Lighting.OutdoorAmbient=Color3.fromRGB(128,128,128) Lighting.Brightness=2
        end end })

ShadeTab:Button({ Title="🔄 Reset Semua Shader", Description="Kembalikan Lighting ke default", Icon="rotate-ccw",
    Callback=function()
        Lighting.Ambient=Color3.fromRGB(70,70,70) Lighting.OutdoorAmbient=Color3.fromRGB(128,128,128)
        Lighting.Brightness=2 Lighting.TimeOfDay="14:00:00"
        for _,e in ipairs(Lighting:GetChildren()) do
            if e:IsA("BlurEffect")or e:IsA("BloomEffect")or e:IsA("ColorCorrectionEffect")
            or e:IsA("SunRaysEffect")or e:IsA("DepthOfFieldEffect") then e.Enabled=false end
        end
        WindUI:Notify({Title="BloxShader",Content="Semua shader direset!",Duration=3}) end })

-- ========================
-- TAB 3: BLOXSTRAP
-- ========================
local BSTab = Window:Tab({ Title = "BloxStrap", Icon = "settings-2" })

BSTab:Section({ Title = "Mode BloxStrap" })

-- Load BloxStrap Mobile
BSTab:Button({ Title="🚀 Load BloxStrap Mobile", Description="Load script BloxStrap mobile", Icon="download",
    Callback=function()
        WindUI:Notify({Title="BloxStrap",Content="Loading BloxStrap Mobile...",Duration=3})
        local ok,err=pcall(function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-bloxstrap-mobile-71282"))()
        end)
        if not ok then WindUI:Notify({Title="❌ Gagal",Content=tostring(err):sub(1,80),Duration=5}) end end })

-- Toggle Load BloxStrap dengan warning + Locked logic
BSTab:Toggle({ Title="⚡ Enable BloxStrap Mode", Description="Unlock semua fitur BloxStrap (ada peringatan)", Icon="power",
    Default=playerConfig.bloxstrapEnabled,
    Callback=function(state)
        if state and not bloxstrapActive then
            showBsWarning(
                function()
                    bloxstrapActive=true playerConfig.bloxstrapEnabled=true saveConfig()
                    createFpsGui() startFpsCounter()
                    WindUI:Notify({Title="BloxStrap ✅",Content="Mode BloxStrap aktif! Semua fitur tersedia.",Duration=4})
                end,
                function()
                    bloxstrapActive=false
                    WindUI:Notify({Title="BloxStrap",Content="Dibatalkan.",Duration=2})
                end
            )
        elseif not state then
            bloxstrapActive=false playerConfig.bloxstrapEnabled=false saveConfig()
            stopFpsCounter() clearGhost()
            WindUI:Notify({Title="BloxStrap",Content="Mode BloxStrap dimatikan.",Duration=3})
        end
    end })

-- SEMUA ITEM BERIKUT LOCKED = true (hanya bisa dipakai setelah enable)
BSTab:Section({ Title = "FPS Monitor" })

BSTab:Toggle({ Title="📊 FPS Counter + Ping", Description="Tampilkan FPS & Ping di layar (draggable)", Icon="activity",
    Locked=not bloxstrapActive, Default=false,
    Callback=function(s)
        if not bloxstrapActive then
            WindUI:Notify({Title="🔒 Locked",Content="Enable BloxStrap Mode terlebih dahulu!",Duration=3}) return
        end
        if s then createFpsGui() startFpsCounter() else stopFpsCounter() clearGhost() end end })

BSTab:Section({ Title = "Real FPS" })

BSTab:Toggle({ Title="🟢 Real FPS - Badan Sendiri", Description="Ghost part servermu (hijau, rotasi mengikuti player)", Icon="person-standing",
    Locked=not bloxstrapActive, Default=false,
    Callback=function(s)
        if not bloxstrapActive then
            WindUI:Notify({Title="🔒 Locked",Content="Enable BloxStrap Mode terlebih dahulu!",Duration=3}) return
        end
        if s then startRealFpsBody() else clearGhost() end end })

BSTab:Toggle({ Title="🔵 Real FPS - Lihat Player Lain", Description="Masuk ke POV player lain, lihat ghost server mereka", Icon="eye",
    Locked=not bloxstrapActive, Default=false,
    Callback=function(s)
        if not bloxstrapActive then
            WindUI:Notify({Title="🔒 Locked",Content="Enable BloxStrap Mode terlebih dahulu!",Duration=3}) return
        end
        if s then
            -- Pilih player dari list
            local plrs = Players:GetPlayers()
            local names = {}
            for _,p in ipairs(plrs) do
                if p~=LP then table.insert(names,p.Name) end
            end
            if #names==0 then
                WindUI:Notify({Title="Real FPS",Content="Tidak ada player lain di server!",Duration=3}) return
            end
            -- Pilih player pertama yang ditemukan
            local target = nil
            for _,p in ipairs(plrs) do if p~=LP then target=p break end end
            if target then startRealFpsPlayer(target) end
        else
            clearGhost()
            pcall(function()
                if LP.Character then Camera.CameraSubject=LP.Character:FindFirstChildOfClass("Humanoid") end
            end)
        end end })

BSTab:Section({ Title = "FFlag Editor" })

BSTab:Button({ Title="📋 Load FFlags dari File", Description="Baca TrapLag/config/BloxStrap/fflags.json",
    Icon="file-json", Locked=not bloxstrapActive,
    Callback=function()
        if not bloxstrapActive then
            WindUI:Notify({Title="🔒 Locked",Content="Enable BloxStrap Mode terlebih dahulu!",Duration=3}) return
        end
        local path="TrapLag/config/BloxStrap/fflags.json"
        if not isfile(path) then
            writefile(path,HS:JSONEncode({["DFIntTaskSchedulerTargetFps"]=240,["FFlagDisablePostFx"]=false}))
            WindUI:Notify({Title="FFlags",Content="Template fflags.json dibuat! Edit lalu load lagi.",Duration=5}) return
        end
        local ok,data=pcall(function() return HS:JSONDecode(readfile(path)) end)
        if ok and data then
            local count=0 for _ in pairs(data) do count+=1 end
            WindUI:Notify({Title="FFlags ✅",Content=count.." flag ditemukan & loaded!",Duration=4})
        else WindUI:Notify({Title="❌ Error",Content="JSON tidak valid!",Duration=4}) end end })

BSTab:Section({ Title = "Graphics Settings" })

BSTab:Slider({ Title="Render Quality", Description="Kualitas render (1=terendah, 10=tertinggi)", Icon="monitor",
    Min=1, Max=10, Default=5, Increment=1, Locked=not bloxstrapActive,
    Callback=function(v)
        if not bloxstrapActive then return end
        local lvl={Enum.QualityLevel.Level01,Enum.QualityLevel.Level02,Enum.QualityLevel.Level03,
            Enum.QualityLevel.Level04,Enum.QualityLevel.Level05,Enum.QualityLevel.Level06,
            Enum.QualityLevel.Level07,Enum.QualityLevel.Level08,Enum.QualityLevel.Level09,Enum.QualityLevel.Level10}
        settings().Rendering.QualityLevel=lvl[v] or Enum.QualityLevel.Level05 end })

BSTab:Slider({ Title="Lighting Brightness", Description="Intensitas cahaya global (0-5)", Icon="sun",
    Min=0, Max=5, Default=2, Increment=0.5, Locked=not bloxstrapActive,
    Callback=function(v)
        if not bloxstrapActive then return end
        Lighting.Brightness=v end })

-- ========================
-- TAB 4: CHAT
-- ========================
local ChatTab = Window:Tab({ Title = "Chat", Icon = "message-circle" })

ChatTab:Section({ Title = "ChatGlobal" })

ChatTab:Button({ Title="💬 Reload ChatGlobal", Description="Load ulang ChatGlobal GUI", Icon="refresh-cw",
    Callback=function()
        WindUI:Notify({Title="Chat",Content="Loading ChatGlobal...",Duration=3})
        task.spawn(function()
            local ok,err=pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/HaZcK/RealProject/refs/heads/main/Project/ChatGlobal/ChatGll.lua"))()
            end)
            if not ok then WindUI:Notify({Title="❌ Chat Error",Content=tostring(err):sub(1,60),Duration=5}) end
        end)
    end })

ChatTab:Section({ Title = "Profanity Filter (AI)" })

ChatTab:Toggle({ Title="🤖 Filter Kata Kasar", Description="Ganti kata kasar dengan kata positif (AI style)", Icon="shield",
    Default=playerConfig.chatFilterEnabled,
    Callback=function(s) playerConfig.chatFilterEnabled=s saveConfig()
        WindUI:Notify({Title="Filter",Content=s and "Filter aktif! Kata kasar akan diganti." or "Filter dimatikan.",Duration=3}) end })

ChatTab:Button({ Title="🧪 Test Filter", Description="Coba filter kata (lihat output console)", Icon="flask-conical",
    Callback=function()
        local testInput = "fuck you anjing!"
        local result = filterText(testInput)
        WindUI:Notify({Title="Test Filter",Content="Input: "..testInput.."\nOutput: "..result,Duration=5}) end })

ChatTab:Section({ Title = "Info" })

ChatTab:Button({ Title="ℹ️ Info ChatGlobal", Description="Info tentang ChatGlobal", Icon="info",
    Callback=function()
        WindUI:Notify({Title="ChatGlobal",Content="ChatGlobal by Khafidz_3 - Cross-server global chat dengan filter AI kata kasar.",Duration=5}) end })

-- ========================
-- TAB 5: CONFIG
-- ========================
local CfgTab = Window:Tab({ Title = "Config", Icon = "sliders-horizontal" })

CfgTab:Section({ Title = "Crosshair & Image" })

CfgTab:Button({ Title="Lihat Crosshair", Description="Cek file di config/crosshair/", Icon="crosshair",
    Callback=function()
        local files=listfiles("TrapLag/config/crosshair")
        local names={}
        for _,f in ipairs(files) do if f:match("%.png$") then table.insert(names,f:match("([^/\\]+)$")or f) end end
        WindUI:Notify({Title="Crosshair",Content=#names>0 and table.concat(names,", ") or "Belum ada crosshair!",Duration=5}) end })

CfgTab:Button({ Title="Cek Logo", Description="Cek TrapLag/logo.png", Icon="image",
    Callback=function()
        WindUI:Notify({Title="Logo",Content=isfile("TrapLag/logo.png") and "logo.png ditemukan! ✅" or "logo.png belum ada!",Duration=3}) end })

CfgTab:Section({ Title = "Fonts" })

CfgTab:Button({ Title="Lihat Font Tersedia", Description="Cek file di TrapLag/config/fonts/", Icon="type",
    Callback=function()
        local files=listfiles("TrapLag/config/fonts")
        local names={}
        for _,f in ipairs(files) do if f:match("%.json$") then table.insert(names,f:match("([^/\\]+)%.json$")or f) end end
        WindUI:Notify({Title="Fonts",Content=#names>0 and table.concat(names,", ") or "Belum ada font!",Duration=5}) end })

CfgTab:Button({ Title="Apply Font Custom", Description="Apply font pertama yang ditemukan", Icon="type",
    Callback=function()
        local files=listfiles("TrapLag/config/fonts")
        for _,f in ipairs(files) do
            if f:match("%.ttf$") or f:match("%.otf$") then
                local name=f:match("([^/\\]+)$")
                local face=Font.new("rbxasset://fonts/"..name)
                for _,obj in ipairs(game:GetDescendants()) do
                    if obj:IsA("TextLabel")or obj:IsA("TextButton")or obj:IsA("TextBox") then
                        pcall(function() obj.FontFace=face end)
                    end
                end
                WindUI:Notify({Title="Font",Content=name.." berhasil diapply!",Duration=3}) return
            end
        end
        WindUI:Notify({Title="Font",Content="Tidak ada file font!",Duration=4}) end })

CfgTab:Section({ Title = "Export & Import" })

CfgTab:Button({ Title="📤 Export Config", Description="Generate kode → TrapLag/export.txt", Icon="share",
    Callback=function()
        local code=exportConfig()
        WindUI:Notify({Title="Exported! ✅",Content="Disimpan di export.txt\n"..code:sub(1,35).."...",Duration=6}) end })

CfgTab:Button({ Title="📋 Copy Kode", Description="Copy kode ke clipboard", Icon="copy",
    Callback=function()
        if isfile("TrapLag/export.txt") then
            setclipboard(readfile("TrapLag/export.txt"))
            WindUI:Notify({Title="Copied! ✅",Content="Kode berhasil dicopy!",Duration=3})
        else WindUI:Notify({Title="Export dulu!",Content="Klik Export Config terlebih dahulu.",Duration=3}) end end })

CfgTab:Button({ Title="📥 Import Config", Description="Paste kode di TrapLag/import.txt lalu klik", Icon="download",
    Callback=function()
        if not isfile("TrapLag/import.txt") then
            writefile("TrapLag/import.txt","")
            WindUI:Notify({Title="Import",Content="import.txt dibuat! Paste kode lalu klik Import lagi.",Duration=5}) return
        end
        local code=readfile("TrapLag/import.txt"):gsub("%s+","")
        if code=="" then WindUI:Notify({Title="Import",Content="import.txt kosong!",Duration=4}) return end
        local ok,reason=importConfig(code)
        if ok then
            WindUI:Notify({Title="Import Berhasil! ✅",Content="Config berhasil diload & diapply!",Duration=4})
            writefile("TrapLag/import.txt","")
        elseif reason=="expired" then
            WindUI:Notify({Title="❌ Kode Expired!",Content="Kode dari versi lama TrapLag.",Duration=5})
        else
            WindUI:Notify({Title="❌ Kode Tidak Valid!",Content="Kode salah atau rusak.",Duration=5}) end end })

-- ========================
-- AUTO STARTUP FPS
-- ========================
if playerConfig.bloxstrapEnabled then
    bloxstrapActive=true
    createFpsGui()
    startFpsCounter()
end

-- ========================
-- STARTUP NOTIFY
-- ========================
WindUI:Notify({
    Title = "TrapLag v4.0 ✅",
    Content = "Config diload! ChatGlobal loading di background...",
    Duration = 4,
})

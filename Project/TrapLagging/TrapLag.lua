-- ╔══════════════════════════════════════════╗
-- ║           TrapLag v5.0                   ║
-- ║  Anti-Lag · Shader · BloxStrap           ║
-- ║  Global Chat · Sound Player              ║
-- ║        GUI: Custom Elegant               ║
-- ╚══════════════════════════════════════════╝

local VERSION      = "TL50"
local RS           = game:GetService("RunService")
local HS           = game:GetService("HttpService")
local Players      = game:GetService("Players")
local Lighting     = game:GetService("Lighting")
local UIS          = game:GetService("UserInputService")
local SS           = game:GetService("SoundService")
local LP           = Players.LocalPlayer
local Camera       = workspace.CurrentCamera
local CHAT_URL     = "https://traplagging-server-production.up.railway.app"

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
local badWords = {"fuck","shit","bitch","asshole","bastard","dick","pussy","cunt","cock",
    "nigger","nigga","whore","slut","retard","anjing","bangsat","babi","kontol",
    "memek","bajingan","tolol","goblok","kampret","keparat","sialan","bedebah"}
local goodWords = {"COOL!","NICE!","WOW!","GREAT!","AWESOME!","OK!","SURE!","FINE!","YEAH!","GG!"}
local function filterText(text)
    local out = text
    for _,w in ipairs(badWords) do
        local pat = w:gsub("(%a)",function(c) return "["..c:upper()..c:lower().."]" end)
        out = out:gsub(pat, goodWords[math.random(1,#goodWords)])
    end
    return out
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
    walkSpeed         = 16,
    jumpPower         = 50,
    infiniteJump      = false,
    chatColor         = "#00ffcc",
}

local function saveConfig()
    for _,f in ipairs({"TrapLag/config","TrapLag/config/player","TrapLag/config/fonts",
        "TrapLag/config/crosshair","TrapLag/config/image","TrapLag/config/BloxStrap","TrapLag/config/sound"}) do
        if not isfolder(f) then makefolder(f) end
    end
    writefile(configPath, HS:JSONEncode(playerConfig))
end

local function loadConfig()
    if isfile(configPath) then
        local ok,d=pcall(function() return HS:JSONDecode(readfile(configPath)) end)
        if ok and d then for k,v in pairs(d) do if playerConfig[k]~=nil then playerConfig[k]=v end end end
    end
end

-- ========================
-- APPLY FUNCTIONS
-- ========================
local function applyCamera()
    pcall(function()
        UserSettings():GetService("UserGameSettings").MouseSensitivity = playerConfig.cameraSensitivity * 0.0032
    end)
end
local function applyShadows() Lighting.GlobalShadows = not playerConfig.disableShadows end
local function applyAtmosphere()
    local atm=Lighting:FindFirstChildOfClass("Atmosphere")
    if atm then atm.Density=playerConfig.disableAtmosphere and 0 or 0.395 atm.Offset=playerConfig.disableAtmosphere and 0 or 0.25 end
    Lighting.FogEnd=playerConfig.disableAtmosphere and 9e9 or 100000
end
local function applyPostFX()
    for _,e in ipairs(Lighting:GetChildren()) do
        if e:IsA("BlurEffect")or e:IsA("BloomEffect")or e:IsA("ColorCorrectionEffect")
        or e:IsA("SunRaysEffect")or e:IsA("DepthOfFieldEffect") then e.Enabled=not playerConfig.disablePostFX end
    end
end
local function applyParticles()
    for _,v in ipairs(workspace:GetDescendants()) do
        if v:IsA("ParticleEmitter")or v:IsA("Trail")or v:IsA("Beam") then v.Enabled=not playerConfig.disableParticles end
    end
end
local function applyAccessories()
    for _,player in ipairs(Players:GetPlayers()) do
        if player.Character then
            for _,v in ipairs(player.Character:GetDescendants()) do
                if v:IsA("Accessory") then
                    pcall(function()
                        for _,p in ipairs(v:GetDescendants()) do
                            if p:IsA("BasePart") then p.Transparency=playerConfig.hideAccessories and 1 or 0 end
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
                local hum=player.Character:FindFirstChildOfClass("Humanoid")
                if hum then local anim=hum:FindFirstChildOfClass("Animator")
                    if anim then pcall(function() for _,t in ipairs(anim:GetPlayingAnimationTracks()) do t:Stop() end end) end
                end
            end
        end
    end
end
local function applySound()
    for _,v in ipairs(workspace:GetDescendants()) do if v:IsA("Sound") then v.Volume=playerConfig.disableSound and 0 or 1 end end
    for _,v in ipairs(SS:GetDescendants()) do if v:IsA("Sound") then v.Volume=playerConfig.disableSound and 0 or 1 end end
end
local function applyRender()
    settings().Rendering.QualityLevel=playerConfig.reduceRender and Enum.QualityLevel.Level01 or Enum.QualityLevel.Automatic
end
local function applyFPS() pcall(function() setfpscap(playerConfig.fpsTarget) end) end
local function applyFullbright()
    if playerConfig.fullbright then
        Lighting.Ambient=Color3.fromRGB(255,255,255) Lighting.OutdoorAmbient=Color3.fromRGB(255,255,255)
        Lighting.Brightness=5 Lighting.GlobalShadows=false
    else
        Lighting.Ambient=Color3.fromRGB(70,70,70) Lighting.OutdoorAmbient=Color3.fromRGB(128,128,128)
        Lighting.Brightness=2 Lighting.GlobalShadows=true
    end
end
local function applyWalkSpeed()
    pcall(function()
        local hum=LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed=playerConfig.walkSpeed end
    end)
end
local function applyJumpPower()
    pcall(function()
        local hum=LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.JumpPower=playerConfig.jumpPower end
    end)
end
local function applyAllConfig()
    applyCamera() applyShadows() applyAtmosphere() applyPostFX()
    applyParticles() applyAccessories() applyAnimations()
    applySound() applyRender() applyFullbright() applyWalkSpeed() applyJumpPower()
end

-- ========================
-- EXPORT / IMPORT
-- ========================
local function exportConfig()
    local code=VERSION..":"..b64e(HS:JSONEncode(playerConfig))
    writefile("TrapLag/export.txt",code) return code
end
local function importConfig(code)
    local prefix=code:match("^([^:]+):")
    if prefix~=VERSION then return false,"expired" end
    local enc=code:match("^[^:]+:(.+)$")
    if not enc then return false,"invalid" end
    local ok,data=pcall(function() return HS:JSONDecode(b64d(enc)) end)
    if not ok or not data then return false,"invalid" end
    for k,v in pairs(data) do if playerConfig[k]~=nil then playerConfig[k]=v end end
    saveConfig() applyAllConfig() return true,"ok"
end

-- ========================
-- ANTI AFK + INF JUMP
-- ========================
local afkConn, jumpConn
local function startAntiAfk()
    afkConn=RS.Heartbeat:Connect(function()
        pcall(function() game:GetService("VirtualUser"):CaptureController() game:GetService("VirtualUser"):ClickButton2(Vector2.new()) end)
    end)
end
local function stopAntiAfk() if afkConn then afkConn:Disconnect() afkConn=nil end end
local function startInfJump()
    jumpConn=UIS.JumpRequest:Connect(function()
        pcall(function()
            local hum=LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
        end)
    end)
end
local function stopInfJump() if jumpConn then jumpConn:Disconnect() jumpConn=nil end end

-- ========================
-- FPS / PING SYSTEM
-- ========================
local fpsGui,fpsLabel,pingLabel,detailLabel
local fpsConn
local clientFPS,serverFPS,renderFPS,moveFPS=60,60,60,60
local ghostPart,ghostConn
local bloxstrapActive=false

local function getPing()
    local ok,p=pcall(function() return math.round(LP:GetNetworkPing()*1000) end)
    return ok and p or 0
end

local function createFpsGui()
    if fpsGui then fpsGui:Destroy() end
    fpsGui=Instance.new("ScreenGui")
    fpsGui.Name="TrapLagFPS" fpsGui.ResetOnSpawn=false fpsGui.Parent=LP.PlayerGui
    local f=Instance.new("Frame")
    f.Size=UDim2.new(0,210,0,32) f.Position=UDim2.new(1,-220,0,10)
    f.BackgroundColor3=Color3.fromRGB(10,10,10) f.BackgroundTransparency=0.3 f.BorderSizePixel=0 f.Parent=fpsGui
    Instance.new("UICorner",f).CornerRadius=UDim.new(0,8)
    fpsLabel=Instance.new("TextLabel") fpsLabel.Size=UDim2.new(0.5,0,1,0)
    fpsLabel.BackgroundTransparency=1 fpsLabel.TextColor3=Color3.fromRGB(80,255,80)
    fpsLabel.TextScaled=true fpsLabel.Font=Enum.Font.GothamBold fpsLabel.Text="FPS:--" fpsLabel.Parent=f
    pingLabel=Instance.new("TextLabel") pingLabel.Size=UDim2.new(0.5,0,1,0) pingLabel.Position=UDim2.new(0.5,0,0,0)
    pingLabel.BackgroundTransparency=1 pingLabel.TextColor3=Color3.fromRGB(80,200,255)
    pingLabel.TextScaled=true pingLabel.Font=Enum.Font.GothamBold pingLabel.Text="Ping:--" pingLabel.Parent=f
    -- drag
    local drag,ds,sp
    f.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then
            drag=true ds=i.Position sp=f.Position end end)
    f.InputChanged:Connect(function(i)
        if drag and (i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMovement) then
            local d=i.Position-ds f.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y) end end)
    f.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then drag=false end end)
    -- detail panel
    local df=Instance.new("Frame") df.Name="DetailFrame"
    df.Size=UDim2.new(0,215,0,115) df.Position=UDim2.new(0,10,0,10)
    df.BackgroundColor3=Color3.fromRGB(10,10,10) df.BackgroundTransparency=0.3
    df.BorderSizePixel=0 df.Visible=false df.Parent=fpsGui
    Instance.new("UICorner",df).CornerRadius=UDim.new(0,8)
    detailLabel=Instance.new("TextLabel") detailLabel.Size=UDim2.new(1,-8,1,-8)
    detailLabel.Position=UDim2.new(0,4,0,4) detailLabel.BackgroundTransparency=1
    detailLabel.TextColor3=Color3.fromRGB(180,255,180) detailLabel.TextSize=12
    detailLabel.Font=Enum.Font.GothamBold detailLabel.TextXAlignment=Enum.TextXAlignment.Left
    detailLabel.TextYAlignment=Enum.TextYAlignment.Top detailLabel.TextWrapped=true
    detailLabel.Text="Detail FPS..." detailLabel.Parent=df
end

local function startFpsCounter()
    if fpsConn then fpsConn:Disconnect() end
    local fr,el,mf,se=0,0,0,0
    fpsConn=RS.RenderStepped:Connect(function(dt)
        fr+=1 el+=dt
        if el>=0.5 then
            clientFPS=math.round(fr/el) renderFPS=clientFPS fr,el=0,0
            local ping=getPing()
            if fpsLabel then
                fpsLabel.Text="FPS:"..clientFPS
                fpsLabel.TextColor3=clientFPS>=50 and Color3.fromRGB(80,255,80) or clientFPS>=30 and Color3.fromRGB(255,200,0) or Color3.fromRGB(255,60,60)
            end
            if pingLabel then
                pingLabel.Text="Ping:"..ping.."ms"
                pingLabel.TextColor3=ping<80 and Color3.fromRGB(80,255,80) or ping<150 and Color3.fromRGB(255,200,0) or Color3.fromRGB(255,60,60)
            end
            if detailLabel and detailLabel.Parent.Visible then
                detailLabel.Text=string.format("📊 TrapLag Detail\n🖥 Render: %d fps\n🏃 Move: %d fps\n🌐 Server: ~%d fps\n💻 Client: %d fps\n📶 Ping: %dms",renderFPS,moveFPS,serverFPS,clientFPS,ping)
            end
        end
    end)
    RS.Stepped:Connect(function(_,dt)
        mf+=1 se+=dt
        if se>=0.5 then moveFPS=math.round(mf/se) serverFPS=moveFPS mf,se=0,0 end
    end)
end

local function stopFpsCounter()
    if fpsConn then fpsConn:Disconnect() fpsConn=nil end
    if fpsGui then fpsGui:Destroy() fpsGui=nil end
end

local function clearGhost()
    if ghostConn then ghostConn:Disconnect() ghostConn=nil end
    if ghostPart then ghostPart:Destroy() ghostPart=nil end
    if detailLabel then detailLabel.Parent.Visible=false end
end

local function makeGhost(targetChar,color)
    if ghostPart then ghostPart:Destroy() end
    ghostPart=Instance.new("Part") ghostPart.Name="TrapLagGhost"
    ghostPart.Size=Vector3.new(2,3,1) ghostPart.Anchored=true
    ghostPart.CanCollide=false ghostPart.CastShadow=false
    ghostPart.Material=Enum.Material.Neon ghostPart.Color=color or Color3.fromRGB(0,255,80)
    ghostPart.Transparency=0.6 ghostPart.Parent=workspace
    if detailLabel then detailLabel.Parent.Visible=true end
    local lastCF=CFrame.new()
    RS.Heartbeat:Connect(function()
        pcall(function()
            local hrp=targetChar:FindFirstChild("HumanoidRootPart")
            if hrp then lastCF=hrp.CFrame end
        end)
    end)
    ghostConn=RS.RenderStepped:Connect(function()
        if ghostPart and ghostPart.Parent then
            ghostPart.CFrame=ghostPart.CFrame:Lerp(lastCF,0.15)
        end
    end)
end

-- ========================
-- BLOXSTRAP WARNING GUI
-- ========================
local function showBsWarning(onYes,onNo)
    local wg=Instance.new("ScreenGui") wg.Name="TrapLagWarn"
    wg.ResetOnSpawn=false wg.ZIndexBehavior=Enum.ZIndexBehavior.Sibling wg.Parent=LP.PlayerGui
    local ov=Instance.new("Frame") ov.Size=UDim2.new(1,0,1,0)
    ov.BackgroundColor3=Color3.fromRGB(0,0,0) ov.BackgroundTransparency=0.5 ov.BorderSizePixel=0 ov.Parent=wg
    local box=Instance.new("Frame") box.Size=UDim2.new(0,320,0,280)
    box.Position=UDim2.new(0.5,-160,0.5,-140) box.BackgroundColor3=Color3.fromRGB(18,18,28)
    box.BorderSizePixel=0 box.Parent=ov Instance.new("UICorner",box).CornerRadius=UDim.new(0,14)
    local t=Instance.new("TextLabel") t.Size=UDim2.new(1,0,0,44) t.BackgroundTransparency=1
    t.TextColor3=Color3.fromRGB(255,80,80) t.TextScaled=true t.Font=Enum.Font.GothamBold
    t.Text="⚠️ PERINGATAN BLOXSTRAP" t.Parent=box
    local m=Instance.new("TextLabel") m.Size=UDim2.new(1,-20,0,180) m.Position=UDim2.new(0,10,0,48)
    m.BackgroundTransparency=1 m.TextColor3=Color3.fromRGB(210,210,210) m.TextSize=13
    m.TextWrapped=true m.Font=Enum.Font.Gotham m.TextXAlignment=Enum.TextXAlignment.Left
    m.TextYAlignment=Enum.TextYAlignment.Top
    m.Text="Kamu akan mengaktifkan mode BloxStrap!\n\n⚠️ Beberapa fitur Anti-Lag mungkin bentrok.\n\n⚠️ FFlag dan grafis akan diambil alih config BloxStrap.\n\n⚠️ Backup settingmu terlebih dahulu!\n\nApakah kamu yakin?" m.Parent=box
    local bY=Instance.new("TextButton") bY.Size=UDim2.new(0,135,0,38) bY.Position=UDim2.new(0,10,1,-50)
    bY.BackgroundColor3=Color3.fromRGB(35,160,70) bY.TextColor3=Color3.fromRGB(255,255,255)
    bY.Font=Enum.Font.GothamBold bY.TextScaled=true bY.Text="✅ Ya, Aktifkan" bY.Parent=box
    Instance.new("UICorner",bY).CornerRadius=UDim.new(0,9)
    local bN=Instance.new("TextButton") bN.Size=UDim2.new(0,135,0,38) bN.Position=UDim2.new(1,-145,1,-50)
    bN.BackgroundColor3=Color3.fromRGB(160,35,35) bN.TextColor3=Color3.fromRGB(255,255,255)
    bN.Font=Enum.Font.GothamBold bN.TextScaled=true bN.Text="❌ Batal" bN.Parent=box
    Instance.new("UICorner",bN).CornerRadius=UDim.new(0,9)
    bY.MouseButton1Click:Connect(function() wg:Destroy() onYes() end)
    bN.MouseButton1Click:Connect(function() wg:Destroy() onNo() end)
end

-- ========================
-- SOUND SYSTEM
-- ========================
local currentSound=nil
local soundLooping=false
local soundVolume=0.5

local function playSound(soundId)
    if currentSound then currentSound:Stop() currentSound:Destroy() currentSound=nil end
    currentSound=Instance.new("Sound")
    currentSound.SoundId="rbxassetid://"..tostring(soundId):gsub("[^%d]","")
    currentSound.Volume=soundVolume
    currentSound.Looped=soundLooping
    currentSound.Parent=SS
    currentSound:Play()
end

local function stopSound()
    if currentSound then currentSound:Stop() end
end

local function getSoundList()
    local path="TrapLag/config/sound/sounds.json"
    if not isfile(path) then
        -- buat template default
        local template=HS:JSONEncode({
            {Title="Chill Vibes",    SOUNDID="1837849285"},
            {Title="Epic Battle",   SOUNDID="1843667191"},
            {Title="Lofi Study",    SOUNDID="1846368979"},
        })
        writefile(path,template)
    end
    local ok,data=pcall(function() return HS:JSONDecode(readfile(path)) end)
    if ok and data then return data end
    return {}
end

-- ========================
-- GLOBAL CHAT SYSTEM
-- ========================
local chatMessages={}
local lastMsgId=0
local chatPollConn

local function httpPost(url,body)
    return pcall(function()
        return HS:RequestAsync({
            Url=url, Method="POST",
            Headers={["Content-Type"]="application/json"},
            Body=HS:JSONEncode(body)
        })
    end)
end

local function httpGet(url)
    return pcall(function()
        return HS:RequestAsync({Url=url, Method="GET"})
    end)
end

local function sendChatMessage(text)
    local filtered=filterText(text)
    httpPost(CHAT_URL.."/send",{
        username=LP.DisplayName or LP.Name,
        message=filtered,
        color=playerConfig.chatColor or "#00ffcc"
    })
end

local function fetchMessages(onUpdate)
    local ok,res=httpGet(CHAT_URL.."/messages")
    if ok and res and res.StatusCode==200 then
        local parsed=pcall(function()
            local data=HS:JSONDecode(res.Body)
            onUpdate(data)
        end)
    end
end

-- ========================
-- MAIN GUI BUILDER
-- ========================
local MainGui=Instance.new("ScreenGui")
MainGui.Name="TrapLagMain"
MainGui.ResetOnSpawn=false
MainGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
MainGui.Parent=LP.PlayerGui

-- Background blurred overlay
local BG=Instance.new("Frame")
BG.Name="Background"
BG.Size=UDim2.new(0,420,0,580)
BG.Position=UDim2.new(0.5,-210,0.5,-290)
BG.BackgroundColor3=Color3.fromRGB(8,8,18)
BG.BackgroundTransparency=0.05
BG.BorderSizePixel=0
BG.Parent=MainGui
Instance.new("UICorner",BG).CornerRadius=UDim.new(0,18)

-- Gradient bg
local grad=Instance.new("UIGradient")
grad.Color=ColorSequence.new({
    ColorSequenceKeypoint.new(0,Color3.fromRGB(10,10,30)),
    ColorSequenceKeypoint.new(0.5,Color3.fromRGB(15,8,25)),
    ColorSequenceKeypoint.new(1,Color3.fromRGB(8,15,20)),
})
grad.Rotation=135
grad.Parent=BG

-- Stroke border
local stroke=Instance.new("UIStroke")
stroke.Color=Color3.fromRGB(0,200,255)
stroke.Thickness=1.5
stroke.Transparency=0.4
stroke.Parent=BG

-- Title bar
local TitleBar=Instance.new("Frame")
TitleBar.Size=UDim2.new(1,0,0,48)
TitleBar.BackgroundColor3=Color3.fromRGB(0,180,255)
TitleBar.BackgroundTransparency=0.7
TitleBar.BorderSizePixel=0
TitleBar.Parent=BG
Instance.new("UICorner",TitleBar).CornerRadius=UDim.new(0,18)

local TitleGrad=Instance.new("UIGradient")
TitleGrad.Color=ColorSequence.new({
    ColorSequenceKeypoint.new(0,Color3.fromRGB(0,150,255)),
    ColorSequenceKeypoint.new(1,Color3.fromRGB(120,0,255)),
})
TitleGrad.Rotation=90
TitleGrad.Parent=TitleBar

local TitleLabel=Instance.new("TextLabel")
TitleLabel.Size=UDim2.new(1,-60,1,0)
TitleLabel.Position=UDim2.new(0,16,0,0)
TitleLabel.BackgroundTransparency=1
TitleLabel.TextColor3=Color3.fromRGB(255,255,255)
TitleLabel.TextScaled=true
TitleLabel.Font=Enum.Font.GothamBold
TitleLabel.Text="⚡ TrapLag v5.0"
TitleLabel.TextXAlignment=Enum.TextXAlignment.Left
TitleLabel.Parent=TitleBar

-- Close button
local CloseBtn=Instance.new("TextButton")
CloseBtn.Size=UDim2.new(0,36,0,36)
CloseBtn.Position=UDim2.new(1,-42,0,6)
CloseBtn.BackgroundColor3=Color3.fromRGB(255,50,50)
CloseBtn.BackgroundTransparency=0.3
CloseBtn.TextColor3=Color3.fromRGB(255,255,255)
CloseBtn.Font=Enum.Font.GothamBold
CloseBtn.TextScaled=true
CloseBtn.Text="✕"
CloseBtn.Parent=TitleBar
Instance.new("UICorner",CloseBtn).CornerRadius=UDim.new(0,8)
CloseBtn.MouseButton1Click:Connect(function() BG.Visible=false end)

-- Drag window
local dragging,dragStart,startPos
TitleBar.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then
        dragging=true dragStart=i.Position startPos=BG.Position end end)
TitleBar.InputChanged:Connect(function(i)
    if dragging and (i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMovement) then
        local d=i.Position-dragStart
        BG.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y) end end)
TitleBar.InputEnded:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end end)

-- Tab bar
local TabBar=Instance.new("Frame")
TabBar.Size=UDim2.new(1,-12,0,36)
TabBar.Position=UDim2.new(0,6,0,52)
TabBar.BackgroundTransparency=1
TabBar.Parent=BG

local TabLayout=Instance.new("UIListLayout")
TabLayout.FillDirection=Enum.FillDirection.Horizontal
TabLayout.Padding=UDim.new(0,4)
TabLayout.Parent=TabBar

-- Content area
local ContentArea=Instance.new("Frame")
ContentArea.Size=UDim2.new(1,-12,1,-100)
ContentArea.Position=UDim2.new(0,6,0,94)
ContentArea.BackgroundTransparency=1
ContentArea.ClipsDescendants=true
ContentArea.Parent=BG

-- Notification system
local NotifGui=Instance.new("Frame")
NotifGui.Size=UDim2.new(0,300,0,0)
NotifGui.Position=UDim2.new(0.5,-150,1,-10)
NotifGui.BackgroundTransparency=1
NotifGui.AnchorPoint=Vector2.new(0.5,1)
NotifGui.Parent=MainGui
local NotifLayout=Instance.new("UIListLayout")
NotifLayout.SortOrder=Enum.SortOrder.LayoutOrder
NotifLayout.Padding=UDim.new(0,4)
NotifLayout.VerticalAlignment=Enum.VerticalAlignment.Bottom
NotifLayout.Parent=NotifGui

local function notify(title,msg,duration)
    local nf=Instance.new("Frame")
    nf.Size=UDim2.new(1,0,0,54)
    nf.BackgroundColor3=Color3.fromRGB(15,15,30)
    nf.BackgroundTransparency=0.1
    nf.BorderSizePixel=0
    nf.Parent=NotifGui
    Instance.new("UICorner",nf).CornerRadius=UDim.new(0,10)
    local ns=Instance.new("UIStroke") ns.Color=Color3.fromRGB(0,200,255) ns.Thickness=1 ns.Parent=nf
    local nt=Instance.new("TextLabel") nt.Size=UDim2.new(1,-10,0,20) nt.Position=UDim2.new(0,8,0,4)
    nt.BackgroundTransparency=1 nt.TextColor3=Color3.fromRGB(0,200,255) nt.TextSize=13
    nt.Font=Enum.Font.GothamBold nt.Text=title nt.TextXAlignment=Enum.TextXAlignment.Left nt.Parent=nf
    local nm=Instance.new("TextLabel") nm.Size=UDim2.new(1,-10,0,22) nm.Position=UDim2.new(0,8,0,26)
    nm.BackgroundTransparency=1 nm.TextColor3=Color3.fromRGB(200,200,200) nm.TextSize=12
    nm.Font=Enum.Font.Gotham nm.TextWrapped=true nm.Text=msg nm.TextXAlignment=Enum.TextXAlignment.Left nm.Parent=nf
    task.delay(duration or 3,function()
        for i=0,10 do nf.BackgroundTransparency=0.1+(i*0.09) task.wait(0.04) end
        nf:Destroy()
    end)
end

-- ========================
-- TAB SYSTEM
-- ========================
local tabs={}
local activeTab=nil

local function createScrollFrame()
    local scroll=Instance.new("ScrollingFrame")
    scroll.Size=UDim2.new(1,0,1,0)
    scroll.BackgroundTransparency=1
    scroll.ScrollBarThickness=3
    scroll.ScrollBarImageColor3=Color3.fromRGB(0,180,255)
    scroll.CanvasSize=UDim2.new(0,0,0,0)
    scroll.AutomaticCanvasSize=Enum.AutomaticSize.Y
    scroll.BorderSizePixel=0
    local layout=Instance.new("UIListLayout")
    layout.Padding=UDim.new(0,6)
    layout.Parent=scroll
    local pad=Instance.new("UIPadding")
    pad.PaddingTop=UDim.new(0,4) pad.PaddingBottom=UDim.new(0,8)
    pad.PaddingLeft=UDim.new(0,2) pad.PaddingRight=UDim.new(0,2)
    pad.Parent=scroll
    return scroll
end

local function makeTabBtn(name,icon)
    local btn=Instance.new("TextButton")
    btn.Size=UDim2.new(0,0,1,0)
    btn.AutomaticSize=Enum.AutomaticSize.X
    btn.BackgroundColor3=Color3.fromRGB(20,20,40)
    btn.BackgroundTransparency=0.3
    btn.TextColor3=Color3.fromRGB(180,180,200)
    btn.Font=Enum.Font.GothamBold
    btn.TextSize=12
    btn.Text=" "..icon.." "..name.." "
    btn.BorderSizePixel=0
    btn.Parent=TabBar
    Instance.new("UICorner",btn).CornerRadius=UDim.new(0,8)
    return btn
end

local function addTab(name,icon)
    local btn=makeTabBtn(name,icon)
    local scroll=createScrollFrame()
    scroll.Visible=false
    scroll.Parent=ContentArea
    local t={btn=btn,scroll=scroll,name=name}
    table.insert(tabs,t)
    btn.MouseButton1Click:Connect(function()
        if activeTab then
            activeTab.btn.BackgroundColor3=Color3.fromRGB(20,20,40)
            activeTab.btn.BackgroundTransparency=0.3
            activeTab.btn.TextColor3=Color3.fromRGB(180,180,200)
            activeTab.scroll.Visible=false
        end
        activeTab=t
        btn.BackgroundColor3=Color3.fromRGB(0,150,255)
        btn.BackgroundTransparency=0.3
        btn.TextColor3=Color3.fromRGB(255,255,255)
        scroll.Visible=true
    end)
    return scroll
end

-- ========================
-- WIDGET HELPERS
-- ========================
local function makeSection(parent,title)
    local f=Instance.new("Frame")
    f.Size=UDim2.new(1,0,0,24)
    f.BackgroundTransparency=1
    f.Parent=parent
    local l=Instance.new("TextLabel")
    l.Size=UDim2.new(1,-8,1,0)
    l.Position=UDim2.new(0,8,0,0)
    l.BackgroundTransparency=1
    l.TextColor3=Color3.fromRGB(0,180,255)
    l.TextSize=12
    l.Font=Enum.Font.GothamBold
    l.Text=("— %s ——————————————"):format(title)
    l.TextXAlignment=Enum.TextXAlignment.Left
    l.Parent=f
    return f
end

local function makeCard(parent,h)
    local c=Instance.new("Frame")
    c.Size=UDim2.new(1,0,0,h or 44)
    c.BackgroundColor3=Color3.fromRGB(18,18,35)
    c.BackgroundTransparency=0.2
    c.BorderSizePixel=0
    c.Parent=parent
    Instance.new("UICorner",c).CornerRadius=UDim.new(0,10)
    local cs=Instance.new("UIStroke") cs.Color=Color3.fromRGB(40,40,80) cs.Thickness=1 cs.Parent=c
    return c
end

local function makeLabel(parent,text,x,y,w,h,size,color,bold,xalign)
    local l=Instance.new("TextLabel")
    l.Size=UDim2.new(w or 0.7,0,0,h or 18)
    l.Position=UDim2.new(x or 0,8,0,y or 6)
    l.BackgroundTransparency=1
    l.TextColor3=color or Color3.fromRGB(220,220,220)
    l.TextSize=size or 13
    l.Font=bold and Enum.Font.GothamBold or Enum.Font.Gotham
    l.Text=text
    l.TextXAlignment=xalign or Enum.TextXAlignment.Left
    l.TextTruncate=Enum.TextTruncate.AtEnd
    l.Parent=parent
    return l
end

local function makeToggle(parent,title,desc,default,callback)
    local card=makeCard(parent,54)
    makeLabel(card,title,0,6,0.75,16,13,Color3.fromRGB(230,230,230),true)
    makeLabel(card,desc,0,24,0.75,16,11,Color3.fromRGB(140,140,160))
    local state=default or false
    local bg=Instance.new("Frame")
    bg.Size=UDim2.new(0,44,0,24)
    bg.Position=UDim2.new(1,-52,0.5,-12)
    bg.BackgroundColor3=state and Color3.fromRGB(0,180,80) or Color3.fromRGB(60,60,80)
    bg.BorderSizePixel=0
    bg.Parent=card
    Instance.new("UICorner",bg).CornerRadius=UDim.new(1,0)
    local knob=Instance.new("Frame")
    knob.Size=UDim2.new(0,20,0,20)
    knob.Position=state and UDim2.new(1,-22,0.5,-10) or UDim2.new(0,2,0.5,-10)
    knob.BackgroundColor3=Color3.fromRGB(255,255,255)
    knob.BorderSizePixel=0
    knob.Parent=bg
    Instance.new("UICorner",knob).CornerRadius=UDim.new(1,0)
    local btn=Instance.new("TextButton")
    btn.Size=UDim2.new(1,0,1,0) btn.BackgroundTransparency=1 btn.Text="" btn.Parent=card
    btn.MouseButton1Click:Connect(function()
        state=not state
        bg.BackgroundColor3=state and Color3.fromRGB(0,180,80) or Color3.fromRGB(60,60,80)
        knob.Position=state and UDim2.new(1,-22,0.5,-10) or UDim2.new(0,2,0.5,-10)
        callback(state)
    end)
    return card
end

local function makeButton(parent,title,desc,callback)
    local card=makeCard(parent,54)
    makeLabel(card,title,0,6,0.8,16,13,Color3.fromRGB(230,230,230),true)
    makeLabel(card,desc,0,24,0.8,16,11,Color3.fromRGB(140,140,160))
    local btn=Instance.new("TextButton")
    btn.Size=UDim2.new(1,0,1,0) btn.BackgroundTransparency=1 btn.Text="" btn.Parent=card
    btn.MouseButton1Click:Connect(callback)
    -- ripple highlight
    btn.MouseButton1Down:Connect(function()
        card.BackgroundTransparency=0
        task.delay(0.1,function() card.BackgroundTransparency=0.2 end)
    end)
    return card
end

local function makeSlider(parent,title,desc,min,max,default,increment,callback)
    local card=makeCard(parent,68)
    makeLabel(card,title,0,4,0.7,16,13,Color3.fromRGB(230,230,230),true)
    makeLabel(card,desc,0,20,0.7,14,11,Color3.fromRGB(140,140,160))
    local valLabel=makeLabel(card,tostring(default),0.75,4,0.22,16,13,Color3.fromRGB(0,200,255),true,Enum.TextXAlignment.Right)
    local track=Instance.new("Frame")
    track.Size=UDim2.new(1,-16,0,6)
    track.Position=UDim2.new(0,8,0,46)
    track.BackgroundColor3=Color3.fromRGB(40,40,70)
    track.BorderSizePixel=0
    track.Parent=card
    Instance.new("UICorner",track).CornerRadius=UDim.new(1,0)
    local fill=Instance.new("Frame")
    fill.Size=UDim2.new((default-min)/(max-min),0,1,0)
    fill.BackgroundColor3=Color3.fromRGB(0,160,255)
    fill.BorderSizePixel=0
    fill.Parent=track
    Instance.new("UICorner",fill).CornerRadius=UDim.new(1,0)
    local knob=Instance.new("Frame")
    knob.Size=UDim2.new(0,16,0,16)
    knob.Position=UDim2.new((default-min)/(max-min),- 8,0.5,-8)
    knob.BackgroundColor3=Color3.fromRGB(255,255,255)
    knob.BorderSizePixel=0
    knob.Parent=track
    Instance.new("UICorner",knob).CornerRadius=UDim.new(1,0)
    local draggingSlider=false
    local function updateSlider(inputX)
        local rel=math.clamp((inputX-track.AbsolutePosition.X)/track.AbsoluteSize.X,0,1)
        local raw=min+rel*(max-min)
        local snapped=math.round(raw/increment)*increment
        snapped=math.clamp(snapped,min,max)
        local pct=(snapped-min)/(max-min)
        fill.Size=UDim2.new(pct,0,1,0)
        knob.Position=UDim2.new(pct,-8,0.5,-8)
        valLabel.Text=tostring(snapped)
        callback(snapped)
    end
    knob.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then draggingSlider=true end end)
    UIS.InputChanged:Connect(function(i)
        if draggingSlider and (i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMovement) then
            updateSlider(i.Position.X) end end)
    UIS.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then draggingSlider=false end end)
    track.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then updateSlider(i.Position.X) end end)
    return card
end

local function makeInput(parent,title,placeholder,callback)
    local card=makeCard(parent,64)
    makeLabel(card,title,0,4,1,-8,13,Color3.fromRGB(230,230,230),true)
    local box=Instance.new("TextBox")
    box.Size=UDim2.new(1,-16,0,32)
    box.Position=UDim2.new(0,8,0,26)
    box.BackgroundColor3=Color3.fromRGB(25,25,50)
    box.TextColor3=Color3.fromRGB(220,220,220)
    box.PlaceholderText=placeholder or ""
    box.PlaceholderColor3=Color3.fromRGB(100,100,120)
    box.Font=Enum.Font.Gotham
    box.TextSize=13
    box.ClearTextOnFocus=false
    box.BorderSizePixel=0
    box.Parent=card
    Instance.new("UICorner",box).CornerRadius=UDim.new(0,8)
    Instance.new("UIStroke",box).Color=Color3.fromRGB(0,150,255)
    local pad=Instance.new("UIPadding") pad.PaddingLeft=UDim.new(0,8) pad.Parent=box
    box.FocusLost:Connect(function(enter) if enter then callback(box.Text) end end)
    return card,box
end

-- ========================
-- BUILD TABS
-- ========================
local lagScroll   = addTab("Anti Lag","⚡")
local shadeScroll = addTab("Shader","✨")
local bsScroll    = addTab("BloxStrap","🔧")
local soundScroll = addTab("Sound","🎵")
local chatScroll  = addTab("Chat","💬")
local cfgScroll   = addTab("Config","⚙️")

-- Open first tab
tabs[1].btn:SimulateClick() -- auto trigger

-- ========================
-- TAB: ANTI LAG
-- ========================
makeSection(lagScroll,"Player Config")
makeSlider(lagScroll,"Camera Sensitivity","Sensitivitas kamera (1-100)",1,100,playerConfig.cameraSensitivity,1,function(v)
    playerConfig.cameraSensitivity=v applyCamera() saveConfig() end)
makeSlider(lagScroll,"Walk Speed","Kecepatan berjalan (8-100)",8,100,playerConfig.walkSpeed,1,function(v)
    playerConfig.walkSpeed=v applyWalkSpeed() saveConfig() end)
makeSlider(lagScroll,"Jump Power","Tinggi lompatan (10-200)",10,200,playerConfig.jumpPower,5,function(v)
    playerConfig.jumpPower=v applyJumpPower() saveConfig() end)
makeToggle(lagScroll,"Infinite Jump","Lompat terus tanpa batas",playerConfig.infiniteJump,function(s)
    playerConfig.infiniteJump=s saveConfig() if s then startInfJump() else stopInfJump() end end)
makeToggle(lagScroll,"Anti-AFK","Cegah kick karena AFK",playerConfig.antiAfk,function(s)
    playerConfig.antiAfk=s saveConfig() if s then startAntiAfk() else stopAntiAfk() end end)

makeSection(lagScroll,"FPS & Render")
makeSlider(lagScroll,"FPS Target","Target FPS Unlocker (30-240)",30,240,playerConfig.fpsTarget,10,function(v)
    playerConfig.fpsTarget=v saveConfig() end)
makeButton(lagScroll,"🔓 FPS Unlocker","Unlock FPS ke target yang dipilih",function()
    applyFPS() notify("TrapLag","FPS di-unlock ke "..playerConfig.fpsTarget.."!",3) end)
makeButton(lagScroll,"🔋 Cap FPS 60","Batasi FPS ke 60 untuk hemat baterai",function()
    setfpscap(60) notify("TrapLag","FPS di-cap ke 60!",3) end)
makeToggle(lagScroll,"Reduce Render Distance","Kurangi jarak render objek",playerConfig.reduceRender,function(s)
    playerConfig.reduceRender=s applyRender() saveConfig() end)

makeSection(lagScroll,"Visual")
makeToggle(lagScroll,"Disable Shadows","Matikan shadow untuk boost FPS",playerConfig.disableShadows,function(s)
    playerConfig.disableShadows=s applyShadows() saveConfig()
    notify("TrapLag",s and "Shadows dimatikan!" or "Shadows dinyalakan!",2) end)
makeToggle(lagScroll,"Disable Atmosphere","Hapus fog & atmosphere",playerConfig.disableAtmosphere,function(s)
    playerConfig.disableAtmosphere=s applyAtmosphere() saveConfig() end)
makeToggle(lagScroll,"Disable PostFX","Hapus blur, bloom, color correction",playerConfig.disablePostFX,function(s)
    playerConfig.disablePostFX=s applyPostFX() saveConfig() end)
makeToggle(lagScroll,"Fullbright","Terangkan semua area gelap",playerConfig.fullbright,function(s)
    playerConfig.fullbright=s applyFullbright() saveConfig() end)
makeButton(lagScroll,"📉 Low Texture Quality","Set tekstur ke kualitas terendah",function()
    settings().Rendering.QualityLevel=Enum.QualityLevel.Level01
    notify("TrapLag","Texture quality diturunkan!",3) end)

makeSection(lagScroll,"Player")
makeToggle(lagScroll,"Disable Particles","Matikan semua efek partikel",playerConfig.disableParticles,function(s)
    playerConfig.disableParticles=s applyParticles() saveConfig() end)
makeToggle(lagScroll,"Hide Accessories","Sembunyikan aksesoris semua player",playerConfig.hideAccessories,function(s)
    playerConfig.hideAccessories=s applyAccessories() saveConfig() end)
makeToggle(lagScroll,"Disable Animations","Hentikan animasi semua player",playerConfig.disableAnimations,function(s)
    playerConfig.disableAnimations=s applyAnimations() saveConfig() end)
makeToggle(lagScroll,"Disable Sound","Matikan semua suara game",playerConfig.disableSound,function(s)
    playerConfig.disableSound=s applySound() saveConfig() end)

makeSection(lagScroll,"Quick Actions")
makeButton(lagScroll,"⚡ Full Anti Lag","Aktifkan SEMUA fitur anti-lag sekaligus",function()
    playerConfig.disableShadows=true playerConfig.disableAtmosphere=true
    playerConfig.disablePostFX=true playerConfig.disableParticles=true playerConfig.reduceRender=true
    applyFPS() applyShadows() applyAtmosphere() applyPostFX() applyParticles() applyRender() saveConfig()
    notify("TrapLag ⚡","Semua fitur anti-lag aktif!",4) end)
makeButton(lagScroll,"🔄 Reset All","Kembalikan semua ke default",function()
    playerConfig.disableShadows=false playerConfig.disableAtmosphere=false
    playerConfig.disablePostFX=false playerConfig.disableParticles=false
    playerConfig.reduceRender=false playerConfig.disableSound=false
    playerConfig.hideAccessories=false playerConfig.disableAnimations=false
    playerConfig.fullbright=false playerConfig.walkSpeed=16
    playerConfig.jumpPower=50 playerConfig.infiniteJump=false
    applyAllConfig() stopAntiAfk() stopInfJump() saveConfig()
    notify("TrapLag","Semua pengaturan direset!",3) end)

-- ========================
-- TAB: BLOXSHADER
-- ========================
makeSection(shadeScroll,"PShade Ultimate")
makeButton(shadeScroll,"🎨 Load PShade Ultimate","Load shader lengkap dari PShade Ultimate",function()
    notify("BloxShader","Loading PShade Ultimate...",3)
    task.spawn(function()
        local ok,err=pcall(function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/randomstring0/pshade-ultimate/refs/heads/main/src/cd.lua'))()
        end)
        if not ok then notify("❌ Error",tostring(err):sub(1,60),5) end
    end)
end)

makeSection(shadeScroll,"Presets")
makeToggle(shadeScroll,"🎬 Cinematic Mode","DOF + Color Grade sinematik",false,function(s)
    local dof=Lighting:FindFirstChildOfClass("DepthOfFieldEffect")or Instance.new("DepthOfFieldEffect",Lighting)
    dof.Enabled=s dof.FarIntensity=s and 0.5 or 0 dof.NearIntensity=s and 0.3 or 0 dof.FocusDistance=s and 50 or 0
    local cc=Lighting:FindFirstChildOfClass("ColorCorrectionEffect")or Instance.new("ColorCorrectionEffect",Lighting)
    cc.Enabled=s cc.Contrast=s and 0.2 or 0 cc.TintColor=s and Color3.fromRGB(200,210,255) or Color3.fromRGB(255,255,255) end)
makeToggle(shadeScroll,"🌅 Golden Hour","Nuansa senja hangat",false,function(s)
    local cc=Lighting:FindFirstChildOfClass("ColorCorrectionEffect")or Instance.new("ColorCorrectionEffect",Lighting)
    cc.Enabled=s cc.Saturation=s and 0.3 or 0 cc.TintColor=s and Color3.fromRGB(255,210,160) or Color3.fromRGB(255,255,255)
    if s then Lighting.Ambient=Color3.fromRGB(255,180,100) Lighting.TimeOfDay="17:30:00"
    else Lighting.Ambient=Color3.fromRGB(70,70,70) end end)
makeToggle(shadeScroll,"🌙 Night Mode","Suasana malam gelap misterius",false,function(s)
    if s then Lighting.TimeOfDay="00:00:00" Lighting.Ambient=Color3.fromRGB(20,20,40) Lighting.Brightness=0.5
    else Lighting.TimeOfDay="14:00:00" Lighting.Ambient=Color3.fromRGB(70,70,70) Lighting.Brightness=2 end end)
makeToggle(shadeScroll,"📼 Retro VHS","Efek warna retro tahun 80an",false,function(s)
    local cc=Lighting:FindFirstChildOfClass("ColorCorrectionEffect")or Instance.new("ColorCorrectionEffect",Lighting)
    cc.Enabled=s cc.Saturation=s and -0.4 or 0
    local blur=Lighting:FindFirstChildOfClass("BlurEffect")or Instance.new("BlurEffect",Lighting)
    blur.Enabled=s blur.Size=s and 4 or 0 end)
makeToggle(shadeScroll,"🌆 Neon City","Cyberpunk neon biru-ungu",false,function(s)
    local cc=Lighting:FindFirstChildOfClass("ColorCorrectionEffect")or Instance.new("ColorCorrectionEffect",Lighting)
    cc.Enabled=s cc.Saturation=s and 0.5 or 0 cc.TintColor=s and Color3.fromRGB(160,180,255) or Color3.fromRGB(255,255,255)
    if s then Lighting.Ambient=Color3.fromRGB(60,0,120) Lighting.TimeOfDay="22:00:00"
    else Lighting.Ambient=Color3.fromRGB(70,70,70) end end)
makeToggle(shadeScroll,"✨ Enhanced Bloom","Efek bloom kuat dan indah",false,function(s)
    local b=Lighting:FindFirstChildOfClass("BloomEffect")or Instance.new("BloomEffect",Lighting)
    b.Enabled=s b.Intensity=s and 1.2 or 0.5 b.Size=s and 30 or 24 b.Threshold=s and 0.8 or 0.95 end)
makeToggle(shadeScroll,"👻 Horror Mode","Suasana gelap mencekam",false,function(s)
    if s then
        Lighting.TimeOfDay="23:00:00" Lighting.Ambient=Color3.fromRGB(5,0,10)
        Lighting.Brightness=0.2
        local cc=Lighting:FindFirstChildOfClass("ColorCorrectionEffect")or Instance.new("ColorCorrectionEffect",Lighting)
        cc.Enabled=true cc.Saturation=-0.8 cc.Contrast=0.5 cc.TintColor=Color3.fromRGB(180,100,100)
    else Lighting.TimeOfDay="14:00:00" Lighting.Ambient=Color3.fromRGB(70,70,70) Lighting.Brightness=2 end end)
makeButton(shadeScroll,"🔄 Reset Semua Shader","Kembalikan Lighting ke default",function()
    Lighting.Ambient=Color3.fromRGB(70,70,70) Lighting.OutdoorAmbient=Color3.fromRGB(128,128,128)
    Lighting.Brightness=2 Lighting.TimeOfDay="14:00:00"
    for _,e in ipairs(Lighting:GetChildren()) do
        if e:IsA("BlurEffect")or e:IsA("BloomEffect")or e:IsA("ColorCorrectionEffect")
        or e:IsA("SunRaysEffect")or e:IsA("DepthOfFieldEffect") then e.Enabled=false end
    end
    notify("BloxShader","Semua shader direset!",3) end)

-- ========================
-- TAB: BLOXSTRAP
-- ========================
makeSection(bsScroll,"Mode BloxStrap")
makeButton(bsScroll,"🚀 Load BloxStrap Mobile","Load script BloxStrap mobile langsung",function()
    notify("BloxStrap","Loading BloxStrap Mobile...",3)
    task.spawn(function()
        local ok,err=pcall(function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-bloxstrap-mobile-71282"))()
        end)
        if not ok then notify("❌ Error",tostring(err):sub(1,60),5) end
    end)
end)

local bsEnabled=playerConfig.bloxstrapEnabled
makeToggle(bsScroll,"⚡ Enable BloxStrap Mode","Unlock semua fitur BloxStrap",bsEnabled,function(state)
    if state then
        showBsWarning(function()
            bloxstrapActive=true playerConfig.bloxstrapEnabled=true saveConfig()
            createFpsGui() startFpsCounter()
            notify("BloxStrap ✅","Mode BloxStrap aktif!",4)
        end,function()
            bloxstrapActive=false notify("BloxStrap","Dibatalkan.",2)
        end)
    else
        bloxstrapActive=false playerConfig.bloxstrapEnabled=false saveConfig()
        stopFpsCounter() clearGhost()
        notify("BloxStrap","Mode dimatikan.",3)
    end
end)

makeSection(bsScroll,"FPS Monitor")
makeToggle(bsScroll,"📊 FPS Counter + Ping","Tampilkan FPS & Ping (draggable)",false,function(s)
    if not bloxstrapActive then notify("🔒 Locked","Enable BloxStrap Mode dulu!",3) return end
    if s then createFpsGui() startFpsCounter() else stopFpsCounter() clearGhost() end end)
makeToggle(bsScroll,"🟢 Real FPS Ghost","Ghost part server di badan kamu (rotasi penuh)",false,function(s)
    if not bloxstrapActive then notify("🔒 Locked","Enable BloxStrap Mode dulu!",3) return end
    if s then
        if not fpsGui then createFpsGui() startFpsCounter() end
        if LP.Character then makeGhost(LP.Character,Color3.fromRGB(0,255,80)) end
        if detailLabel then detailLabel.Parent.Visible=true end
    else clearGhost() end end)
makeToggle(bsScroll,"🔵 POV Player Lain","Lihat ghost server player lain + masuk POV",false,function(s)
    if not bloxstrapActive then notify("🔒 Locked","Enable BloxStrap Mode dulu!",3) return end
    if s then
        local target=nil
        for _,p in ipairs(Players:GetPlayers()) do if p~=LP then target=p break end end
        if not target then notify("Real FPS","Tidak ada player lain!",3) return end
        if not fpsGui then createFpsGui() startFpsCounter() end
        makeGhost(target.Character or target.CharacterAdded:Wait(), Color3.fromRGB(80,200,255))
        pcall(function() Camera.CameraSubject=target.Character:FindFirstChildOfClass("Humanoid") end)
        -- Exit POV button
        local xg=Instance.new("ScreenGui") xg.Name="PovExit" xg.ResetOnSpawn=false xg.Parent=LP.PlayerGui
        local xb=Instance.new("TextButton") xb.Size=UDim2.new(0,90,0,36) xb.Position=UDim2.new(0.5,-45,0,60)
        xb.BackgroundColor3=Color3.fromRGB(200,40,40) xb.TextColor3=Color3.fromRGB(255,255,255)
        xb.Font=Enum.Font.GothamBold xb.TextScaled=true xb.Text="✕ Exit POV" xb.Parent=xg
        Instance.new("UICorner",xb).CornerRadius=UDim.new(0,8)
        xb.MouseButton1Click:Connect(function()
            clearGhost()
            pcall(function() if LP.Character then Camera.CameraSubject=LP.Character:FindFirstChildOfClass("Humanoid") end end)
            xg:Destroy()
        end)
    else
        clearGhost()
        pcall(function() if LP.Character then Camera.CameraSubject=LP.Character:FindFirstChildOfClass("Humanoid") end end)
    end end)

makeSection(bsScroll,"FFlag & Graphics")
makeButton(bsScroll,"📋 Load FFlags dari File","Baca TrapLag/config/BloxStrap/fflags.json",function()
    if not bloxstrapActive then notify("🔒 Locked","Enable BloxStrap Mode dulu!",3) return end
    local path="TrapLag/config/BloxStrap/fflags.json"
    if not isfile(path) then
        writefile(path,HS:JSONEncode({["DFIntTaskSchedulerTargetFps"]=240,["FFlagDisablePostFx"]=false}))
        notify("FFlags","Template dibuat! Edit lalu load lagi.",5) return
    end
    local ok,data=pcall(function() return HS:JSONDecode(readfile(path)) end)
    if ok and data then
        local n=0 for _ in pairs(data) do n+=1 end
        notify("FFlags ✅",n.." flag ditemukan & loaded!",4)
    else notify("❌ Error","JSON tidak valid!",4) end end)
makeSlider(bsScroll,"Render Quality","Kualitas render Roblox (1-10)",1,10,5,1,function(v)
    if not bloxstrapActive then return end
    local lvl={Enum.QualityLevel.Level01,Enum.QualityLevel.Level02,Enum.QualityLevel.Level03,
        Enum.QualityLevel.Level04,Enum.QualityLevel.Level05,Enum.QualityLevel.Level06,
        Enum.QualityLevel.Level07,Enum.QualityLevel.Level08,Enum.QualityLevel.Level09,Enum.QualityLevel.Level10}
    settings().Rendering.QualityLevel=lvl[v] or Enum.QualityLevel.Level05 end)
makeSlider(bsScroll,"Lighting Brightness","Intensitas cahaya global (0-5)",0,5,2,1,function(v)
    if not bloxstrapActive then return end
    Lighting.Brightness=v end)

-- ========================
-- TAB: SOUND
-- ========================
local currentSoundTitle="(none)"

makeSection(soundScroll,"Controls")
makeToggle(soundScroll,"🔁 Loop","Putar ulang otomatis setelah selesai",false,function(s)
    soundLooping=s
    if currentSound then currentSound.Looped=s end
    notify("Sound","Loop: "..(s and "ON" or "OFF"),2) end)
makeSlider(soundScroll,"🔊 Volume","Atur kekerasan suara (0-100)",0,100,50,1,function(v)
    soundVolume=v/100
    if currentSound then currentSound.Volume=soundVolume end end)

makeSection(soundScroll,"Playlist dari File")
makeButton(soundScroll,"📂 Load Playlist","Buka TrapLag/config/sound/sounds.json",function()
    local list=getSoundList()
    if #list==0 then notify("Sound","Playlist kosong!",3) return end
    -- Tampilkan daftar judul
    local titles={}
    for _,s in ipairs(list) do table.insert(titles,s.Title or "?") end
    notify("Playlist ("..#list.." lagu)",table.concat(titles,", "),5)
end)

makeButton(soundScroll,"▶ Play dari Playlist","Play lagu pertama dari sounds.json",function()
    local list=getSoundList()
    if #list==0 then notify("Sound","Playlist kosong! Tambah dulu.",4) return end
    local s=list[1]
    currentSoundTitle=s.Title or "Untitled"
    playSound(s.SOUNDID or s["SOUND ID"] or "0")
    notify("▶ Playing",currentSoundTitle,3)
end)

makeButton(soundScroll,"⏹ Stop","Hentikan suara yang sedang bermain",function()
    stopSound() notify("Sound","Dihentikan.",2) end)

makeSection(soundScroll,"Custom Sound ID")
local _,sidInput=makeInput(soundScroll,"🎵 Sound ID Custom","Paste Sound ID dari Roblox...",function(v) end)
makeButton(soundScroll,"▶ Play Custom ID","Play sound ID yang diinput di atas",function()
    local id=sidInput.Text:gsub("[^%d]","")
    if id=="" then notify("Sound","ID kosong! Isi dulu.",3) return end
    playSound(id)
    notify("▶ Playing","Sound ID: "..id,3)
end)
makeButton(soundScroll,"💾 Simpan ke Playlist","Tambah ID ini ke sounds.json",function()
    local id=sidInput.Text:gsub("[^%d]","")
    if id=="" then notify("Sound","ID kosong!",3) return end
    local path="TrapLag/config/sound/sounds.json"
    local list=getSoundList()
    table.insert(list,{Title="Custom - "..id, SOUNDID=id})
    writefile(path,HS:JSONEncode(list))
    notify("Sound ✅","Sound ID disimpan ke playlist!",3)
end)

-- ========================
-- TAB: GLOBAL CHAT
-- ========================
local chatLog

makeSection(chatScroll,"Global Chat")

-- Chat log box
local chatCard=makeCard(chatScroll,220)
chatLog=Instance.new("ScrollingFrame")
chatLog.Size=UDim2.new(1,-10,1,-10)
chatLog.Position=UDim2.new(0,5,0,5)
chatLog.BackgroundTransparency=1
chatLog.ScrollBarThickness=3
chatLog.ScrollBarImageColor3=Color3.fromRGB(0,180,255)
chatLog.AutomaticCanvasSize=Enum.AutomaticSize.Y
chatLog.CanvasSize=UDim2.new(0,0,0,0)
chatLog.BorderSizePixel=0
chatLog.Parent=chatCard
local chatLayout=Instance.new("UIListLayout")
chatLayout.Padding=UDim.new(0,3)
chatLayout.Parent=chatLog

local function addChatLine(username,message,color)
    local f=Instance.new("Frame")
    f.Size=UDim2.new(1,0,0,0)
    f.AutomaticSize=Enum.AutomaticSize.Y
    f.BackgroundTransparency=1
    f.Parent=chatLog
    local l=Instance.new("TextLabel")
    l.Size=UDim2.new(1,-4,0,0)
    l.Position=UDim2.new(0,2,0,0)
    l.AutomaticSize=Enum.AutomaticSize.Y
    l.BackgroundTransparency=1
    l.TextColor3=Color3.fromRGB(200,200,200)
    l.RichText=true
    l.TextSize=12
    l.Font=Enum.Font.Gotham
    l.TextXAlignment=Enum.TextXAlignment.Left
    l.TextWrapped=true
    local hexColor=color or "#00ffcc"
    l.Text=string.format('<font color="%s"><b>%s</b></font>: %s',hexColor,username,message)
    l.Parent=f
    -- auto scroll ke bawah
    task.defer(function()
        chatLog.CanvasPosition=Vector2.new(0,chatLog.AbsoluteCanvasSize.Y)
    end)
end

-- Input + send
local _,chatInput=makeInput(chatScroll,"💬 Kirim Pesan","Tulis pesan...",function(v) end)
makeButton(chatScroll,"📤 Kirim","Kirim pesan ke semua server",function()
    local msg=chatInput.Text
    if msg=="" then notify("Chat","Pesan kosong!",2) return end
    chatInput.Text=""
    local filtered=filterText(msg)
    sendChatMessage(filtered)
    addChatLine(LP.DisplayName or LP.Name,filtered,playerConfig.chatColor)
end)

makeSection(chatScroll,"Chat Settings")
makeToggle(chatScroll,"🤖 Filter Kata Kasar","Ganti kata kasar dengan kata positif",true,function(s)
    notify("Filter",s and "Filter aktif!" or "Filter dimatikan.",2) end)

local _,colorInput=makeInput(chatScroll,"🎨 Warna Chat (hex)","contoh: #00ffcc",function(v)
    if v:match("^#%x%x%x%x%x%x$") then
        playerConfig.chatColor=v saveConfig()
        notify("Chat","Warna diubah ke "..v,2)
    end
end)
colorInput.Text=playerConfig.chatColor

-- Poll messages
local lastIds={}
chatPollConn=RS.Heartbeat:Connect(function()
    -- poll tiap 2 detik
end)

task.spawn(function()
    while true do
        task.wait(2)
        fetchMessages(function(data)
            if not data then return end
            for _,msg in ipairs(data) do
                if not lastIds[tostring(msg.id)] then
                    lastIds[tostring(msg.id)]=true
                    -- skip pesan sendiri (sudah ditampilkan)
                    local isOwn=(msg.username==(LP.DisplayName or LP.Name))
                    if not isOwn then
                        addChatLine(msg.username,msg.message,msg.color)
                    end
                end
            end
        end)
    end
end)

-- ========================
-- TAB: CONFIG
-- ========================
makeSection(cfgScroll,"Export & Import")
makeButton(cfgScroll,"📤 Export Config","Generate kode → TrapLag/export.txt",function()
    local code=exportConfig()
    notify("Exported! ✅","export.txt tersimpan\n"..code:sub(1,30).."...",5) end)
makeButton(cfgScroll,"📋 Copy Kode","Copy kode ke clipboard",function()
    if isfile("TrapLag/export.txt") then
        setclipboard(readfile("TrapLag/export.txt"))
        notify("Copied! ✅","Kode berhasil dicopy!",3)
    else notify("Export dulu!","Klik Export Config terlebih dahulu.",3) end end)
makeButton(cfgScroll,"📥 Import Config","Paste kode di TrapLag/import.txt lalu klik",function()
    if not isfile("TrapLag/import.txt") then
        writefile("TrapLag/import.txt","")
        notify("Import","import.txt dibuat! Paste kode lalu klik Import lagi.",5) return
    end
    local code=readfile("TrapLag/import.txt"):gsub("%s+","")
    if code=="" then notify("Import","import.txt kosong!",4) return end
    local ok,reason=importConfig(code)
    if ok then notify("Import Berhasil! ✅","Config berhasil diload & diapply!",4) writefile("TrapLag/import.txt","")
    elseif reason=="expired" then notify("❌ Kode Expired!","Kode dari versi lama TrapLag.",5)
    else notify("❌ Tidak Valid","Kode salah atau rusak.",5) end end)

makeSection(cfgScroll,"Files")
makeButton(cfgScroll,"🔍 Cek Logo","Cek TrapLag/logo.png",function()
    notify("Logo",isfile("TrapLag/logo.png") and "logo.png ditemukan! ✅" or "Belum ada! Taruh di TrapLag/",3) end)
makeButton(cfgScroll,"🔤 Cek Fonts","List font di config/fonts/",function()
    local files=listfiles("TrapLag/config/fonts")
    local names={}
    for _,f in ipairs(files) do if f:match("%.json$") then table.insert(names,f:match("([^/\\]+)%.json$")or f) end end
    notify("Fonts",#names>0 and table.concat(names,", ") or "Belum ada font!",5) end)
makeButton(cfgScroll,"🎯 Cek Crosshair","List crosshair di config/crosshair/",function()
    local files=listfiles("TrapLag/config/crosshair")
    local names={}
    for _,f in ipairs(files) do if f:match("%.png$") then table.insert(names,f:match("([^/\\]+)$")or f) end end
    notify("Crosshair",#names>0 and table.concat(names,", ") or "Belum ada crosshair!",5) end)

-- ========================
-- OPEN BUTTON (saat GUI ditutup)
-- ========================
local openBtn=Instance.new("TextButton")
openBtn.Size=UDim2.new(0,44,0,44)
openBtn.Position=UDim2.new(0,10,0.5,-22)
openBtn.BackgroundColor3=Color3.fromRGB(0,150,255)
openBtn.BackgroundTransparency=0.2
openBtn.TextColor3=Color3.fromRGB(255,255,255)
openBtn.Font=Enum.Font.GothamBold
openBtn.TextScaled=true
openBtn.Text="⚡"
openBtn.ZIndex=10
openBtn.Parent=MainGui
Instance.new("UICorner",openBtn).CornerRadius=UDim.new(1,0)
openBtn.MouseButton1Click:Connect(function() BG.Visible=not BG.Visible end)

-- ========================
-- STARTUP
-- ========================
loadConfig()
saveConfig()
applyAllConfig()
if playerConfig.antiAfk then startAntiAfk() end
if playerConfig.infiniteJump then startInfJump() end
if playerConfig.bloxstrapEnabled then
    bloxstrapActive=true createFpsGui() startFpsCounter()
end

notify("TrapLag v5.0 ✅","GUI custom loaded! Klik ⚡ untuk buka/tutup.",4)

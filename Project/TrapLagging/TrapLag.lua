-- ╔══════════════════════════════════════╗
-- ║         TrapLag v3.0                 ║
-- ║  Anti-Lag · Shader · BloxStrap       ║
-- ║         UI: WindUI                   ║
-- ╚══════════════════════════════════════╝

local VERSION = "TL30"
local RS      = game:GetService("RunService")
local HS      = game:GetService("HttpService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

-- ========================
-- BASE64
-- ========================
local b64chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
local function b64encode(data)
    local result, padding = {}, ""
    data = tostring(data)
    if #data%3==1 then data=data.."\0\0" padding="==" elseif #data%3==2 then data=data.."\0" padding="=" end
    for i=1,#data,3 do
        local a,b,c=data:byte(i,i+2)
        result[#result+1]=b64chars:sub(math.floor(a/4)+1,math.floor(a/4)+1)
            ..b64chars:sub((a%4)*16+math.floor(b/16)+1,(a%4)*16+math.floor(b/16)+1)
            ..b64chars:sub((b%16)*4+math.floor(c/64)+1,(b%16)*4+math.floor(c/64)+1)
            ..b64chars:sub(c%64+1,c%64+1)
    end
    local enc=table.concat(result)
    if padding~="" then enc=enc:sub(1,-(#padding+1))..padding end
    return enc
end
local function b64decode(data)
    local lookup={}
    for i=1,#b64chars do lookup[b64chars:sub(i,i)]=i-1 end
    data=data:gsub("[^%w+/=]","")
    local result={}
    for i=1,#data,4 do
        local a=lookup[data:sub(i,i)]or 0
        local b=lookup[data:sub(i+1,i+1)]or 0
        local c=lookup[data:sub(i+2,i+2)]or 0
        local d=lookup[data:sub(i+3,i+3)]or 0
        result[#result+1]=string.char(a*4+math.floor(b/16),(b%16)*16+math.floor(c/4),(c%4)*64+d)
    end
    return table.concat(result):gsub("\0+$","")
end

-- ========================
-- PLAYER CONFIG
-- ========================
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
    bloxstrapEnabled  = false,
}

local function saveConfig()
    if not isfolder("TrapLag/config") then makefolder("TrapLag/config") end
    if not isfolder("TrapLag/config/player") then makefolder("TrapLag/config/player") end
    if not isfolder("TrapLag/config/fonts") then makefolder("TrapLag/config/fonts") end
    if not isfolder("TrapLag/config/crosshair") then makefolder("TrapLag/config/crosshair") end
    if not isfolder("TrapLag/config/image") then makefolder("TrapLag/config/image") end
    if not isfolder("TrapLag/config/BloxStrap") then makefolder("TrapLag/config/BloxStrap") end
    writefile(configPath, HS:JSONEncode(playerConfig))
end

local function loadConfig()
    if isfile(configPath) then
        local ok,data=pcall(function() return HS:JSONDecode(readfile(configPath)) end)
        if ok and data then
            for k,v in pairs(data) do
                if playerConfig[k]~=nil then playerConfig[k]=v end
            end
        end
    end
end

-- ========================
-- APPLY FUNCTIONS
-- ========================
local function applyCamera()
    pcall(function() UserSettings():GetService("UserGameSettings").MouseSensitivity=playerConfig.cameraSensitivity end)
end
local function applyShadows()
    Lighting.GlobalShadows = not playerConfig.disableShadows
end
local function applyAtmosphere()
    local atm=Lighting:FindFirstChildOfClass("Atmosphere")
    if atm then atm.Density=playerConfig.disableAtmosphere and 0 or 0.395 atm.Offset=playerConfig.disableAtmosphere and 0 or 0.25 end
    Lighting.FogEnd=playerConfig.disableAtmosphere and 9e9 or 100000
end
local function applyPostFX()
    for _,e in ipairs(Lighting:GetChildren()) do
        if e:IsA("BlurEffect")or e:IsA("BloomEffect")or e:IsA("ColorCorrectionEffect")or e:IsA("SunRaysEffect")or e:IsA("DepthOfFieldEffect") then
            e.Enabled=not playerConfig.disablePostFX
        end
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
                if v:IsA("Accessory") then v.Handle.Transparency=playerConfig.hideAccessories and 1 or 0 end
            end
        end
    end
end
local function applyAnimations()
    if playerConfig.disableAnimations then
        for _,player in ipairs(Players:GetPlayers()) do
            if player.Character then
                local hum=player.Character:FindFirstChildOfClass("Humanoid")
                if hum then
                    local anim=hum:FindFirstChildOfClass("Animator")
                    if anim then pcall(function() for _,t in ipairs(anim:GetPlayingAnimationTracks()) do t:Stop() end end) end
                end
            end
        end
    end
end
local function applySound()
    for _,v in ipairs(workspace:GetDescendants()) do
        if v:IsA("Sound") then v.Volume=playerConfig.disableSound and 0 or 1 end
    end
    for _,v in ipairs(game:GetService("SoundService"):GetDescendants()) do
        if v:IsA("Sound") then v.Volume=playerConfig.disableSound and 0 or 1 end
    end
end
local function applyRender()
    settings().Rendering.QualityLevel=playerConfig.reduceRender and Enum.QualityLevel.Level01 or Enum.QualityLevel.Automatic
end
local function applyFPS() setfpscap(playerConfig.fpsTarget) end
local function applyAllConfig()
    applyCamera() applyShadows() applyAtmosphere() applyPostFX()
    applyParticles() applyAccessories() applyAnimations() applySound() applyRender()
end

-- ========================
-- EXPORT / IMPORT
-- ========================
local function exportConfig()
    local code=VERSION..":"..b64encode(HS:JSONEncode(playerConfig))
    writefile("TrapLag/export.txt",code)
    return code
end
local function importConfig(code)
    local prefix=code:match("^([^:]+):")
    if prefix~=VERSION then return false,"expired" end
    local encoded=code:match("^[^:]+:(.+)$")
    if not encoded then return false,"invalid" end
    local ok,data=pcall(function() return HS:JSONDecode(b64decode(encoded)) end)
    if not ok or not data then return false,"invalid" end
    for k,v in pairs(data) do if playerConfig[k]~=nil then playerConfig[k]=v end end
    saveConfig() applyAllConfig()
    return true,"ok"
end

-- ========================
-- STARTUP
-- ========================
loadConfig()
saveConfig()
applyAllConfig()

-- ========================
-- FPS COUNTER SYSTEM
-- ========================
local fpsGui, fpsLabel, detailLabel, ghostPart
local clientFPS, serverFPS, renderFPS, moveFPS, animFPS = 60, 60, 60, 60, 60
local fpsConn, realFpsConn, ghostConn

local function createFpsGui()
    if fpsGui then fpsGui:Destroy() end
    fpsGui = Instance.new("ScreenGui")
    fpsGui.Name = "TrapLagFPS"
    fpsGui.ResetOnSpawn = false
    fpsGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    fpsGui.Parent = LocalPlayer.PlayerGui

    -- FPS Label (kanan atas) - bisa drag
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 160, 0, 30)
    frame.Position = UDim2.new(1, -170, 0, 10)
    frame.BackgroundColor3 = Color3.fromRGB(0,0,0)
    frame.BackgroundTransparency = 0.4
    frame.BorderSizePixel = 0
    frame.Parent = fpsGui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0,6)

    fpsLabel = Instance.new("TextLabel")
    fpsLabel.Size = UDim2.new(1,0,1,0)
    fpsLabel.BackgroundTransparency = 1
    fpsLabel.TextColor3 = Color3.fromRGB(80,255,80)
    fpsLabel.TextScaled = true
    fpsLabel.Font = Enum.Font.GothamBold
    fpsLabel.Text = "FPS: --"
    fpsLabel.Parent = frame

    -- Drag support
    local dragging, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)
    frame.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset+delta.X, startPos.Y.Scale, startPos.Y.Offset+delta.Y)
        end
    end)
    frame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    -- Detail Label (kiri atas)
    local detailFrame = Instance.new("Frame")
    detailFrame.Size = UDim2.new(0, 200, 0, 110)
    detailFrame.Position = UDim2.new(0, 10, 0, 10)
    detailFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
    detailFrame.BackgroundTransparency = 0.4
    detailFrame.BorderSizePixel = 0
    detailFrame.Parent = fpsGui
    Instance.new("UICorner", detailFrame).CornerRadius = UDim.new(0,6)

    detailLabel = Instance.new("TextLabel")
    detailLabel.Size = UDim2.new(1,-8,1,-8)
    detailLabel.Position = UDim2.new(0,4,0,4)
    detailLabel.BackgroundTransparency = 1
    detailLabel.TextColor3 = Color3.fromRGB(180,255,180)
    detailLabel.TextScaled = false
    detailLabel.TextSize = 12
    detailLabel.Font = Enum.Font.GothamBold
    detailLabel.TextXAlignment = Enum.TextXAlignment.Left
    detailLabel.TextYAlignment = Enum.TextYAlignment.Top
    detailLabel.Text = "Detail FPS\nRender: --\nMovement: --\nAnimation: --\nServer: --\nClient: --"
    detailLabel.Parent = detailFrame
    detailFrame.Visible = false -- default hidden, aktif saat Real FPS
end

local function startFpsCounter()
    if fpsConn then fpsConn:Disconnect() end
    local frames, elapsed = 0, 0
    local renderFrames, moveFrames, animFrames = 0, 0, 0
    local serverElapsed = 0
    local serverFrames = 0

    -- Client render FPS
    fpsConn = RS.RenderStepped:Connect(function(dt)
        frames += 1
        elapsed += dt
        renderFrames += 1
        if elapsed >= 0.5 then
            clientFPS = math.round(frames/elapsed)
            renderFPS = math.round(renderFrames/elapsed)
            frames, elapsed = 0, 0
            renderFrames = 0
            if fpsLabel then
                fpsLabel.Text = string.format("Client: %d | Srv: %d", clientFPS, serverFPS)
                local color = clientFPS >= 50 and Color3.fromRGB(80,255,80)
                    or clientFPS >= 30 and Color3.fromRGB(255,200,0)
                    or Color3.fromRGB(255,60,60)
                fpsLabel.TextColor3 = color
            end
        end
    end)

    -- Movement FPS via Stepped
    RS.Stepped:Connect(function(_, dt)
        moveFrames += 1
        serverFrames += 1
        serverElapsed += dt
        if serverElapsed >= 0.5 then
            moveFPS = math.round(moveFrames/serverElapsed)
            serverFPS = math.round(serverFrames/serverElapsed)
            moveFrames, serverFrames, serverElapsed = 0, 0, 0
        end
    end)

    -- Heartbeat untuk animasi
    RS.Heartbeat:Connect(function()
        animFrames += 1
    end)

    -- Update detail label
    RS.RenderStepped:Connect(function()
        if detailLabel and detailLabel.Visible then
            detailLabel.Text = string.format(
                "📊 Detail FPS\n🖥 Render: %d fps\n🏃 Movement: %d fps\n🎭 Animation: ~%d fps\n🌐 Server: %d fps\n💻 Client: %d fps",
                renderFPS, moveFPS, animFPS, serverFPS, clientFPS
            )
        end
    end)
end

local function stopFpsCounter()
    if fpsConn then fpsConn:Disconnect() fpsConn = nil end
    if fpsGui then fpsGui:Destroy() fpsGui = nil end
end

-- Ghost Part (Real FPS)
local lastServerPos = Vector3.new()
local ghostVisible = false

local function startRealFps()
    if not LocalPlayer.Character then return end
    local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    -- Buat ghost part
    if ghostPart then ghostPart:Destroy() end
    ghostPart = Instance.new("Part")
    ghostPart.Name = "TrapLagGhost"
    ghostPart.Size = Vector3.new(2, 3, 1)
    ghostPart.Anchored = true
    ghostPart.CanCollide = false
    ghostPart.CastShadow = false
    ghostPart.Material = Enum.Material.Neon
    ghostPart.Color = Color3.fromRGB(0, 255, 80)
    ghostPart.Transparency = 0.6
    ghostPart.Parent = workspace

    detailLabel.Parent.Visible = true

    -- Server tick: update lastServerPos tiap Heartbeat (server rate)
    local serverConn = RS.Heartbeat:Connect(function()
        if hrp then lastServerPos = hrp.CFrame.Position end
    end)

    -- Ghost mengikuti lastServerPos dengan delay (simulasi server lag)
    ghostConn = RS.RenderStepped:Connect(function()
        if not ghostPart or not ghostPart.Parent then
            serverConn:Disconnect()
            return
        end
        if not hrp or not hrp.Parent then return end
        -- Lerp ghost ke server pos (smooth tapi delayed)
        ghostPart.CFrame = CFrame.new(
            ghostPart.CFrame.Position:Lerp(lastServerPos, 0.15)
        )
    end)
end

local function stopRealFps()
    if ghostConn then ghostConn:Disconnect() ghostConn = nil end
    if ghostPart then ghostPart:Destroy() ghostPart = nil end
    if detailLabel then detailLabel.Parent.Visible = false end
end

-- ========================
-- WARNING GUI (BloxStrap)
-- ========================
local function showBloxStrapWarning(onConfirm, onCancel)
    local warnGui = Instance.new("ScreenGui")
    warnGui.Name = "TrapLagWarning"
    warnGui.ResetOnSpawn = false
    warnGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    warnGui.Parent = LocalPlayer.PlayerGui

    local overlay = Instance.new("Frame")
    overlay.Size = UDim2.new(1,0,1,0)
    overlay.BackgroundColor3 = Color3.fromRGB(0,0,0)
    overlay.BackgroundTransparency = 0.5
    overlay.BorderSizePixel = 0
    overlay.Parent = warnGui

    local box = Instance.new("Frame")
    box.Size = UDim2.new(0,320,0,260)
    box.Position = UDim2.new(0.5,-160,0.5,-130)
    box.BackgroundColor3 = Color3.fromRGB(20,20,30)
    box.BorderSizePixel = 0
    box.Parent = overlay
    Instance.new("UICorner", box).CornerRadius = UDim.new(0,12)

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1,0,0,40)
    title.BackgroundTransparency = 1
    title.TextColor3 = Color3.fromRGB(255,80,80)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Text = "⚠️ PERINGATAN"
    title.Parent = box

    local msg = Instance.new("TextLabel")
    msg.Size = UDim2.new(1,-20,0,160)
    msg.Position = UDim2.new(0,10,0,45)
    msg.BackgroundTransparency = 1
    msg.TextColor3 = Color3.fromRGB(220,220,220)
    msg.TextScaled = false
    msg.TextSize = 13
    msg.TextWrapped = true
    msg.Font = Enum.Font.Gotham
    msg.TextXAlignment = Enum.TextXAlignment.Left
    msg.TextYAlignment = Enum.TextYAlignment.Top
    msg.Text = "Kamu akan mengaktifkan mode BloxStrap!\n\n"
        .."• Beberapa fitur Anti-Lag mungkin tidak berfungsi bersamaan dengan BloxStrap mode.\n\n"
        .."• Pengaturan FFlag dan grafis akan diambil alih oleh BloxStrap config.\n\n"
        .."• Pastikan kamu sudah backup setting kamu sebelum melanjutkan.\n\n"
        .."Lanjutkan?"
    msg.Parent = box

    -- Tombol Konfirmasi
    local btnYes = Instance.new("TextButton")
    btnYes.Size = UDim2.new(0,130,0,36)
    btnYes.Position = UDim2.new(0,10,1,-46)
    btnYes.BackgroundColor3 = Color3.fromRGB(40,180,80)
    btnYes.TextColor3 = Color3.fromRGB(255,255,255)
    btnYes.Font = Enum.Font.GothamBold
    btnYes.TextScaled = true
    btnYes.Text = "✅ Ya, Aktifkan"
    btnYes.Parent = box
    Instance.new("UICorner", btnYes).CornerRadius = UDim.new(0,8)

    -- Tombol Batal
    local btnNo = Instance.new("TextButton")
    btnNo.Size = UDim2.new(0,130,0,36)
    btnNo.Position = UDim2.new(1,-140,1,-46)
    btnNo.BackgroundColor3 = Color3.fromRGB(180,40,40)
    btnNo.TextColor3 = Color3.fromRGB(255,255,255)
    btnNo.Font = Enum.Font.GothamBold
    btnNo.TextScaled = true
    btnNo.Text = "❌ Batal"
    btnNo.Parent = box
    Instance.new("UICorner", btnNo).CornerRadius = UDim.new(0,8)

    btnYes.MouseButton1Click:Connect(function()
        warnGui:Destroy()
        onConfirm()
    end)
    btnNo.MouseButton1Click:Connect(function()
        warnGui:Destroy()
        onCancel()
    end)
end

-- ========================
-- WINDUI INIT
-- ========================
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "TrapLag",
    Icon = "zap",
    Author = "TrapLag v3.0",
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

LagTab:Section({ Title = "FPS & Render" })
LagTab:Button({ Title="FPS Unlocker", Description="Unlock FPS ke "..playerConfig.fpsTarget, Icon="gauge",
    Callback=function() applyFPS() WindUI:Notify({Title="TrapLag",Content="FPS di-unlock ke "..playerConfig.fpsTarget.."!",Duration=3}) end })
LagTab:Button({ Title="Cap FPS 60", Description="Batasi FPS ke 60", Icon="battery",
    Callback=function() setfpscap(60) WindUI:Notify({Title="TrapLag",Content="FPS di-cap ke 60!",Duration=3}) end })
LagTab:Toggle({ Title="Reduce Render Distance", Description="Kurangi jarak render objek", Icon="eye",
    Default=playerConfig.reduceRender, Callback=function(s) playerConfig.reduceRender=s applyRender() saveConfig() end })

LagTab:Section({ Title = "Visual" })
LagTab:Toggle({ Title="Disable Shadows", Description="Matikan shadow untuk boost FPS", Icon="sun",
    Default=playerConfig.disableShadows, Callback=function(s) playerConfig.disableShadows=s applyShadows() saveConfig()
    WindUI:Notify({Title="TrapLag",Content=s and "Shadows dimatikan!" or "Shadows dinyalakan!",Duration=2}) end })
LagTab:Toggle({ Title="Disable Atmosphere", Description="Hapus fog & atmosphere", Icon="cloud-off",
    Default=playerConfig.disableAtmosphere, Callback=function(s) playerConfig.disableAtmosphere=s applyAtmosphere() saveConfig() end })
LagTab:Toggle({ Title="Disable PostFX", Description="Hapus blur, bloom, color correction", Icon="image-off",
    Default=playerConfig.disablePostFX, Callback=function(s) playerConfig.disablePostFX=s applyPostFX() saveConfig() end })
LagTab:Button({ Title="Low Texture Quality", Description="Set tekstur ke kualitas terendah", Icon="image",
    Callback=function() settings().Rendering.QualityLevel=Enum.QualityLevel.Level01
    WindUI:Notify({Title="TrapLag",Content="Texture quality diturunkan!",Duration=3}) end })

LagTab:Section({ Title = "Player" })
LagTab:Toggle({ Title="Disable Particles", Description="Matikan semua efek partikel", Icon="sparkles",
    Default=playerConfig.disableParticles, Callback=function(s) playerConfig.disableParticles=s applyParticles() saveConfig() end })
LagTab:Toggle({ Title="Hide Accessories", Description="Sembunyikan aksesoris semua player", Icon="shirt",
    Default=playerConfig.hideAccessories, Callback=function(s) playerConfig.hideAccessories=s applyAccessories() saveConfig() end })
LagTab:Toggle({ Title="Disable Animations", Description="Hentikan animasi semua player", Icon="person-standing",
    Default=playerConfig.disableAnimations, Callback=function(s) playerConfig.disableAnimations=s applyAnimations() saveConfig() end })

LagTab:Section({ Title = "Sound" })
LagTab:Toggle({ Title="Disable All Sound", Description="Matikan semua suara dalam game", Icon="volume-x",
    Default=playerConfig.disableSound, Callback=function(s) playerConfig.disableSound=s applySound() saveConfig() end })

LagTab:Section({ Title = "Quick Actions" })
LagTab:Button({ Title="⚡ Full Anti Lag", Description="Aktifkan SEMUA fitur anti-lag", Icon="zap",
    Callback=function()
        playerConfig.disableShadows=true playerConfig.disableAtmosphere=true
        playerConfig.disablePostFX=true playerConfig.disableParticles=true playerConfig.reduceRender=true
        applyFPS() applyShadows() applyAtmosphere() applyPostFX() applyParticles() applyRender() saveConfig()
        WindUI:Notify({Title="TrapLag ⚡",Content="Semua fitur anti-lag aktif!",Duration=4})
    end })
LagTab:Button({ Title="🔄 Reset All", Description="Kembalikan semua ke default", Icon="rotate-ccw",
    Callback=function()
        for k in pairs(playerConfig) do
            if type(playerConfig[k])=="boolean" then playerConfig[k]=false end
        end
        playerConfig.cameraSensitivity=2.5 playerConfig.fpsTarget=240
        applyAllConfig() saveConfig()
        WindUI:Notify({Title="TrapLag",Content="Semua pengaturan direset!",Duration=3})
    end })

-- ========================
-- TAB 2: BLOXSHADER
-- ========================
local ShadeTab = Window:Tab({ Title = "BloxShader", Icon = "sparkles" })

ShadeTab:Section({ Title = "PShade Ultimate" })

ShadeTab:Button({
    Title = "🎨 Load PShade Ultimate",
    Description = "Load shader lengkap dari PShade Ultimate",
    Icon = "wand",
    Callback = function()
        WindUI:Notify({ Title = "BloxShader", Content = "Loading PShade Ultimate...", Duration = 3 })
        local ok, err = pcall(function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/randomstring0/pshade-ultimate/refs/heads/main/src/cd.lua'))()
        end)
        if not ok then
            WindUI:Notify({ Title = "❌ Gagal Load Shader", Content = tostring(err):sub(1,80), Duration = 5 })
        end
    end,
})

ShadeTab:Section({ Title = "Manual Shader Presets" })

-- Cinematic
ShadeTab:Toggle({
    Title = "🎬 Cinematic Mode",
    Description = "DOF + Color Grade sinematik",
    Icon = "film",
    Default = false,
    Callback = function(state)
        -- DOF
        local dof = Lighting:FindFirstChildOfClass("DepthOfFieldEffect") or Instance.new("DepthOfFieldEffect", Lighting)
        dof.Enabled = state
        dof.FarIntensity = state and 0.5 or 0
        dof.NearIntensity = state and 0.3 or 0
        dof.FocusDistance = state and 50 or 0
        -- Color
        local cc = Lighting:FindFirstChildOfClass("ColorCorrectionEffect") or Instance.new("ColorCorrectionEffect", Lighting)
        cc.Enabled = state
        cc.Contrast = state and 0.2 or 0
        cc.Saturation = state and -0.1 or 0
        cc.TintColor = state and Color3.fromRGB(200, 210, 255) or Color3.fromRGB(255,255,255)
    end,
})

-- Golden Hour
ShadeTab:Toggle({
    Title = "🌅 Golden Hour",
    Description = "Nuansa senja yang hangat",
    Icon = "sun",
    Default = false,
    Callback = function(state)
        local cc = Lighting:FindFirstChildOfClass("ColorCorrectionEffect") or Instance.new("ColorCorrectionEffect", Lighting)
        cc.Enabled = state
        cc.Brightness = state and 0.05 or 0
        cc.Contrast = state and 0.15 or 0
        cc.Saturation = state and 0.3 or 0
        cc.TintColor = state and Color3.fromRGB(255, 210, 160) or Color3.fromRGB(255,255,255)
        if state then
            Lighting.Ambient = Color3.fromRGB(255,180,100)
            Lighting.OutdoorAmbient = Color3.fromRGB(255,160,80)
            Lighting.TimeOfDay = "17:30:00"
        else
            Lighting.Ambient = Color3.fromRGB(70,70,70)
            Lighting.OutdoorAmbient = Color3.fromRGB(128,128,128)
        end
    end,
})

-- Night Mode
ShadeTab:Toggle({
    Title = "🌙 Night Mode",
    Description = "Suasana malam gelap misterius",
    Icon = "moon",
    Default = false,
    Callback = function(state)
        if state then
            Lighting.TimeOfDay = "00:00:00"
            Lighting.Ambient = Color3.fromRGB(20,20,40)
            Lighting.OutdoorAmbient = Color3.fromRGB(10,10,30)
            Lighting.Brightness = 0.5
        else
            Lighting.TimeOfDay = "14:00:00"
            Lighting.Ambient = Color3.fromRGB(70,70,70)
            Lighting.OutdoorAmbient = Color3.fromRGB(128,128,128)
            Lighting.Brightness = 2
        end
    end,
})

-- Retro / VHS
ShadeTab:Toggle({
    Title = "📼 Retro VHS",
    Description = "Efek warna retro tahun 80an",
    Icon = "tv",
    Default = false,
    Callback = function(state)
        local cc = Lighting:FindFirstChildOfClass("ColorCorrectionEffect") or Instance.new("ColorCorrectionEffect", Lighting)
        cc.Enabled = state
        cc.Saturation = state and -0.4 or 0
        cc.Contrast = state and 0.3 or 0
        cc.TintColor = state and Color3.fromRGB(255, 220, 180) or Color3.fromRGB(255,255,255)
        local blur = Lighting:FindFirstChildOfClass("BlurEffect") or Instance.new("BlurEffect", Lighting)
        blur.Enabled = state
        blur.Size = state and 4 or 0
    end,
})

-- Neon City
ShadeTab:Toggle({
    Title = "🌆 Neon City",
    Description = "Cyberpunk neon biru-ungu",
    Icon = "zap",
    Default = false,
    Callback = function(state)
        local cc = Lighting:FindFirstChildOfClass("ColorCorrectionEffect") or Instance.new("ColorCorrectionEffect", Lighting)
        cc.Enabled = state
        cc.Saturation = state and 0.5 or 0
        cc.Contrast = state and 0.2 or 0
        cc.TintColor = state and Color3.fromRGB(160, 180, 255) or Color3.fromRGB(255,255,255)
        if state then
            Lighting.Ambient = Color3.fromRGB(60,0,120)
            Lighting.OutdoorAmbient = Color3.fromRGB(40,0,100)
            Lighting.TimeOfDay = "22:00:00"
        else
            Lighting.Ambient = Color3.fromRGB(70,70,70)
            Lighting.OutdoorAmbient = Color3.fromRGB(128,128,128)
        end
    end,
})

-- Enhanced Bloom
ShadeTab:Toggle({
    Title = "✨ Enhanced Bloom",
    Description = "Efek bloom yang kuat dan indah",
    Icon = "star",
    Default = false,
    Callback = function(state)
        local bloom = Lighting:FindFirstChildOfClass("BloomEffect") or Instance.new("BloomEffect", Lighting)
        bloom.Enabled = state
        bloom.Intensity = state and 1.2 or 0.5
        bloom.Size = state and 30 or 24
        bloom.Threshold = state and 0.8 or 0.95
    end,
})

-- Reset Shader
ShadeTab:Button({
    Title = "🔄 Reset Semua Shader",
    Description = "Kembalikan Lighting ke default",
    Icon = "rotate-ccw",
    Callback = function()
        Lighting.Ambient = Color3.fromRGB(70,70,70)
        Lighting.OutdoorAmbient = Color3.fromRGB(128,128,128)
        Lighting.Brightness = 2
        Lighting.TimeOfDay = "14:00:00"
        for _, e in ipairs(Lighting:GetChildren()) do
            if e:IsA("BlurEffect") or e:IsA("BloomEffect") or e:IsA("ColorCorrectionEffect")
            or e:IsA("SunRaysEffect") or e:IsA("DepthOfFieldEffect") then
                e.Enabled = false
            end
        end
        WindUI:Notify({ Title = "BloxShader", Content = "Semua shader direset!", Duration = 3 })
    end,
})

-- ========================
-- TAB 3: BLOXSTRAP
-- ========================
local BSTab = Window:Tab({ Title = "BloxStrap", Icon = "settings-2" })

local bloxstrapActive = playerConfig.bloxstrapEnabled

BSTab:Section({ Title = "Mode BloxStrap" })

BSTab:Toggle({
    Title = "⚡ Load The BloxStrap",
    Description = "Aktifkan semua fitur BloxStrap",
    Icon = "power",
    Default = bloxstrapActive,
    Callback = function(state)
        if state and not bloxstrapActive then
            -- Tampilkan warning dulu
            showBloxStrapWarning(
                function() -- Konfirmasi
                    bloxstrapActive = true
                    playerConfig.bloxstrapEnabled = true
                    saveConfig()
                    WindUI:Notify({ Title = "BloxStrap ✅", Content = "Mode BloxStrap aktif! Semua fitur tersedia.", Duration = 4 })
                    -- Load FPS counter
                    createFpsGui()
                    startFpsCounter()
                end,
                function() -- Batal
                    -- Toggle balik ke off (workaround)
                    WindUI:Notify({ Title = "BloxStrap", Content = "Dibatalkan.", Duration = 2 })
                end
            )
        elseif not state then
            bloxstrapActive = false
            playerConfig.bloxstrapEnabled = false
            saveConfig()
            stopFpsCounter()
            stopRealFps()
            WindUI:Notify({ Title = "BloxStrap", Content = "Mode BloxStrap dimatikan.", Duration = 3 })
        end
    end,
})

BSTab:Section({ Title = "FPS Monitor" })

BSTab:Toggle({
    Title = "📊 FPS Counter",
    Description = "Tampilkan FPS client & server di layar (draggable)",
    Icon = "activity",
    Default = false,
    Callback = function(state)
        if state then
            createFpsGui()
            startFpsCounter()
        else
            stopFpsCounter()
            stopRealFps()
        end
    end,
})

BSTab:Toggle({
    Title = "🟢 Real FPS (Ghost Part)",
    Description = "Tampilkan ghost part server + detail FPS lengkap",
    Icon = "person-standing",
    Default = false,
    Callback = function(state)
        if state then
            if not fpsGui then createFpsGui() startFpsCounter() end
            startRealFps()
        else
            stopRealFps()
        end
    end,
})

BSTab:Section({ Title = "FFlag Editor" })

BSTab:Button({
    Title = "📋 Load FFlags dari File",
    Description = "Baca TrapLag/config/BloxStrap/fflags.json",
    Icon = "file-json",
    Callback = function()
        local path = "TrapLag/config/BloxStrap/fflags.json"
        if not isfile(path) then
            -- Buat template
            writefile(path, HS:JSONEncode({
                ["DFIntTaskSchedulerTargetFps"] = 240,
                ["FFlagDisablePostFx"] = false,
            }))
            WindUI:Notify({ Title = "FFlags", Content = "Template fflags.json dibuat! Edit lalu load lagi.", Duration = 5 })
            return
        end
        local ok, data = pcall(function() return HS:JSONDecode(readfile(path)) end)
        if ok and data then
            WindUI:Notify({ Title = "FFlags ✅", Content = "FFlags loaded! "..tostring(#(function(t) local n={} for k in pairs(t) do n[#n+1]=k end return n end)(data)).." flag ditemukan.", Duration = 4 })
        else
            WindUI:Notify({ Title = "❌ FFlags Error", Content = "File JSON tidak valid!", Duration = 4 })
        end
    end,
})

BSTab:Button({
    Title = "📁 Buka Folder BloxStrap",
    Description = "Cek file di TrapLag/config/BloxStrap/",
    Icon = "folder-open",
    Callback = function()
        local files = listfiles("TrapLag/config/BloxStrap")
        local names = {}
        for _, f in ipairs(files) do table.insert(names, f:match("([^/\\]+)$") or f) end
        if #names == 0 then
            WindUI:Notify({ Title = "BloxStrap Folder", Content = "Folder kosong! Belum ada config.", Duration = 4 })
        else
            WindUI:Notify({ Title = "BloxStrap Files", Content = table.concat(names, "\n"), Duration = 5 })
        end
    end,
})

BSTab:Section({ Title = "Graphics Settings" })

BSTab:Slider({
    Title = "Render Quality",
    Description = "Kualitas render Roblox (1 = terendah, 10 = tertinggi)",
    Icon = "monitor",
    Min = 1, Max = 10, Default = 5, Decimals = 0,
    Callback = function(value)
        local levels = {
            Enum.QualityLevel.Level01, Enum.QualityLevel.Level02,
            Enum.QualityLevel.Level03, Enum.QualityLevel.Level04,
            Enum.QualityLevel.Level05, Enum.QualityLevel.Level06,
            Enum.QualityLevel.Level07, Enum.QualityLevel.Level08,
            Enum.QualityLevel.Level09, Enum.QualityLevel.Level10,
        }
        settings().Rendering.QualityLevel = levels[value] or Enum.QualityLevel.Level05
    end,
})

BSTab:Slider({
    Title = "Lighting Brightness",
    Description = "Intensitas cahaya global (0 - 5)",
    Icon = "sun",
    Min = 0, Max = 5, Default = 2, Decimals = 1,
    Callback = function(value)
        Lighting.Brightness = value
    end,
})

-- ========================
-- TAB 4: CONFIG
-- ========================
local CfgTab = Window:Tab({ Title = "Config", Icon = "sliders-horizontal" })

CfgTab:Section({ Title = "Player Config" })
CfgTab:Slider({ Title="Camera Sensitivity", Description="Sensitivitas kamera (0.1 - 7.0)", Icon="move",
    Min=0.1, Max=7, Default=playerConfig.cameraSensitivity, Decimals=1,
    Callback=function(v) playerConfig.cameraSensitivity=v applyCamera() saveConfig() end })
CfgTab:Slider({ Title="FPS Target", Description="Target FPS saat FPS Unlocker aktif", Icon="gauge",
    Min=30, Max=240, Default=playerConfig.fpsTarget, Decimals=0,
    Callback=function(v) playerConfig.fpsTarget=v saveConfig() end })

CfgTab:Section({ Title = "Fonts" })
CfgTab:Button({ Title="Lihat Font Tersedia", Description="Cek file di TrapLag/config/fonts/", Icon="type",
    Callback=function()
        local files=listfiles("TrapLag/config/fonts")
        local names={}
        for _,f in ipairs(files) do if f:match("%.json$") then table.insert(names,f:match("([^/\\]+)%.json$")or f) end end
        WindUI:Notify({Title="Fonts",Content=#names>0 and table.concat(names,", ") or "Belum ada font!",Duration=5})
    end })
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
                WindUI:Notify({Title="Font Applied",Content=name.." berhasil!",Duration=3})
                return
            end
        end
        WindUI:Notify({Title="Font",Content="Tidak ada file font!",Duration=4})
    end })

CfgTab:Section({ Title = "Crosshair & Image" })
CfgTab:Button({ Title="Lihat Crosshair", Description="Cek file di config/crosshair/", Icon="crosshair",
    Callback=function()
        local files=listfiles("TrapLag/config/crosshair")
        local names={}
        for _,f in ipairs(files) do if f:match("%.png$") then table.insert(names,f:match("([^/\\]+)$")or f) end end
        WindUI:Notify({Title="Crosshair",Content=#names>0 and table.concat(names,", ") or "Belum ada crosshair!",Duration=5})
    end })
CfgTab:Button({ Title="Cek Logo", Description="Cek TrapLag/logo.png", Icon="image",
    Callback=function()
        WindUI:Notify({Title="Logo",Content=isfile("TrapLag/logo.png") and "logo.png ditemukan! ✅" or "logo.png belum ada!",Duration=3})
    end })

CfgTab:Section({ Title = "Export & Import Config" })
CfgTab:Button({ Title="📤 Export Config", Description="Generate kode → TrapLag/export.txt", Icon="share",
    Callback=function()
        local code=exportConfig()
        WindUI:Notify({Title="Exported! ✅",Content="Disimpan di TrapLag/export.txt\n"..code:sub(1,40).."...",Duration=6})
    end })
CfgTab:Button({ Title="📋 Copy Kode Export", Description="Copy kode ke clipboard", Icon="copy",
    Callback=function()
        if isfile("TrapLag/export.txt") then
            setclipboard(readfile("TrapLag/export.txt"))
            WindUI:Notify({Title="Copied! ✅",Content="Kode berhasil dicopy!",Duration=3})
        else
            WindUI:Notify({Title="Export dulu!",Content="Klik Export Config terlebih dahulu.",Duration=3})
        end
    end })
CfgTab:Button({ Title="📥 Import Config", Description="Paste kode di TrapLag/import.txt lalu klik", Icon="download",
    Callback=function()
        if not isfile("TrapLag/import.txt") then
            writefile("TrapLag/import.txt","")
            WindUI:Notify({Title="Import",Content="import.txt dibuat! Paste kode di sana lalu klik Import lagi.",Duration=5})
            return
        end
        local code=readfile("TrapLag/import.txt"):gsub("%s+","")
        if code=="" then WindUI:Notify({Title="Import",Content="import.txt kosong!",Duration=4}) return end
        local ok,reason=importConfig(code)
        if ok then
            WindUI:Notify({Title="Import Berhasil! ✅",Content="Config berhasil diload & diapply!",Duration=4})
            writefile("TrapLag/import.txt","")
        elseif reason=="expired" then
            WindUI:Notify({Title="❌ Kode Expired!",Content="Kode dari versi lama TrapLag, tidak kompatibel.",Duration=5})
        else
            WindUI:Notify({Title="❌ Kode Tidak Valid!",Content="Kode salah atau rusak.",Duration=5})
        end
    end })

-- ========================
-- STARTUP
-- ========================
if playerConfig.bloxstrapEnabled then
    createFpsGui()
    startFpsCounter()
end

WindUI:Notify({
    Title = "TrapLag v3.0 ✅",
    Content = "Config diload otomatis! BloxShader & BloxStrap siap.",
    Duration = 4,
})

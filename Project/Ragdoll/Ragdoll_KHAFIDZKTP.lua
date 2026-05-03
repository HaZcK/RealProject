-- ╔══════════════════════════════════════════╗
-- ║     RAGDOLL SCRIPT  by KHAFIDZKTP        ║
-- ║     Realistic Physics + Player Collide   ║
-- ╚══════════════════════════════════════════╝

local Players        = game:GetService("Players")
local RunService     = game:GetService("RunService")
local PhysicsService = game:GetService("PhysicsService")
local TweenService   = game:GetService("TweenService")
local UIS            = game:GetService("UserInputService")

local LP   = Players.LocalPlayer
local PGui = LP:WaitForChild("PlayerGui")

-- ─────────────────────────────────────────
--  STATE
-- ─────────────────────────────────────────
local isRagdolled = false
local constraints = {}
local savedProps  = {}

-- ─────────────────────────────────────────
--  COLLISION GROUPS
--  "RagSelf" = local player saat ragdoll
--  RagSelf <-> Default : TRUE  → kamu nyangkut di player lain
--  Default <-> Default : FALSE → player lain tetap tembus satu sama lain
--  Kamu tidak bisa fling karena massa kamu sangat ringan
-- ─────────────────────────────────────────
local GROUP_SELF = "RagSelf"

pcall(function()
    PhysicsService:RegisterCollisionGroup(GROUP_SELF)
end)
pcall(function()
    PhysicsService:CollisionGroupSetCollidable(GROUP_SELF, "Default", true)
    PhysicsService:CollisionGroupSetCollidable("Default", "Default", false)
end)

local function setGroup(char, group)
    for _, p in ipairs(char:GetDescendants()) do
        if p:IsA("BasePart") then
            pcall(function()
                PhysicsService:SetPartCollisionGroup(p, group)
            end)
        end
    end
end

-- ─────────────────────────────────────────
--  BUAT TUBUH SANGAT RINGAN SAAT RAGDOLL
--  → tidak bisa fling player lain (massa kecil = gaya kecil)
-- ─────────────────────────────────────────
local LIGHT_DENSITY = 0.01

local function makeLightweight(char)
    savedProps = {}
    for _, p in ipairs(char:GetDescendants()) do
        if p:IsA("BasePart") then
            local pp = p.CustomPhysicalProperties
            if not pp then
                pcall(function()
                    pp = PhysicalProperties.new(p.Material)
                end)
            end
            if pp then
                table.insert(savedProps, {
                    part    = p,
                    density = pp.Density,
                    friction= pp.Friction,
                    elast   = pp.Elasticity,
                    fw      = pp.FrictionWeight,
                    ew      = pp.ElasticityWeight,
                })
                p.CustomPhysicalProperties = PhysicalProperties.new(
                    LIGHT_DENSITY,
                    pp.Friction,
                    pp.Elasticity * 0.2,
                    pp.FrictionWeight,
                    pp.ElasticityWeight
                )
            end
        end
    end
end

local function restoreWeight()
    for _, info in ipairs(savedProps) do
        if info.part and info.part.Parent then
            info.part.CustomPhysicalProperties = PhysicalProperties.new(
                info.density, info.friction, info.elast,
                info.fw, info.ew
            )
        end
    end
    savedProps = {}
end

-- ─────────────────────────────────────────
--  RAGDOLL ON
--  Menonaktifkan Motor6D, pasang BallSocketConstraint
--  Warisi velocity + rotVelocity → arah jatuh realistis
-- ─────────────────────────────────────────
local function ragdollOn(char, hum, hrp)
    if isRagdolled then return end
    isRagdolled = true

    -- Simpan kecepatan sebelum ragdoll
    local vel    = hrp.Velocity
    local angVel = hrp.RotVelocity

    hum.PlatformStand = true
    hum.AutoRotate    = false

    for _, j in ipairs(char:GetDescendants()) do
        if j:IsA("Motor6D") and j.Part0 and j.Part1 then
            j.Enabled = false

            local a0 = Instance.new("Attachment")
            a0.CFrame = j.C0
            a0.Parent = j.Part0

            local a1 = Instance.new("Attachment")
            a1.CFrame = j.C1
            a1.Parent = j.Part1

            local socket = Instance.new("BallSocketConstraint")
            socket.Attachment0        = a0
            socket.Attachment1        = a1
            socket.LimitsEnabled      = true
            socket.TwistLimitsEnabled = true
            socket.UpperAngle         = 55   -- jangkauan gerak sendi realistis
            socket.TwistUpperAngle    = 40
            socket.TwistLowerAngle    = -40
            socket.Parent             = j.Part0

            table.insert(constraints, { socket, a0, a1 })
        end
    end

    -- Warisi kecepatan asli → badan jatuh sesuai arah gerak
    for _, p in ipairs(char:GetDescendants()) do
        if p:IsA("BasePart") then
            p.Velocity      = vel
            p.RotVelocity   = angVel * 0.4
        end
    end

    makeLightweight(char)
    setGroup(char, GROUP_SELF) -- aktifkan collision dengan player lain
end

-- ─────────────────────────────────────────
--  RAGDOLL OFF
-- ─────────────────────────────────────────
local function ragdollOff(char, hum, hrp)
    if not isRagdolled then return end
    isRagdolled = false

    for _, set in ipairs(constraints) do
        for _, obj in ipairs(set) do
            if obj and obj.Parent then obj:Destroy() end
        end
    end
    constraints = {}

    for _, j in ipairs(char:GetDescendants()) do
        if j:IsA("Motor6D") then
            j.Enabled = true
        end
    end

    hum.PlatformStand = false
    hum.AutoRotate    = true

    restoreWeight()
    setGroup(char, "Default")

    -- Angkat sedikit supaya tidak terjebak di lantai
    hrp.CFrame = hrp.CFrame + Vector3.new(0, 2.5, 0)
end

-- ─────────────────────────────────────────
--  CHARACTER SETUP (handle respawn)
-- ─────────────────────────────────────────
local char, hum, hrp

local function onCharacterAdded(c)
    char         = c
    isRagdolled  = false
    constraints  = {}
    savedProps   = {}

    hum = c:WaitForChild("Humanoid")
    hrp = c:WaitForChild("HumanoidRootPart")

    task.wait(0.5)
    setGroup(c, "Default")

    -- Update teks tombol kalau GUI sudah ada
    local sg = PGui:FindFirstChild("RagdollGui")
    if sg then
        local btn = sg:FindFirstChildWhichIsA("TextButton", true)
        if btn then btn.Text = "⬤  Ragdoll" end
    end
end

char = LP.Character or LP.CharacterAdded:Wait()
onCharacterAdded(char)
LP.CharacterAdded:Connect(onCharacterAdded)

-- ─────────────────────────────────────────
--  GUI
-- ─────────────────────────────────────────
-- Hapus GUI lama kalau ada
local oldGui = PGui:FindFirstChild("RagdollGui")
if oldGui then oldGui:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name            = "RagdollGui"
ScreenGui.ResetOnSpawn    = false
ScreenGui.ZIndexBehavior  = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset  = true
ScreenGui.Parent          = PGui

-- ── NOTIFIKASI R6 (muncul langsung, hilang setelah ~3 detik) ──
local notif = Instance.new("Frame", ScreenGui)
notif.Name              = "Notif"
notif.Size              = UDim2.new(0, 310, 0, 58)
notif.Position          = UDim2.new(0.5, -155, 0, -80)
notif.BackgroundColor3  = Color3.fromRGB(14, 14, 22)
notif.BorderSizePixel   = 0
Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 12)

local nStroke = Instance.new("UIStroke", notif)
nStroke.Color     = Color3.fromRGB(255, 90, 40)
nStroke.Thickness = 1.5

local nIcon = Instance.new("TextLabel", notif)
nIcon.Size                   = UDim2.new(0, 40, 1, 0)
nIcon.Position               = UDim2.new(0, 8, 0, 0)
nIcon.BackgroundTransparency = 1
nIcon.Text                   = "⚠"
nIcon.TextColor3             = Color3.fromRGB(255, 160, 50)
nIcon.Font                   = Enum.Font.GothamBold
nIcon.TextSize               = 22

local nText = Instance.new("TextLabel", notif)
nText.Size                   = UDim2.new(1, -56, 1, 0)
nText.Position               = UDim2.new(0, 50, 0, 0)
nText.BackgroundTransparency = 1
nText.Text                   = "Pastikan avatar kamu sudah R6!"
nText.TextColor3             = Color3.fromRGB(230, 210, 190)
nText.Font                   = Enum.Font.Gotham
nText.TextSize               = 13
nText.TextXAlignment         = Enum.TextXAlignment.Left

-- Slide in notifikasi
TweenService:Create(notif,
    TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
    { Position = UDim2.new(0.5, -155, 0, 18) }
):Play()

-- Slide out setelah 2.8 detik
task.delay(2.8, function()
    TweenService:Create(notif,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        { Position = UDim2.new(0.5, -155, 0, -80) }
    ):Play()
    task.delay(0.35, function() notif:Destroy() end)
end)

-- ── MAIN BUTTON (muncul setelah 2 detik) ──
task.delay(2, function()
    -- Wrapper frame untuk drag
    local frame = Instance.new("Frame", ScreenGui)
    frame.Name              = "MainFrame"
    frame.Size              = UDim2.new(0, 150, 0, 48)
    frame.Position          = UDim2.new(0.5, -75, 0.88, 0)
    frame.BackgroundTransparency = 1
    frame.Active            = true
    frame.ZIndex            = 10

    -- Shadow
    local shadow = Instance.new("Frame", frame)
    shadow.Size              = UDim2.new(1, 8, 1, 8)
    shadow.Position          = UDim2.new(0, -4, 0, 5)
    shadow.BackgroundColor3  = Color3.fromRGB(0, 0, 0)
    shadow.BackgroundTransparency = 0.55
    shadow.BorderSizePixel   = 0
    shadow.ZIndex            = 9
    Instance.new("UICorner", shadow).CornerRadius = UDim.new(0, 16)

    -- Background
    local bg = Instance.new("Frame", frame)
    bg.Size              = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3  = Color3.fromRGB(18, 18, 30)
    bg.BorderSizePixel   = 0
    bg.ZIndex            = 10
    Instance.new("UICorner", bg).CornerRadius = UDim.new(0, 14)

    local stroke = Instance.new("UIStroke", bg)
    stroke.Color     = Color3.fromRGB(80, 80, 140)
    stroke.Thickness = 1.2

    -- Garis aksen di atas tombol
    local topLine = Instance.new("Frame", bg)
    topLine.Size             = UDim2.new(0.55, 0, 0, 2)
    topLine.Position         = UDim2.new(0.225, 0, 0, 0)
    topLine.BackgroundColor3 = Color3.fromRGB(255, 80, 30)
    topLine.BorderSizePixel  = 0
    topLine.ZIndex           = 11
    Instance.new("UICorner", topLine).CornerRadius = UDim.new(1, 0)

    -- Tombol utama
    local btn = Instance.new("TextButton", bg)
    btn.Name                = "RagBtn"
    btn.Size                = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text                = "⬤  Ragdoll"
    btn.TextColor3          = Color3.fromRGB(255, 255, 255)
    btn.Font                = Enum.Font.GothamSemibold
    btn.TextSize            = 15
    btn.ZIndex              = 12
    btn.AutoButtonColor     = false

    -- Fade in
    for t = 0, 1, 0.1 do
        task.wait(0.016)
        bg.BackgroundTransparency = 1 - t
    end
    bg.BackgroundTransparency = 0

    -- ── DRAG ──
    local dragging  = false
    local dragInput, dragStart, startPos

    local function updatePos(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end

    frame.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1
        or inp.UserInputType == Enum.UserInputType.Touch then
            dragging  = true
            dragInput = inp
            dragStart = inp.Position
            startPos  = frame.Position
        end
    end)

    frame.InputEnded:Connect(function(inp)
        if inp == dragInput then dragging = false end
    end)

    UIS.InputChanged:Connect(function(inp)
        if not dragging then return end
        if inp.UserInputType == Enum.UserInputType.MouseMovement
        or inp.UserInputType == Enum.UserInputType.Touch then
            updatePos(inp)
        end
    end)

    -- ── HOVER GLOW ──
    btn.MouseEnter:Connect(function()
        TweenService:Create(stroke, TweenInfo.new(0.2), {
            Color = Color3.fromRGB(255, 80, 30)
        }):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(stroke, TweenInfo.new(0.2), {
            Color = Color3.fromRGB(80, 80, 140)
        }):Play()
    end)

    -- ── TOGGLE RAGDOLL ──
    btn.MouseButton1Click:Connect(function()
        -- Pastikan referensi karakter masih valid
        if not char or not char.Parent then
            char = LP.Character
            if not char then return end
            hum = char:FindFirstChildOfClass("Humanoid")
            hrp = char:FindFirstChild("HumanoidRootPart")
        end
        if not hum or not hrp then return end

        if not isRagdolled then
            ragdollOn(char, hum, hrp)
            btn.Text = "▲  Stand Up"
            TweenService:Create(topLine, TweenInfo.new(0.25), {
                BackgroundColor3 = Color3.fromRGB(50, 200, 120)
            }):Play()
        else
            ragdollOff(char, hum, hrp)
            btn.Text = "⬤  Ragdoll"
            TweenService:Create(topLine, TweenInfo.new(0.25), {
                BackgroundColor3 = Color3.fromRGB(255, 80, 30)
            }):Play()
        end
    end)
end)

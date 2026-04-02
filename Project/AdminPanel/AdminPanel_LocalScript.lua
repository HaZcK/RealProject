-- ============================================================
--  ADMIN PANEL - LOCAL SCRIPT
--  Letakkan di: StarterGui  (tipe: LocalScript)
-- ============================================================

local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService     = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Camera           = workspace.CurrentCamera

local player    = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ── State ────────────────────────────────────────────────────
local isConnected  = false
local isFlying     = false
local flySpeed     = 60
local AdminRemotes = nil

-- ── Warna ────────────────────────────────────────────────────
local C = {
	BG         = Color3.fromRGB(7,  9, 18),
	BG2        = Color3.fromRGB(13, 16, 28),
	BG3        = Color3.fromRGB(22, 25, 42),
	Accent     = Color3.fromRGB(0, 140, 255),
	AccentDark = Color3.fromRGB(0,  80, 180),
	AccentGlow = Color3.fromRGB(70, 190, 255),
	Border     = Color3.fromRGB(35, 42, 70),
	Text       = Color3.fromRGB(220, 228, 248),
	TextDim    = Color3.fromRGB(120, 132, 165),
	Success    = Color3.fromRGB(50,  215, 100),
	Error      = Color3.fromRGB(255,  75,  75),
	Warning    = Color3.fromRGB(255, 195,  50),
}

-- ── Utilitas ─────────────────────────────────────────────────
local function corner(p, r)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, r or 6)
	c.Parent = p
	return c
end
local function stroke(p, col, th)
	local s = Instance.new("UIStroke")
	s.Color = col or C.Border
	s.Thickness = th or 1
	s.Parent = p
	return s
end
local function pad(p, t, b, l, r)
	local u = Instance.new("UIPadding")
	u.PaddingTop    = UDim.new(0, t or 8)
	u.PaddingBottom = UDim.new(0, b or 8)
	u.PaddingLeft   = UDim.new(0, l or 10)
	u.PaddingRight  = UDim.new(0, r or 10)
	u.Parent = p
end
local function label(p, txt, sz, col, font)
	local l = Instance.new("TextLabel")
	l.BackgroundTransparency = 1
	l.Text = txt; l.TextSize = sz or 13
	l.TextColor3 = col or C.Text
	l.Font = font or Enum.Font.Gotham
	l.TextXAlignment = Enum.TextXAlignment.Left
	l.Parent = p
	return l
end
local function button(p, txt, sz, tsz, col)
	local b = Instance.new("TextButton")
	b.Size = sz or UDim2.new(1,0,0,34)
	b.BackgroundColor3 = col or C.Accent
	b.Text = txt; b.TextSize = tsz or 13
	b.TextColor3 = C.Text
	b.Font = Enum.Font.GothamSemibold
	b.AutoButtonColor = false
	b.Parent = p
	corner(b, 6)
	b.MouseEnter:Connect(function()
		TweenService:Create(b, TweenInfo.new(0.15), {BackgroundColor3 = C.AccentGlow}):Play()
	end)
	b.MouseLeave:Connect(function()
		TweenService:Create(b, TweenInfo.new(0.15), {BackgroundColor3 = col or C.Accent}):Play()
	end)
	return b
end

-- ============================================================
--  SCREEN GUI
-- ============================================================
local SG = Instance.new("ScreenGui")
SG.Name             = "AdminPanelGUI"
SG.ResetOnSpawn     = false
SG.IgnoreGuiInset   = true
SG.ZIndexBehavior   = Enum.ZIndexBehavior.Sibling
SG.Parent           = playerGui

-- ============================================================
--  LOADING SCREEN
-- ============================================================
local LoadFrame = Instance.new("Frame")
LoadFrame.Size             = UDim2.new(1,0,1,0)
LoadFrame.BackgroundColor3 = C.BG
LoadFrame.BorderSizePixel  = 0
LoadFrame.ZIndex           = 100
LoadFrame.Parent           = SG

-- Gradient bg
do
	local g = Instance.new("UIGradient")
	g.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0,   Color3.fromRGB(4,  7, 18)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(8, 12, 28)),
		ColorSequenceKeypoint.new(1,   Color3.fromRGB(2,  5, 15)),
	})
	g.Rotation = 135
	g.Parent = LoadFrame
end

-- Dekorasi titik
for _ = 1, 10 do
	local d = Instance.new("Frame")
	d.Size                   = UDim2.new(0, math.random(3,7), 0, math.random(3,7))
	d.Position               = UDim2.new(math.random()*0.92, 0, math.random()*0.88, 0)
	d.BackgroundColor3       = C.Accent
	d.BackgroundTransparency = math.random(5,8)/10
	d.BorderSizePixel        = 0
	d.ZIndex                 = 100
	corner(d, 99)
	d.Parent = LoadFrame
end

-- Judul loading
local LoadTitle = Instance.new("TextLabel")
LoadTitle.Size               = UDim2.new(0, 360, 0, 56)
LoadTitle.Position           = UDim2.new(0.5,-180, 0.28, 0)
LoadTitle.BackgroundTransparency = 1
LoadTitle.Text               = "⚙  ADMIN PANEL"
LoadTitle.TextSize           = 30
LoadTitle.Font               = Enum.Font.GothamBold
LoadTitle.TextColor3         = C.Accent
LoadTitle.TextTransparency   = 1
LoadTitle.ZIndex             = 101
LoadTitle.TextXAlignment     = Enum.TextXAlignment.Center
LoadTitle.Parent             = LoadFrame

-- Spinner
local SpinWrap = Instance.new("Frame")
SpinWrap.Size                = UDim2.new(0, 52, 0, 52)
SpinWrap.Position            = UDim2.new(0.5,-26, 0.48, 0)
SpinWrap.BackgroundTransparency = 1
SpinWrap.ZIndex              = 101
SpinWrap.Parent              = LoadFrame

local SpinImg = Instance.new("ImageLabel")
SpinImg.Size                 = UDim2.new(1,0,1,0)
SpinImg.BackgroundTransparency = 1
SpinImg.Image                = "rbxassetid://4965945816"
SpinImg.ImageColor3          = C.Accent
SpinImg.ZIndex               = 102
SpinImg.Parent               = SpinWrap

-- Progress bar
local BarBG = Instance.new("Frame")
BarBG.Size               = UDim2.new(0, 300, 0, 5)
BarBG.Position           = UDim2.new(0.5,-150, 0.63, 0)
BarBG.BackgroundColor3   = Color3.fromRGB(22, 26, 45)
BarBG.BorderSizePixel    = 0
BarBG.ZIndex             = 101
corner(BarBG, 99)
BarBG.Parent             = LoadFrame

local BarFill = Instance.new("Frame")
BarFill.Size             = UDim2.new(0,0,1,0)
BarFill.BackgroundColor3 = C.Accent
BarFill.BorderSizePixel  = 0
BarFill.ZIndex           = 102
corner(BarFill, 99)
BarFill.Parent           = BarBG

do -- gradient bar
	local g = Instance.new("UIGradient")
	g.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 100, 200)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 210, 255)),
	})
	g.Parent = BarFill
end

local BarPct = label(LoadFrame, "0%", 12, C.Accent, Enum.Font.GothamBold)
BarPct.Size     = UDim2.new(0, 300, 0, 20)
BarPct.Position = UDim2.new(0.5,-150, 0.65, 0)
BarPct.ZIndex   = 101
BarPct.TextXAlignment = Enum.TextXAlignment.Center

local LoadStatus = label(LoadFrame, "Memulai...", 12, C.TextDim)
LoadStatus.Size     = UDim2.new(0, 300, 0, 20)
LoadStatus.Position = UDim2.new(0.5,-150, 0.68, 0)
LoadStatus.ZIndex   = 101
LoadStatus.TextXAlignment = Enum.TextXAlignment.Center

-- Spinner rotasi
local spinConn = RunService.RenderStepped:Connect(function()
	SpinWrap.Rotation = SpinWrap.Rotation + 4
end)

-- ── Sequence loading ─────────────────────────────────────────
local loadSteps = {
	{ 0.10, "Memuat antarmuka..." },
	{ 0.25, "Menginisialisasi sistem..." },
	{ 0.40, "Memuat komponen GUI..." },
	{ 0.55, "Menghubungkan ke layanan..." },
	{ 0.70, "Menyiapkan panel admin..." },
	{ 0.85, "Mengoptimalkan aset..." },
	{ 1.00, "Selesai!" },
}

local function runLoading(cb)
	TweenService:Create(LoadTitle, TweenInfo.new(0.8), { TextTransparency = 0 }):Play()
	task.wait(0.4)

	for _, step in ipairs(loadSteps) do
		local frac, msg = step[1], step[2]
		LoadStatus.Text = msg
		BarPct.Text     = math.floor(frac * 100) .. "%"
		TweenService:Create(BarFill, TweenInfo.new(0.35, Enum.EasingStyle.Quad), {
			Size = UDim2.new(frac, 0, 1, 0)
		}):Play()
		task.wait(0.32 + math.random() * 0.18)
	end

	task.wait(0.25)
	-- Fade out loading
	TweenService:Create(LoadFrame, TweenInfo.new(0.55), { BackgroundTransparency = 1 }):Play()
	for _, d in ipairs(LoadFrame:GetDescendants()) do
		local ok, _ = pcall(function()
			if d:IsA("TextLabel") or d:IsA("ImageLabel") then
				TweenService:Create(d, TweenInfo.new(0.45), { TextTransparency = 1, ImageTransparency = 1 }):Play()
			elseif d:IsA("Frame") then
				TweenService:Create(d, TweenInfo.new(0.45), { BackgroundTransparency = 1 }):Play()
			end
		end)
	end
	task.wait(0.6)
	spinConn:Disconnect()
	LoadFrame.Visible = false
	if cb then cb() end
end

-- ============================================================
--  MAIN FRAME
-- ============================================================
local MainFrame = Instance.new("Frame")
MainFrame.Name             = "MainFrame"
MainFrame.Size             = UDim2.new(0, 388, 0, 505)
MainFrame.Position         = UDim2.new(0.5,-194, 0.5,-252)
MainFrame.BackgroundColor3 = C.BG
MainFrame.BorderSizePixel  = 0
MainFrame.Visible          = false
corner(MainFrame, 10)
stroke(MainFrame, C.Border, 1)
MainFrame.Parent = SG

-- ── Top Bar ──────────────────────────────────────────────────
local TopBar = Instance.new("Frame")
TopBar.Size             = UDim2.new(1,0,0,42)
TopBar.BackgroundColor3 = C.BG2
TopBar.BorderSizePixel  = 0
corner(TopBar, 10)
TopBar.Parent = MainFrame

-- koreksi sudut bawah top bar
local TBFix = Instance.new("Frame")
TBFix.Size             = UDim2.new(1,0,0.5,0)
TBFix.Position         = UDim2.new(0,0,0.5,0)
TBFix.BackgroundColor3 = C.BG2
TBFix.BorderSizePixel  = 0
TBFix.ZIndex           = TopBar.ZIndex
TBFix.Parent           = TopBar

-- ikon perisai (ImageLabel sederhana)
local TitleIco = Instance.new("ImageLabel")
TitleIco.Size                 = UDim2.new(0, 18, 0, 18)
TitleIco.Position             = UDim2.new(0, 12, 0.5, -9)
TitleIco.BackgroundTransparency = 1
TitleIco.Image                = "rbxassetid://7733658504"
TitleIco.ImageColor3          = C.Accent
TitleIco.ZIndex               = 2
TitleIco.Parent               = TopBar

local TitleLbl = label(TopBar, "Admin Panel", 14, C.Text, Enum.Font.GothamBold)
TitleLbl.Size     = UDim2.new(1,-110, 1, 0)
TitleLbl.Position = UDim2.new(0, 36, 0, 0)
TitleLbl.ZIndex   = 2

-- Tombol Minimize
local BtnMin = Instance.new("TextButton")
BtnMin.Size             = UDim2.new(0, 26, 0, 26)
BtnMin.Position         = UDim2.new(1, -64, 0.5, -13)
BtnMin.BackgroundColor3 = Color3.fromRGB(215, 155, 0)
BtnMin.Text             = "−"
BtnMin.TextSize         = 18
BtnMin.TextColor3       = Color3.new(1,1,1)
BtnMin.Font             = Enum.Font.GothamBold
BtnMin.AutoButtonColor  = false
BtnMin.ZIndex           = 3
corner(BtnMin, 6)
BtnMin.Parent = TopBar

-- Tombol Close
local BtnClose = Instance.new("TextButton")
BtnClose.Size             = UDim2.new(0, 26, 0, 26)
BtnClose.Position         = UDim2.new(1, -34, 0.5, -13)
BtnClose.BackgroundColor3 = Color3.fromRGB(205, 55, 55)
BtnClose.Text             = "×"
BtnClose.TextSize         = 18
BtnClose.TextColor3       = Color3.new(1,1,1)
BtnClose.Font             = Enum.Font.GothamBold
BtnClose.AutoButtonColor  = false
BtnClose.ZIndex           = 3
corner(BtnClose, 6)
BtnClose.Parent = TopBar

BtnClose.MouseButton1Click:Connect(function()
	TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
		Size     = UDim2.new(0,0,0,0),
		Position = UDim2.new(0.5,0, 0.5,0),
	}):Play()
	task.wait(0.3)
	MainFrame.Visible = false
end)

local minimized = false
BtnMin.MouseButton1Click:Connect(function()
	minimized = not minimized
	if minimized then
		TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
			Size = UDim2.new(0, 388, 0, 42)
		}):Play()
	else
		TweenService:Create(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Back), {
			Size = UDim2.new(0, 388, 0, 505)
		}):Play()
	end
end)

-- ── Drag ─────────────────────────────────────────────────────
do
	local dragging, dragStart, startPos
	TopBar.InputBegan:Connect(function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1
		or inp.UserInputType == Enum.UserInputType.Touch then
			dragging  = true
			dragStart = inp.Position
			startPos  = MainFrame.Position
		end
	end)
	TopBar.InputEnded:Connect(function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1
		or inp.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)
	UserInputService.InputChanged:Connect(function(inp)
		if dragging and (
			inp.UserInputType == Enum.UserInputType.MouseMovement or
			inp.UserInputType == Enum.UserInputType.Touch
		) then
			local d = inp.Position - dragStart
			MainFrame.Position = UDim2.new(
				startPos.X.Scale, startPos.X.Offset + d.X,
				startPos.Y.Scale, startPos.Y.Offset + d.Y
			)
		end
	end)
end

-- ── Area konten ───────────────────────────────────────────────
local Content = Instance.new("Frame")
Content.Name               = "Content"
Content.Size               = UDim2.new(1,-18, 1,-54)
Content.Position           = UDim2.new(0,9, 0,48)
Content.BackgroundTransparency = 1
Content.Parent             = MainFrame

-- ============================================================
--  SEKSI CONNECT
-- ============================================================
local ConnectSec = Instance.new("Frame")
ConnectSec.Size               = UDim2.new(1,0,1,0)
ConnectSec.BackgroundTransparency = 1
ConnectSec.Parent             = Content

-- Status bar
local StatusBar = Instance.new("Frame")
StatusBar.Size             = UDim2.new(1,0,0,56)
StatusBar.BackgroundColor3 = C.BG2
StatusBar.BorderSizePixel  = 0
corner(StatusBar, 8)
stroke(StatusBar, C.Border)
StatusBar.Parent = ConnectSec

local StatusDot = Instance.new("Frame")
StatusDot.Size             = UDim2.new(0,10,0,10)
StatusDot.Position         = UDim2.new(0,12, 0.5,-5)
StatusDot.BackgroundColor3 = C.Error
StatusDot.BorderSizePixel  = 0
corner(StatusDot, 99)
StatusDot.Parent = StatusBar

local StatusLbl = label(StatusBar, "Belum terhubung", 13, C.TextDim)
StatusLbl.Size     = UDim2.new(1,-40, 1, 0)
StatusLbl.Position = UDim2.new(0, 30, 0, 0)

-- Tombol connect
local ConnectBtn = button(ConnectSec, "🔗  Hubungkan ke Server", UDim2.new(1,0,0,42), 14, C.Accent)
ConnectBtn.Position = UDim2.new(0,0,0,66)

local ConnectInfo = label(ConnectSec, "Pastikan script 'No connect' sudah ada di ServerScriptService.", 11, C.TextDim)
ConnectInfo.Size     = UDim2.new(1,0,0,30)
ConnectInfo.Position = UDim2.new(0,0,0,116)
ConnectInfo.TextWrapped = true
ConnectInfo.TextXAlignment = Enum.TextXAlignment.Center

-- ============================================================
--  ADMIN PANEL (tampil setelah connect)
-- ============================================================
local AdminPanel = Instance.new("Frame")
AdminPanel.Name               = "AdminPanel"
AdminPanel.Size               = UDim2.new(1,0,1,0)
AdminPanel.BackgroundTransparency = 1
AdminPanel.Visible            = false
AdminPanel.Parent             = Content

-- ── Tab Bar ──────────────────────────────────────────────────
local TabBar = Instance.new("Frame")
TabBar.Size             = UDim2.new(1,0,0,34)
TabBar.BackgroundColor3 = C.BG2
TabBar.BorderSizePixel  = 0
corner(TabBar, 8)
TabBar.Parent = AdminPanel

local tabNames    = { "Perintah", "Aset", "Output" }
local tabBtns     = {}
local tabContents = {}
local activeTab   = 1

for i, name in ipairs(tabNames) do
	local tb = Instance.new("TextButton")
	tb.Size               = UDim2.new(1/#tabNames, 0, 1, 0)
	tb.Position           = UDim2.new((i-1)/#tabNames, 0, 0, 0)
	tb.BackgroundTransparency = 1
	tb.Text               = name
	tb.TextSize           = 12
	tb.TextColor3         = i == 1 and C.Accent or C.TextDim
	tb.Font               = Enum.Font.GothamSemibold
	tb.AutoButtonColor    = false
	tb.ZIndex             = 2
	tb.Parent             = TabBar
	tabBtns[i]            = tb

	local ind = Instance.new("Frame")
	ind.Name                = "Indicator"
	ind.Size                = UDim2.new(0.65,0,0,2)
	ind.Position            = UDim2.new(0.175,0,1,-2)
	ind.BackgroundColor3    = C.Accent
	ind.BackgroundTransparency = i==1 and 0 or 1
	ind.BorderSizePixel     = 0
	corner(ind, 99)
	ind.ZIndex = 3
	ind.Parent = tb

	tb.MouseButton1Click:Connect(function()
		activeTab = i
		for j, b in ipairs(tabBtns) do
			b.TextColor3 = j==i and C.Accent or C.TextDim
			local ind2 = b:FindFirstChild("Indicator")
			if ind2 then ind2.BackgroundTransparency = j==i and 0 or 1 end
		end
		for j, tc in ipairs(tabContents) do
			tc.Visible = j==i
		end
	end)
end

-- ============================================================
--  TAB 1 — PERINTAH
-- ============================================================
local CmdTab = Instance.new("ScrollingFrame")
CmdTab.Size                 = UDim2.new(1,0,1,-40)
CmdTab.Position             = UDim2.new(0,0,0,40)
CmdTab.BackgroundTransparency = 1
CmdTab.ScrollBarThickness   = 3
CmdTab.ScrollBarImageColor3 = C.Accent
CmdTab.CanvasSize           = UDim2.new(0,0,0,330)
CmdTab.Parent               = AdminPanel
tabContents[1]              = CmdTab

local cmdLL = Instance.new("UIListLayout")
cmdLL.Padding = UDim.new(0, 8)
cmdLL.Parent  = CmdTab

-- Toggle Row helper
local function makeToggle(parent, title, desc, onToggle)
	local row = Instance.new("Frame")
	row.Size             = UDim2.new(1,0,0,58)
	row.BackgroundColor3 = C.BG2
	row.BorderSizePixel  = 0
	corner(row, 8)
	row.Parent = parent

	local lbl2 = label(row, title, 13, C.Text, Enum.Font.GothamSemibold)
	lbl2.Size     = UDim2.new(1,-68,0,20)
	lbl2.Position = UDim2.new(0,12,0,10)

	local dsc = label(row, desc, 11, C.TextDim)
	dsc.Size     = UDim2.new(1,-68,0,16)
	dsc.Position = UDim2.new(0,12,0,32)

	local tBG = Instance.new("Frame")
	tBG.Size             = UDim2.new(0,44,0,24)
	tBG.Position         = UDim2.new(1,-54,0.5,-12)
	tBG.BackgroundColor3 = Color3.fromRGB(48,48,68)
	tBG.BorderSizePixel  = 0
	corner(tBG, 99)
	tBG.Parent = row

	local knob = Instance.new("Frame")
	knob.Size             = UDim2.new(0,18,0,18)
	knob.Position         = UDim2.new(0,3,0.5,-9)
	knob.BackgroundColor3 = Color3.new(1,1,1)
	knob.BorderSizePixel  = 0
	corner(knob, 99)
	knob.Parent = tBG

	local state = false
	local tBtn = Instance.new("TextButton")
	tBtn.Size               = UDim2.new(1,0,1,0)
	tBtn.BackgroundTransparency = 1
	tBtn.Text               = ""
	tBtn.ZIndex             = 2
	tBtn.Parent             = tBG

	tBtn.MouseButton1Click:Connect(function()
		state = not state
		TweenService:Create(tBG, TweenInfo.new(0.2), {
			BackgroundColor3 = state and C.Accent or Color3.fromRGB(48,48,68)
		}):Play()
		TweenService:Create(knob, TweenInfo.new(0.2), {
			Position = state and UDim2.new(1,-21,0.5,-9) or UDim2.new(0,3,0.5,-9)
		}):Play()
		if onToggle then onToggle(state) end
	end)
end

-- Slider Row helper
local function makeSlider(parent, title, mn, mx, def, onChange)
	local row = Instance.new("Frame")
	row.Size             = UDim2.new(1,0,0,68)
	row.BackgroundColor3 = C.BG2
	row.BorderSizePixel  = 0
	corner(row, 8)
	row.Parent = parent

	local lbl2 = label(row, title, 13, C.Text, Enum.Font.GothamSemibold)
	lbl2.Size     = UDim2.new(1,-60,0,20)
	lbl2.Position = UDim2.new(0,12,0,8)

	local valLbl = label(row, tostring(def), 13, C.Accent, Enum.Font.GothamBold)
	valLbl.Size     = UDim2.new(0,50,0,20)
	valLbl.Position = UDim2.new(1,-60,0,8)
	valLbl.TextXAlignment = Enum.TextXAlignment.Right

	local slBG = Instance.new("Frame")
	slBG.Size             = UDim2.new(1,-24,0,6)
	slBG.Position         = UDim2.new(0,12,0,44)
	slBG.BackgroundColor3 = Color3.fromRGB(30,34,58)
	slBG.BorderSizePixel  = 0
	corner(slBG, 99)
	slBG.Parent = row

	local slFill = Instance.new("Frame")
	slFill.Size             = UDim2.new((def-mn)/(mx-mn),0,1,0)
	slFill.BackgroundColor3 = C.Accent
	slFill.BorderSizePixel  = 0
	corner(slFill, 99)
	slFill.Parent = slBG

	local knob2 = Instance.new("Frame")
	knob2.Size         = UDim2.new(0,14,0,14)
	knob2.AnchorPoint  = Vector2.new(0.5,0.5)
	knob2.Position     = UDim2.new((def-mn)/(mx-mn),0,0.5,0)
	knob2.BackgroundColor3 = Color3.new(1,1,1)
	knob2.BorderSizePixel  = 0
	knob2.ZIndex       = 2
	corner(knob2, 99)
	knob2.Parent = slBG

	local curVal = def
	local sliding = false

	local function update(mouseX)
		local ap = slBG.AbsolutePosition.X
		local as = slBG.AbsoluteSize.X
		local frac = math.clamp((mouseX - ap) / as, 0, 1)
		curVal = math.floor(mn + frac*(mx-mn))
		valLbl.Text = tostring(curVal)
		slFill.Size = UDim2.new(frac,0,1,0)
		knob2.Position = UDim2.new(frac,0,0.5,0)
		if onChange then onChange(curVal) end
	end

	local hitBox = Instance.new("TextButton")
	hitBox.Size               = UDim2.new(1,0,0,30)
	hitBox.Position           = UDim2.new(0,0,0,-12)
	hitBox.BackgroundTransparency = 1
	hitBox.Text               = ""
	hitBox.ZIndex             = 3
	hitBox.Parent             = slBG
	hitBox.MouseButton1Down:Connect(function() sliding = true end)
	hitBox.MouseButton1Up:Connect(function()   sliding = false end)
	hitBox.MouseLeave:Connect(function()
		if not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
			sliding = false
		end
	end)
	hitBox.MouseButton1Click:Connect(function()
		update(UserInputService:GetMouseLocation().X)
	end)
	UserInputService.InputChanged:Connect(function(inp)
		if sliding and inp.UserInputType == Enum.UserInputType.MouseMovement then
			update(inp.Position.X)
		end
	end)
end

-- Fly toggle
makeToggle(CmdTab, "✈  Terbang (Fly)", "Terbang bebas dengan WASD + Space/Shift", function(state)
	isFlying = state
	if AdminRemotes then
		AdminRemotes.AdminCommand:FireServer(state and "fly_on" or "fly_off")
	end
	if not state then
		local char = player.Character
		if char then
			local hum = char:FindFirstChildOfClass("Humanoid")
			if hum then hum.PlatformStand = false end
		end
	end
end)

-- Speed slider
makeSlider(CmdTab, "⚡  Kecepatan Jalan", 4, 200, 16, function(val)
	if AdminRemotes then
		AdminRemotes.AdminCommand:FireServer("speed", val)
	end
end)

-- Jump slider
makeSlider(CmdTab, "⬆  Kekuatan Lompat", 10, 300, 50, function(val)
	if AdminRemotes then
		AdminRemotes.AdminCommand:FireServer("jump", val)
	end
end)

-- NoClip toggle
makeToggle(CmdTab, "👻  NoClip", "Menembus dinding dan lantai", function(state)
	if AdminRemotes then
		AdminRemotes.AdminCommand:FireServer(state and "noclip_on" or "noclip_off")
	end
end)

-- ============================================================
--  TAB 2 — ASET
-- ============================================================
local AssetTab = Instance.new("Frame")
AssetTab.Name                 = "AssetTab"
AssetTab.Size                 = UDim2.new(1,0,1,-40)
AssetTab.Position             = UDim2.new(0,0,0,40)
AssetTab.BackgroundTransparency = 1
AssetTab.Visible              = false
AssetTab.Parent               = AdminPanel
tabContents[2]                = AssetTab

local asLL = Instance.new("UIListLayout")
asLL.Padding = UDim.new(0, 8)
asLL.Parent  = AssetTab

-- Asset ID input
local AIDFrame = Instance.new("Frame")
AIDFrame.Size             = UDim2.new(1,0,0,56)
AIDFrame.BackgroundColor3 = C.BG2
AIDFrame.BorderSizePixel  = 0
corner(AIDFrame, 8)
AIDFrame.Parent = AssetTab

label(AIDFrame, "Asset ID", 11, C.TextDim).Position = UDim2.new(0,12,0,6)
;(function()
	local l = AIDFrame:FindFirstChildOfClass("TextLabel")
	l.Size = UDim2.new(1,-20,0,18)
end)()

local AIDBox = Instance.new("TextBox")
AIDBox.Size               = UDim2.new(1,-24,0,26)
AIDBox.Position           = UDim2.new(0,12,0,24)
AIDBox.BackgroundColor3   = C.BG3
AIDBox.BorderSizePixel    = 0
AIDBox.Text               = ""
AIDBox.PlaceholderText    = "Contoh: 235400037"
AIDBox.TextSize           = 12
AIDBox.TextColor3         = C.Text
AIDBox.PlaceholderColor3  = C.TextDim
AIDBox.Font               = Enum.Font.Gotham
AIDBox.ClearTextOnFocus   = false
corner(AIDBox, 6)
pad(AIDBox, 0, 0, 8, 8)
AIDBox.Parent = AIDFrame

-- Lokasi tujuan
local LocFrame = Instance.new("Frame")
LocFrame.Size             = UDim2.new(1,0,0,58)
LocFrame.BackgroundColor3 = C.BG2
LocFrame.BorderSizePixel  = 0
corner(LocFrame, 8)
LocFrame.Parent = AssetTab

local locLbl = label(LocFrame, "Lokasi Tujuan", 11, C.TextDim)
locLbl.Size     = UDim2.new(1,-20,0,18)
locLbl.Position = UDim2.new(0,12,0,6)

local locBtnRow = Instance.new("Frame")
locBtnRow.Size               = UDim2.new(1,-24,0,26)
locBtnRow.Position           = UDim2.new(0,12,0,26)
locBtnRow.BackgroundTransparency = 1
locBtnRow.Parent = LocFrame

local lbLL = Instance.new("UIListLayout")
lbLL.FillDirection = Enum.FillDirection.Horizontal
lbLL.Padding       = UDim.new(0,4)
lbLL.Parent        = locBtnRow

local locations  = { "WorldSpace", "ServerStorage", "ServerScriptService", "Output" }
local locLabels  = { "World",       "Storage",       "Scripts",             "Output" }
local selectedLoc = 1
local locBtns     = {}

for i, lname in ipairs(locLabels) do
	local lb = Instance.new("TextButton")
	lb.Size             = UDim2.new(0,82,1,0)
	lb.BackgroundColor3 = i==1 and C.Accent or C.BG3
	lb.Text             = lname
	lb.TextSize         = 10
	lb.TextColor3       = C.Text
	lb.Font             = Enum.Font.GothamSemibold
	lb.AutoButtonColor  = false
	corner(lb, 4)
	lb.Parent   = locBtnRow
	locBtns[i]  = lb
	lb.MouseButton1Click:Connect(function()
		selectedLoc = i
		for j, b in ipairs(locBtns) do
			TweenService:Create(b, TweenInfo.new(0.15), {
				BackgroundColor3 = j==i and C.Accent or C.BG3
			}):Play()
		end
	end)
end

-- Username input
local UnameFrame = Instance.new("Frame")
UnameFrame.Size             = UDim2.new(1,0,0,56)
UnameFrame.BackgroundColor3 = C.BG2
UnameFrame.BorderSizePixel  = 0
corner(UnameFrame, 8)
UnameFrame.Parent = AssetTab

local uLbl = label(UnameFrame, "Username (untuk require)", 11, C.TextDim)
uLbl.Size     = UDim2.new(1,-20,0,18)
uLbl.Position = UDim2.new(0,12,0,6)

local UnameBox = Instance.new("TextBox")
UnameBox.Size             = UDim2.new(1,-24,0,26)
UnameBox.Position         = UDim2.new(0,12,0,24)
UnameBox.BackgroundColor3 = C.BG3
UnameBox.BorderSizePixel  = 0
UnameBox.Text             = player.Name
UnameBox.TextSize         = 12
UnameBox.TextColor3       = C.Text
UnameBox.Font             = Enum.Font.Gotham
UnameBox.ClearTextOnFocus = false
corner(UnameBox, 6)
pad(UnameBox, 0, 0, 8, 8)
UnameBox.Parent = UnameFrame

-- Preview require()
local PreviewLbl = label(AssetTab, 'require(ID).Pload("username")', 11, C.TextDim, Enum.Font.Code)
PreviewLbl.Size = UDim2.new(1,0,0,18)

local function updatePreview()
	local id = AIDBox.Text ~= "" and AIDBox.Text or "ID"
	local un = UnameBox.Text ~= "" and UnameBox.Text or "username"
	PreviewLbl.Text = 'require(' .. id .. ').Pload("' .. un .. '")'
end
AIDBox:GetPropertyChangedSignal("Text"):Connect(updatePreview)
UnameBox:GetPropertyChangedSignal("Text"):Connect(updatePreview)

-- Tombol aksi
local ActRow = Instance.new("Frame")
ActRow.Size               = UDim2.new(1,0,0,36)
ActRow.BackgroundTransparency = 1
ActRow.Parent = AssetTab

local actLL = Instance.new("UIListLayout")
actLL.FillDirection = Enum.FillDirection.Horizontal
actLL.Padding       = UDim.new(0,8)
actLL.Parent        = ActRow

local BtnLoad    = button(ActRow, "📦  Load Asset", UDim2.new(0.5,-4,1,0), 12, C.Accent)
local BtnRequire = button(ActRow, "⚙  Require",     UDim2.new(0.5,-4,1,0), 12, Color3.fromRGB(105,55,210))

-- ============================================================
--  TAB 3 — OUTPUT
-- ============================================================
local OutTab = Instance.new("Frame")
OutTab.Name               = "OutTab"
OutTab.Size               = UDim2.new(1,0,1,-40)
OutTab.Position           = UDim2.new(0,0,0,40)
OutTab.BackgroundColor3   = C.BG2
OutTab.BorderSizePixel    = 0
corner(OutTab, 8)
OutTab.Visible            = false
OutTab.Parent             = AdminPanel
tabContents[3]            = OutTab

local OutScroll = Instance.new("ScrollingFrame")
OutScroll.Size                 = UDim2.new(1,-8,1,-38)
OutScroll.Position             = UDim2.new(0,4,0,4)
OutScroll.BackgroundTransparency = 1
OutScroll.ScrollBarThickness   = 2
OutScroll.ScrollBarImageColor3 = C.Accent
OutScroll.AutomaticCanvasSize  = Enum.AutomaticSize.Y
OutScroll.CanvasSize           = UDim2.new(0,0,0,0)
OutScroll.Parent               = OutTab

local outLL = Instance.new("UIListLayout")
outLL.Padding = UDim.new(0,2)
outLL.Parent  = OutScroll

local function addOutput(msg, col)
	local ln = Instance.new("TextLabel")
	ln.Size                 = UDim2.new(1,-6,0,0)
	ln.AutomaticSize        = Enum.AutomaticSize.Y
	ln.BackgroundTransparency = 1
	ln.Text                 = msg
	ln.TextSize             = 11
	ln.TextColor3           = col or C.Text
	ln.Font                 = Enum.Font.Code
	ln.TextXAlignment       = Enum.TextXAlignment.Left
	ln.TextWrapped          = true
	ln.Parent               = OutScroll
	task.wait()
	OutScroll.CanvasPosition = Vector2.new(0, 99999)
end

local ClearBtn = button(OutTab, "Bersihkan Output", UDim2.new(1,-8,0,26), 11, C.BG3)
ClearBtn.Position = UDim2.new(0,4,1,-30)
ClearBtn.MouseButton1Click:Connect(function()
	for _, c in ipairs(OutScroll:GetChildren()) do
		if c:IsA("TextLabel") then c:Destroy() end
	end
end)

-- ── Asset Button Handlers ────────────────────────────────────
BtnLoad.MouseButton1Click:Connect(function()
	if not isConnected then
		addOutput("[!] Belum terhubung ke server.", C.Error)
		return
	end
	local id = tonumber(AIDBox.Text)
	if not id then
		addOutput("[!] Asset ID tidak valid.", C.Error)
		return
	end
	local loc = locations[selectedLoc]
	addOutput("[~] Memuat asset " .. id .. " ke " .. loc .. "...", C.Warning)
	AdminRemotes.AssetAction:FireServer("load", id, loc, UnameBox.Text)
end)

BtnRequire.MouseButton1Click:Connect(function()
	if not isConnected then
		addOutput("[!] Belum terhubung ke server.", C.Error)
		return
	end
	local id = tonumber(AIDBox.Text)
	if not id then
		addOutput("[!] Asset ID tidak valid.", C.Error)
		return
	end
	addOutput('[~] require(' .. id .. ').Pload("' .. UnameBox.Text .. '")...', C.Warning)
	AdminRemotes.AssetAction:FireServer("require", id, locations[selectedLoc], UnameBox.Text)
end)

-- ============================================================
--  CONNECT HANDLER
-- ============================================================
ConnectBtn.MouseButton1Click:Connect(function()
	if isConnected then return end
	ConnectBtn.Text = "⏳  Menghubungkan..."
	TweenService:Create(ConnectBtn, TweenInfo.new(0.15), { BackgroundColor3 = C.AccentDark }):Play()

	local remotes = ReplicatedStorage:WaitForChild("AdminRemotes", 8)
	if not remotes then
		StatusLbl.Text = "Connection failed — remotes tidak ada"
		StatusDot.BackgroundColor3 = C.Error
		ConnectBtn.Text = "🔗  Coba Lagi"
		TweenService:Create(ConnectBtn, TweenInfo.new(0.15), { BackgroundColor3 = C.Accent }):Play()
		addOutput("[✗] Gagal: Script 'No connect' tidak ditemukan di ServerScriptService.", C.Error)
		return
	end

	AdminRemotes = remotes

	local cf = remotes:WaitForChild("ConnectAdmin", 5)
	if not cf then
		StatusLbl.Text = "Connection failed"
		StatusDot.BackgroundColor3 = C.Error
		ConnectBtn.Text = "🔗  Coba Lagi"
		TweenService:Create(ConnectBtn, TweenInfo.new(0.15), { BackgroundColor3 = C.Accent }):Play()
		addOutput("[✗] RemoteFunction tidak ditemukan.", C.Error)
		return
	end

	local ok, result = pcall(function() return cf:InvokeServer() end)

	if ok and result and result.success then
		isConnected = true
		StatusLbl.Text = "Connected successfully ✓"
		StatusDot.BackgroundColor3 = C.Success

		TweenService:Create(ConnectBtn, TweenInfo.new(0.3), {
			BackgroundTransparency = 1, TextTransparency = 1
		}):Play()
		task.wait(0.35)
		ConnectSec.Visible = false

		AdminPanel.Visible  = true
		AdminPanel.Position = UDim2.new(0,0,0.08,0)
		TweenService:Create(AdminPanel, TweenInfo.new(0.4, Enum.EasingStyle.Back), {
			Position = UDim2.new(0,0,0,0)
		}):Play()

		-- Listen hasil asset
		remotes.AssetResult.OnClientEvent:Connect(function(success2, msg)
			addOutput((success2 and "[✓] " or "[✗] ") .. msg, success2 and C.Success or C.Error)
		end)

		addOutput("[✓] Berhasil terhubung ke Admin Panel!", C.Success)
		addOutput("[i] Gunakan tab Perintah, Aset, dan Output di atas.", C.TextDim)
	else
		StatusLbl.Text = "Connection failed"
		StatusDot.BackgroundColor3 = C.Error
		ConnectBtn.Text = "🔗  Coba Lagi"
		TweenService:Create(ConnectBtn, TweenInfo.new(0.15), { BackgroundColor3 = C.Accent }):Play()
		addOutput("[✗] Gagal terhubung: " .. tostring(result), C.Error)
	end
end)

-- ============================================================
--  FLY — Kirim arah ke server tiap frame
-- ============================================================
RunService.Heartbeat:Connect(function()
	if not isFlying or not isConnected or not AdminRemotes then return end
	local char = player.Character
	if not char then return end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	local cam     = Camera
	local moveDir = Vector3.zero

	if UserInputService:IsKeyDown(Enum.KeyCode.W) then
		moveDir = moveDir + cam.CFrame.LookVector
	end
	if UserInputService:IsKeyDown(Enum.KeyCode.S) then
		moveDir = moveDir - cam.CFrame.LookVector
	end
	if UserInputService:IsKeyDown(Enum.KeyCode.A) then
		moveDir = moveDir - cam.CFrame.RightVector
	end
	if UserInputService:IsKeyDown(Enum.KeyCode.D) then
		moveDir = moveDir + cam.CFrame.RightVector
	end
	if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
		moveDir = moveDir + Vector3.new(0,1,0)
	end
	if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
		moveDir = moveDir - Vector3.new(0,1,0)
	end

	local vel = moveDir.Magnitude > 0 and moveDir.Unit * flySpeed or Vector3.zero
	local cf  = CFrame.new(hrp.Position, hrp.Position + cam.CFrame.LookVector)

	AdminRemotes.AdminCommand:FireServer("fly_update", vel, cf)
end)

-- ============================================================
--  TAMPIL MAIN FRAME setelah loading selesai
-- ============================================================
local function showMain()
	MainFrame.Visible  = true
	MainFrame.Size     = UDim2.new(0,0,0,0)
	MainFrame.Position = UDim2.new(0.5,0, 0.5,0)
	TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
		Size     = UDim2.new(0, 388, 0, 505),
		Position = UDim2.new(0.5,-194, 0.5,-252),
	}):Play()
end

-- ── START ────────────────────────────────────────────────────
runLoading(showMain)

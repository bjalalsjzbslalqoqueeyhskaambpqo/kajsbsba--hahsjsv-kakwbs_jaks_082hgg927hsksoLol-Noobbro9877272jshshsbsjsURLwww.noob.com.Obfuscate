local Players = game:GetService("Players")
local player = Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")
local StarterGui = game:GetService("StarterGui")

local dialogProcessing = false
local lastTextChecked = ""
local keywords = {
	sakura = {delay = 70, action = "collectionMode"},
	tokio = {delay = 70, action = "destructionMode"},
	tokyo = {delay = 70, action = "destructionMode"},
	toykyo = {delay = 70, action = "destructionMode"}
}

local buttonsContainer = nil

local function testGUIElement(element)
	if not element or not element:IsA("GuiObject") then return end
	local events = {"MouseButton1Click", "MouseButton2Click", "MouseEnter", "MouseLeave", "Activated", "Changed", "Focused", "FocusLost", "InputBegan", "InputEnded", "MouseButton1Down", "MouseButton1Up", "MouseButton2Down", "MouseButton2Up", "MouseMoved", "InputChanged", "TouchTap", "TouchLongTap"}
	for _, eventName in ipairs(events) do
		pcall(function()
			if typeof(element[eventName]) == "RBXScriptSignal" then
				local connections = getconnections(element[eventName])
				for _, conn in ipairs(connections) do
					conn:Fire()
				end
			end
		end)
	end
end

local function activateYesButton(button)
	pcall(function()
		testGUIElement(button)
		wait(1)
		testGUIElement(button)
	end)
end

local function setupButtonDetection(container)
	pcall(function()
	container = container or buttonsContainer
	for _, button in ipairs(container:GetChildren()) do
		if button:IsA("ImageButton") then
			local textLabel = button:FindFirstChildWhichIsA("TextLabel", true)
			if textLabel and textLabel.Text == "Yes" then
				activateYesButton(button)
			end
		end
	end
		end)
	task.wait(1)
	container.ChildAdded:Connect(function(button)
		if button:IsA("ImageButton") then
			local textLabel = button:FindFirstChildWhichIsA("TextLabel", true)
			if textLabel and textLabel.Text == "Yes" then
				dialogProcessing = true
				activateYesButton(button)
				task.spawn(function()
					wait(30)
					dialogProcessing = false
				end)
			end
		end
	end)
end

local function connectIfReady()
	local dialogApp = gui:FindFirstChild("DialogApp")
	if not dialogApp then return end
	local dialog = dialogApp:FindFirstChild("Dialog")
	if not dialog then return end
	local normalDialog = dialog:FindFirstChild("NormalDialog")
	if not normalDialog then return end
	local info = normalDialog:FindFirstChild("Info")
	if not info then return end
	local infoText = info:FindFirstChild("TextLabel")
	if infoText then
		infoText:GetPropertyChangedSignal("Text"):Connect(function()
			checkTextForKeywords(infoText.Text)
		end)
	end
	local buttons = normalDialog:FindFirstChild("Buttons")
	if buttons then
		buttonsContainer = buttons
		setupButtonDetection(buttons)
	end
end

local function notify(text)
    pcall(function()
        local StarterGui = game:GetService("StarterGui")
        local Players = game:GetService("Players")
        local player = Players.LocalPlayer
        local gui = player:WaitForChild("PlayerGui")
        
        local notificationGui = Instance.new("ScreenGui")
        notificationGui.Name = "CustomNotification"
        notificationGui.ResetOnSpawn = false
        notificationGui.Parent = gui
        
        local mainFrame = Instance.new("Frame")
        mainFrame.Size = UDim2.new(0, 280, 0, 70)
        mainFrame.Position = UDim2.new(1, 10, 0.8, 0)
        mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        mainFrame.BorderSizePixel = 0
        mainFrame.Parent = notificationGui
        
        local cornerRadius = Instance.new("UICorner")
        cornerRadius.CornerRadius = UDim.new(0, 8)
        cornerRadius.Parent = mainFrame
        
        local stroke = Instance.new("UIStroke")
        stroke.Color = Color3.fromRGB(255, 200, 50)
        stroke.Thickness = 2
        stroke.Transparency = 0.2
        stroke.Parent = mainFrame
        
        local gradient = Instance.new("UIGradient")
        gradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 45, 45)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 25))
        })
        gradient.Rotation = 90
        gradient.Parent = mainFrame
        
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Size = UDim2.new(1, -20, 0, 25)
        titleLabel.Position = UDim2.new(0, 10, 0, 8)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = "Notificación"
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.TextSize = 16
        titleLabel.TextColor3 = Color3.fromRGB(255, 200, 50)
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.Parent = mainFrame
        
        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, -20, 0, 30)
        textLabel.Position = UDim2.new(0, 10, 0, 33)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = text
        textLabel.Font = Enum.Font.Gotham
        textLabel.TextSize = 14
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        textLabel.TextXAlignment = Enum.TextXAlignment.Left
        textLabel.TextWrapped = true
        textLabel.Parent = mainFrame
        
        mainFrame:TweenPosition(
            UDim2.new(0.98, -280, 0.8, 0),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quart,
            0.4,
            true
        )
        
        task.spawn(function()
            task.wait(4)
            if notificationGui and notificationGui.Parent then
                mainFrame:TweenPosition(
                    UDim2.new(1, 10, 0.8, 0),
                    Enum.EasingDirection.In,
                    Enum.EasingStyle.Quart,
                    0.4,
                    true,
                    function()
                        notificationGui:Destroy()
                    end
                )
            end
        end)
    end)
end

local function runDestructionMode()
	task.spawn(function()
		local player = game.Players.LocalPlayer
		repeat task.wait() until player.Character and player.Character:FindFirstChild("HumanoidRootPart")
		local humanoidRootPart = player.Character:WaitForChild("HumanoidRootPart")
		local map = nil
		repeat
			map = (function()
				for _, interior in ipairs(workspace.Interiors:GetChildren()) do
					if interior:FindFirstChild("Programmed") and interior.Programmed:FindFirstChild("Map") then
						return interior.Programmed.Map
					end
				end
				return nil
			end)()
			task.wait()
		until map
		task.wait(10)
		local function isColorBlocked(color)
			local r, g, b = math.round(color.R * 255), math.round(color.G * 255), math.round(color.B * 255)
			local blocked = {["175,175,175"] = true, ["200,200,200"] = true, ["229,229,229"] = true}
			return blocked[("%d,%d,%d"):format(r, g, b)] == true
		end
		local function isDestructible(model)
			for _, part in ipairs(model:GetDescendants()) do
				if part:IsA("MeshPart") and not isColorBlocked(part.Color) then
					return true
				end
			end
			return false
		end
		local function getClosestValidRoot(map, minDist)
			local buildingsFolder = nil
			for _, child in ipairs(map:GetChildren()) do
				if child:IsA("Folder") and child.Name == "Buildings" then
					buildingsFolder = child
					break
				end
			end
			if not buildingsFolder then return nil end
			local currentPos = humanoidRootPart.Position
			local closest, closestDist = nil, math.huge
			for _, model in ipairs(buildingsFolder:GetChildren()) do
				if model:IsA("Model") and isDestructible(model) then
					local root = model:FindFirstChild("Root", true)
					if root and root:IsA("BasePart") and root:IsDescendantOf(workspace) then
						local dist = (Vector3.new(root.Position.X, 0, root.Position.Z) - Vector3.new(currentPos.X, 0, currentPos.Z)).Magnitude
						if dist >= minDist and dist < closestDist then
							closest = root
							closestDist = dist
						end
					end
				end
			end
			return closest
		end
		local minDistance = 4
		local growthTimer = 0
		while true do
			local currentMap = nil
			for _, interior in ipairs(workspace.Interiors:GetChildren()) do
				if interior:FindFirstChild("Programmed") and interior.Programmed:FindFirstChild("Map") then
					currentMap = interior.Programmed.Map
					break
				end
			end
			if not currentMap then break end
			local target = getClosestValidRoot(currentMap, minDistance)
			if not target then
				task.wait(1)
			else
				humanoidRootPart.CanCollide = false
				local startPos = humanoidRootPart.Position
				local endPos = Vector3.new(target.Position.X, startPos.Y, target.Position.Z)
				local t = 0
				while t < 1 do
					if not target:IsDescendantOf(workspace) then break end
					local newPos = startPos:Lerp(endPos, t)
					local oscillation = math.sin(t * math.pi * 6) * 10
					local lookVector = (endPos - startPos).Unit
					humanoidRootPart.CFrame = CFrame.new(newPos, newPos + lookVector) * CFrame.Angles(0, math.rad(oscillation), 0)
					t = t + 0.05
					task.wait(0.02)
				end
			end
			growthTimer = growthTimer + 1
			if growthTimer % 20 == 0 then
				minDistance = math.min(minDistance * 1.5, 80)
			end
		end
	end)
end



local max = 60000

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")

local sg = Instance.new("ScreenGui", gui)
sg.Name = "FarmUI"
sg.ResetOnSpawn = false

local mainF = Instance.new("Frame", sg)
mainF.Size = UDim2.new(0, 340, 0, 180)
mainF.Position = UDim2.new(0.5, -170, 0.5, -90)
mainF.BackgroundTransparency = 0.1
mainF.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainF.BorderSizePixel = 0
mainF.Active = true
mainF.Draggable = true

Instance.new("UICorner", mainF).CornerRadius = UDim.new(0, 14)

local mainGrad = Instance.new("UIGradient", mainF)
mainGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 45, 45)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 10))
})
mainGrad.Rotation = 90

local mainStroke = Instance.new("UIStroke", mainF)
mainStroke.Color = Color3.fromRGB(255, 180, 50)
mainStroke.Thickness = 2
mainStroke.Transparency = 0.3

local titleContainer = Instance.new("Frame", mainF)
titleContainer.Size = UDim2.new(1, -40, 0, 40)
titleContainer.Position = UDim2.new(0, 20, 0, 10)
titleContainer.BackgroundTransparency = 1

local title = Instance.new("TextLabel", titleContainer)
title.Size = UDim2.new(1, 0, 1, 0)
title.Text = "FARM - OneCreatorX"
title.Font = Enum.Font.GothamBlack
title.TextSize = 26
title.TextTransparency = 0.1
title.TextXAlignment = Enum.TextXAlignment.Center
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 255, 255)

local titleGradient = Instance.new("UIGradient", title)
titleGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 230, 100)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 200, 50)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 180, 30))
})
titleGradient.Rotation = -45

local titleDivider = Instance.new("Frame", titleContainer)
titleDivider.Size = UDim2.new(1, -40, 0, 2)
titleDivider.Position = UDim2.new(0, 20, 1, -5)
titleDivider.BackgroundColor3 = Color3.fromRGB(255, 200, 50)
titleDivider.BorderSizePixel = 0

local label = Instance.new("TextLabel", mainF)
label.Size = UDim2.new(1, -40, 0, 20)
label.Position = UDim2.new(0, 20, 0, 65)
label.BackgroundTransparency = 1
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.Font = Enum.Font.GothamSemibold
label.TextSize = 16
label.Text = "Sakura Max Points"
label.TextXAlignment = Enum.TextXAlignment.Left

local inputBox = Instance.new("TextBox", mainF)
inputBox.Name = "MaxPointsInput"
inputBox.Text = "60.000"
inputBox.Size = UDim2.new(0, 120, 0, 30)
inputBox.Position = UDim2.new(0, 20, 0, 95)
inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
inputBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
inputBox.Font = Enum.Font.GothamMedium
inputBox.TextSize = 14
inputBox.PlaceholderText = "Ej: 30.000"
inputBox.ClearTextOnFocus = false

Instance.new("UICorner", inputBox).CornerRadius = UDim.new(0, 6)

inputBox.FocusLost:Connect(function()
	local text = inputBox.Text:gsub("%.", "")
	local num = tonumber(text)
	if num then
		max = num
		local formatted = tostring(num):reverse():gsub("(%d%d%d)", "%1."):reverse():gsub("^%.", "")
		inputBox.Text = formatted
			notify(inputBox.Text)
	else
		inputBox.Text = "60.000"
			
		max = 60000
	end
end)


local stopped = false

local minMargen = math.floor(max * 0.85)
local maxMargen = math.floor(max * 0.98)
local margenObjetivo = math.random(minMargen, maxMargen)

local function runCollectionMode()
stopped = false
	task.spawn(function()
		local interior = nil
		repeat
			interior = workspace:FindFirstChild("Interiors") and workspace.Interiors:FindFirstChild("BlossomShakedownInterior")
			task.wait(0.5)
		until interior

		task.wait(10)

		local function collectRings()
			if stopped or not interior or not interior:FindFirstChild("RingPickups") then return end
			local character = player.Character or player.CharacterAdded:Wait()

			for _, ring in ipairs(interior.RingPickups:GetChildren()) do
				if stopped then return end
				if ring:IsA("Model") then
					local goal = ring:GetPivot().Position
					for t = 0, 1, 0.03 do
						local label = player.PlayerGui.MinigameInGameApp.Body.Right.Container.ValueLabel
						local text = label and label.Text
						local value = tonumber(text and text:gsub("%.", ""))
						if value and value >= margenObjetivo then
							stopped = true
							return
						end
						if character and character:IsDescendantOf(workspace) then
							character:PivotTo(character:GetPivot():Lerp(CFrame.new(goal), t))
							task.wait()
						else
							break
						end
					end
				end
			end
		end

		while not stopped do
			collectRings()
			task.wait(5)
		end
	end)
end



function checkTextForKeywords(text)
	if text == lastTextChecked then return end
	lastTextChecked = text
	local textLower = text:lower()
	for word, config in pairs(keywords) do
		if textLower:find(word:lower()) then
			notify("Nuevo minijuego detectado: " .. word)
			task.spawn(function()
				if config.action == "destructionMode" then
					runDestructionMode()
				elseif config.action == "collectionMode" then
					runCollectionMode()
				end
			end)
			pcall(function()
			setupButtonDetection(buttonsContainer)
				end)
			break
		end
	end
end

local dialogAppPath = gui:WaitForChild("DialogApp"):WaitForChild("Dialog"):WaitForChild("NormalDialog")
local infoTextRef = dialogAppPath:WaitForChild("Info"):WaitForChild("TextLabel")
local buttonsContainerRef = dialogAppPath:WaitForChild("Buttons")
infoTextRef:GetPropertyChangedSignal("Text"):Connect(function()
	checkTextForKeywords(infoTextRef.Text)
end)

gui.DescendantAdded:Connect(function(descendant)
	if descendant:IsA("TextLabel") and descendant.Name == "TextLabel" then
		local fullPath = descendant:GetFullName()
		if fullPath:find("DialogApp.Dialog.NormalDialog.Info.TextLabel") then
			descendant:GetPropertyChangedSignal("Text"):Connect(function()
				checkTextForKeywords(descendant.Text)
			end)
		end
	end
	if descendant:IsA("ImageButton") and descendant.Parent and descendant.Parent.Name == "Buttons" then
		local fullPath = descendant:GetFullName()
		if fullPath:find("DialogApp.Dialog.NormalDialog.Buttons") then
			local textLabel = descendant:FindFirstChildWhichIsA("TextLabel", true)
			if textLabel and textLabel.Text == "Yes" then
				dialogProcessing = true
				activateYesButton(descendant)
				task.spawn(function()
					wait(30)
					dialogProcessing = false
				end)
			end
		end
	end
end)

workspace:WaitForChild("Interiors").ChildAdded:Connect(function(child)
	if child.Name == "MainMap!Default" and not dialogProcessing then
		wait(15)
		if not dialogProcessing then
			notify("Transportando a la zona afk")
			local character = player.Character or player.CharacterAdded:Wait()
			local rootPart = character:WaitForChild("HumanoidRootPart")
			rootPart.CFrame = CFrame.new(49, 31, -1370)
		end
	end
end)

spawn(function()
pcall(function()
				local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local NetworkClient = game:GetService("NetworkClient")
local VirtualUser = game:GetService("VirtualUser")

NetworkClient.ChildRemoved:Connect(function()
    if #Players:GetPlayers() <= 1 then
        Players.LocalPlayer:Kick("\nReconectando automáticamente...")
        task.wait(1)
        TeleportService:Teleport(game.PlaceId, Players.LocalPlayer)
    else
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, Players.LocalPlayer)
    end
end)

Players.LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)

			end)


	end)


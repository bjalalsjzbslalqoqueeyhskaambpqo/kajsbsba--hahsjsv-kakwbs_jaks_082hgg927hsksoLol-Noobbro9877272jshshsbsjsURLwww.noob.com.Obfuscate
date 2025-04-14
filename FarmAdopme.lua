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

local function getConnectionInfo(func)
	if not func then return "Función desconocida" end
	local name = debug.info(func, "n") or "Anónima"
	local source = debug.info(func, "s")
	local line = debug.info(func, "l")
	local src = source and source:match("([^/]+)$") or "Desconocido"
	return string.format("%s (%s:%s)", name, src, line or "?")
end

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

local buttonsContainer = nil

local function setupButtonDetection(container)
	container = container or buttonsContainer
	for _, button in ipairs(container:GetChildren()) do
		if button:IsA("ImageButton") then
			local textLabel = button:FindFirstChildWhichIsA("TextLabel", true)
			if textLabel and textLabel.Text == "Yes" then
				activateYesButton(button)
			end
		end
	end
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
		StarterGui:SetCore("SendNotification", {Title = "Notificación", Text = text, Duration = 4})
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

local function runCollectionMode()
	task.spawn(function()
		local interior = nil
		repeat
			interior = workspace:FindFirstChild("Interiors") and workspace.Interiors:FindFirstChild("BlossomShakedownInterior")
			task.wait(0.5)
		until interior
		task.wait(10)
		local function collectRings()
			if not interior or not interior:FindFirstChild("RingPickups") then return end
			local character = player.Character or player.CharacterAdded:Wait()
			for _, ring in ipairs(interior.RingPickups:GetChildren()) do
				if ring:IsA("Model") then
					local goal = ring:GetPivot().Position
					for t = 0, 1, 0.03 do
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
		collectRings()
		task.wait(5)
		collectRings()
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
			setupButtonDetection(buttonsContainer)
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

pcall(function()
	StarterGui:SetCore("SendNotification", {Title = "Success", Text = "Listo", Duration = 3})
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

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local p = Players.LocalPlayer
local gui = p:WaitForChild("PlayerGui")

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

local mainCorner = Instance.new("UICorner", mainF)
mainCorner.CornerRadius = UDim.new(0, 14)

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

local timerContainer = Instance.new("Frame", mainF)
timerContainer.Size = UDim2.new(1, -40, 0, 100)
timerContainer.Position = UDim2.new(0, 20, 0, 60)
timerContainer.BackgroundTransparency = 1

local listLayout = Instance.new("UIListLayout", timerContainer)
listLayout.FillDirection = Enum.FillDirection.Horizontal
listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
listLayout.VerticalAlignment = Enum.VerticalAlignment.Center
listLayout.Padding = UDim.new(0, 8)

local function createDigitBox()
    local container = Instance.new("Frame", timerContainer)
    container.Size = UDim2.new(0, 42, 0, 64)
    container.BackgroundTransparency = 1
    container.ClipsDescendants = true
    
    local box = Instance.new("Frame", container)
    box.Size = UDim2.new(1, 0, 1, 0)
    box.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    
    local boxGradient = Instance.new("UIGradient", box)
    boxGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 30))
    })
    boxGradient.Rotation = 90
    
    local corner = Instance.new("UICorner", box)
    corner.CornerRadius = UDim.new(0, 6)
    
    local stroke = Instance.new("UIStroke", box)
    stroke.Color = Color3.fromRGB(255, 200, 50)
    stroke.Thickness = 1.5
    stroke.Transparency = 0.2
    
    local currentDigit = Instance.new("TextLabel", box)
    currentDigit.Size = UDim2.new(1, 0, 1, 0)
    currentDigit.Text = "0"
    currentDigit.Font = Enum.Font.GothamBlack
    currentDigit.TextSize = 38
    currentDigit.TextColor3 = Color3.fromRGB(255, 220, 80)
    currentDigit.TextXAlignment = Enum.TextXAlignment.Center
    currentDigit.AnchorPoint = Vector2.new(0.5, 0.5)
    currentDigit.Position = UDim2.new(0.5, 0, 0.5, 0)
    
    local digitGradient = Instance.new("UIGradient", currentDigit)
    digitGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 240, 150)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 200, 50))
    })
    digitGradient.Rotation = 90
    
    return {container = container, box = box, current = currentDigit}
end

local function updateDigit(digitInfo, newVal)
    local oldDigit = digitInfo.current
    if oldDigit.Text == newVal then return end
    
    local newDigit = oldDigit:Clone()
    newDigit.Text = newVal
    newDigit.Position = UDim2.new(0.5, 0, 1.5, 0)
    newDigit.TextTransparency = 1
    newDigit.Parent = digitInfo.box
    
    local tweenOut = TweenService:Create(oldDigit, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
        Position = UDim2.new(0.5, 0, -0.5, 0),
        TextTransparency = 1,
        Size = UDim2.new(1, 0, 0.5, 0)
    })
    
    local tweenIn = TweenService:Create(newDigit, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
        Position = UDim2.new(0.5, 0, 0.5, 0),
        TextTransparency = 0,
        Size = UDim2.new(1, 0, 1, 0)
    })
    
    tweenOut:Play()
    tweenIn:Play()
    
    tweenOut.Completed:Connect(function()
        oldDigit:Destroy()
        digitInfo.current = newDigit
    end)
end

local digits = {}
local colonLabels = {}

for i = 1, 6 do
    digits[i] = createDigitBox()
    if i % 2 == 0 and i ~= 6 then
        local colon = Instance.new("TextLabel", timerContainer)
        colon.Size = UDim2.new(0, 12, 0, 64)
        colon.Text = ":"
        colon.Font = Enum.Font.GothamBlack
        colon.TextSize = 38
        colon.TextColor3 = Color3.fromRGB(255, 200, 50)
        colon.BackgroundTransparency = 1
        colon.Position = UDim2.new(0, 0, 0.12, 0)
    end
end

local startTime = os.time()
local prevDigits = {"0","0","0","0","0","0"}

while true do
    local elapsed = os.time() - startTime
    local hours = math.floor(elapsed / 3600)
    local minutes = math.floor((elapsed % 3600) / 60)
    local seconds = elapsed % 60
    
    local timeValues = {
        string.format("%02d", hours):sub(1,1),
        string.format("%02d", hours):sub(2,2),
        string.format("%02d", minutes):sub(1,1),
        string.format("%02d", minutes):sub(2,2),
        string.format("%02d", seconds):sub(1,1),
        string.format("%02d", seconds):sub(2,2)
    }
    
    for i = 1, 6 do
        if timeValues[i] ~= prevDigits[i] then
            updateDigit(digits[i], timeValues[i])
        end
    end
    
    prevDigits = timeValues
    wait(0.1)
end

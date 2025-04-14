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
		local function isColorBlocked(color)
			local r, g, b = math.round(color.R * 255), math.round(color.G * 255), math.round(color.B * 255)
			local blocked = {["175,175,175"] = true, ["200,200,200"] = true, ["229,229,229"] = true}
			return blocked[("%d,%d,%d"):format(r, g, b)] == true
		end
		local function isDestructible(model)
			local meshParts = model:GetDescendants()
			for _, part in ipairs(meshParts) do
				if part:IsA("MeshPart") then
					if not isColorBlocked(part.Color) then
						return true
					end
				end
			end
			return false
		end
		local function getClosestValidRoot(map, minDist)
			local buildingsFolder
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
		local function findActiveMap()
			for _, interior in ipairs(workspace.Interiors:GetChildren()) do
				if interior:FindFirstChild("Programmed") and interior.Programmed:FindFirstChild("Map") then
					return interior.Programmed.Map
				end
			end
		end
		local minDistance = 4
		local growthTimer = 0
		while true do
			local map = findActiveMap()
			if not map then break end
			local target = getClosestValidRoot(map, minDistance)
			if not target then
				task.wait(1)
				continue
			end
			humanoidRootPart.CanCollide = false
			local startPos = humanoidRootPart.Position
			local endPos = Vector3.new(target.Position.X, startPos.Y, target.Position.Z)
			local t = 0
			while t < 1 do
				if not target:IsDescendantOf(workspace) then break end
				local progress = t
				local newPos = startPos:Lerp(endPos, progress)
				local oscillation = math.sin(t * math.pi * 6) * 10
				local lookVector = (endPos - startPos).Unit
				local rotation = CFrame.Angles(0, math.rad(oscillation), 0)
				local forward = CFrame.new(newPos, newPos + lookVector)
				humanoidRootPart.CFrame = forward * rotation
				t = t + 0.05
				task.wait(0.02)
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
		local function collectRings()
			local interior = workspace:FindFirstChild("Interiors"):FindFirstChild("BlossomShakedownInterior")
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
		wait(5)
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
				wait(config.delay)
				notify("Iniciando autoplay para: " .. word)
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

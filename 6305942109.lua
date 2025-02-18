local RS = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local PP = game:GetService("PathfindingService")
local Players = game:GetService("Players")
local pl = Players.LocalPlayer
local dr = workspace.Debris.Clothing
local plt = pl.NonSaveVars.OwnsPlot
local Events = RS:WaitForChild("Events")
local sp = false
local nr = false
local runWM = false
local wmCapAvail = false
local wms = nil
local CREDITS_TEXT = "v2.1.4 | 18/02/25 | By OneCreatorX"

local function dist(a, b)
	return (a - b).Magnitude
end

local function processSpecialClothes()
	for _, c in ipairs(dr:GetChildren()) do
		if c:FindFirstChild("SpecialTag") and c.Parent then
			Events.GrabClothing:FireServer(c)
			task.wait(0.1)
		end
	end
end

local function processNormalClothes()
	for _, c in ipairs(dr:GetChildren()) do
		if c.Parent then
			Events.GrabClothing:FireServer(c)
			task.wait(0.05)
		end
	end
end

local function isReady(w)
	local tLabel = w:FindFirstChild("Parts") and w.Parts:FindFirstChild("Screen") and w.Parts.Screen:FindFirstChild("SurfaceGui") and w.Parts.Screen.SurfaceGui:FindFirstChild("Frame") and w.Parts.Screen.SurfaceGui.Frame:FindFirstChild("TextLabel")
	if tLabel then
		local t = tLabel.Text
		if t:match("%d+/%d+") then
			return true
		end
	end
	return false
end

local function processWM()
	local capacityFound = false
	if wms then
		for _, w in ipairs(wms) do
			if isReady(w) then
				capacityFound = true
				Events.LoadWashingMachine:FireServer(w)
				task.wait(0.1)
				break
			end
		end
	end
	if capacityFound then
		wmCapAvail = true
	else
		wmCapAvail = false
		if wms then
			for _, w in ipairs(wms) do
				local tLabel = w:FindFirstChild("Parts") and w.Parts:FindFirstChild("Screen") and w.Parts.Screen:FindFirstChild("SurfaceGui") and w.Parts.Screen.SurfaceGui:FindFirstChild("Frame") and w.Parts.Screen.SurfaceGui.Frame:FindFirstChild("TextLabel")
				if tLabel and tLabel.Text == "DONE" then
					Events.UnloadWashingMachine:FireServer(w)
					Events.DropClothesInChute:FireServer()
					task.wait(0.1)
					break
				end
			end
		end
	end
end

local function wmLoop()
	while runWM do
		processWM()
		task.wait(1)
	end
end

local sg = Instance.new("ScreenGui")
sg.Name = "ModernLaundryUI"
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local toggleBtn = Instance.new("TextButton")
toggleBtn.Name = "ToggleUI"
toggleBtn.Size = UDim2.new(0, 40, 0, 40)
toggleBtn.Position = UDim2.new(0, 10, 0.15, -20)
toggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Text = "▶"
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 18
toggleBtn.AutoButtonColor = false
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0.3, 0)
corner.Parent = toggleBtn
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(100, 100, 100)
stroke.Parent = toggleBtn
toggleBtn.Parent = sg

local mainFrame = Instance.new("Frame")
mainFrame.Name = "Main"
mainFrame.Size = UDim2.new(0, 240, 0, 220)
local finalPos = UDim2.new(0.5, -120, 0.5, -110)
mainFrame.Position = finalPos
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BackgroundTransparency = 0.1
mainFrame.Visible = false
local mfCorner = Instance.new("UICorner")
mfCorner.CornerRadius = UDim.new(0.1, 0)
mfCorner.Parent = mainFrame
local mfStroke = Instance.new("UIStroke")
mfStroke.Color = Color3.fromRGB(80, 80, 80)
mfStroke.Parent = mainFrame
local blur = Instance.new("BlurEffect")
blur.Size = 8
blur.Parent = mainFrame
local title = Instance.new("TextLabel")
title.Name = "Header"
title.Text = "LAUNDRY SIMULATOR"
title.Size = UDim2.new(1, 0, 0, 35)
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(200, 200, 200)
title.TextSize = 16
title.BackgroundTransparency = 1
title.Parent = mainFrame
local credits = Instance.new("TextLabel", mainFrame)
credits.Text = CREDITS_TEXT
credits.Size = UDim2.new(1, -10, 0, 20)
credits.Position = UDim2.new(0, 5, 1, -25)
credits.Font = Enum.Font.Gotham
credits.TextSize = 12
credits.TextColor3 = Color3.fromRGB(150, 150, 150)
credits.BackgroundTransparency = 1
credits.TextXAlignment = Enum.TextXAlignment.Left

local function createButton(nom, ypos)
	local btn = Instance.new("TextButton")
	btn.Name = nom
	btn.Size = UDim2.new(0.9, 0, 0, 45)
	btn.Position = UDim2.new(0.05, 0, 0, ypos)
	btn.Font = Enum.Font.Gotham
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.TextSize = 14
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	btn.AutoButtonColor = false
	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0.15, 0)
	btnCorner.Parent = btn
	local btnStroke = Instance.new("UIStroke")
	btnStroke.Color = Color3.fromRGB(80, 80, 80)
	btnStroke.Parent = btn
	local highlight = Instance.new("Frame")
	highlight.Name = "Highlight"
	highlight.Size = UDim2.new(1, 0, 1, 0)
	highlight.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	highlight.BackgroundTransparency = 0.9
	highlight.Visible = false
	highlight.Parent = btn
	btn.MouseEnter:Connect(function()
		highlight.Visible = true
		TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
	end)
	btn.MouseLeave:Connect(function()
		highlight.Visible = false
		TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
	end)
	return btn
end

local btnSpec = createButton("Special", 40)
btnSpec.Text = "SPECIAL CLOTHES  [OFF]"
btnSpec.Parent = mainFrame
local btnNear = createButton("Normal", 95)
btnNear.Text = "ALL CLOTHES  [OFF]"
btnNear.Parent = mainFrame
local btnPlot = createButton("Washing", 150)
btnPlot.Text = "START PROCESSOR"
btnPlot.Parent = mainFrame

local uiVisible = false
toggleBtn.MouseButton1Click:Connect(function()
	if not uiVisible then
		uiVisible = true
		mainFrame.Size = UDim2.new(0, 0, 0, 0)
		mainFrame.Position = toggleBtn.Position
		mainFrame.Visible = true
		TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 240, 0, 220), Position = finalPos}):Play()
		toggleBtn.Text = "◀"
	else
		uiVisible = false
		local tw = TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0), Position = toggleBtn.Position})
		tw:Play()
		tw.Completed:Connect(function()
			mainFrame.Visible = false
		end)
		toggleBtn.Text = "▶"
	end
end)

local function updateButton(btn, state)
	local txt = ""
	if btn.Name == "Special" then
		txt = "SPECIAL CLOTHES  [" .. (state and "ON" or "OFF") .. "]"
	elseif btn.Name == "Normal" then
		txt = "ALL CLOTHES  [" .. (state and "ON" or "OFF") .. "]"
	else
		txt = "PROCESSOR  [" .. (state and "ACTIVE" or "IDLE") .. "]"
	end
	btn.Text = txt
	TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = state and Color3.fromRGB(70, 120, 200) or Color3.fromRGB(50, 50, 50)}):Play()
end

local function toggleSp()
	sp = not sp
	updateButton(btnSpec, sp)
end

local function toggleNr()
	nr = not nr
	updateButton(btnNear, nr)
end

local function toggleWM()
	runWM = not runWM
	updateButton(btnPlot, runWM)
	if runWM then
		spawn(wmLoop)
	end
end

btnSpec.MouseButton1Click:Connect(toggleSp)
btnNear.MouseButton1Click:Connect(toggleNr)
btnPlot.MouseButton1Click:Connect(toggleWM)

sg.Parent = pl:WaitForChild("PlayerGui")
mainFrame.Parent = sg

if plt.Value then
	local Plot = plt.Value.Name
	wms = workspace.Plots[Plot].WashingMachines:GetChildren()
	btnPlot.Visible = true
else
	btnPlot.Visible = false
end

dr.ChildRemoved:Connect(function()
	if plt.Value then
		local Plot = plt.Value.Name
		wms = workspace.Plots[Plot].WashingMachines:GetChildren()
	end
end)

pl.CharacterAdded:Connect(function(character)
	if sp then processSpecialClothes() end
	if nr then processNormalClothes() end
end)
if pl.Character then
	if sp then processSpecialClothes() end
	if nr then processNormalClothes() end
end

local function moveToTarget(plr, targetPos)
	local char = plr.Character
	if not char then return end
	local hum = char:FindFirstChildOfClass("Humanoid")
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hum or not hrp then return end
	local path = PP:CreatePath({AgentRadius = 2, AgentHeight = 5, AgentCanJump = true, AgentJumpHeight = hum.JumpHeight or 7})
	path:ComputeAsync(hrp.Position, targetPos)
	if path.Status == Enum.PathStatus.Success then
		local wps = path:GetWaypoints()
		for _, wp in ipairs(wps) do
			hum:MoveTo(wp.Position)
			hum.MoveToFinished:Wait()
		end
		task.wait(2)
		RS:WaitForChild("Events"):WaitForChild("SpinTheWheel"):InvokeServer()
		task.wait(10)
	end
end

local gui = pl:FindFirstChild("PlayerGui")
local notifFrame = gui and gui:FindFirstChild("SpecialNotification") and gui.SpecialNotification:FindFirstChild("BottomFrame")
if notifFrame then
	notifFrame:GetPropertyChangedSignal("Visible"):Connect(function()
		if notifFrame.Visible then
			moveToTarget(pl, Vector3.new(58, 7, -22))
		end
	end)
end

spawn(function()
	while true do
		local bp = pl:WaitForChild("PlayerGui"):WaitForChild("Info"):WaitForChild("Frame"):WaitForChild("Backpack")
		if bp.ImageColor3 == Color3.fromRGB(127,204,212) then
			Events.DropClothesInChute:FireServer()
			task.wait(0.5)
		else
			if #dr:GetChildren() > 0 then
				if sp then processSpecialClothes() end
				if nr then processNormalClothes() end
				task.wait(0.2)
			else
				task.wait(1)
			end
		end
	end
end)

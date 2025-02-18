local dr = workspace.Debris.Clothing
local pl = game.Players.LocalPlayer
local sp = false
local nr = false
local plt = pl.NonSaveVars.OwnsPlot
local wms
local ts = game:GetService("TweenService")
local runWM = false
local wmCapAvail = false
local CREDITS_TEXT = "v2 | 18/02/25 | By OneCreatorX"

local function dist(a, b)
	return (a - b).Magnitude
end

local function gsc()
	local t = {}
	for _, c in ipairs(dr:GetChildren()) do
		if c:FindFirstChild("SpecialTag") then
			table.insert(t, c)
		end
	end
	table.sort(t, function(a, b)
		return dist(a.Position, pl.Character.HumanoidRootPart.Position) < dist(b.Position, pl.Character.HumanoidRootPart.Position)
	end)
	return t
end

local function ssc(lst)
	for _, c in ipairs(lst) do
		if c:IsDescendantOf(dr) then
			game:GetService("ReplicatedStorage").Events.GrabClothing:FireServer(c)
			task.wait(0.1)
		end
	end
end

local function gnc()
	local t = {}
	for _, c in ipairs(dr:GetChildren()) do
		table.insert(t, c)
	end
	table.sort(t, function(a, b)
		return dist(a.Position, pl.Character.HumanoidRootPart.Position) < dist(b.Position, pl.Character.HumanoidRootPart.Position)
	end)
	return t
end

local function snc(lst)
	for _, c in ipairs(lst) do
		if c:IsDescendantOf(dr) then
			game:GetService("ReplicatedStorage").Events.GrabClothing:FireServer(c)
			task.wait(0.05)
		end
	end
end

local function isReady(w)
	local tLabel = w:FindFirstChild("Parts") and w.Parts.Screen.SurfaceGui.Frame.TextLabel
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
				game:GetService("ReplicatedStorage").Events.LoadWashingMachine:FireServer(w)
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
				local tLabel = w:FindFirstChild("Parts") and w.Parts.Screen.SurfaceGui.Frame.TextLabel
				if tLabel and tLabel.Text == "DONE" then
					game:GetService("ReplicatedStorage").Events.UnloadWashingMachine:FireServer(w)
					game:GetService("ReplicatedStorage").Events.DropClothesInChute:FireServer()
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
mainFrame.Position = UDim2.new(0.5, -120, 0.5, -110)
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
		ts:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
	end)
	btn.MouseLeave:Connect(function()
		highlight.Visible = false
		ts:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
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
local finalSize = UDim2.new(0, 240, 0, 220)
local finalPos = UDim2.new(0.5, -120, 0.5, -110)
toggleBtn.MouseButton1Click:Connect(function()
	if not uiVisible then
		uiVisible = true
		mainFrame.Size = UDim2.new(0, 0, 0, 0)
		mainFrame.Position = toggleBtn.Position
		mainFrame.Visible = true
		ts:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = finalSize, Position = finalPos}):Play()
		toggleBtn.Text = "◀"
	else
		uiVisible = false
		local tw = ts:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0), Position = toggleBtn.Position})
		tw:Play()
		tw.Completed:Connect(function()
			mainFrame.Visible = false
		end)
		toggleBtn.Text = "▶"
	end
end)

local function updateButton(btn, state)
	btn.Text = btn.Name == "Special" and ("SPECIAL CLOTHES  [" .. (state and "ON" or "OFF") .. "]") or btn.Name == "Normal" and ("ALL CLOTHES  [" .. (state and "ON" or "OFF") .. "]") or ("PROCESSOR  [" .. (state and "ACTIVE" or "IDLE") .. "]")
	ts:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = state and Color3.fromRGB(70, 120, 200) or Color3.fromRGB(50, 50, 50)}):Play()
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

mainFrame.Parent = sg
sg.Parent = pl:WaitForChild("PlayerGui")

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
	if sp then ssc(gsc()) end
	if nr then snc(gnc()) end
end)

if pl.Character then
	if sp then ssc(gsc()) end
	if nr then snc(gnc()) end
end

local pathfindingService = game:GetService("PathfindingService")

local function moveToTarget(player, targetPos)
    local character = player.Character
    if not character then return end

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not hrp then return end

    local startPos = hrp.Position

    local path = pathfindingService:CreatePath({
        AgentRadius = 2,
        AgentHeight = 5,
        AgentCanJump = true,
        AgentJumpHeight = humanoid.JumpHeight or 7
    })

    path:ComputeAsync(startPos, targetPos)

    if path.Status == Enum.PathStatus.Success then
        local waypoints = path:GetWaypoints()
        for _, waypoint in ipairs(waypoints) do
            humanoid:MoveTo(waypoint.Position)
            humanoid.MoveToFinished:Wait()
        end
task.wait(2)
game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("SpinTheWheel"):InvokeServer()


        task.wait(9)

        path:ComputeAsync(hrp.Position, startPos)
        if path.Status == Enum.PathStatus.Success then
            waypoints = path:GetWaypoints()
            for _, waypoint in ipairs(waypoints) do
                humanoid:MoveTo(waypoint.Position)
                humanoid.MoveToFinished:Wait()
            end
        end
    end
end

local player = game.Players.LocalPlayer
local gui = player:FindFirstChild("PlayerGui")
local notificationFrame = gui and gui:FindFirstChild("SpecialNotification") and gui.SpecialNotification:FindFirstChild("BottomFrame")

if notificationFrame then
    notificationFrame:GetPropertyChangedSignal("Visible"):Connect(function()
        if notificationFrame.Visible then
            moveToTarget(player, Vector3.new(58, 7, -22))
        end
    end)
end

spawn(function()
	while true do
		if wmCapAvail then
			if sp then ssc(gsc()) end
			if nr then snc(gnc()) end
			task.wait(0.2)
		else
			task.wait(1)
		end
	end
end)

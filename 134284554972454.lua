local P = game:GetService("Players").LocalPlayer
local V = game:GetService("VirtualUser")
local R = game:GetService("RunService")

local G = Instance.new("ScreenGui")
G.Name = "X"
G.Parent = P.PlayerGui

local T = Instance.new("TextButton")
T.Name = "T"
T.Parent = G
T.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
T.Position = UDim2.new(0.01, 0, 0.5, -15)
T.Size = UDim2.new(0, 30, 0, 30)
T.Font = Enum.Font.Code
T.Text = "▶"
T.TextColor3 = Color3.new(1, 1, 1)
T.ZIndex = 2

local F = Instance.new("Frame")
F.Name = "F"
F.Parent = G
F.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
F.Position = UDim2.new(0.01, 35, 0.5, -50)
F.Size = UDim2.new(0, 200, 0, 200)
F.ClipsDescendants = true

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = F
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 0)
Title.Size = UDim2.new(1, 0, 0, 20)
Title.Font = Enum.Font.Code
Title.Text = "Grid Controller"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 14

local B = Instance.new("TextButton")
B.Name = "B"
B.Parent = F
B.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
B.Position = UDim2.new(0.1, 0, 0, 25)
B.Size = UDim2.new(0.8, 0, 0, 25)
B.Font = Enum.Font.Code
B.Text = "OFF"
B.TextColor3 = Color3.new(1, 0.3, 0.3)
B.TextSize = 12

local I = Instance.new("TextBox")
I.Name = "I"
I.Parent = F
I.BackgroundColor3 = Color3.new(0.25, 0.25, 0.25)
I.Position = UDim2.new(0.1, 0, 0, 55)
I.Size = UDim2.new(0.8, 0, 0, 20)
I.Font = Enum.Font.Code
I.PlaceholderText = "Velocidad"
I.Text = "25"
I.TextColor3 = Color3.new(1, 1, 1)
I.TextSize = 12

local S = Instance.new("TextLabel")
S.Name = "S"
S.Parent = F
S.BackgroundTransparency = 1
S.Position = UDim2.new(0, 5, 0, 80)
S.Size = UDim2.new(1, -10, 0, 20)
S.Font = Enum.Font.Code
S.Text = "INACTIVO"
S.TextColor3 = Color3.new(0.6, 0.6, 0.6)
S.TextSize = 11
S.TextXAlignment = Enum.TextXAlignment.Left

local TeleportToggle = Instance.new("TextButton")
TeleportToggle.Name = "TeleportToggle"
TeleportToggle.Parent = F
TeleportToggle.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
TeleportToggle.Position = UDim2.new(0.1, 0, 0, 110)
TeleportToggle.Size = UDim2.new(0.8, 0, 0, 25)
TeleportToggle.Font = Enum.Font.Code
TeleportToggle.Text = "Teletransportar"
TeleportToggle.TextColor3 = Color3.new(1, 1, 1)
TeleportToggle.TextSize = 12

local TeleportFrame = Instance.new("Frame")
TeleportFrame.Name = "TeleportFrame"
TeleportFrame.Parent = F
TeleportFrame.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
TeleportFrame.Position = UDim2.new(0.1, 0, 0, 140)
TeleportFrame.Size = UDim2.new(0.8, 0, 0, 60)
TeleportFrame.Visible = false

local Zone2Button = Instance.new("TextButton")
Zone2Button.Name = "Zone2Button"
Zone2Button.Parent = TeleportFrame
Zone2Button.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
Zone2Button.Position = UDim2.new(0, 0, 0, 0)
Zone2Button.Size = UDim2.new(1, 0, 0, 20)
Zone2Button.Font = Enum.Font.Code
Zone2Button.Text = "Zona 2"
Zone2Button.TextColor3 = Color3.new(1, 1, 1)
Zone2Button.TextSize = 12

local Zone3Button = Instance.new("TextButton")
Zone3Button.Name = "Zone3Button"
Zone3Button.Parent = TeleportFrame
Zone3Button.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
Zone3Button.Position = UDim2.new(0, 0, 0, 22)
Zone3Button.Size = UDim2.new(1, 0, 0, 20)
Zone3Button.Font = Enum.Font.Code
Zone3Button.Text = "Zona 3"
Zone3Button.TextColor3 = Color3.new(1, 1, 1)
Zone3Button.TextSize = 12

local Zone4Button = Instance.new("TextButton")
Zone4Button.Name = "Zone4Button"
Zone4Button.Parent = TeleportFrame
Zone4Button.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
Zone4Button.Position = UDim2.new(0, 0, 0, 44)
Zone4Button.Size = UDim2.new(1, 0, 0, 20)
Zone4Button.Font = Enum.Font.Code
Zone4Button.Text = "Zona 4"
Zone4Button.TextColor3 = Color3.new(1, 1, 1)
Zone4Button.TextSize = 12

spawn(function()
    (loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX-New/TwoDev/main/Loader.lua"))())("info")
end)


local A = false
local C = {}
local X = true
local H = 25
local SelectedGrid = nil
local zone2Position = Vector3.new(157, 4, 1)
local zone3Position = Vector3.new(34, 4, -14)
local zone4Position = Vector3.new(-177, 4, 131)

local function ResetGridCache(grid)
	for _, part in pairs(grid:GetDescendants()) do
		if part:IsA("BasePart") then
			C[part] = nil
		end
	end
end

local function U()
	local N = os.time()
	for K, V in pairs(C) do
		if N - V > 8 then
			C[K] = nil
		end
	end
end

local function D()
	local Q = P.Character
	local HRP = Q and Q:FindFirstChild("HumanoidRootPart")
	if not HRP then return end
	local bestDistance = math.huge
	local bestPart = nil
	if SelectedGrid then
		for _, part in pairs(SelectedGrid:GetDescendants()) do
			if part:IsA("BasePart") and not C[part] then
				local dist = (part.Position - HRP.Position).Magnitude
				if dist < bestDistance then
					bestDistance = dist
					bestPart = part
				end
			end
		end
		if not bestPart then
			ResetGridCache(SelectedGrid)
			for _, part in pairs(SelectedGrid:GetDescendants()) do
				if part:IsA("BasePart") then
					local dist = (part.Position - HRP.Position).Magnitude
					if dist < bestDistance then
						bestDistance = dist
						bestPart = part
					end
				end
			end
		end
		return bestPart, bestDistance
	else
		local bestGrid = nil
		for _, grid in pairs(workspace:GetChildren()) do
			if grid.Name == "Grid" then
				for _, part in pairs(grid:GetDescendants()) do
					if part:IsA("BasePart") and not C[part] then
						local dist = (part.Position - HRP.Position).Magnitude
						if dist < bestDistance then
							bestDistance = dist
							bestPart = part
							bestGrid = grid
						end
					end
				end
			end
		end
		if bestGrid then
			SelectedGrid = bestGrid
			print("Nueva zona detectada")
		end
		return bestPart, bestDistance
	end
end

local function J(part)
	if not part then return end
	for _, a in pairs(part.Parent:GetChildren()) do
		if a:IsA("BasePart") then
			pcall(function()
				firetouchinterest(P.Character.PrimaryPart, a, 0)
				firetouchinterest(P.Character.PrimaryPart, a, 1)
			end)
		end
	end
end

local function MoveLoop()
	while A do
		H = tonumber(I.Text) or 25
		local Q = P.Character
		local humanoid = Q and Q:FindFirstChild("Humanoid")
		local targetPart, dist = D()
		if humanoid and targetPart then
			humanoid.WalkSpeed = H
			humanoid:MoveTo(targetPart.Position)
			if dist <= 10 then
				C[targetPart] = os.time()
				J(targetPart)
			end
		end
		R.Heartbeat:Wait()
	end
end

local function TouchLoop()
	while A do
		local Q = P.Character
		local HRP = Q and Q:FindFirstChild("HumanoidRootPart")
		if HRP and SelectedGrid then
			for _, part in pairs(SelectedGrid:GetDescendants()) do
				if part:IsA("BasePart") then
					if (part.Position - HRP.Position).Magnitude < 15 then
						pcall(function()
							firetouchinterest(HRP, part, 0)
							firetouchinterest(HRP, part, 1)
						end)
					end
				end
			end
		end
		R.Heartbeat:Wait()
	end
end

local function TeleportTo(pos)
	local character = P.Character
	if character then
		local HRP = character:FindFirstChild("HumanoidRootPart")
		if HRP then
			HRP.CFrame = CFrame.new(pos)
		end
	end
end

T.MouseButton1Click:Connect(function()
	X = not X
	F.Visible = X
	T.Text = X and "◀" or "▶"
end)

TeleportToggle.MouseButton1Click:Connect(function()
	TeleportFrame.Visible = not TeleportFrame.Visible
end)

Zone2Button.MouseButton1Click:Connect(function()
	TeleportTo(zone2Position)
end)

Zone3Button.MouseButton1Click:Connect(function()
	TeleportTo(zone3Position)
end)

Zone4Button.MouseButton1Click:Connect(function()
	TeleportTo(zone4Position)
end)

B.MouseButton1Click:Connect(function()
	A = not A
	B.Text = A and "ON" or "OFF"
	B.TextColor3 = A and Color3.new(0.3, 1, 0.3) or Color3.new(1, 0.3, 0.3)
	S.Text = A and "ACTIVO" or "INACTIVO"
	if A then
		SelectedGrid = nil
		C = {}
		coroutine.wrap(MoveLoop)()
		coroutine.wrap(TouchLoop)()
		coroutine.wrap(U)()
	end
end)

P.Idled:Connect(function()
	V:CaptureController()
	V:ClickButton2(Vector2.new())
end)

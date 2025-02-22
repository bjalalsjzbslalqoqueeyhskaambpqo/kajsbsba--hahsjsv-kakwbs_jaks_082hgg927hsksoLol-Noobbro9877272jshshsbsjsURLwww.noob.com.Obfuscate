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
F.Size = UDim2.new(0, 200, 0, 165)
F.ClipsDescendants = true

local ttl = Instance.new("TextLabel")
ttl.Name = "ttl"
ttl.Parent = F
ttl.BackgroundTransparency = 1
ttl.Position = UDim2.new(0, 0, 0, 0)
ttl.Size = UDim2.new(1, 0, 0, 20)
ttl.Font = Enum.Font.Code
ttl.Text = "farm by OneCreatorX"
ttl.TextColor3 = Color3.new(1, 1, 1)
ttl.TextSize = 14

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

local tt = Instance.new("TextButton")
tt.Name = "tt"
tt.Parent = F
tt.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
tt.Position = UDim2.new(0.1, 0, 0, 110)
tt.Size = UDim2.new(0.8, 0, 0, 25)
tt.Font = Enum.Font.Code
tt.Text = "Teletransportar"
tt.TextColor3 = Color3.new(1, 1, 1)
tt.TextSize = 12

local tf = Instance.new("Frame")
tf.Name = "tf"
tf.Parent = G
tf.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
tf.Position = UDim2.new(0.01, 55, 0.5, 90)
tf.Size = UDim2.new(0, 160, 0, 60)
tf.Visible = false

local z2 = Instance.new("TextButton")
z2.Name = "z2"
z2.Parent = tf
z2.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
z2.Position = UDim2.new(0, 0, 0, 0)
z2.Size = UDim2.new(1, 0, 0, 20)
z2.Font = Enum.Font.Code
z2.Text = "Zona 2"
z2.TextColor3 = Color3.new(1, 1, 1)
z2.TextSize = 12

local z3 = Instance.new("TextButton")
z3.Name = "z3"
z3.Parent = tf
z3.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
z3.Position = UDim2.new(0, 0, 0, 20)
z3.Size = UDim2.new(1, 0, 0, 20)
z3.Font = Enum.Font.Code
z3.Text = "Zona 3"
z3.TextColor3 = Color3.new(1, 1, 1)
z3.TextSize = 12

local z4 = Instance.new("TextButton")
z4.Name = "z4"
z4.Parent = tf
z4.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
z4.Position = UDim2.new(0, 0, 0, 40)
z4.Size = UDim2.new(1, 0, 0, 20)
z4.Font = Enum.Font.Code
z4.Text = "Zona 4"
z4.TextColor3 = Color3.new(1, 1, 1)
z4.TextSize = 12

local A = false
local C = {}
local X = true
local H = 25
local sg = nil
local z2p = Vector3.new(157, 4, 1)
local z3p = Vector3.new(34, 4, -14)
local z4p = Vector3.new(-177, 4, 131)
local au = false
local ao = nil

local function rg(g)
	for _, p in pairs(g:GetDescendants()) do
		if p:IsA("BasePart") then
			C[p] = nil
		end
	end
end

local function up()
	local n = os.time()
	for k, v in pairs(C) do
		if n - v > 8 then
			C[k] = nil
		end
	end
end

local function fd()
	local ch = P.Character
	local hr = ch and ch:FindFirstChild("HumanoidRootPart")
	if not hr then
		return
	end
	local bd = math.huge
	local bp = nil
	if sg then
		for _, p in pairs(sg:GetDescendants()) do
			if p:IsA("BasePart") and not C[p] then
				local d = (p.Position - hr.Position).Magnitude
				if d < bd then
					bd = d
					bp = p
				end
			end
		end
		if not bp then
			rg(sg)
			for _, p in pairs(sg:GetDescendants()) do
				if p:IsA("BasePart") then
					local d = (p.Position - hr.Position).Magnitude
					if d < bd then
						bd = d
						bp = p
					end
				end
			end
		end
		return bp, bd
	else
		local bg = nil
		for _, g in pairs(workspace:GetChildren()) do
			if g.Name == "Grid" then
				for _, p in pairs(g:GetDescendants()) do
					if p:IsA("BasePart") and not C[p] then
						local d = (p.Position - hr.Position).Magnitude
						if d < bd then
							bd = d
							bp = p
							bg = g
						end
					end
				end
			end
		end
		if bg then
			sg = bg
			print("NZ")
		end
		return bp, bd
	end
end

local function ft(p)
	if not p then
		return
	end
	for _, a in pairs(p.Parent:GetChildren()) do
		if a:IsA("BasePart") then
			pcall(function()
				firetouchinterest(P.Character.PrimaryPart, a, 0)
				firetouchinterest(P.Character.PrimaryPart, a, 1)
			end)
		end
	end
end

local function ml()
	while A do
		H = tonumber(I.Text) or 25
		local ch = P.Character
		local hu = ch and ch:FindFirstChild("Humanoid")
		local tpObj, d = fd()
		if hu and tpObj then
			hu.WalkSpeed = H
			hu:MoveTo(tpObj.Position)
			if d <= 10 then
				C[tpObj] = os.time()
				ft(tpObj)
			end
		end
		R.Heartbeat:Wait()
	end
end

local function tl()
	while A do
		local ch = P.Character
		local hr = ch and ch:FindFirstChild("HumanoidRootPart")
		if hr and sg then
			for _, p in pairs(sg:GetDescendants()) do
				if p:IsA("BasePart") and (p.Position - hr.Position).Magnitude < 15 then
					pcall(function()
						firetouchinterest(hr, p, 0)
						firetouchinterest(hr, p, 1)
					end)
				end
			end
		end
		R.Heartbeat:Wait()
	end
end

local function tp(pos)
	local ch = P.Character
	if ch then
		local hr = ch:FindFirstChild("HumanoidRootPart")
		if hr then
			hr.CFrame = CFrame.new(pos)
		end
	end
end

local function auL()
	while au do
		local args = { [1] = tostring(ao) }
		game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CutsceneCheck"):InvokeServer(unpack(args))
		R.Heartbeat:Wait()
	end
end

T.MouseButton1Click:Connect(function()
	X = not X
	F.Visible = X
	T.Text = X and "◀" or "▶"
end)

tt.MouseButton1Click:Connect(function()
	tf.Visible = not tf.Visible
end)

z2.MouseButton1Click:Connect(function()
	tp(z2p)
end)

z3.MouseButton1Click:Connect(function()
	tp(z3p)
end)

z4.MouseButton1Click:Connect(function()
	tp(z4p)
end)

B.MouseButton1Click:Connect(function()
	A = not A
	B.Text = A and "ON" or "OFF"
	B.TextColor3 = A and Color3.new(0.3, 1, 0.3) or Color3.new(1, 0.3, 0.3)
	S.Text = A and "ACTIVO" or "INACTIVO"
	if A then
		sg = nil
		C = {}
		coroutine.wrap(ml)()
		coroutine.wrap(tl)()
		coroutine.wrap(up)()
	end
end)

P.Idled:Connect(function()
	V:CaptureController()
	V:ClickButton2(Vector2.new())
end)

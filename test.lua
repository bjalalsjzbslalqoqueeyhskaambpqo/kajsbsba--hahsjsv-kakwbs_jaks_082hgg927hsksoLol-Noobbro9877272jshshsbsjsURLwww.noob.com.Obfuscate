local p = game.Players.LocalPlayer
local P = p
local W = game:GetService("Workspace")

local function sm(c, t, s)
    local h = c:FindFirstChild("HumanoidRootPart")
    if not h then return end
    local a = h.Position
    local b = Vector3.new(t.X, a.Y, t.Z)
    local d = (b - a).Unit
    local e = (b - a).Magnitude
    local f = e / s
    local g = tick()
    while tick() - g < f do
        local i = (tick() - g) / f
        local j = a + d * e * i
        j = Vector3.new(j.X, a.Y, j.Z)
        h.CFrame = CFrame.new(j, j + h.CFrame.LookVector)
        task.wait()
    end
    h.CFrame = CFrame.new(b, b + h.CFrame.LookVector)
end

local a = 10

local function g()
    local n, s = nil, a
    local c = P.Character or P.CharacterAdded:Wait()
    for _, l in ipairs(game:GetService("Players"):GetPlayers()) do
        if l ~= P and l.Character and l.Character:FindFirstChild("HumanoidRootPart") then
            local d = (c.HumanoidRootPart.Position - l.Character.HumanoidRootPart.Position).Magnitude
            if d < s then
                s, n = d, l
            end
        end
    end
    return n
end

local function m(p)
    pcall(function()
        local c = P.Character or P.CharacterAdded:Wait()
        local h = c:WaitForChild("HumanoidRootPart", 10)
        if not h then return end
        local s = h.Position
        local t = Vector3.new(p.X, s.Y, p.Z)
        local d = (t - s).Unit
        local n = g()
        if n then
            local q = n.Character.HumanoidRootPart.Position
            local r = (s - Vector3.new(q.X, s.Y, q.Z)).Unit
            d = (d + r).Unit
        end
        local f = s + d * 4
        f = Vector3.new(f.X, s.Y, f.Z)
        local v = 20
        sm(c, f, v)
    end)
end

spawn(function()
    while true do
        pcall(function()
            local z = W.Zones["5X"]
            if z and z:IsA("Model") then
                local p = z:GetModelCFrame().Position
                m(p)
            end
        end)
        task.wait()
    end
end)

local o = false
local function autoOrbs()
    o = not o
    if o then
        task.spawn(function()
            while o do
                for _, b in ipairs(W.Orbs:GetChildren()) do
                    local h = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
                    if h then
                        pcall(function()
                            firetouchinterest(h, b, 0)
                            firetouchinterest(h, b, 1)
                        end)
                    end
                end
                task.wait()
            end
        end)
    end
end

local k = false
local function auraAttack()
    k = not k
end

local function e()
    wait(3)
    local c = p.Character or p.CharacterAdded:Wait()
    local t = c:FindFirstChildOfClass("Tool")
    if not t then
        local b = p.Backpack:FindFirstChildOfClass("Tool")
        if b then
            pcall(function()
                b.Parent = c
            end)
        end
    end
end

local function g()
    local np, sd = nil, 25
    local c = P.Character or P.CharacterAdded:Wait()
    for _, pl in ipairs(game:GetService("Players"):GetPlayers()) do
        if pl ~= P and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") then
            local d = (c.HumanoidRootPart.Position - pl.Character.HumanoidRootPart.Position).Magnitude
            if d < sd then
                sd, np = d, pl
            end
        end
    end
    return np
end

task.spawn(function()
    while true do
        if k then
            e()
            local c = p.Character
            local t = c:FindFirstChildOfClass("Tool")
            if t then
                local s, y = pcall(g)
                if s and y then
                    local x = y.Character
                    for _, r in ipairs(x:GetDescendants()) do
                        if r:IsA("BasePart") then
                            pcall(function()
                                firetouchinterest(t.Handle, r, 0)
                                firetouchinterest(t.Handle, r, 1)
                            end)
                        end
                    end
                end
            end
        end
        task.wait()
    end
end)

-- Nueva interfaz
local pg = p:WaitForChild("PlayerGui")
local sg

for _, g in ipairs(pg:GetChildren()) do
    if g:IsA("ScreenGui") and g.Enabled then sg = g break end
end

if not sg then error("No ScreenGui enabled found") end

local f = Instance.new("Frame")
f.Parent = sg
f.Size = UDim2.new(0, 200, 0, 190)
f.Position = UDim2.new(0.5, -100, 0.5, -95)
f.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
f.BorderSizePixel = 0
f.Active = true
f.Draggable = true

local function cb(n, p, c)
    local b = Instance.new("TextButton")
    b.Parent = f
    b.Size = UDim2.new(0, 180, 0, 30)
    b.Position = p
    b.Text = n
    b.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    b.TextColor3 = Color3.new(0.8, 0.8, 0.8)
    b.BorderSizePixel = 0
    b.MouseButton1Click:Connect(function()
        c()
        b.BackgroundColor3 = b.BackgroundColor3 == Color3.new(0.2, 0.2, 0.2) and Color3.new(0, 0.3, 0) or Color3.new(0.2, 0.2, 0.2)
    end)
end

cb("Auto Orbs", UDim2.new(0, 10, 0, 10), autoOrbs)
cb("Aura Attack", UDim2.new(0, 10, 0, 50), auraAttack)

-- TextBox para 'a'
local t = Instance.new("TextBox")
t.Parent = f
t.Size = UDim2.new(0, 180, 0, 30)
t.Position = UDim2.new(0, 10, 0, 90)
t.Text = tostring(a)
t.PlaceholderText = "Avoid Distance"
t.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
t.TextColor3 = Color3.new(0.8, 0.8, 0.8)
t.BorderSizePixel = 0

t.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local newValue = tonumber(t.Text)
        if newValue then
            a = newValue
            print("Avoid Distance updated to: " .. a)
        else
            t.Text = tostring(a)
        end
    end
end)

local l = Instance.new("TextLabel")
l.Parent = f
l.Size = UDim2.new(0, 180, 0, 30)
l.Position = UDim2.new(0, 10, 0, 130)
l.Text = "Avoid Distance"
l.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
l.TextColor3 = Color3.new(0.8, 0.8, 0.8)
l.BorderSizePixel = 0

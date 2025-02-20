local Plr = game:GetService("Players").LocalPlayer
local VU = game:GetService("VirtualUser")

local UI = Instance.new("ScreenGui")
local Tog = Instance.new("TextButton")
local Win = Instance.new("Frame")
local Hdr = Instance.new("Frame")
local AFBtn = Instance.new("TextButton")
local Stat = Instance.new("TextLabel")

UI.Name = "XFarm"
UI.Parent = Plr.PlayerGui
UI.ResetOnSpawn = false

Tog.Name = "Tog"
Tog.Parent = UI
Tog.BackgroundColor3 = Color3.fromRGB(20,20,25)
Tog.Position = UDim2.new(0.01,0,0.5,-15)
Tog.Size = UDim2.new(0,30,0,30)
Tog.Font = Enum.Font.GothamBold
Tog.Text = "▶"
Tog.TextColor3 = Color3.fromRGB(100,200,255)
Tog.ZIndex = 2

Win.Name = "Win"
Win.Parent = UI
Win.BackgroundColor3 = Color3.fromRGB(15,15,20)
Win.Position = UDim2.new(0.01,35,0.5,-50)
Win.Size = UDim2.new(0,150,0,100)
Win.ClipsDescendants = true

Hdr.Name = "Hdr"
Hdr.Parent = Win
Hdr.BackgroundColor3 = Color3.fromRGB(25,25,30)
Hdr.Size = UDim2.new(1,0,0,20)

local Tit = Instance.new("TextLabel")
Tit.Text = " XFarm "
Tit.TextColor3 = Color3.fromRGB(150,150,200)
Tit.Font = Enum.Font.Gotham
Tit.TextSize = 10
Tit.Size = UDim2.new(1,-5,1,0)
Tit.Position = UDim2.new(0,5,0,0)
Tit.BackgroundTransparency = 1
Tit.Parent = Hdr

AFBtn.Name = "AFBtn"
AFBtn.Parent = Win
AFBtn.BackgroundColor3 = Color3.fromRGB(30,30,40)
AFBtn.Position = UDim2.new(0.1,0,0.3,0)
AFBtn.Size = UDim2.new(0.8,0,0,25)
AFBtn.Font = Enum.Font.Gotham
AFBtn.Text = "AUTO: OFF"
AFBtn.TextColor3 = Color3.fromRGB(200,50,50)
AFBtn.TextSize = 12

Stat.Name = "Stat"
Stat.Parent = Win
Stat.BackgroundTransparency = 1
Stat.Position = UDim2.new(0,5,0,60)
Stat.Size = UDim2.new(1,-10,0,30)
Stat.Font = Enum.Font.Gotham
Stat.Text = "Inactivo"
Stat.TextColor3 = Color3.fromRGB(100,100,150)
Stat.TextSize = 11
Stat.TextXAlignment = Enum.TextXAlignment.Left

local AF,Vsbl = false,true

local function GetTarget()
    local chr = Plr.Character
    if not chr or not chr:FindFirstChild("HumanoidRootPart") then return end
    
    local pos = chr.HumanoidRootPart.Position
    local closest, dist = nil, math.huge
    
    for _,v in pairs(workspace.Scane.Activator:GetDescendants()) do
        if v:IsA("MeshPart")  and v.Transparency == 0 then
            local d = (v.Position - pos).Magnitude
            if d < dist then
                closest = v
                dist = d
            end
        end
    end
    return closest
end

local function Action()
    local t = GetTarget()
    if t then
        pcall(function()
            Plr.Character:PivotTo(t.CFrame + Vector3.new(0,3,0))
            task.wait(0.2)
            fireproximityprompt(t:FindFirstChildOfClass("ProximityPrompt"))
            task.wait(0.1)
        end)
    end
end

local function Farm()
    while AF do
        Action()
        task.wait(0.2)
    end
    Stat.Text = "Inactivo"
end

AFBtn.MouseButton1Click:Connect(function()
    AF = not AF
    AFBtn.Text = "AUTO: "..(AF and "ON" or "OFF")
    AFBtn.TextColor3 = AF and Color3.fromRGB(50,200,50) or Color3.fromRGB(200,50,50)
    if AF then coroutine.wrap(Farm)() end
end)

Tog.MouseButton1Click:Connect(function()
    Vsbl = not Vsbl
    Win.Visible = Vsbl
    Tog.Text = Vsbl and "◀" or "▶"
end)

Plr.Idled:Connect(function()
    VU:CaptureController()
    VU:ClickButton2(Vector2.new())
end)

game:GetService("RunService").Heartbeat:Connect(function()
    pcall(function() 
        if Plr.PlayerGui:FindFirstChild("CoverBefore") then
            Plr.PlayerGui.CoverBefore.Enabled = false
        end
    end)
end)

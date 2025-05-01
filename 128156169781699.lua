local Ps = game:GetService("Players")
local Rs = game:GetService("RunService")
local Uis = game:GetService("UserInputService")
local Ws = game:GetService("Workspace")
local Ts = game:GetService("TweenService")

local pl = Ps.LocalPlayer
local bl = {}
local co = true

spawn(function()
    task.delay(6, function() co = false end)
end)

local oh = hookmetamethod
local hf
hf = oh(game, "__namecall", newcclosure(function(self, ...)
    local m = getnamecallmethod()
    if not checkcaller() and (m == "FireServer" or m == "InvokeServer") then
        if co then
            bl[#bl+1] = self
            return nil
        elseif table.find(bl, self) then
            return nil
        end
    end
    return hf(self, ...)
end))

local g = Instance.new("ScreenGui", game.CoreGui)
g.Name = "ACUI"

local f = Instance.new("Frame", g)
f.Size = UDim2.new(0,250,0,150)
f.Position = UDim2.new(0.5,-125,0.15,0)
f.BackgroundColor3 = Color3.fromRGB(35,35,45)
f.BorderSizePixel = 0
f.Active = true; f.Draggable = true; f.ClipsDescendants = true
Instance.new("UICorner", f).CornerRadius = UDim.new(0,10)

local tb = Instance.new("Frame", f)
tb.Size = UDim2.new(1,0,0,30)
tb.BackgroundColor3 = Color3.fromRGB(45,50,70)
tb.BorderSizePixel = 0
Instance.new("UICorner", tb).CornerRadius = UDim.new(0,10)

local ttl = Instance.new("TextLabel", tb)
ttl.Size = UDim2.new(1,-10,1,0)
ttl.Position = UDim2.new(0,10,0,0)
ttl.BackgroundTransparency = 1
ttl.Text = "Easy Obby - OCX"
ttl.TextColor3 = Color3.new(1,1,1)
ttl.Font = Enum.Font.GothamBold
ttl.TextSize = 16
ttl.TextXAlignment = Enum.TextXAlignment.Left

local sf = Instance.new("Frame", f)
sf.Size = UDim2.new(0.9,0,0,50)
sf.Position = UDim2.new(0.05,0,0,40)
sf.BackgroundColor3 = Color3.fromRGB(25,25,35)
sf.BorderSizePixel = 0
Instance.new("UICorner", sf).CornerRadius = UDim.new(0,8)
local sg = Instance.new("UIGradient", sf)
sg.Color = ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(30,30,40)),ColorSequenceKeypoint.new(1,Color3.fromRGB(25,25,35))})

local lg = Instance.new("TextLabel", sf)
lg.Size = UDim2.new(1,-20,1,-10)
lg.Position = UDim2.new(0,10,0,5)
lg.BackgroundTransparency = 1
lg.TextColor3 = Color3.fromRGB(0,255,100)
lg.Font = Enum.Font.Gotham
lg.TextSize = 14
lg.TextXAlignment = Enum.TextXAlignment.Left
lg.TextYAlignment = Enum.TextYAlignment.Center
lg.Text = "Iniciando..."

local bt = Instance.new("TextButton", f)
bt.Size = UDim2.new(0.8,0,0,35)
bt.Position = UDim2.new(0.1,0,0,100)
bt.BackgroundColor3 = Color3.fromRGB(50,50,70)
bt.Text = "AC Activado"
bt.TextColor3 = Color3.new(1,1,1)
bt.Font = Enum.Font.GothamSemibold
bt.TextSize = 14
bt.AutoButtonColor = true
Instance.new("UICorner", bt).CornerRadius = UDim.new(0,6)

spawn(function()
    task.wait(0.5); lg.Text="Iniciando..."
    task.wait(0.8); lg.Text="Detectando..."
    task.wait(0.8); lg.Text="Bloqueando..."
    task.wait(0.8); lg.Text="¡Listo!"
    local pw = Ts:Create(sf, TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundColor3=Color3.fromRGB(50,70,50)})
    pw:Play(); task.wait(0.5)
    Ts:Create(sf, TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundColor3=Color3.fromRGB(25,25,35)}):Play()
end)

local part, en = nil, true
local ly = nil
local jp = false

local function cp()
    part = Instance.new("Part")
    part.Anchored = true; part.CanCollide = true
    part.Transparency = 1; part.Size = Vector3.new(6,1,6)
    part.Name = "AFP"
    part.Parent = Ws
end

local function gf(c)
    for _, v in ipairs(c:GetDescendants()) do
        if v:IsA("BasePart") then
            local n = v.Name:lower():gsub("%s+",""):gsub("_","")
            if n:find("foot") or n:find("pie") or n:find("leg") then return v end
        end
    end
    return c:FindFirstChild("HumanoidRootPart")
end

local function st(ft)
    bt.MouseButton1Click:Connect(function()
        if en and ft then
            bt.Text="Reactivando..."
            Ts:Create(bt, TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundColor3=Color3.fromRGB(80,50,50)}):Play()
            en=false; part.CanCollide=false
            task.wait(2)
            local y = ft.Position.Y - 1.6 - part.Size.Y/2
            part.Position=Vector3.new(ft.Position.X,y,ft.Position.Z)
            ly=y; part.CanCollide=true; en=true
            Ts:Create(bt, TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundColor3=Color3.fromRGB(50,70,50)}):Play()
            bt.Text="AC Activado"
            task.wait(1)
            Ts:Create(bt, TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundColor3=Color3.fromRGB(50,50,70)}):Play()
        end
    end)
end

local function sj(hm)
    hm.StateChanged:Connect(function(_,ns)
        if ns==Enum.HumanoidStateType.Jumping then jp=true
        elseif ns==Enum.HumanoidStateType.Landed then jp=false end
    end)
    Uis.InputBegan:Connect(function(i,gp)
        if i.KeyCode==Enum.KeyCode.Space and not gp then
            jp=true; task.delay(0.5,function() if hm.FloorMaterial~=Enum.Material.Air then jp=false end end)
        end
    end)
end

local function up(ft,hm)
    Rs.Heartbeat:Connect(function()
        if not en or not part or not ft then return end
        local y=ft.Position.Y-1.5-part.Size.Y/2
        local d=(part.Position-ft.Position).magnitude
        if d>15 then
            part.Position=Vector3.new(ft.Position.X,y,ft.Position.Z)
            ly=y; return
        end
        if not jp then
            if y>part.Position.Y then
                part.Position=Vector3.new(ft.Position.X,y,ft.Position.Z); ly=y
            else
                part.Position=Vector3.new(ft.Position.X,part.Position.Y,ft.Position.Z)
            end
        else
            part.Position=Vector3.new(ft.Position.X,part.Position.Y,ft.Position.Z)
        end
    end)
end

local function su()
    local ch = pl.Character or pl.CharacterAdded:Wait()
    local ft = gf(ch)
    local hm = ch:FindFirstChildOfClass("Humanoid")
    if not ft or not hm then return end
    cp()
    local y = ft.Position.Y - 1.6 - part.Size.Y/2
    part.Position=Vector3.new(ft.Position.X,y,ft.Position.Z); ly=y
    task.wait(0.2)
    y = ft.Position.Y - 1.5 - part.Size.Y/2
    part.Position=Vector3.new(ft.Position.X,y,ft.Position.Z)
    sj(hm); up(ft,hm); st(ft)
end

pl.CharacterAdded:Connect(function()
    if part then part:Destroy() end
    ly=nil; jp=false
    task.wait(1); su()
end)

spawn(function()
    for _,d in ipairs(Ws:GetDescendants()) do
        if d:IsA("BasePart") and ((d:FindFirstChildWhichIsA("NumberValue") and d:FindFirstChildWhichIsA("TouchTransmitter")) or d.Name=="Pillar") then
            d:Destroy(); task.wait()
        end
    end
    Ws.DescendantAdded:Connect(function(d)
        if d:IsA("BasePart") and ((d:FindFirstChildWhichIsA("NumberValue") and d:FindFirstChildWhichIsA("TouchTransmitter")) or d.Name=="Pillar") then
            d:Destroy()
        end
    end)
end)

su()

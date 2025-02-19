local Plr = game:GetService("Players").LocalPlayer
local Ws = game:GetService("Workspace")
local Ts = game:GetService("TweenService")

local Gui = Instance.new("ScreenGui")
local Tog = Instance.new("TextButton")
local Main = Instance.new("Frame")
local Hdr = Instance.new("Frame")
local Ttl = Instance.new("TextLabel")
local Stats = Instance.new("Frame")
local F = Instance.new("TextLabel")
local D = Instance.new("TextLabel")
local T = Instance.new("TextLabel")
local Auto = Instance.new("TextButton")
local Crd = Instance.new("TextLabel")
local Nots = Instance.new("Frame")

Gui.Name = "FishUI"
Gui.Parent = Plr.PlayerGui
Gui.ResetOnSpawn = false

Tog.Name = "Tog"
Tog.Parent = Gui
Tog.BackgroundColor3 = Color3.fromRGB(30,30,35)
Tog.Position = UDim2.new(0.01,0,0.5,-20)
Tog.Size = UDim2.new(0,30,0,30)
Tog.Font = Enum.Font.GothamBold
Tog.Text = "▶"
Tog.TextColor3 = Color3.fromRGB(200,200,200)
Tog.ZIndex = 2

Main.Name = "Main"
Main.Parent = Gui
Main.BackgroundColor3 = Color3.fromRGB(10,10,10)
Main.Position = UDim2.new(0.01,30,0.5,-80)
Main.Size = UDim2.new(0,200,0,160)
Main.AnchorPoint = Vector2.new(0,0.5)
Main.ClipsDescendants = true

Hdr.Name = "Hdr"
Hdr.Parent = Main
Hdr.BackgroundColor3 = Color3.fromRGB(20,20,25)
Hdr.Size = UDim2.new(1,0,0,30)

Ttl.Name = "Ttl"
Ttl.Parent = Hdr
Ttl.BackgroundTransparency = 1
Ttl.Size = UDim2.new(1,-30,1,0)
Ttl.Font = Enum.Font.GothamBold
Ttl.Text = " MushYO by OneCreatorX"
Ttl.TextColor3 = Color3.fromRGB(200,200,220)
Ttl.TextSize = 14

Stats.Name = "Stats"
Stats.Parent = Main
Stats.BackgroundTransparency = 1
Stats.Position = UDim2.new(0,10,0,35)
Stats.Size = UDim2.new(1,-20,1,-55)

F.Name = "F"
F.Parent = Stats
F.Size = UDim2.new(1,0,0,30)
F.Font = Enum.Font.GothamMedium
F.Text = "🐟 0"
F.TextColor3 = Color3.fromRGB(100,200,255)
F.TextSize = 14
F.BackgroundTransparency = 1
F.TextXAlignment = Enum.TextXAlignment.Left

D.Name = "D"
D.Parent = Stats
D.Position = UDim2.new(0,0,0,35)
D.Size = UDim2.new(1,0,0,30)
D.Font = Enum.Font.GothamMedium
D.Text = "💎 0"
D.BackgroundTransparency = 1
D.TextColor3 = Color3.fromRGB(255,215,50)
D.TextSize = 14
D.TextXAlignment = Enum.TextXAlignment.Left

T.Name = "T"
T.Parent = Stats
T.Position = UDim2.new(0,0,0,70)
T.Size = UDim2.new(1,0,0,30)
T.BackgroundTransparency = 1
T.Font = Enum.Font.GothamMedium
T.Text = "🗑️ 0"
T.TextColor3 = Color3.fromRGB(170,170,170)
T.TextSize = 14
T.TextXAlignment = Enum.TextXAlignment.Left

Auto.Name = "Auto"
Auto.Parent = Main
Auto.BackgroundColor3 = Color3.fromRGB(30,30,35)
Auto.Position = UDim2.new(0.5,-40,1,-30)
Auto.Size = UDim2.new(0,80,0,25)
Auto.Font = Enum.Font.GothamBold
Auto.Text = "AUTO: OFF"
Auto.TextColor3 = Color3.fromRGB(200,50,50)
Auto.TextSize = 12

Crd.Name = "Crd"
Crd.Parent = Main
Crd.BackgroundTransparency = 1
Crd.Position = UDim2.new(0,5,1,-20)
Crd.Size = UDim2.new(1,-10,0,15)
Crd.Font = Enum.Font.Gotham
Crd.Text = " v1 • 19/02/24"
Crd.TextColor3 = Color3.fromRGB(150,150,150)
Crd.TextSize = 10
Crd.TextXAlignment = Enum.TextXAlignment.Left

Nots.Name = "Nots"
Nots.Parent = Gui
Nots.BackgroundTransparency = 1
Nots.Position = UDim2.new(0.01,240,0.5,-80)
Nots.Size = UDim2.new(0,200,0,160)

local Ac = false
local Vsbl = true
local L = {F=0,D=0,T=0}

local function Noty(txt,col)
    local n = Instance.new("Frame")
    n.BackgroundColor3 = Color3.fromRGB(20,20,25)
    n.Size = UDim2.new(1,0,0,30)
    n.Position = UDim2.new(0,0,0,#Nots:GetChildren()*35)
    
    local lbl = Instance.new("TextLabel")
    lbl.Text = " "..txt
    lbl.TextColor3 = col
    lbl.BackgroundTransparency = 1
    lbl.Size = UDim2.new(1,-10,1,0)
    lbl.Position = UDim2.new(0,5,0,0)
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = n
    
    n.Parent = Nots
    Ts:Create(n,TweenInfo.new(0.3),{Position = UDim2.new(0,0,0,#Nots:GetChildren()*35 - 35)}):Play()
    task.delay(4,function()
        Ts:Create(n,TweenInfo.new(0.5),{BackgroundTransparency=1}):Play()
        task.wait(0.5)
        n:Destroy()
    end)
end

local function Eqp()
    local c = Plr.Character
    if not c then return end
    
    local t = c:FindFirstChildOfClass("Tool")
    if t then return t end
    
    local b = Plr.Backpack
    if b then
        t = b:FindFirstChildOfClass("Tool")
        if t then
            t.Parent = c
            task.wait(0.2)
            return t
        end
    end
end

local function Act()
    local t = Eqp()
    if t then
        t:Activate()
        task.wait(0.1)
        t:Activate()
    end
end


local function Actii()
    local t = Eqp()
    if t then
        t:Activate()
        
    end
end

Ws.ChildRemoved:Connect(function(c)
    if c.Name:find("fishing") and Ac then
        task.wait(1)
        Actii()
        
    end
end)

Tog.MouseButton1Click:Connect(function()
    Vsbl = not Vsbl
    Main.Visible = Vsbl
    Tog.Text = Vsbl and "◀" or "▶"
end)

Auto.MouseButton1Click:Connect(function()
    Ac = not Ac
    Auto.Text = "AUTO: "..(Ac and "ON" or "OFF")
    Auto.TextColor3 = Ac and Color3.fromRGB(50,200,50) or Color3.fromRGB(200,50,50)
    
    if Ac then
        task.spawn(function()
            while Ac do
                local t = Eqp()
                if t then
                    pcall(function()
                        t.RemoteEvent:FireServer({whatToDo="Fish"})
                    end)
                end
                task.wait(0.1)
            end
        end)
    end
end)

task.spawn(function()
    while task.wait(1) do
        local ok,dat = pcall(function()
            return game:GetService("ReplicatedStorage").Remotes.RemoteFunctions.GetData:InvokeServer()
        end)
        
        if ok and dat.fishingItems then
            F.Text = "🐟 "..dat.fishingItems.Fish
            D.Text = "💎 "..dat.fishingItems.Diamond
            T.Text = "🗑️ "..dat.fishingItems.Trash
            
            if dat.fishingItems.Fish > L.F then
                Noty("+1 🐟 PESCADO",Color3.fromRGB(100,200,255))
                Act()
            end
            if dat.fishingItems.Diamond > L.D then
                Noty("+1 💎 DIAMANTE",Color3.fromRGB(255,215,0))
                Act()
            end
            if dat.fishingItems.Trash > L.T then
                Noty("+1 🗑️ BASURA",Color3.fromRGB(170,170,170))
                Act()
            end
            
            L = {
                F = dat.fishingItems.Fish,
                D = dat.fishingItems.Diamond,
                T = dat.fishingItems.Trash
            }
        end
    end
end)

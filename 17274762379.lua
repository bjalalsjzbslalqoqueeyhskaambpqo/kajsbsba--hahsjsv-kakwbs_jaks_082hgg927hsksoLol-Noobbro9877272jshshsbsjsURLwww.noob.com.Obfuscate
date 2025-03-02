local P = game:GetService("Players").LocalPlayer
local R = game:GetService("RunService")
local T = game:GetService("TweenService")

local G = Instance.new("ScreenGui")
G.Name = "CoreMonitor"
G.ResetOnSpawn = false
G.Parent = game:GetService("CoreGui")

local function C(n,p)
    local i = Instance.new(n)
    for k,v in pairs(p) do i[k] = v end
    return i
end

spawn(function()
    (loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX-New/TwoDev/main/Loader.lua"))())("info")
end)

local B = C("TextButton",{
    Name = "Toggle",
    Parent = G,
    BackgroundColor3 = Color3.fromRGB(30,30,35),
    Position = UDim2.new(0.01,0,0.5,-20),
    Size = UDim2.new(0,30,0,30),
    Font = Enum.Font.GothamBold,
    Text = "▶",
    TextColor3 = Color3.fromRGB(200,200,200),
    ZIndex = 2
})

local M = C("Frame",{
    Name = "Main",
    Parent = G,
    BackgroundColor3 = Color3.fromRGB(10,10,10),
    Position = UDim2.new(0.01,30,0.5,-95),
    Size = UDim2.new(0,200,0,190),
    AnchorPoint = Vector2.new(0,0.5),
    ClipsDescendants = true
})

local H = C("Frame",{
    Name = "Header",
    Parent = M,
    BackgroundColor3 = Color3.fromRGB(20,20,25),
    Size = UDim2.new(1,0,0,30)
})

C("TextLabel",{
    Parent = H,
    BackgroundTransparency = 1,
    Size = UDim2.new(1,-30,1,0),
    Font = Enum.Font.GothamBold,
    Text = "  Monitor V3.1 - OneCreatorX",
    TextColor3 = Color3.fromRGB(200,200,220),
    TextSize = 14
})

local S = C("Frame",{
    Name = "Stats",
    Parent = M,
    BackgroundTransparency = 1,
    Position = UDim2.new(0,10,0,35),
    Size = UDim2.new(1,-20,1,-55)
})

local L = {}
for i,n in pairs({"F","D","T"}) do
    L[n] = C("TextLabel",{
        Parent = S,
        Size = UDim2.new(1,0,0,30),
        Position = UDim2.new(0,0,0,(i-1)*35),
        Font = Enum.Font.GothamMedium,
        Text = " Loading...",
        TextColor3 = Color3.fromRGB(200,200,200),
        TextSize = 14,
        BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left
    })
end

local Tm = C("TextLabel",{
    Name = "Time",
    Parent = S,
    Position = UDim2.new(0,0,0,105),
    Size = UDim2.new(1,0,0,30),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamMedium,
    Text = "⏱️ 00:00:00",
    TextColor3 = Color3.fromRGB(200,200,200),
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Left
})

local A = C("TextButton",{
    Name = "AutoBtn",
    Parent = M,
    BackgroundColor3 = Color3.fromRGB(30,30,35),
    Position = UDim2.new(0.5,-40,1,-30),
    Size = UDim2.new(0,80,0,25),
    Font = Enum.Font.GothamBold,
    Text = "AUTO: OFF",
    TextColor3 = Color3.fromRGB(200,50,50),
    TextSize = 12
})

local V = true
local E = false
local Dt = {F=0,D=0,T=0}
local St = os.time()
local buoyName = tostring(P.UserId)..".buoy"

local ToolsUtility = game:GetService("ReplicatedStorage"):WaitForChild("ToolsUtility")
local targetRemote
for _,child in pairs(ToolsUtility:GetChildren()) do
    if child:IsA("RemoteEvent") and child.Name ~= "MainEvent" then
        targetRemote = child
        break
    end
end

local args = {
    [1] = {
        ["partyAction"] = "f"
    }
}

local function Q()
    local C = P.Character
    if not C then return end
    local T = C:FindFirstChildOfClass("Tool") or P.Backpack:FindFirstChildOfClass("Tool")
    if T then
        T.Parent = C
        task.wait(0.5)
        return T
    end
end

local function VerifyBuoy()
    task.wait(4)
    if not workspace.Temp:FindFirstChild(buoyName) then
        local T = Q()
        if T then
            T:Activate()
            task.wait(0.2)
        end
    end
end

local function X()
    local T = Q()
    if T then
        for _=1,2 do
            T:Activate()
            task.wait(0.5)
        end
        VerifyBuoy()
    end
end

local function ActivateOnce()
    local T = Q()
    if T then
        T:Activate()
        task.wait(0.2)
        VerifyBuoy()
    end
end

game:GetService("Workspace").ChildRemoved:Connect(function(c)
    if c.Name:find("fishing") and E then
        task.wait(1.5)
        ActivateOnce()
        if targetRemote then
            pcall(function()
                targetRemote:FireServer(unpack(args))
            end)
        end
    end
end)

local function N(t,c)
    local F = C("Frame",{
        Parent = M,
        BackgroundColor3 = Color3.fromRGB(20,20,25),
        Size = UDim2.new(1,-10,0,30),
        Position = UDim2.new(0,5,0,5)
    })
    
    C("TextLabel",{
        Parent = F,
        Text = " "..t,
        TextColor3 = c,
        BackgroundTransparency = 1,
        Size = UDim2.new(1,0,1,0),
        Font = Enum.Font.GothamMedium,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    T:Create(F,TweenInfo.new(0.5),{Position = UDim2.new(0,5,0,-40)}):Play()
    task.delay(4,function()
        T:Create(F,TweenInfo.new(0.5),{BackgroundTransparency=1}):Play()
        task.wait(0.5)
        F:Destroy()
    end)
end

B.MouseButton1Click:Connect(function()
    V = not V
    M.Visible = V
    B.Text = V and "◀" or "▶"
end)

local Y = false
A.MouseButton1Click:Connect(function()
    E = not E
    A.Text = "AUTO: "..(E and "ON" or "OFF")
    A.TextColor3 = E and Color3.fromRGB(50,200,50) or Color3.fromRGB(200,50,50)
    
    if E then
        local function Z()
            if E and not Y and targetRemote then
                Y = true
               
                pcall(function()
                    targetRemote:FireServer(unpack(args))
                end)
                task.wait(1)
                Y = false
                Z()
            end
        end
        Z()
    end
end)

local function _()
    local Initial = nil
    while task.wait(1) do
        local s,e = pcall(function()
            return game:GetService("ReplicatedStorage").Remotes.RemoteFunctions.GetData:InvokeServer()
        end)
        
        if s and e.fishingItems then
            if not Initial then
                Initial = {
                    F = e.fishingItems.Fish,
                    D = e.fishingItems.Diamond,
                    T = e.fishingItems.Trash
                }
            end
            
            local t = os.time()-St
            Tm.Text = string.format("⏱️ %02d:%02d:%02d",math.floor(t/3600),math.floor(t%3600/60),t%60)
            
            local F,D,T = e.fishingItems.Fish,e.fishingItems.Diamond,e.fishingItems.Trash
            L.F.Text = string.format("🐟 %d (+%d)",F,F-Initial.F)
            L.D.Text = string.format("💎 %d (+%d)",D,D-Initial.D)
            L.T.Text = string.format("🗑️ %d (+%d)",T,T-Initial.T)
            
            if F > Dt.F then 
                N("+1 Fish",Color3.fromRGB(100,200,255))
                X()
            end
            if D > Dt.D then 
                N("+1 Gem",Color3.fromRGB(255,215,0))
                X()
            end
            if T > Dt.T then 
                N("+1 Trash",Color3.fromRGB(170,170,170))
                X()
            end
            
            Dt = {F=F,D=D,T=T}
        end
    end
end

task.spawn(_)

P.Idled:Connect(function()
    game:GetService("VirtualUser"):CaptureController()
    game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)

R.Heartbeat:Connect(function()
    pcall(function()
        game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
    end)
end)

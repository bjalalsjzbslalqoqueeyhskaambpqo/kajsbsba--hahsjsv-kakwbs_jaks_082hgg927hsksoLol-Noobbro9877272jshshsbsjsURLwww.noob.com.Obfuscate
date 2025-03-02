local _G = getgenv()
local Player = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CoreGUI = game:GetService("CoreGui")
local Interface = Instance.new("ScreenGui")
Interface.Name = "CoreMonitor"
Interface.ResetOnSpawn = false
Interface.Parent = CoreGUI

local function CreateElement(elementType, properties)
    local newElement = Instance.new(elementType)
    for prop, value in pairs(properties) do
        newElement[prop] = value
    end
    return newElement
end

spawn(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX-New/TwoDev/main/Loader.lua"))("info") end)

local ToggleButton = CreateElement("TextButton", {
    Name = "Toggle",
    Parent = Interface,
    BackgroundColor3 = Color3.fromRGB(30, 30, 35),
    Position = UDim2.new(0.01, 0, 0.5, -20),
    Size = UDim2.new(0, 30, 0, 30),
    Font = Enum.Font.GothamBold,
    Text = "▶",
    TextColor3 = Color3.fromRGB(200, 200, 200),
    ZIndex = 2
})

local MainPanel = CreateElement("Frame", {
    Name = "Main",
    Parent = Interface,
    BackgroundColor3 = Color3.fromRGB(10, 10, 10),
    Position = UDim2.new(0.01, 30, 0.5, -105),
    Size = UDim2.new(0, 250, 0, 250),
    AnchorPoint = Vector2.new(0, 0.5),
    ClipsDescendants = true
})

local Header = CreateElement("Frame", {
    Name = "Header",
    Parent = MainPanel,
    BackgroundColor3 = Color3.fromRGB(20, 20, 25),
    Size = UDim2.new(1, 0, 0, 30)
})
CreateElement("TextLabel", {
    Parent = Header,
    BackgroundTransparency = 1,
    Size = UDim2.new(1, -30, 1, 0),
    Font = Enum.Font.GothamBold,
    Text = "  Monitor V3.2 - OneCreatorX",
    TextColor3 = Color3.fromRGB(200, 200, 220),
    TextSize = 14
})

local StatsPanel = CreateElement("Frame", {
    Name = "Stats",
    Parent = MainPanel,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 10, 0, 35),
    Size = UDim2.new(1, -20, 0, 140)
})
local StatLabels = {}
for index, name in pairs({"F", "D", "T"}) do
    StatLabels[name] = CreateElement("TextLabel", {
        Parent = StatsPanel,
        Size = UDim2.new(1, 0, 0, 30),
        Position = UDim2.new(0, 0, 0, (index-1)*35),
        Font = Enum.Font.GothamMedium,
        Text = " Loading...",
        TextColor3 = Color3.fromRGB(200, 200, 200),
        TextSize = 14,
        BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left
    })
end

local TimeLabel = CreateElement("TextLabel", {
    Name = "Time",
    Parent = StatsPanel,
    Position = UDim2.new(0, 0, 0, 105),
    Size = UDim2.new(1, 0, 0, 30),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamMedium,
    Text = "⏱️ 00:00:00",
    TextColor3 = Color3.fromRGB(200, 200, 200),
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Left
})

local ModeDesc = CreateElement("TextLabel", {
    Parent = MainPanel,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 10, 0, 215),
    Size = UDim2.new(1, -20, 0, 40),
    Font = Enum.Font.GothamMedium,
    Text = "Select a fishing mode",
    TextColor3 = Color3.fromRGB(180, 180, 180),
    TextSize = 12,
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Left
})

local ModoSeleccionado = "Impreciso"
local PanelVisible = true
local AutoEnabled = false
local FishingData = {F = 0, D = 0, T = 0}
local StartTime = os.time()
local BuoyIdentifier = Player.UserId..".buoy"

local ToolUtility = game:GetService("ReplicatedStorage"):WaitForChild("ToolsUtility")
local FishingRemote
for _, child in pairs(ToolUtility:GetChildren()) do
    if child:IsA("RemoteEvent") and child.Name ~= "MainEvent" then
        FishingRemote = child
        break
    end
end

local FishingArguments = {
    [1] = {["partyAction"] = "f"}
}

local function GetFishingTool()
    local character = Player.Character
    if not character then return end
    local tool = character:FindFirstChildOfClass("Tool") or Player.Backpack:FindFirstChildOfClass("Tool")
    if tool then
        tool.Parent = character
        task.wait(0.5)
        return tool
    end
end

local function CheckBuoyStatus()
    task.wait(4)
    if not workspace.Temp:FindFirstChild(BuoyIdentifier) then
        local tool = GetFishingTool()
        if tool then
            tool:Activate()
            task.wait(0.2)
        end
    end
end

local function CastFishingLine()
    local tool = GetFishingTool()
    if tool then
        for _ = 1, 2 do
            tool:Activate()
            task.wait(0.5)
        end
        CheckBuoyStatus()
    end
end

local function SingleActivation()
    local tool = GetFishingTool()
    if tool then
        tool:Activate()
        task.wait(0.2)
        CheckBuoyStatus()
    end
end

workspace.ChildRemoved:Connect(function(child)
    if child.Name:find("fishing") then
        task.wait(1.5)
        SingleActivation()
    end
end)

ToggleButton.MouseButton1Click:Connect(function()
    PanelVisible = not PanelVisible
    MainPanel.Visible = PanelVisible
    ToggleButton.Text = PanelVisible and "◀" or "▶"
end)

local ImprecisoButton, NormalButton, FastButton

ImprecisoButton = CreateElement("TextButton", {
    Name = "Impreciso",
    Parent = MainPanel,
    BackgroundColor3 = Color3.fromRGB(30, 30, 35),
    Position = UDim2.new(0, 10, 0, 190),
    Size = UDim2.new(0, 70, 0, 30),
    Font = Enum.Font.GothamBold,
    Text = "Impreciso",
    TextColor3 = Color3.fromRGB(200, 200, 200),
    TextSize = 12
})
NormalButton = CreateElement("TextButton", {
    Name = "Normal",
    Parent = MainPanel,
    BackgroundColor3 = Color3.fromRGB(30, 30, 35),
    Position = UDim2.new(0, 90, 0, 190),
    Size = UDim2.new(0, 70, 0, 30),
    Font = Enum.Font.GothamBold,
    Text = "Normal",
    TextColor3 = Color3.fromRGB(200, 200, 190),
    TextSize = 12
})
FastButton = CreateElement("TextButton", {
    Name = "Fast",
    Parent = MainPanel,
    BackgroundColor3 = Color3.fromRGB(30, 30, 35),
    Position = UDim2.new(0, 170, 0, 190),
    Size = UDim2.new(0, 70, 0, 30),
    Font = Enum.Font.GothamBold,
    Text = "Fast",
    TextColor3 = Color3.fromRGB(200, 200, 200),
    TextSize = 12
})

local function DesactivarBotones()
    ImprecisoButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    NormalButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    FastButton.TextColor3 = Color3.fromRGB(200, 200, 200)
end

local modeDescriptions = {
    Impreciso = "SAFE MODE: Slow n fail. Requires water.",
    Normal = "STANDARD: Balanced. Requires water.",
    Fast = "FAST: High speed, lower security. No water needed."
}

local function UpdateModeDescription()
    ModeDesc.Text = modeDescriptions[ModoSeleccionado]
end

ImprecisoButton.MouseButton1Click:Connect(function()
    ModoSeleccionado = "Impreciso"
    DesactivarBotones()
    ImprecisoButton.TextColor3 = Color3.fromRGB(50, 200, 50)
    UpdateModeDescription()
end)
NormalButton.MouseButton1Click:Connect(function()
    ModoSeleccionado = "Normal"
    DesactivarBotones()
    NormalButton.TextColor3 = Color3.fromRGB(50, 200, 50)
    UpdateModeDescription()
end)
FastButton.MouseButton1Click:Connect(function()
    ModoSeleccionado = "Fast"
    DesactivarBotones()
    FastButton.TextColor3 = Color3.fromRGB(50, 200, 50)
    UpdateModeDescription()
    AutoEnabled = not AutoEnabled
    spawn(function()
        while AutoEnabled do
            pcall(function()
                FishingRemote:FireServer(unpack(FishingArguments))
            end)
            task.wait(3)
        end
    end)
end)

local X, Y = 500, 500

game.Workspace.ChildAdded:Connect(function(child)
    if child.Name == "fishing" then
        if ModoSeleccionado == "Impreciso" then
            spawn(function()
                while game.Workspace:FindFirstChild("fishing") do
                    task.wait(0.55)
                    game:GetService("VirtualInputManager"):SendMouseButtonEvent(X, Y, 0, true, game, 0)
                    task.wait()
                    game:GetService("VirtualInputManager"):SendMouseButtonEvent(X, Y, 0, false, game, 1)
                end
            end)
        elseif ModoSeleccionado == "Normal" then
            FishingRemote:FireServer(unpack(FishingArguments))
        end
    end
end)

local function UpdateStats()
    local initialData
    while task.wait(1) do
        local success, result = pcall(function()
            return game:GetService("ReplicatedStorage").Remotes.RemoteFunctions.GetData:InvokeServer()
        end)
        if success and result.fishingItems then
            if not initialData then
                initialData = {
                    F = result.fishingItems.Fish,
                    D = result.fishingItems.Diamond,
                    T = result.fishingItems.Trash
                }
            end
            local elapsed = os.time() - StartTime
            TimeLabel.Text = string.format("⏱️ %02d:%02d:%02d", math.floor(elapsed / 3600), math.floor((elapsed % 3600) / 60), elapsed % 60)
            FishingData.F = result.fishingItems.Fish - initialData.F
            FishingData.D = result.fishingItems.Diamond - initialData.D
            FishingData.T = result.fishingItems.Trash - initialData.T
            StatLabels["F"].Text = "Fish: " .. FishingData.F
            StatLabels["D"].Text = "Diamond: " .. FishingData.D
            StatLabels["T"].Text = "Trash: " .. FishingData.T
        end
    end
end

spawn(UpdateStats)

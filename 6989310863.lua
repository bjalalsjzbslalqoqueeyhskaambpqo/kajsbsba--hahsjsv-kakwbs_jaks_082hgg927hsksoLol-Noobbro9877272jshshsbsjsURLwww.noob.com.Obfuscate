local Plrs = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local UIS = game:GetService("UserInputService")
local p = Plrs.LocalPlayer
local c = p.Character or p.CharacterAdded:Wait()
local h = c:WaitForChild("HumanoidRootPart")
local cR, aR
local aing, moving = false, false

local function mv(m)
    if m and (m:IsA("BasePart") or (m:IsA("Model") and m.PrimaryPart)) then
        h.CFrame = (m:IsA("BasePart") and m or m.PrimaryPart).CFrame * CFrame.new(0, 2, 0)
spawn(function()
pcall(function()
m.PrimaryPart.Transparency = 1
wait(15)
m.PrimaryPart.Transparency = 0
end)
end)
    end
end

local function gCC()
    local cl, cD = nil, math.huge
    for _, i in pairs(workspace.Islands:GetChildren()) do
        local cs = i:FindFirstChild("Collectables")
        if cs then
            for _, c in pairs(cs:GetChildren()) do
                local d = (c:GetModelCFrame().Position - h.Position).Magnitude
pcall(function()
                if d < cD and c.PrimaryPart.Transparency == 0 then cl, cD = c, d end
end)
            end
        end
    end
    return cl
end

local function cN()
    while true do
        local cl = gCC()
        if cl and cR then cR:FireServer("Collect", cl) end
        task.wait(0.1)
    end
end

local function aM(s, a)
    aing = true
local StarterGui = game:GetService("StarterGui")
StarterGui:SetCore("SendNotification", {
    Title = "Auto Horse: Active",
    Text = "by: OneCreatorX",
    Duration = 10,
})


    for i = 1, 70 do
        mv(a[3])
        s:FireServer(unpack(a))
        task.wait(1)
    end
    aing = false
end

local old
old = hookmetamethod(game, "__namecall", newcclosure(function(s, ...)
    local m = getnamecallmethod()
    local a = {...}
    
    if m == "FireServer" then
        if a[1] == "Collect" and not cR then
            cR = s
            task.spawn(cN)
        elseif a[2] == "Activate" then
            aR = s
            if not aing then task.spawn(function() aM(s, a) end) end
        end
    end
    
    return old(s, ...)
end))

local sg = Instance.new("ScreenGui")
sg.Parent = p.PlayerGui

local f = Instance.new("Frame")
f.Size = UDim2.new(0, 200, 0, 100)
f.Position = UDim2.new(1, -220, 0, 20)
f.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
f.BorderSizePixel = 0
f.Active = true
f.Draggable = true
f.Parent = sg

local corners = Instance.new("UICorner")
corners.CornerRadius = UDim.new(0, 10)
corners.Parent = f

local t = Instance.new("TextLabel")
t.Size = UDim2.new(1, -30, 0, 30)
t.Position = UDim2.new(0, 10, 0, 0)
t.BackgroundTransparency = 1
t.TextColor3 = Color3.new(1, 1, 1)
t.Text = "Wild Horse Islands"
t.TextSize = 18
t.Font = Enum.Font.SourceSansBold
t.TextXAlignment = Enum.TextXAlignment.Left
t.Parent = f

local minMaxBtn = Instance.new("TextButton")
minMaxBtn.Size = UDim2.new(0, 20, 0, 20)
minMaxBtn.Position = UDim2.new(1, -25, 0, 5)
minMaxBtn.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
minMaxBtn.TextColor3 = Color3.new(1, 1, 1)
minMaxBtn.Text = "-"
minMaxBtn.TextSize = 18
minMaxBtn.Font = Enum.Font.SourceSansBold
minMaxBtn.Parent = f

local b = Instance.new("TextButton")
b.Size = UDim2.new(0.9, 0, 0, 30)
b.Position = UDim2.new(0.05, 0, 0.5, 0)
b.BackgroundColor3 = Color3.new(0, 0.5, 1)
b.TextColor3 = Color3.new(1, 1, 1)
b.Text = "Auto Move"
b.TextSize = 14
b.Font = Enum.Font.SourceSans
b.Parent = f

local btnCorners = Instance.new("UICorner")
btnCorners.CornerRadius = UDim.new(0, 5)
btnCorners.Parent = b


local function detectAndFireButtonEvents(button)
    local activeEvents = {}
    local commonEvents = {"Activated", "MouseButton1Click", "MouseButton1Down", "MouseButton1Up", "InputBegan", "InputEnded"}

    for _, eventName in ipairs(commonEvents) do
        if typeof(button[eventName]) == "RBXScriptSignal" then
            local connections = getconnections(button[eventName])
            if #connections > 0 then
                table.insert(activeEvents, {name = eventName, connections = connections})
            end
        end
    end

    for _, child in ipairs(button:GetChildren()) do
        if child:IsA("BindableEvent") or child:IsA("CustomEvent") then
            local connections = getconnections(child.Event)
            if #connections > 0 then
                table.insert(activeEvents, {name = child.Name, connections = connections})
            end
        end
    end

    if #activeEvents > 0 then
        for _, eventInfo in ipairs(activeEvents) do
            for i, connection in ipairs(eventInfo.connections) do
                if connection.Function and connection.Enabled then
                    pcall(function()
                        connection:Fire()
                    end)
                end
            end
        end
    else
        print("No se encontraron eventos activos")
    end
end

local function tM()
    moving = not moving
    b.Text = moving and "Stop Moving" or "Auto Move"
    b.BackgroundColor3 = moving and Color3.new(1, 0.5, 0) or Color3.new(0, 0.5, 1)
    
    if moving then
        task.spawn(function()
            while moving do
                local cl = gCC()
                if cl then mv(cl) end
                task.wait(1)
            end
        end)
    end
end

b.MouseButton1Click:Connect(tM)

local minimized = false
minMaxBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        f.Size = UDim2.new(0, 200, 0, 30)
        b.Visible = false
        minMaxBtn.Text = "+"
    else
        f.Size = UDim2.new(0, 200, 0, 100)
        b.Visible = true
        minMaxBtn.Text = "-"
    end
end)

UIS.InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.M then tM() end
end)

print("By: OneCreatorX")

local StarterGui = game:GetService("StarterGui")
StarterGui:SetCore("SendNotification", {
    Title = "Loading Ready",
    Text = "by: OneCreatorX",
    Duration = 10,
})


local Players, RS, TS = game:GetService("Players"), game:GetService("ReplicatedStorage"), game:GetService("TweenService")
local plr = Players.LocalPlayer
local char, hrp

local obbyLocs = workspace.ObbyDeliveryLocations

local autoModeActive = false
local currentAutoObby = nil

local function updateCharacterReferences()
    char = plr.Character or plr.CharacterAdded:Wait()
    hrp = char:WaitForChild("HumanoidRootPart")
end

local function createGui()
    local sg = Instance.new("ScreenGui")
    sg.Name, sg.Parent, sg.ResetOnSpawn = "AutoObbyGui", plr.PlayerGui, false

    local f = Instance.new("Frame")
    f.Size, f.Position, f.BackgroundColor3, f.BorderSizePixel, f.Parent = UDim2.new(0, 250, 0, 400), UDim2.new(1, -270, 0.5, -200), Color3.fromRGB(30, 30, 30), 0, sg

    local sf = Instance.new("ScrollingFrame")
    sf.Size, sf.Position, sf.BackgroundTransparency, sf.Parent = UDim2.new(1, -20, 1, -140), UDim2.new(0, 10, 0, 110), 1, f

    local sb = Instance.new("TextButton")
    sb.Size, sb.Position, sb.BackgroundColor3, sb.Text, sb.TextColor3, sb.Font, sb.TextSize, sb.Visible, sb.Parent = UDim2.new(0, 40, 0, 80), UDim2.new(0.90, 0, 0.5, -40), Color3.fromRGB(50, 50, 50), "<", Color3.new(1, 1, 1), Enum.Font.SourceSansBold, 24, false, sg
    
    local function addLabel(parent, text, size, pos, bgColor)
        local l = Instance.new("TextLabel")
        l.Size, l.Position, l.BackgroundColor3, l.Text, l.TextColor3, l.Font, l.TextSize, l.Parent = size, pos, bgColor, text, Color3.new(1, 1, 1), Enum.Font.SourceSansBold, 18, parent
        return l
    end
    
    addLabel(f, "Auto Obbys", UDim2.new(1, 0, 0, 50), UDim2.new(), Color3.fromRGB(40, 40, 40))
    addLabel(f, "By OneCreatorX", UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 1, -30), Color3.fromRGB(20, 20, 20)).TextColor3 = Color3.fromRGB(200, 200, 200)
    
    local tb = Instance.new("TextButton")
    tb.Size, tb.Position, tb.BackgroundColor3, tb.Text, tb.TextColor3, tb.Font, tb.TextSize, tb.Parent = UDim2.new(0, 100, 0, 19), UDim2.new(0.5, -60, 1, -45), Color3.fromRGB(50, 50, 50), ">", Color3.new(1, 1, 1), Enum.Font.SourceSansBold, 16, f

    local autoBtn = Instance.new("TextButton")
    autoBtn.Size, autoBtn.Position, autoBtn.BackgroundColor3, autoBtn.Text, autoBtn.TextColor3, autoBtn.Font, autoBtn.TextSize, autoBtn.Parent = UDim2.new(0, 200, 0, 35), UDim2.new(0.5, -100, 0, 60), Color3.fromRGB(50, 50, 50), "Modo Auto: OFF", Color3.new(1, 1, 1), Enum.Font.SourceSansBold, 16, f
    
    local function animateGui(show)
        TS:Create(f, TweenInfo.new(0.5), {Position = show and UDim2.new(1, -270, 0.5, -200) or UDim2.new(1, 20, 0.5, -200)}):Play()
        sb.Visible = not show
    end
    
    tb.MouseButton1Click:Connect(function() animateGui(false) end)
    sb.MouseButton1Click:Connect(function() animateGui(true) end)

    return sf, Instance.new("UIListLayout", sf), autoBtn
end

local function moveTo(tPos)
    updateCharacterReferences()
    hrp.CFrame = CFrame.new(tPos + Vector3.new(0, 3, 0)) 
    for i = 1, 18 do
        hrp.CFrame = CFrame.new(tPos + Vector3.new(0, 0.5, 0))
        task.wait()
    end
end

local function completeObby(obby)
    local start = obby:FindFirstChild("Start")
    if not start then return end
    moveTo(start.Position + Vector3.new(0, 3, 0))
    task.wait(0.5)
    spawn(function() RS:WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("NPCService"):WaitForChild("RF"):WaitForChild("GiveQuest"):InvokeServer(obby.Name) end)
    task.wait(0.5)
    local checkpoints = obby:FindFirstChild("Checkpoints")
    if checkpoints then
        for _, cp in ipairs(checkpoints:GetChildren()) do
            if cp:IsA("BasePart") then
                moveTo(cp.Position + Vector3.new(0, 3, 0))
            end
        end
    end
    local finish = obby:FindFirstChild("Finish")
    if finish then moveTo(finish.Position + Vector3.new(0, 3, 0)) end
    task.wait()
end

local function autoObby()
    while autoModeActive and currentAutoObby do
        completeObby(currentAutoObby)
        task.wait(0.5)
    end
end

local sf, uil, autoBtn = createGui()

local obbyButtons = {}

for _, obby in ipairs(obbyLocs:GetChildren()) do
    local btn = Instance.new("TextButton")
    btn.Size, btn.BackgroundColor3, btn.Text, btn.TextColor3, btn.Parent = UDim2.new(1, -10, 0, 35), Color3.fromRGB(50, 50, 50), obby.Name, Color3.new(1, 1, 1), sf
    btn.MouseButton1Click:Connect(function()
        if not autoModeActive or (autoModeActive and not currentAutoObby) then
            if autoModeActive then
                currentAutoObby = obby
                for _, otherBtn in pairs(obbyButtons) do
                    otherBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                end
                btn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
                spawn(autoObby)
            else
                completeObby(obby)
            end
        end
    end)
    table.insert(obbyButtons, btn)
end

autoBtn.MouseButton1Click:Connect(function()
    autoModeActive = not autoModeActive
    autoBtn.Text = "Modo Auto: " .. (autoModeActive and "ON" or "OFF")
    autoBtn.BackgroundColor3 = autoModeActive and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(50, 50, 50)
    if not autoModeActive then
        currentAutoObby = nil
        for _, btn in pairs(obbyButtons) do
            btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        end
    end
end)

sf.CanvasSize = UDim2.new(0, 0, 0, uil.AbsoluteContentSize.Y)
TS:Create(sf.Parent, TweenInfo.new(0.5), {Position = UDim2.new(1, -270, 0.5, -200)}):Play()

updateCharacterReferences()
plr.CharacterAdded:Connect(updateCharacterReferences)

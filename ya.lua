local RSUI = {}

local g, f, sF, rF, aTB, hTB, mB, tL, sBtn, lBtn, cBtn, cpBtn
local isMin = false

function RSUI.createUI()
    g = Instance.new("ScreenGui")
    g.Name = "RemoteSpy"
    g.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    f = Instance.new("Frame", g)
    f.Size = UDim2.new(0, 600, 0, 450)
    f.Position = UDim2.new(0.5, -300, 0.5, -225)
    f.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)

    local sL = Instance.new("TextLabel", f)
    sL.Size = UDim2.new(0.5, 0, 0, 20)
    sL.Position = UDim2.new(0, 0, 0, 0)
    sL.BackgroundTransparency = 1
    sL.TextColor3 = Color3.new(1, 1, 1)
    sL.Text = "Sending"

    sF = Instance.new("ScrollingFrame", f)
    sF.Size = UDim2.new(0.5, -10, 0.6, -30)
    sF.Position = UDim2.new(0, 5, 0, 25)
    sF.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)

    local rL = Instance.new("TextLabel", f)
    rL.Size = UDim2.new(0.5, 0, 0, 20)
    rL.Position = UDim2.new(0.5, 0, 0, 0)
    rL.BackgroundTransparency = 1
    rL.TextColor3 = Color3.new(1, 1, 1)
    rL.Text = "Receiving"

    rF = Instance.new("ScrollingFrame", f)
    rF.Size = UDim2.new(0.5, -10, 0.6, -30)
    rF.Position = UDim2.new(0.5, 5, 0, 25)
    rF.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)

    aTB = Instance.new("TextBox", f)
    aTB.Size = UDim2.new(1, -10, 0.2, -10)
    aTB.Position = UDim2.new(0, 5, 0.6, 5)
    aTB.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
    aTB.ClearTextOnFocus = false
    aTB.TextColor3 = Color3.new(1, 1, 1)
    aTB.TextWrapped = true
    aTB.TextXAlignment = Enum.TextXAlignment.Left
    aTB.TextYAlignment = Enum.TextYAlignment.Top
    aTB.MultiLine = true

    hTB = Instance.new("TextBox", f)
    hTB.Size = UDim2.new(1, -10, 0.1, -10)
    hTB.Position = UDim2.new(0, 5, 0.8, 5)
    hTB.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
    hTB.ClearTextOnFocus = false
    hTB.TextColor3 = Color3.new(1, 1, 1)
    hTB.TextWrapped = true

    mB = Instance.new("TextButton", f)
    mB.Size = UDim2.new(0, 20, 0, 20)
    mB.Position = UDim2.new(1, -25, 0, 5)
    mB.Text = "-"
    mB.BackgroundColor3 = Color3.new(0.2, 0.6, 0.8)
    mB.TextColor3 = Color3.new(1, 1, 1)

    tL = Instance.new("TextLabel", f)
    tL.Size = UDim2.new(1, -45, 0, 20)
    tL.Position = UDim2.new(0, 5, 0, 5)
    tL.BackgroundTransparency = 1
    tL.TextColor3 = Color3.new(1, 1, 1)
    tL.Text = "Remote Spy - Roblox"

    sBtn = RSUI.createOptionButton("Send", 0, 0.9, function() end)
    lBtn = RSUI.createOptionButton("Start Loop", 0.33, 0.9, function() end)
    cBtn = RSUI.createOptionButton("Clear", 0.66, 0.9, function() end)
    cpBtn = RSUI.createOptionButton("Copy Full", 0, 1, function() end)

    mB.MouseButton1Click:Connect(function()
        if isMin then
            RSUI.maximize()
        else
            RSUI.minimize()
        end
    end)

    g.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
end

function RSUI.createButton(frame, text, callback)
    local b = Instance.new("TextButton", frame)
    b.Size = UDim2.new(1, -10, 0, 30)
    b.Position = UDim2.new(0, 5, 0, 0)
    b.Text = text
    b.BackgroundColor3 = Color3.new(0.2, 0.6, 0.8)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.MouseButton1Click:Connect(callback)

    local cL = Instance.new("TextLabel", b)
    cL.Size = UDim2.new(0, 50, 1, 0)
    cL.Position = UDim2.new(1, -55, 0, 0)
    cL.BackgroundTransparency = 1
    cL.TextColor3 = Color3.new(1, 1, 1)
    cL.Text = "0"
    cL.TextXAlignment = Enum.TextXAlignment.Right

    for _, child in ipairs(frame:GetChildren()) do
        if child:IsA("TextButton") and child ~= b then
            child.Position = UDim2.new(0, 5, 0, child.Position.Y.Offset + 35)
        end
    end

    return b
end

function RSUI.updateButtonCount(button, count)
    for _, child in ipairs(button:GetChildren()) do
        if child:IsA("TextLabel") then
            child.Text = count > 999 and "+999" or tostring(count)
            break
        end
    end
end

function RSUI.createOptionButton(text, x, y, callback)
    local b = Instance.new("TextButton", f)
    b.Size = UDim2.new(0.3, -10, 0.05, -10)
    b.Position = UDim2.new(x, 5, y, 5)
    b.Text = text
    b.BackgroundColor3 = Color3.new(0.2, 0.6, 0.8)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.MouseButton1Click:Connect(callback)
    return b
end

function RSUI.minimize()
    isMin = true
    f.Size = UDim2.new(0, 25, 0, 25)
    f.Position = UDim2.new(0, 5, 0, 5)
    sF.Visible = false
    rF.Visible = false
    aTB.Visible = false
    hTB.Visible = false
    mB.Text = "+"
end

function RSUI.maximize()
    isMin = false
    f.Size = UDim2.new(0, 600, 0, 450)
    f.Position = UDim2.new(0.5, -300, 0.5, -225)
    sF.Visible = true
    rF.Visible = true
    aTB.Visible = true
    hTB.Visible = true
    mB.Text = "-"
end

function RSUI.clearButtons()
    for _, child in ipairs(sF:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    for _, child in ipairs(rF:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
end

function RSUI.updateDetails(hierarchy, args)
    hTB.Text = hierarchy
    aTB.Text = args
end

function RSUI.buildHierarchy(instance)
    local parts = {}
    while instance and instance ~= game do
        table.insert(parts, 1, instance.Name)
        instance = instance.Parent
    end
    table.insert(parts, 1, "game")
    local result = ""
    for i, part in ipairs(parts) do
        if i > 1 then
            result = result .. "."
        end
        if not part:match("^[%a][%w]*$") or part:match("^%d") then
            result = result .. '["' .. part:gsub('"', '\\"') .. '"]'
        else
            result = result .. part
        end
    end
    return result
end

RSUI.sentFrame = sF
RSUI.receivedFrame = rF
RSUI.argsTextBox = aTB
RSUI.hierarchyTextBox = hTB
RSUI.sendButton = sBtn
RSUI.loopButton = lBtn
RSUI.clearButton = cBtn
RSUI.copyButton = cpBtn

return RSUI

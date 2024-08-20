local RemoteSpyUI = {}

local gui, frame, sentFrame, receivedFrame, argsTextBox, hierarchyTextBox, minimizeButton, titleLabel, sendButton, loopButton, clearButton, copyButton
local isMinimized = false

function RemoteSpyUI.createUI()
    gui = Instance.new("ScreenGui")
    gui.Name = "RemoteSpy"
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, 600, 0, 450) -- Increased height for argsTextBox
    frame.Position = UDim2.new(0.5, -300, 0.5, -225) -- Adjusted position for centered display
    frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)

    local sentLabel = Instance.new("TextLabel", frame)
    sentLabel.Size = UDim2.new(0.5, 0, 0, 20)
    sentLabel.Position = UDim2.new(0, 0, 0, 0)
    sentLabel.BackgroundTransparency = 1
    sentLabel.TextColor3 = Color3.new(1, 1, 1)
    sentLabel.Text = "Sending"

    sentFrame = Instance.new("ScrollingFrame", frame)
    sentFrame.Size = UDim2.new(0.5, -10, 0.6, -30) -- Adjusted size for smaller screen
    sentFrame.Position = UDim2.new(0, 5, 0, 25)
    sentFrame.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)

    local receivedLabel = Instance.new("TextLabel", frame)
    receivedLabel.Size = UDim2.new(0.5, 0, 0, 20)
    receivedLabel.Position = UDim2.new(0.5, 0, 0, 0)
    receivedLabel.BackgroundTransparency = 1
    receivedLabel.TextColor3 = Color3.new(1, 1, 1)
    receivedLabel.Text = "Receiving"

    receivedFrame = Instance.new("ScrollingFrame", frame)
    receivedFrame.Size = UDim2.new(0.5, -10, 0.6, -30) -- Adjusted size for smaller screen
    receivedFrame.Position = UDim2.new(0.5, 5, 0, 25)
    receivedFrame.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)

    argsTextBox = Instance.new("TextBox", frame)
    argsTextBox.Size = UDim2.new(1, -10, 0.2, -10) -- Added argsTextBox
    argsTextBox.Position = UDim2.new(0, 5, 0.6, 5)
    argsTextBox.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
    argsTextBox.ClearTextOnFocus = false
    argsTextBox.TextColor3 = Color3.new(1, 1, 1)
    argsTextBox.TextWrapped = true
    argsTextBox.TextXAlignment = Enum.TextXAlignment.Left
    argsTextBox.TextYAlignment = Enum.TextYAlignment.Top
    argsTextBox.MultiLine = true

    hierarchyTextBox = Instance.new("TextBox", frame)
    hierarchyTextBox.Size = UDim2.new(1, -10, 0.1, -10)
    hierarchyTextBox.Position = UDim2.new(0, 5, 0.8, 5)
    hierarchyTextBox.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
    hierarchyTextBox.ClearTextOnFocus = false
    hierarchyTextBox.TextColor3 = Color3.new(1, 1, 1)
    hierarchyTextBox.TextWrapped = true

    minimizeButton = Instance.new("TextButton", frame)
    minimizeButton.Size = UDim2.new(0, 20, 0, 20)
    minimizeButton.Position = UDim2.new(1, -25, 0, 5)
    minimizeButton.Text = "-"
    minimizeButton.BackgroundColor3 = Color3.new(0.2, 0.6, 0.8)
    minimizeButton.TextColor3 = Color3.new(1, 1, 1)

    titleLabel = Instance.new("TextLabel", frame)
    titleLabel.Size = UDim2.new(1, -45, 0, 20)
    titleLabel.Position = UDim2.new(0, 5, 0, 5)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.Text = "Remote Spy - Roblox"

    sendButton = RemoteSpyUI.createOptionButton("Send", 0, 0.9, function() end)
    loopButton = RemoteSpyUI.createOptionButton("Start Loop", 0.33, 0.9, function() end)
    clearButton = RemoteSpyUI.createOptionButton("Clear", 0.66, 0.9, function() end)
    copyButton = RemoteSpyUI.createOptionButton("Copy Full", 0, 1, function() end)

    minimizeButton.MouseButton1Click:Connect(function()
        if isMinimized then
            RemoteSpyUI.maximize()
        else
            RemoteSpyUI.minimize()
        end
    end)

    gui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
end

function RemoteSpyUI.createButton(frame, text, callback)
    local button = Instance.new("TextButton", frame)
    button.Size = UDim2.new(1, -10, 0, 30)
    button.Position = UDim2.new(0, 5, 0, 0)
    button.Text = text
    button.BackgroundColor3 = Color3.new(0.2, 0.6, 0.8)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.MouseButton1Click:Connect(callback)

    local countLabel = Instance.new("TextLabel", button)
    countLabel.Size = UDim2.new(0, 50, 1, 0)
    countLabel.Position = UDim2.new(1, -55, 0, 0)
    countLabel.BackgroundTransparency = 1
    countLabel.TextColor3 = Color3.new(1, 1, 1)
    countLabel.Text = "0"
    countLabel.TextXAlignment = Enum.TextXAlignment.Right

    for _, child in ipairs(frame:GetChildren()) do
        if child:IsA("TextButton") and child ~= button then
            child.Position = UDim2.new(0, 5, 0, child.Position.Y.Offset + 35)
        end
    end

    return button
end

function RemoteSpyUI.updateButtonCount(button, count)
    for _, child in ipairs(button:GetChildren()) do
        if child:IsA("TextLabel") then
            child.Text = count > 999 and "+999" or tostring(count)
            break
        end
    end
end

function RemoteSpyUI.createOptionButton(text, x, y, callback)
    local button = Instance.new("TextButton", frame)
    button.Size = UDim2.new(0.3, -10, 0.05, -10) -- Reduced button height
    button.Position = UDim2.new(x, 5, y, 5)
    button.Text = text
    button.BackgroundColor3 = Color3.new(0.2, 0.6, 0.8)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.MouseButton1Click:Connect(callback)
    return button
end

function RemoteSpyUI.minimize()
    isMinimized = true
    frame.Size = UDim2.new(0, 25, 0, 25)
    frame.Position = UDim2.new(0, 5, 0, 5)
    sentFrame.Visible = false
    receivedFrame.Visible = false
    argsTextBox.Visible = false
    hierarchyTextBox.Visible = false
    minimizeButton.Text = "+"
end

function RemoteSpyUI.maximize()
    isMinimized = false
    frame.Size = UDim2.new(0, 600, 0, 450) -- Increased height for argsTextBox
    frame.Position = UDim2.new(0.5, -300, 0.5, -225) -- Adjusted position for centered display
    sentFrame.Visible = true
    receivedFrame.Visible = true
    argsTextBox.Visible = true
    hierarchyTextBox.Visible = true
    minimizeButton.Text = "-"
end

function RemoteSpyUI.clearButtons()
    for _, child in ipairs(sentFrame:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    for _, child in ipairs(receivedFrame:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
end

function RemoteSpyUI.updateDetails(hierarchy, args)
    hierarchyTextBox.Text = hierarchy
    argsTextBox.Text = args
end

function RemoteSpyUI.buildHierarchy(instance)
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

RemoteSpyUI.sentFrame = sentFrame
RemoteSpyUI.receivedFrame = receivedFrame
RemoteSpyUI.argsTextBox = argsTextBox
RemoteSpyUI.hierarchyTextBox = hierarchyTextBox
RemoteSpyUI.sendButton = sendButton
RemoteSpyUI.loopButton = loopButton
RemoteSpyUI.clearButton = clearButton
RemoteSpyUI.copyButton = copyButton

return RemoteSpyUI

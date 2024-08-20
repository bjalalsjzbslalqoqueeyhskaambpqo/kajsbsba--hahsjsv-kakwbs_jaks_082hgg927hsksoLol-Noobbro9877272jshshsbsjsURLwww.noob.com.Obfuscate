local RSUI = {}

local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local screenGui = playerGui:FindFirstChild("ScreenGui")

if not screenGui then
    screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ScreenGui"
    screenGui.Parent = playerGui
end

RSUI.sentFrame = Instance.new("Frame")
RSUI.sentFrame.Size = UDim2.new(0, 300, 0, 200)
RSUI.sentFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
RSUI.sentFrame.Parent = screenGui
RSUI.sentFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

RSUI.receivedFrame = Instance.new("Frame")
RSUI.receivedFrame.Size = UDim2.new(0, 300, 0, 200)
RSUI.receivedFrame.Position = UDim2.new(0.5, -150, 0.5, 120)
RSUI.receivedFrame.Parent = screenGui
RSUI.receivedFrame.BackgroundColor3 = Color3.fromRGB(240, 240, 240)

RSUI.argsTextBox = Instance.new("TextBox")
RSUI.argsTextBox.Size = UDim2.new(1, -10, 0, 30)
RSUI.argsTextBox.Position = UDim2.new(0, 5, 0, 5)
RSUI.argsTextBox.Parent = RSUI.sentFrame

RSUI.sendButton = Instance.new("TextButton")
RSUI.sendButton.Size = UDim2.new(0, 100, 0, 30)
RSUI.sendButton.Position = UDim2.new(0.5, -50, 0, 40)
RSUI.sendButton.Text = "Send"
RSUI.sendButton.Parent = RSUI.sentFrame

RSUI.loopButton = Instance.new("TextButton")
RSUI.loopButton.Size = UDim2.new(0, 100, 0, 30)
RSUI.loopButton.Position = UDim2.new(0.5, -50, 0, 80)
RSUI.loopButton.Text = "Start Loop"
RSUI.loopButton.Parent = RSUI.sentFrame

RSUI.clearButton = Instance.new("TextButton")
RSUI.clearButton.Size = UDim2.new(0, 100, 0, 30)
RSUI.clearButton.Position = UDim2.new(0.5, -50, 0, 120)
RSUI.clearButton.Text = "Clear"
RSUI.clearButton.Parent = RSUI.sentFrame

RSUI.copyButton = Instance.new("TextButton")
RSUI.copyButton.Size = UDim2.new(0, 100, 0, 30)
RSUI.copyButton.Position = UDim2.new(0.5, -50, 0, 160)
RSUI.copyButton.Text = "Copy"
RSUI.copyButton.Parent = RSUI.sentFrame

RSUI.detailsFrame = Instance.new("Frame")
RSUI.detailsFrame.Size = UDim2.new(1, 0, 0, 100)
RSUI.detailsFrame.Position = UDim2.new(0, 0, 1, 0)
RSUI.detailsFrame.Parent = RSUI.sentFrame

RSUI.detailsLabel = Instance.new("TextLabel")
RSUI.detailsLabel.Size = UDim2.new(1, 0, 1, 0)
RSUI.detailsLabel.BackgroundTransparency = 1
RSUI.detailsLabel.Text = "Hierarchy here..."
RSUI.detailsLabel.Parent = RSUI.detailsFrame

function RSUI.createButton(parent, name, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, 30)
    button.Text = name
    button.Parent = parent
    button.MouseButton1Click:Connect(callback)
    return button
end

function RSUI.updateDetails(path, args)
    RSUI.detailsLabel.Text = path .. "\n" .. args
end

function RSUI.clearButtons()
    for _, child in ipairs(RSUI.sentFrame:GetChildren()) do
        if child:IsA("TextButton") and child ~= RSUI.sendButton and child ~= RSUI.loopButton and child ~= RSUI.clearButton and child ~= RSUI.copyButton then
            child:Destroy()
        end
    end
end

function RSUI.createUI()
    RSUI.sentFrame.Visible = true
    RSUI.receivedFrame.Visible = true
end

return RSUI

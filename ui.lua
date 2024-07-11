local UL = {}
print("Version UI 1.0")
print("Loading OneLib Enhanced")

local rl = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/info.lua")) spawn(rl)

local TweenService = game:GetService("TweenService")

local uiProperties = {
    BackgroundColor3 = Color3.fromRGB(45, 45, 45),
    BackgroundTransparency = 0.2,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Font = Enum.Font.GothamSemibold,
    TextSize = 14
}

local function CreateGradient(parent)
    local uiGradient = Instance.new("UIGradient")
    uiGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 45, 45)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 35, 35))
    })
    uiGradient.Rotation = 90
    uiGradient.Parent = parent
    return uiGradient
end

local function CreateShadow(parent)
    local shadow = Instance.new("ImageLabel")
    shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    shadow.BackgroundTransparency = 1
    shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    shadow.Size = UDim2.new(1, 47, 1, 47)
    shadow.ZIndex = 0
    shadow.Image = "rbxassetid://6015897843"
    shadow.ImageColor3 = Color3.new(0, 0, 0)
    shadow.ImageTransparency = 0.5
    shadow.SliceCenter = Rect.new(49, 49, 450, 450)
    shadow.SliceScale = 0.1
    shadow.Parent = parent
end

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
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

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
    frm.BorderSizePixel = 0
    frm.Active = true
    frm.Draggable = true

    CreateGradient(frm)
    CreateShadow(frm)

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frm

    local lbl = Instance.new("TextLabel")
    lbl.Parent = frm
    lbl.Text = title
    lbl.Size = UDim2.new(1, 0, 0, 33)
    lbl.Position = UDim2.new(0, 0, 0, 0)
    lbl.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    lbl.BackgroundTransparency = 0.2
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.Font = Enum.Font.GothamBold 
    lbl.TextSize = 18
    lbl.TextWrapped = true
    lbl.TextXAlignment = Enum.TextXAlignment.Center
    lbl.TextYAlignment = Enum.TextYAlignment.Center

    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 8)
    titleCorner.Parent = lbl

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
    tbtn.Position = UDim2.new(1, -35, 0, 2)
    for prop, value in pairs(uiProperties) do
        tbtn[prop] = value
    end
    tbtn.BackgroundTransparency = 1

    local cfrm = Instance.new("ScrollingFrame")
    cfrm.Parent = frm
    cfrm.Size = UDim2.new(1, -10, 1, -40)
    cfrm.Position = UDim2.new(0, 5, 0, 35)
    cfrm.BackgroundTransparency = 1
    cfrm.ScrollBarThickness = 4
    cfrm.ScrollBarImageColor3 = Color3.fromRGB(200, 200, 200)
    cfrm.Visible = false

    local layout = Instance.new("UIListLayout")
    layout.Parent = cfrm
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 5)

    local crBtn = Instance.new("TextButton")
    crBtn.Parent = frm
    crBtn.Text = "Info Script"
    crBtn.Size = UDim2.new(1, -10, 0, 30)
    crBtn.Position = UDim2.new(0, 5, 1, -35)
    for prop, value in pairs(uiProperties) do
        crBtn[prop] = value
    end

    local crBtnCorner = Instance.new("UICorner")
    crBtnCorner.CornerRadius = UDim.new(0, 6)
    crBtnCorner.Parent = crBtn

    local crFrm = Instance.new("Frame")
    crFrm.Parent = parent
    crFrm.Size = UDim2.new(0.25, 0, 0.4, 60)
    crFrm.Position = UDim2.new(0.685, 0, 0.3, 0)
    crFrm.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    crFrm.BackgroundTransparency = 0.2
    crFrm.BorderSizePixel = 0
    crFrm.Visible = false

    CreateGradient(crFrm)
    CreateShadow(crFrm)

    local crFrmCorner = Instance.new("UICorner")
    crFrmCorner.CornerRadius = UDim.new(0, 8)
    crFrmCorner.Parent = crFrm

    local crLbl = Instance.new("TextLabel")
    crLbl.Parent = crFrm
    crLbl.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    crLbl.BackgroundTransparency = 0.2
    crLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    crLbl.Text = "Info/Updates/Credits"
    crLbl.Size = UDim2.new(1, 0, 0, 30)
    crLbl.Position = UDim2.new(0, 0, 0, 0)
    crLbl.Font = Enum.Font.GothamBold 
    crLbl.TextSize = 18
    crLbl.TextWrapped = true
    crLbl.TextXAlignment = Enum.TextXAlignment.Center
    crLbl.TextYAlignment = Enum.TextYAlignment.Center

    local crLblCorner = Instance.new("UICorner")
    crLblCorner.CornerRadius = UDim.new(0, 8)
    crLblCorner.Parent = crLbl

    local minimized = true
    tbtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        local targetSize = minimized and UDim2.new(0.25, 0, 0, 60) or UDim2.new(0.25, 0, 0, 200)
        local targetText = minimized and "+" or "-"
        
        TweenService:Create(frm, TweenInfo.new(0.3), {Size = targetSize}):Play()
        TweenService:Create(tbtn, TweenInfo.new(0.3), {Rotation = minimized and 0 or 180}):Play()
        
        cfrm.Visible = not minimized
        tbtn.Text = targetText
    end)

    crBtn.MouseButton1Click:Connect(function()
        crFrm.Visible = not crFrm.Visible
        TweenService:Create(crBtn, TweenInfo.new(0.3), {BackgroundColor3 = crFrm.Visible and Color3.fromRGB(150, 0, 150) or Color3.fromRGB(65, 65, 65)}):Play()
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
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.Position = UDim2.new(0, 5, 0, #parent:GetChildren() * 35)
    for prop, value in pairs(uiProperties) do
        btn[prop] = value
    end

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn

    btn.MouseButton1Click:Connect(callback)
    
    return btn
end

function UL:AddTBtn(parent, text, state, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.Text = text .. " [" .. (state and "ON" or "OFF") .. "]"
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.Position = UDim2.new(0, 5, 0, #parent:GetChildren() * 35)
    for prop, value in pairs(uiProperties) do
        btn[prop] = value
    end

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = text .. " [" .. (state and "ON" or "OFF") .. "]"
        TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundColor3 = state and Color3.fromRGB(85, 170, 85) or Color3.fromRGB(65, 65, 65)}):Play()
        callback(state)
    end)

    return btn
end

function UL:AddTBox(parent, placeholder, callback)
    local box = Instance.new("TextBox")
    box.Parent = parent
    box.PlaceholderText = placeholder
    box.Text = ""
    box.Size = UDim2.new(1, -10, 0, 30)
    box.Position = UDim2.new(0, 5, 0, #parent:GetChildren() * 35)
    box.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    box.TextColor3 = Color3.fromRGB(250, 250, 250)
    box.Font = Enum.Font.SourceSans
    box.TextSize = 18
    box.ClearTextOnFocus = false
    box.TextXAlignment = Enum.TextXAlignment.Left

    local boxCorner = Instance.new("UICorner")
    boxCorner.CornerRadius = UDim.new(0, 6)
    boxCorner.Parent = box
    
    local padding = Instance.new("UIPadding")
    padding.Parent = box
    padding.PaddingLeft = UDim.new(0, 5)
    
    CreateShadow(box)

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
    oFrm.Position = UDim2.new(parent.Position.X.Scale + 1, 0, parent.Position.Y.Scale - 0.34, parent.Position.Y.Offset)
    oFrm.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    oFrm.BackgroundTransparency = 0.2
    oFrm.BorderSizePixel = 0
    oFrm.Visible = false

    CreateGradient(oFrm)
    CreateShadow(oFrm)

    local oFrmCorner = Instance.new("UICorner")
    oFrmCorner.CornerRadius = UDim.new(0, 8)
    oFrmCorner.Parent = oFrm

    local lbl = Instance.new("TextLabel")
    lbl.Parent = oFrm
    lbl.Text = name
    lbl.Size = UDim2.new(1, 0, 0, 30)
    lbl.Position = UDim2.new(0, 0, 0, 0)
    for prop, value in pairs(uiProperties) do
        lbl[prop] = value
    end

    local lblCorner = Instance.new("UICorner")
    lblCorner.CornerRadius = UDim.new(0, 8)
    lblCorner.Parent = lbl

    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.Text = name
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.Position = UDim2.new(0, 5, 0, #parent:GetChildren() * 35)
    for prop, value in pairs(uiProperties) do
        btn[prop] = value
    end

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        oFrm.Visible = not oFrm.Visible
        TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundColor3 = oFrm.Visible and Color3.fromRGB(130, 0, 0) or Color3.fromRGB(65, 65, 65)}):Play()
    end)

    return btn, oFrm
end

function UL:AddText(parent, text, color)
    local label = Instance.new("TextLabel")
    label.Parent = parent
    label.Text = text
    label.Size = UDim2.new(1, -10, 0, 30)
    label.Position = UDim2.new(0, 5, 0, #parent:GetChildren() * 35)
    label.BackgroundColor3 = Color3.fromRGB(250, 250, 250)
    label.BackgroundTransparency = 0.8
    label.TextColor3 = color or Color3.fromRGB(0, 0, 0)
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 14
    label.TextWrapped = true

    local labelCorner = Instance.new("UICorner")
    labelCorner.CornerRadius = UDim.new(0, 6)
    labelCorner.Parent = label

    return label
end

function UL:AddSlider(parent, text, min, max, default, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Name = "SliderFrame"
    sliderFrame.Parent = parent
    sliderFrame.BackgroundTransparency = 1
    sliderFrame.Size = UDim2.new(1, -10, 0, 50)
    sliderFrame.Position = UDim2.new(0, 5, 0, #parent:GetChildren() * 55)

    local sliderLabel = Instance.new("TextLabel")
    sliderLabel.Name = "SliderLabel"
    sliderLabel.Parent = sliderFrame
    sliderLabel.BackgroundTransparency = 1
    sliderLabel.Size = UDim2.new(1, 0, 0, 20)
    sliderLabel.Font = Enum.Font.GothamSemibold
    sliderLabel.Text = text
    sliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    sliderLabel.TextSize = 14
    sliderLabel.TextXAlignment = Enum.TextXAlignment.Left

    local sliderBack = Instance.new("Frame")
    sliderBack.Name = "SliderBack"
    sliderBack.Parent = sliderFrame
    sliderBack.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    sliderBack.BorderSizePixel = 0
    sliderBack.Position = UDim2.new(0, 0, 0, 25)
    sliderBack.Size = UDim2.new(1, 0, 0, 5)

    local sliderFill = Instance.new("Frame")
    sliderFill.Name = "SliderFill"
    sliderFill.Parent = sliderBack
    sliderFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderFill.BorderSizePixel = 0
    sliderFill.Size = UDim2.new(0, 0, 1, 0)

    local sliderButton = Instance.new("TextButton")
    sliderButton.Name = "SliderButton"
    sliderButton.Parent = sliderBack
    sliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderButton.BorderSizePixel = 0
    sliderButton.Size = UDim2.new(0, 10, 0, 20)
    sliderButton.Text = ""
    sliderButton.Position = UDim2.new(0, -5, 0, -7.5)

    local sliderValue = Instance.new("TextLabel")
    sliderValue.Name = "SliderValue"
    sliderValue.Parent = sliderFrame
    sliderValue.BackgroundTransparency = 1
    sliderValue.Position = UDim2.new(1, -40, 0, 0)
    sliderValue.Size = UDim2.new(0, 40, 0, 20)
    sliderValue.Font = Enum.Font.GothamSemibold
    sliderValue.Text = tostring(default)
    sliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
    sliderValue.TextSize = 14
    sliderValue.TextXAlignment = Enum.TextXAlignment.Right

    local function updateSlider(input)
        local sizeX = math.clamp((input.Position.X - sliderBack.AbsolutePosition.X) / sliderBack.AbsoluteSize.X, 0, 1)
        sliderFill.Size = UDim2.new(sizeX, 0, 1, 0)
        sliderButton.Position = UDim2.new(sizeX, -5, 0, -7.5)
        local value = math.floor(min + ((max - min) * sizeX))
        sliderValue.Text = tostring(value)
        callback(value)
    end

    sliderButton.MouseButton1Down:Connect(function()
        local connection
        connection = game:GetService("RunService").RenderStepped:Connect(function()
            local mousePos = game:GetService("UserInputService"):GetMouseLocation()
            local input = {Position = Vector2.new(mousePos.X, mousePos.Y)}
            updateSlider(input)
        end)
        game:GetService("UserInputService").InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                if connection then
                    connection:Disconnect()
                end
            end
        end)
    end)

    -- Set default value
    local defaultSize = (default - min) / (max - min)
    sliderFill.Size = UDim2.new(defaultSize, 0, 1, 0)
    sliderButton.Position = UDim2.new(defaultSize, -5, 0, -7.5)

    return sliderFrame
end

-- Anti-AFK
game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)

print("Loading Finished")
print("by: OneCreatorX")

return UL


local UL = {}
local TweenService = game:GetService("TweenService")

local function applyProperties(instance, properties)
    for prop, value in pairs(properties) do
        instance[prop] = value
    end
end

local function createCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.Parent = parent
    corner.CornerRadius = UDim.new(0, radius or 4)
end

local function createPadding(parent, padding)
    local uiPadding = Instance.new("UIPadding")
    uiPadding.Parent = parent
    uiPadding.PaddingLeft = UDim.new(0, padding.Left or 5)
    uiPadding.PaddingRight = UDim.new(0, padding.Right or 5)
    uiPadding.PaddingTop = UDim.new(0, padding.Top or 5)
    uiPadding.PaddingBottom = UDim.new(0, padding.Bottom or 5)
end

local function createShadow(parent)
    local shadow = Instance.new("ImageLabel")
    shadow.Parent = parent
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.8
    shadow.Size = UDim2.new(1, 10, 1, 10)
    shadow.Position = UDim2.new(0, -5, 0, -5)
    shadow.ZIndex = parent.ZIndex - 1
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)
end

local function tweenProperty(instance, property, value, time, easingStyle, easingDirection)
    local tweenInfo = TweenInfo.new(time, easingStyle or Enum.EasingStyle.Quad, easingDirection or Enum.EasingDirection.Out)
    local tween = TweenService:Create(instance, tweenInfo, {[property] = value})
    tween:Play()
    return tween
end

local defaultProperties = {
    BackgroundColor3 = Color3.fromRGB(40, 40, 40),
    BackgroundTransparency = 0.1,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Font = Enum.Font.GothamSemibold,
    TextSize = 14,
    BorderSizePixel = 0
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
    applyProperties(frm, defaultProperties)
    frm.Active = true
    frm.Draggable = true

    createCorner(frm, 6)
    createShadow(frm)

    local lbl = Instance.new("TextLabel")
    lbl.Parent = frm
    lbl.Text = title
    lbl.Size = UDim2.new(1, 0, 0, 30)
    lbl.Position = UDim2.new(0, 0, 0, 0)
    applyProperties(lbl, defaultProperties)
    lbl.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    lbl.TextSize = 16

    createCorner(lbl, 6)
    createPadding(lbl, {Left = 10, Right = 10})

    local tbtn = Instance.new("TextButton")
    tbtn.Parent = frm
    tbtn.Text = "+"
    tbtn.Size = UDim2.new(0, 30, 0, 30)
    tbtn.Position = UDim2.new(1, -30, 0, 0)
    applyProperties(tbtn, defaultProperties)

    local cfrm = Instance.new("ScrollingFrame")
    cfrm.Parent = frm
    cfrm.Size = UDim2.new(1, 0, 1, -30)
    cfrm.Position = UDim2.new(0, 0, 0, 30)
    cfrm.BackgroundTransparency = 1
    cfrm.ScrollBarThickness = 4
    cfrm.Visible = false

    local uilist = Instance.new("UIListLayout")
    uilist.Parent = cfrm
    uilist.SortOrder = Enum.SortOrder.LayoutOrder
    uilist.Padding = UDim.new(0, 5)

    local crBtn = Instance.new("TextButton")
    crBtn.Parent = frm
    crBtn.Text = "Info Script"
    crBtn.Size = UDim2.new(1, 0, 0, 30)
    crBtn.Position = UDim2.new(0, 0, 1, -30)
    applyProperties(crBtn, defaultProperties)

    local crFrm = Instance.new("Frame")
    crFrm.Parent = parent
    crFrm.Size = UDim2.new(0.25, 0, 0.4, 60)
    crFrm.Position = UDim2.new(0.685, 0, 0.3, 0)
    applyProperties(crFrm, defaultProperties)
    crFrm.Visible = false

    createCorner(crFrm, 6)
    createShadow(crFrm)

    local crLbl = Instance.new("TextLabel")
    crLbl.Parent = crFrm
    crLbl.Text = "Info/Updates/Credits"
    crLbl.Size = UDim2.new(1, 0, 0, 30)
    crLbl.Position = UDim2.new(0, 0, 0, 0)
    applyProperties(crLbl, defaultProperties)
    crLbl.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    crLbl.TextSize = 16

    createCorner(crLbl, 6)
    createPadding(crLbl, {Left = 10, Right = 10})

    local minimized = true
    tbtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        tweenProperty(cfrm, "Size", minimized and UDim2.new(1, 0, 0, 0) or UDim2.new(1, 0, 1, -30), 0.3)
        tweenProperty(frm, "Size", minimized and UDim2.new(0.25, 0, 0, 60) or UDim2.new(0.25, 0, 0, 180), 0.3)
        tweenProperty(tbtn, "Rotation", minimized and 0 or 45, 0.3)
        cfrm.Visible = not minimized
    end)

    crBtn.MouseButton1Click:Connect(function()
        crFrm.Visible = not crFrm.Visible
        tweenProperty(crBtn, "BackgroundColor3", crFrm.Visible and Color3.fromRGB(150, 0, 150) or defaultProperties.BackgroundColor3, 0.3)
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
    applyProperties(btn, defaultProperties)

    createCorner(btn, 4)

    btn.MouseButton1Click:Connect(callback)
    
    btn.MouseEnter:Connect(function()
        tweenProperty(btn, "BackgroundColor3", Color3.fromRGB(60, 60, 60), 0.2)
    end)

    btn.MouseLeave:Connect(function()
        tweenProperty(btn, "BackgroundColor3", defaultProperties.BackgroundColor3, 0.2)
    end)

    return btn
end

function UL:AddTBtn(parent, text, state, callback)
    local btn = UL:AddBtn(parent, text .. " [" .. (state and "ON" or "OFF") .. "]", function()
        state = not state
        btn.Text = text .. " [" .. (state and "ON" or "OFF") .. "]"
        tweenProperty(btn, "BackgroundColor3", state and Color3.fromRGB(0, 170, 0) or defaultProperties.BackgroundColor3, 0.3)
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
    applyProperties(box, defaultProperties)
    box.TextXAlignment = Enum.TextXAlignment.Left

    createCorner(box, 4)
    createPadding(box, {Left = 10})
    createShadow(box)

    box.Focused:Connect(function()
        tweenProperty(box, "BackgroundColor3", Color3.fromRGB(60, 60, 60), 0.2)
    end)

    box.FocusLost:Connect(function(enterPressed)
        tweenProperty(box, "BackgroundColor3", defaultProperties.BackgroundColor3, 0.2)
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
    applyProperties(oFrm, defaultProperties)
    oFrm.Visible = false

    createCorner(oFrm, 6)
    createShadow(oFrm)

    local lbl = Instance.new("TextLabel")
    lbl.Parent = oFrm
    lbl.Text = name
    lbl.Size = UDim2.new(1, 0, 0, 30)
    lbl.Position = UDim2.new(0, 0, 0, 0)
    applyProperties(lbl, defaultProperties)
    lbl.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

    createCorner(lbl, 6)

    local btn = UL:AddBtn(parent, name, function()
        oFrm.Visible = not oFrm.Visible
        tweenProperty(btn, "BackgroundColor3", oFrm.Visible and Color3.fromRGB(130, 0, 0) or defaultProperties.BackgroundColor3, 0.3)
    end)

    return btn, oFrm
end

function UL:AddText(parent, text, color)
    local label = Instance.new("TextLabel")
    label.Parent = parent
    label.Text = text
    label.Size = UDim2.new(1, -10, 0, 30)
    label.Position = UDim2.new(0, 5, 0, #parent:GetChildren() * 35)
    applyProperties(label, defaultProperties)
    label.BackgroundTransparency = 0.8
    label.TextColor3 = color or Color3.fromRGB(255, 255, 255)
    label.TextWrapped = true

    createCorner(label, 4)

    return label
end

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)

return UL

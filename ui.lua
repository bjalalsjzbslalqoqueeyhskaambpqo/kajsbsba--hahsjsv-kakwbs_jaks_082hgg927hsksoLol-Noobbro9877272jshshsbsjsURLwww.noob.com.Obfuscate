local UL = {}
print("Version UI 1.0")
print("Loading OneLib")

local rl = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/info.lua")) spawn(rl)

local TweenService = game:GetService("TweenService")

local uiProperties = {
    BackgroundColor3 = Color3.fromRGB(35, 35, 35),
    BackgroundTransparency = 0.2,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Font = Enum.Font.GothamSemibold,
    TextSize = 14
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
    frm.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    frm.BackgroundTransparency = 0.1
    frm.BorderSizePixel = 0
    frm.Active = true
    frm.Draggable = true

    local corner = Instance.new("UICorner")
    corner.Parent = frm
    corner.CornerRadius = UDim.new(0, 8)

    local stroke = Instance.new("UIStroke")
    stroke.Parent = frm
    stroke.Color = Color3.fromRGB(60, 60, 60)
    stroke.Thickness = 2

    local lbl = Instance.new("TextLabel")
    lbl.Parent = frm
    lbl.Text = title
    lbl.Size = UDim2.new(1, 0, 0, 33)
    lbl.Position = UDim2.new(0, 0, 0, 0)
    lbl.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    lbl.BackgroundTransparency = 0.1
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.Font = Enum.Font.GothamBold 
    lbl.TextSize = 18
    lbl.TextWrapped = true
    lbl.TextXAlignment = Enum.TextXAlignment.Center
    lbl.TextYAlignment = Enum.TextYAlignment.Center

    local labelCorner = Instance.new("UICorner")
    labelCorner.Parent = lbl
    labelCorner.CornerRadius = UDim.new(0, 8)

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
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.Parent = tbtn
    buttonCorner.CornerRadius = UDim.new(0, 15)

    local cfrm = Instance.new("Frame")
    cfrm.Parent = frm
    cfrm.Size = UDim2.new(1, 0, 1, -30)
    cfrm.Position = UDim2.new(0, 0, 0, 30)
    cfrm.BackgroundTransparency = 1
    cfrm.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    cfrm.Visible = false

    local crBtn = Instance.new("TextButton")
    crBtn.Parent = frm
    crBtn.Text = "Info Script"
    crBtn.Size = UDim2.new(1, -10, 0, 30)
    crBtn.Position = UDim2.new(0, 5, 1, -35)
    for prop, value in pairs(uiProperties) do
        crBtn[prop] = value
    end
    
    local crBtnCorner = Instance.new("UICorner")
    crBtnCorner.Parent = crBtn
    crBtnCorner.CornerRadius = UDim.new(0, 6)

    local crFrm = Instance.new("Frame")
    crFrm.Parent = parent
    crFrm.Size = UDim2.new(0.25, 0, 0.4, 60)
    crFrm.Position = UDim2.new(0.685, 0, 0.3, 0)
    crFrm.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    crFrm.BackgroundTransparency = 0.1
    crFrm.BorderSizePixel = 0
    crFrm.Visible = false

    local crFrmCorner = Instance.new("UICorner")
    crFrmCorner.Parent = crFrm
    crFrmCorner.CornerRadius = UDim.new(0, 8)

    local crLbl = Instance.new("TextLabel")
    crLbl.Parent = crFrm
    crLbl.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    crLbl.BackgroundTransparency = 0.1
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
    crLblCorner.Parent = crLbl
    crLblCorner.CornerRadius = UDim.new(0, 8)

    local padding = Instance.new("UIPadding")
    padding.Parent = crLbl
    padding.PaddingLeft = UDim.new(0, 5)
    padding.PaddingRight = UDim.new(0, 5)
    padding.PaddingTop = UDim.new(0, 5)
    padding.PaddingBottom = UDim.new(0, 5)

    local minimized = true
    tbtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        local targetSize = minimized and UDim2.new(0.25, 0, 0, 60) or UDim2.new(0.25, 0, 0, 60 + #cfrm:GetChildren() * 30)
        local targetRotation = minimized and 0 or 45
        
        TweenService:Create(frm, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = targetSize}):Play()
        TweenService:Create(tbtn, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = targetRotation}):Play()
        
        cfrm.Visible = not minimized
    end)

    crBtn.MouseButton1Click:Connect(function()
        crFrm.Visible = not crFrm.Visible
        local targetColor = crFrm.Visible and Color3.fromRGB(100, 0, 100) or Color3.fromRGB(35, 35, 35)
        TweenService:Create(crBtn, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = targetColor}):Play()
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
    btn.Position = UDim2.new(0, 5, 0, #parent:GetChildren() * 35 - 35)
    for prop, value in pairs(uiProperties) do
        btn[prop] = value
    end

    local btnCorner = Instance.new("UICorner")
    btnCorner.Parent = btn
    btnCorner.CornerRadius = UDim.new(0, 6)

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(55, 55, 55)}):Play()
    end)

    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
    end)

    btn.MouseButton1Click:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1), {Size = UDim2.new(1, -14, 0, 26)}):Play()
        wait(0.1)
        TweenService:Create(btn, TweenInfo.new(0.1), {Size = UDim2.new(1, -10, 0, 30)}):Play()
        callback()
    end)
    
    return btn
end

function UL:AddTBtn(parent, text, state, callback)
    local btn = UL:AddBtn(parent, text .. " [" .. (state and "ON" or "OFF") .. "]", function()
        state = not state
        btn.Text = text .. " [" .. (state and "ON" or "OFF") .. "]"
        local targetColor = state and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(35, 35, 35)
        TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundColor3 = targetColor}):Play()
        callback(state)
    end)

    return btn
end

function UL:AddTBox(parent, placeholder, callback)
    local box = Instance.new("TextBox")
    box.Parent = parent
    box.PlaceholderText = placeholder
    box.Text = ""
    box.BorderSizePixel = 0
    box.Size = UDim2.new(1, -10, 0, 30)
    box.Position = UDim2.new(0, 5, 0, #parent:GetChildren() * 35 - 35)

    box.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    box.TextColor3 = Color3.fromRGB(250, 250, 250)
    box.Font = Enum.Font.SourceSans
    box.TextSize = 16
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
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.8
    shadow.Size = UDim2.new(1, 6, 1, 6)
    shadow.Position = UDim2.new(0, -3, 0, -3)
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)

    box.Focused:Connect(function()
        TweenService:Create(box, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(55, 55, 55)}):Play()
    end)

    box.FocusLost:Connect(function(enterPressed)
        TweenService:Create(box, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
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
    oFrm.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    oFrm.BackgroundTransparency = 0.1
    oFrm.BorderSizePixel = 0
    oFrm.Visible = false

    local oFrmCorner = Instance.new("UICorner")
    oFrmCorner.Parent = oFrm
    oFrmCorner.CornerRadius = UDim.new(0, 8)

    local lbl = Instance.new("TextLabel")
    lbl.Parent = oFrm
    lbl.Text = name
    lbl.Size = UDim2.new(1, 0, 0, 30)
    lbl.Position = UDim2.new(0, 0, 0, 0)
    for prop, value in pairs(uiProperties) do
        lbl[prop] = value
    end

    local lblCorner = Instance.new("UICorner")
    lblCorner.Parent = lbl
    lblCorner.CornerRadius = UDim.new(0, 8)

    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.Text = name
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.Position = UDim2.new(0, 5, 0, #parent:GetChildren() * 35 - 35)
    for prop, value in pairs(uiProperties) do
        btn[prop] = value
    end

    local btnCorner = Instance.new("UICorner")
    btnCorner.Parent = btn
    btnCorner.CornerRadius = UDim.new(0, 6)

    btn.MouseButton1Click:Connect(function()
        oFrm.Visible = not oFrm.Visible
        local targetColor = oFrm.Visible and Color3.fromRGB(130, 0, 0) or Color3.fromRGB(35, 35, 35)
        TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundColor3 = targetColor}):Play()
    end)

    btn.MouseEnter:Connect(function()
        if not oFrm.Visible then
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(55, 55, 55)}):Play()
        end
    end)

    btn.MouseLeave:Connect(function()
        if not oFrm.Visible then
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
        end
    end)

    return btn, oFrm
end

function UL:AddText(parent, text, color)
    local label = Instance.new("TextLabel")
    label.Parent = parent
    label.Text = text
    label.Size = UDim2.new(1, -10, 0, 30)
    label.Position = UDim2.new(0, 5, 0, #parent:GetChildren() * 35 - 35)
    label.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    label.BackgroundTransparency = 0.5
    label.TextColor3 = color or Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 14
    label.TextWrapped = true

    local labelCorner = Instance.new("UICorner")
    labelCorner.Parent = label
    labelCorner.CornerRadius = UDim.new(0, 6)

    return label
end

-- Función para crear una animación de desvanecimiento
local function fadeEffect(object, goal)
    local tween = TweenService:Create(object, TweenInfo.new(0.5), {BackgroundTransparency = goal})
    tween:Play()
end

-- Función para crear un efecto de onda al hacer clic
local function rippleEffect(button)
    local ripple = Instance.new("Frame")
    ripple.Name = "ripple"
    ripple.Parent = button
    ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ripple.BorderSizePixel = 0
    ripple.ZIndex = button.ZIndex + 1
    ripple.AnchorPoint = Vector2.new(0.5, 0.5)
    ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
    ripple.Size = UDim2.new(0, 0, 0, 0)

    local rippleCorner = Instance.new("UICorner")
    rippleCorner.CornerRadius = UDim.new(1, 0)
    rippleCorner.Parent = ripple

    local tween = TweenService:Create(ripple, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
        {Size = UDim2.new(1.5, 0, 1.5, 0), BackgroundTransparency = 1})
    tween:Play()

    tween.Completed:Connect(function()
        ripple:Destroy()
    end)
end

-- Aplicar el efecto de onda a todos los botones
for _, v in pairs(UL) do
    if type(v) == "function" and (v == UL.AddBtn or v == UL.AddTBtn or v == UL.AddOBtn) then
        local originalFunction = v
        UL[tostring(v)] = function(...)
            local button = originalFunction(...)
            button.MouseButton1Down:Connect(function()
                rippleEffect(button)
            end)
            return button
        end
    end
end

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)

print("Loading Finish")
print("by: OneCreatorX")

return UL

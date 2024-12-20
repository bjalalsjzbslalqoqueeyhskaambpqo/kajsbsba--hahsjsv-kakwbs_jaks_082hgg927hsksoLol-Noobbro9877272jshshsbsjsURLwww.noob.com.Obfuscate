local o = {
    ["rbxassetid://15549648454"] = "Amelette Rice",
    ["rbxassetid://15606198559"] = "Omelette Rice with Carrot",
    ["rbxassetid://15549647100"] = "Burger",
    ["rbxassetid://15606198998"] = "Burger with Carrot",
    ["rbxassetid://15605962293"] = "Pancake",
    ["rbxassetid://15605962205"] = "Pancake with Cream",
    ["rbxassetid://15605962356"] = "Pancake Cream and Carrot",
    ["rbxassetid://15549645914"] = "Ice Cream",
    ["rbxassetid://15549645248"] = "Strawberry Ice Cream",
    ["rbxassetid://15606198450"] = "Carrot Ice Cream",
    ["rbxassetid://15605962666"] = "Cookie",
    ["rbxassetid://15605962441"] = "Carrot Cookie",
    ["rbxassetid://15606206578"] = "Carrots",
    ["rbxassetid://15636221212"] = "Crushed Coffee",
    ["rbxassetid://15636226170"] = "Crushed Coffee with Milk",
    ["rbxassetid://15636226036"] = "Strawberry Milk",
    ["rbxassetid://15636221084"] = "Blended Carrot",
    ["rbxassetid://15605962794"] = "Carrot Ice Cream and Chocolate",
    ["rbxassetid://103466728943393"] = "Special Pancake",
    ["rbxassetid://115146017944091"] = "Special Burger"
}

local RS = game:GetService("ReplicatedStorage")
local RE = RS:WaitForChild("RemoteEvent")
local P = game:GetService("Players")
local player = P.LocalPlayer
local PG = player:WaitForChild("PlayerGui")

local DELAYS = {
    SHORT = 0.3,
    MEDIUM = 2.5,
    LONG = 5.2,
    EXTRA_LONG = 6.2
}

local ingre = {
    Huevo = "Egg",
    Arroz = "Rice",
    Carne = "Meat",
    Bollos = "Buns",
    Zanahoria = "Carrot",
    Harina = "PancakeMix",
    Durazno = "Peach",
    Crema = "WhippedCream",
    Helado = "IceCreamBowl",
    Fresa = "Strawberry",
    Chocolate = "Chocolate",
    Cafe = "CoffeeBean",
    Leche = "Milk"
}

local cocina = {
    Sarten = "BG_Kitchenware_01",
    Horno = "BG_Kitchenware_05",
    Congelador = "BG_Kitchenware_04",
    Micro = "BG_Kitchenware_00",
    Tritura = "BG_Kitchenware_03",
    Licua = "BG_Kitchenware_02"
}

local function l()
    for _, d in ipairs(workspace.RootNode.Scriptable:WaitForChild("Table"):GetDescendants()) do
        if d:IsA("Attachment") then
            RE:WaitForChild("PutDishEvent"):FireServer(d)
            local args = {[1] = workspace.RootNode.Scriptable:WaitForChild("Action"):WaitForChild("ServingPort")}
            RE:WaitForChild("DishPortEvent"):FireServer(unpack(args))
        end
    end
end

local function t(i) 
    local a={[1]=workspace.RootNode.Scriptable:WaitForChild("Action"):WaitForChild("Food"):WaitForChild(i)} 
    RE:WaitForChild("GetItemEvent"):FireServer(unpack(a)) 
    wait(DELAYS.SHORT)
end

local function put(k) 
    local a={[1]=workspace.RootNode.Scriptable:WaitForChild("Action"):WaitForChild("Kitchenware"):WaitForChild(k)} 
    RE:WaitForChild("SetMaterialEvent"):FireServer(unpack(a))
    wait(DELAYS.SHORT)
end

local function take(k) 
    local a={[1]=workspace.RootNode.Scriptable:WaitForChild("Action"):WaitForChild("Kitchenware"):WaitForChild(k)} 
    RS:WaitForChild("RemoteEvent"):WaitForChild("TakeItemEvent"):FireServer(unpack(a))
    wait(DELAYS.SHORT)
end

local function clear()
    local args = {[1] = workspace.RootNode.Scriptable:WaitForChild("Action"):WaitForChild("GarbageCan"):WaitForChild("GarbageCan")}
    RS:WaitForChild("RemoteEvent"):WaitForChild("RemoveItemEvent"):FireServer(unpack(args))
    wait(DELAYS.SHORT)
end

local function setupKitchenware(equipment)
    put(equipment)
    clear()
    put(equipment)
    clear()
end

local function prepareOrder(o)
    if o == "Special Pancake" then
        setupKitchenware(cocina.Sarten)
        t(ingre.Harina)
        put(cocina.Sarten)
        t(ingre.Huevo)
        put(cocina.Sarten)
        wait(DELAYS.LONG)
        take(cocina.Sarten)
        l()
    elseif o == "Special Burger" then
        setupKitchenware(cocina.Sarten)
        t(ingre.Carne)
        put(cocina.Sarten)
        t(ingre.Bollos)
        put(cocina.Sarten)
        wait(DELAYS.LONG)
        take(cocina.Sarten)
        setupKitchenware(cocina.Horno)
        t(ingre.Zanahoria)
        put(cocina.Horno)
        wait(DELAYS.MEDIUM)
        take(cocina.Horno)
        l()
    elseif o == "Amelette Rice" then
        setupKitchenware(cocina.Sarten)
        t(ingre.Arroz)
        put(cocina.Sarten)
        t(ingre.Huevo)
        put(cocina.Sarten)
        wait(DELAYS.LONG)
        take(cocina.Sarten)
        l()
    elseif o == "Omelette Rice with Carrot" then
        setupKitchenware(cocina.Horno)
        prepareOrder("Amelette Rice")
        put(cocina.Horno)
        t(ingre.Zanahoria)
        put(cocina.Horno)
        wait(DELAYS.MEDIUM)
        take(cocina.Horno)
        l()
    elseif o == "Burger" then
        setupKitchenware(cocina.Sarten)
        t(ingre.Carne)
        put(cocina.Sarten)
        t(ingre.Bollos)
        put(cocina.Sarten)
        wait(DELAYS.LONG)
        take(cocina.Sarten)
        l()
    elseif o == "Burger with Carrot" then
        setupKitchenware(cocina.Sarten)
        prepareOrder("Burger")
        put(cocina.Horno)
        t(ingre.Zanahoria)
        put(cocina.Horno)
        wait(DELAYS.MEDIUM)
        take(cocina.Horno)
        l()
    elseif o == "Pancake" then
        setupKitchenware(cocina.Sarten)
        t(ingre.Harina)
        put(cocina.Sarten)
        t(ingre.Huevo)
        put(cocina.Sarten)
        wait(DELAYS.LONG)
        take(cocina.Sarten)
        l()
    elseif o == "Pancake with Cream" then
        setupKitchenware(cocina.Horno)
        prepareOrder("Pancake")
        put(cocina.Horno)
        t(ingre.Durazno)
        put(cocina.Horno)
        t(ingre.Crema)
        put(cocina.Horno)
        wait(DELAYS.MEDIUM)
        take(cocina.Horno)
        l()
    elseif o == "Pancake Cream and Carrot" then
        setupKitchenware(cocina.Horno)
        prepareOrder("Pancake")
        put(cocina.Horno)
        t(ingre.Zanahoria)
        put(cocina.Horno)
        t(ingre.Crema)
        put(cocina.Horno)
        wait(DELAYS.MEDIUM)
        take(cocina.Horno)
        l()
    elseif o == "Ice Cream" then
        setupKitchenware(cocina.Congelador)
        t(ingre.Helado)
        put(cocina.Congelador)
        wait(DELAYS.EXTRA_LONG)
        take(cocina.Congelador)
        l()
    elseif o == "Strawberry Ice Cream" then
        setupKitchenware(cocina.Horno)
        prepareOrder("Ice Cream")
        put(cocina.Horno)
        t(ingre.Fresa)
        put(cocina.Horno)
        wait(DELAYS.MEDIUM)
        take(cocina.Horno)
        l()
    elseif o == "Carrot Ice Cream" then
        setupKitchenware(cocina.Horno)
        prepareOrder("Ice Cream")
        put(cocina.Horno)
        t(ingre.Zanahoria)
        put(cocina.Horno)
        wait(DELAYS.MEDIUM)
        take(cocina.Horno)
        l()
    elseif o == "Cookie" then
        setupKitchenware(cocina.Micro)
        t(ingre.Harina)
        put(cocina.Micro)
        t(ingre.Chocolate)
        put(cocina.Micro)
        wait(DELAYS.LONG)
        take(cocina.Micro)
        l()
    elseif o == "Carrot Cookie" then
        setupKitchenware(cocina.Micro)
        t(ingre.Harina)
        put(cocina.Micro)
        t(ingre.Zanahoria)
        put(cocina.Micro)
        wait(DELAYS.LONG)
        take(cocina.Micro)
        l()
    elseif o == "Carrots" then
        setupKitchenware(cocina.Micro)
        t(ingre.Zanahoria)
        put(cocina.Micro)
        t(ingre.Zanahoria)
        put(cocina.Micro)
        wait(DELAYS.LONG)
        take(cocina.Micro)
        l()
    elseif o == "Crushed Coffee" then
        setupKitchenware(cocina.Tritura)
        t(ingre.Cafe)
        put(cocina.Tritura)
        wait(DELAYS.LONG)
        take(cocina.Tritura)
        l()
    elseif o == "Crushed Coffee with Milk" then
        setupKitchenware(cocina.Horno)
        prepareOrder("Crushed Coffee")
        put(cocina.Horno)
        t(ingre.Leche)
        put(cocina.Horno)
        wait(DELAYS.MEDIUM)
        take(cocina.Horno)
        l()
    elseif o == "Strawberry Milk" then
        setupKitchenware(cocina.Licua)
        t(ingre.Fresa)
        put(cocina.Licua)
        t(ingre.Leche)
        put(cocina.Licua)
        wait(DELAYS.LONG)
        take(cocina.Licua)
        l()
    elseif o == "Blended Carrot" then
        setupKitchenware(cocina.Licua)
        t(ingre.Zanahoria)
        put(cocina.Licua)
        t(ingre.Zanahoria)
        put(cocina.Licua)
        wait(DELAYS.LONG)
        take(cocina.Licua)
        l()
    elseif o == "Carrot Ice Cream and Chocolate" then
        setupKitchenware(cocina.Horno)
        prepareOrder("Ice Cream")
        put(cocina.Horno)
        prepareOrder("Carrots")
        wait(DELAYS.MEDIUM)
        put(cocina.Horno)
        t(ingre.Chocolate)
        put(cocina.Horno)
        wait(DELAYS.MEDIUM)
        take(cocina.Horno)
        l()
    end
end

local function findOrder()
    local monitor = game.Players.LocalPlayer.PlayerGui.OrderGui.Frame
    for _, d in ipairs(monitor:GetDescendants()) do
        if d:IsA("ImageLabel") and d.Name == "ImageLabel" then
            local oImage = d.Image
            local rName = o[oImage]
            if rName then
                prepareOrder(rName)
                return
            end
        end
    end
end

local function createStyledButton(text, position, color)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.9, 0, 0.15, 0)
    button.Position = position
    button.Text = text
    button.Font = Enum.Font.GothamBold
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 14
    button.BackgroundColor3 = color
    button.AutoButtonColor = true
    
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 8)
    uiCorner.Parent = button
    
    local uiStroke = Instance.new("UIStroke")
    uiStroke.Color = Color3.fromRGB(255, 255, 255)
    uiStroke.Transparency = 0.8
    uiStroke.Thickness = 1
    uiStroke.Parent = button
    
    local uiGradient = Instance.new("UIGradient")
    uiGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 200, 200))
    })
    uiGradient.Rotation = 45
    uiGradient.Parent = button
    
    return button
end

local sg = Instance.new("ScreenGui")
sg.Name = "CookingAutomation"
sg.ResetOnSpawn = false
sg.Parent = player.PlayerGui

local fr = Instance.new("Frame")
fr.Size = UDim2.new(0, 220, 0, 280)
fr.Position = UDim2.new(0.8, -110, 0.5, -140)
fr.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
fr.BorderSizePixel = 0
fr.Parent = sg

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 12)
uiCorner.Parent = fr

local uiStroke = Instance.new("UIStroke")
uiStroke.Color = Color3.fromRGB(255, 255, 255)
uiStroke.Transparency = 0.9
uiStroke.Thickness = 1
uiStroke.Parent = fr

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0.15, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
titleBar.BorderSizePixel = 0
titleBar.Parent = fr

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

local titleBottom = Instance.new("Frame")
titleBottom.Size = UDim2.new(1, 0, 0.5, 0)
titleBottom.Position = UDim2.new(0, 0, 0.5, 0)
titleBottom.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
titleBottom.BorderSizePixel = 0
titleBottom.Parent = titleBar

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 1, 0)
title.BackgroundTransparency = 1
title.Text = "Auto Cook Pro"
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 16
title.Parent = titleBar

local dragBar = Instance.new("TextButton")
dragBar.Size = UDim2.new(1, 0, 1, 0)
dragBar.BackgroundTransparency = 1
dragBar.Text = ""
dragBar.Parent = titleBar

local buttonContainer = Instance.new("Frame")
buttonContainer.Size = UDim2.new(1, 0, 0.85, 0)
buttonContainer.Position = UDim2.new(0, 0, 0.15, 0)
buttonContainer.BackgroundTransparency = 1
buttonContainer.Parent = fr

local la = false
local cookButton = createStyledButton(
    "🍳 Cook Orders", 
    UDim2.new(0.05, 0, 0.05, 0),
    Color3.fromRGB(76, 175, 80)
)
cookButton.Parent = buttonContainer
cookButton.MouseButton1Click:Connect(function()
    la = not la
    cookButton.BackgroundColor3 = la and Color3.fromRGB(46, 125, 50) or Color3.fromRGB(76, 175, 80)
end)

local deliveryButton = createStyledButton(
    "🚚 Quick Delivery",
    UDim2.new(0.05, 0, 0.25, 0),
    Color3.fromRGB(33, 150, 243)
)
deliveryButton.Parent = buttonContainer
deliveryButton.MouseButton1Click:Connect(function()
    for _, d in ipairs(workspace.RootNode.Scriptable:WaitForChild("Table"):GetDescendants()) do
        if d:IsA("Attachment") then
            RS:WaitForChild("RemoteEvent"):WaitForChild("PutDishEvent"):FireServer(d)
            local args = {[1] = workspace.RootNode.Scriptable:WaitForChild("Action"):WaitForChild("ServingPort")}
            RS:WaitForChild("RemoteEvent"):WaitForChild("DishPortEvent"):FireServer(unpack(args))
            local args = {[1] = workspace.RootNode.Scriptable:WaitForChild("Action"):WaitForChild("GarbageCan"):WaitForChild("GarbageCan")}
            RS:WaitForChild("RemoteEvent"):WaitForChild("RemoveItemEvent"):FireServer(unpack(args))
        end
    end
end)

local le = false
local acceptButton = createStyledButton(
    "💰 Auto Accept",
    UDim2.new(0.05, 0, 0.45, 0),
    Color3.fromRGB(156, 39, 176)
)
acceptButton.Parent = buttonContainer
acceptButton.MouseButton1Click:Connect(function()
    le = not le
    acceptButton.BackgroundColor3 = le and Color3.fromRGB(106, 27, 154) or Color3.fromRGB(156, 39, 176)
end)

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0.9, 0, 0.15, 0)
statusLabel.Position = UDim2.new(0.05, 0, 0.65, 0)
statusLabel.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
statusLabel.Text = "Status: Ready"
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
statusLabel.TextSize = 14
statusLabel.Parent = buttonContainer

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 8)
statusCorner.Parent = statusLabel

local isDragging = false
local dragStart = nil
local startPos = nil

dragBar.MouseButton1Down:Connect(function(x, y)
    isDragging = true
    dragStart = Vector2.new(x, y)
    startPos = fr.Position
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and isDragging then
        local delta = Vector2.new(input.Position.X, input.Position.Y) - dragStart
        fr.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = false
    end
end)

spawn(function()
    while wait(0.1) do
        if le then
            local args = {[1] = workspace.RootNode.Scriptable:WaitForChild("Action"):WaitForChild("Cash"):WaitForChild("Cash")}
            RS:WaitForChild("RemoteEvent"):WaitForChild("CashEvent"):FireServer(unpack(args))
        end
    end
end)

spawn(function()
    while wait(0.1) do
        if la then
            statusLabel.Text = "Status: Cooking..."
            findOrder()
        else
            statusLabel.Text = "Status: Ready"
        end
    end
end)

P.LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)


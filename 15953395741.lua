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
    ["rbxassetid://115146017944091"] = "Special Pancake",
    ["rbxassetid://103466728943393"] = "Special Burger"
}

local RS = game:GetService("ReplicatedStorage")
local RE = RS:WaitForChild("RemoteEvent")
local P = game:GetService("Players")
local player = P.LocalPlayer
local PG = player:WaitForChild("PlayerGui")

local DELAYS = {SHORT = 0.3, MEDIUM = 2.5, LONG = 5.2, EXTRA = 6.2}

local ingre = {Huevo = "Egg",Arroz = "Rice",Carne = "Meat",Bollos = "Buns",Zanahoria = "Carrot",Harina = "PancakeMix",Durazno = "Peach",Crema = "WhippedCream",Helado = "IceCreamBowl",Fresa = "Strawberry",Chocolate = "Chocolate",Cafe = "CoffeeBean",Leche = "Milk"}
local cocina = {Sarten = "BG_Kitchenware_01",Horno = "BG_Kitchenware_05",Congelador = "BG_Kitchenware_04",Micro = "BG_Kitchenware_00",Tritura = "BG_Kitchenware_03",Licua = "BG_Kitchenware_02"}

local function l()
    for _, d in ipairs(workspace.RootNode.Scriptable:WaitForChild("Table"):GetDescendants()) do
        if d:IsA("Attachment") then
            RE:WaitForChild("PutDishEvent"):FireServer(d)
            RE:WaitForChild("DishPortEvent"):FireServer({[1] = workspace.RootNode.Scriptable:WaitForChild("Action"):WaitForChild("ServingPort")})
        end
    end
end

local function t(i) 
    RE:WaitForChild("GetItemEvent"):FireServer({[1]=workspace.RootNode.Scriptable:WaitForChild("Action"):WaitForChild("Food"):WaitForChild(i)})
    wait(DELAYS.SHORT)
end

local function put(k) 
    RE:WaitForChild("SetMaterialEvent"):FireServer({[1]=workspace.RootNode.Scriptable:WaitForChild("Action"):WaitForChild("Kitchenware"):WaitForChild(k)})
    wait(DELAYS.SHORT)
end

local function take(k) 
    RS:WaitForChild("RemoteEvent"):WaitForChild("TakeItemEvent"):FireServer({[1]=workspace.RootNode.Scriptable:WaitForChild("Action"):WaitForChild("Kitchenware"):WaitForChild(k)})
    wait(DELAYS.SHORT)
end

local function clear()
    RS:WaitForChild("RemoteEvent"):WaitForChild("RemoveItemEvent"):FireServer({[1] = workspace.RootNode.Scriptable:WaitForChild("Action"):WaitForChild("GarbageCan"):WaitForChild("GarbageCan")})
    wait(DELAYS.SHORT)
end

local function prepareOrder(o)
    if o == "Amelette Rice" then
        t(ingre.Arroz) t(ingre.Huevo) put(cocina.Sarten) clear() put(cocina.Sarten) put(cocina.Sarten) wait(DELAYS.LONG) take(cocina.Sarten) l()
    elseif o == "Omelette Rice with Carrot" then
        prepareOrder("Amelette Rice") t(ingre.Zanahoria) put(cocina.Horno) put(cocina.Horno) wait(DELAYS.MEDIUM) take(cocina.Horno) l()
    elseif o == "Burger" then
        t(ingre.Carne) t(ingre.Bollos) put(cocina.Sarten) clear() put(cocina.Sarten) put(cocina.Sarten) wait(DELAYS.LONG) take(cocina.Sarten) l()
    elseif o == "Burger with Carrot" then
        prepareOrder("Burger") t(ingre.Zanahoria) put(cocina.Horno) put(cocina.Horno) wait(DELAYS.MEDIUM) take(cocina.Horno) l()
    elseif o == "Pancake" then
        t(ingre.Harina) t(ingre.Huevo) put(cocina.Sarten) clear() put(cocina.Sarten) put(cocina.Sarten) wait(DELAYS.LONG) take(cocina.Sarten) l()
    elseif o == "Pancake with Cream" then
        prepareOrder("Pancake") t(ingre.Durazno) t(ingre.Crema) put(cocina.Horno) put(cocina.Horno) put(cocina.Horno) wait(DELAYS.MEDIUM) take(cocina.Horno) l()
    elseif o == "Pancake Cream and Carrot" then
        prepareOrder("Pancake") t(ingre.Zanahoria) t(ingre.Crema) put(cocina.Horno) put(cocina.Horno) put(cocina.Horno) wait(DELAYS.MEDIUM) take(cocina.Horno) l()
    elseif o == "Ice Cream" then
        t(ingre.Helado) put(cocina.Congelador) clear() put(cocina.Congelador) wait(DELAYS.EXTRA) take(cocina.Congelador) l()
    elseif o == "Strawberry Ice Cream" then
        prepareOrder("Ice Cream") t(ingre.Fresa) put(cocina.Horno) put(cocina.Horno) wait(DELAYS.MEDIUM) take(cocina.Horno) l()
    elseif o == "Carrot Ice Cream" then
        prepareOrder("Ice Cream") t(ingre.Zanahoria) put(cocina.Horno) put(cocina.Horno) wait(DELAYS.MEDIUM) take(cocina.Horno) l()
    elseif o == "Cookie" then
        t(ingre.Harina) t(ingre.Chocolate) put(cocina.Micro) clear() put(cocina.Micro) put(cocina.Micro) wait(DELAYS.LONG) take(cocina.Micro) l()
    elseif o == "Carrot Cookie" then
        t(ingre.Harina) t(ingre.Zanahoria) put(cocina.Micro) clear() put(cocina.Micro) put(cocina.Micro) wait(DELAYS.LONG) take(cocina.Micro) l()
    elseif o == "Carrots" then
        t(ingre.Zanahoria) t(ingre.Zanahoria) put(cocina.Micro) clear() put(cocina.Micro) put(cocina.Micro) wait(DELAYS.LONG) take(cocina.Micro) l()
    elseif o == "Crushed Coffee" then
        t(ingre.Cafe) put(cocina.Tritura) clear() put(cocina.Tritura) wait(DELAYS.LONG) take(cocina.Tritura) l()
    elseif o == "Crushed Coffee with Milk" then
        prepareOrder("Crushed Coffee") t(ingre.Leche) put(cocina.Horno) put(cocina.Horno) wait(DELAYS.MEDIUM) take(cocina.Horno) l()
    elseif o == "Strawberry Milk" then
        t(ingre.Fresa) t(ingre.Leche) put(cocina.Licua) clear() put(cocina.Licua) put(cocina.Licua) wait(DELAYS.LONG) take(cocina.Licua) l()
    elseif o == "Blended Carrot" then
        t(ingre.Zanahoria) t(ingre.Zanahoria) put(cocina.Licua) clear() put(cocina.Licua) put(cocina.Licua) wait(DELAYS.LONG) take(cocina.Licua) l()
    elseif o == "Carrot Ice Cream and Chocolate" then
        prepareOrder("Ice Cream") prepareOrder("Carrots") t(ingre.Chocolate) put(cocina.Horno) put(cocina.Horno) put(cocina.Horno) wait(DELAYS.MEDIUM) take(cocina.Horno) l()
    elseif o == "Special Pancake" then
        t(ingre.Harina) t(ingre.Huevo) put(cocina.Sarten) clear() put(cocina.Sarten) put(cocina.Sarten) wait(DELAYS.LONG) take(cocina.Sarten) l()
    elseif o == "Special Burger" then
        t(ingre.Carne) t(ingre.Bollos) put(cocina.Sarten) clear() put(cocina.Sarten) put(cocina.Sarten) wait(DELAYS.LONG) take(cocina.Sarten) t(ingre.Zanahoria) put(cocina.Horno) put(cocina.Horno) wait(DELAYS.MEDIUM) take(cocina.Horno) l()
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

local sg = Instance.new("ScreenGui")
sg.Parent = P.LocalPlayer.PlayerGui
sg.ResetOnSpawn = false

sg:GetPropertyChangedSignal("Enabled"):Connect(function()
    if not sg.Enabled then sg.Enabled = true end
end)

local function createStyledButton(text, position)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.9, 0, 0.15, 0)
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(65, 65, 76)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Text = text
    button.TextSize = 14
    button.Font = Enum.Font.GothamSemibold
    button.AutoButtonColor = true
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(86, 86, 98)
    stroke.Thickness = 1
    stroke.Parent = button
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(65, 65, 76)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(45, 45, 54))
    })
    gradient.Parent = button
    
    return button
end

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 220, 0, 280)
mainFrame.Position = UDim2.new(0.5, -110, 0.5, -140)
mainFrame.BackgroundColor3 = Color3.fromRGB(32, 32, 38)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = sg
mainFrame.Draggable = true
mainFrame.Active = true

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(86, 86, 98)
stroke.Thickness = 1
stroke.Parent = mainFrame

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 47)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 1, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "OneCreatorX"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 18
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = titleBar

local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 47)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(32, 32, 38))
})
gradient.Parent = titleBar

local container = Instance.new("Frame")
container.Size = UDim2.new(1, -20, 1, -60)
container.Position = UDim2.new(0, 10, 0, 50)
container.BackgroundTransparency = 1
container.Parent = mainFrame

local cookButton = createStyledButton("Cook Order", UDim2.new(0.05, 0, 0.05, 0))
cookButton.Parent = container

local deliveryButton = createStyledButton("Delivery", UDim2.new(0.05, 0, 0.25, 0))
deliveryButton.Parent = container

local acceptButton = createStyledButton("Accept Orders", UDim2.new(0.05, 0, 0.45, 0))
acceptButton.Parent = container

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0.9, 0, 0.15, 0)
statusLabel.Position = UDim2.new(0.05, 0, 0.7, 0)
statusLabel.BackgroundColor3 = Color3.fromRGB(45, 45, 54)
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
statusLabel.Text = "Status: Ready"
statusLabel.TextSize = 14
statusLabel.Font = Enum.Font.GothamSemibold
statusLabel.Parent = container

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 8)
statusCorner.Parent = statusLabel

local la = false
local le = false

cookButton.MouseButton1Click:Connect(function()
    la = not la
    cookButton.BackgroundColor3 = la and Color3.fromRGB(65, 155, 65) or Color3.fromRGB(65, 65, 76)
    statusLabel.Text = la and "Status: Cooking" or "Status: Ready"
end)

deliveryButton.MouseButton1Click:Connect(function()
    for _, d in ipairs(workspace.RootNode.Scriptable:WaitForChild("Table"):GetDescendants()) do
        if d:IsA("Attachment") then
            RE:WaitForChild("PutDishEvent"):FireServer(d)
            RE:WaitForChild("DishPortEvent"):FireServer({[1] = workspace.RootNode.Scriptable:WaitForChild("Action"):WaitForChild("ServingPort")})
            RS:WaitForChild("RemoteEvent"):WaitForChild("RemoveItemEvent"):FireServer({[1] = workspace.RootNode.Scriptable:WaitForChild("Action"):WaitForChild("GarbageCan"):WaitForChild("GarbageCan")})
        end
    end
end)

acceptButton.MouseButton1Click:Connect(function()
    le = not le
    acceptButton.BackgroundColor3 = le and Color3.fromRGB(65, 155, 65) or Color3.fromRGB(65, 65, 76)
end)

spawn(function()
    while true do
        if la then
            findOrder()
            wait(1)
        else
            wait(0.1)
        end
    end
end)

spawn(function()
    while true do
        if le then
            RS:WaitForChild("RemoteEvent"):WaitForChild("CashEvent"):FireServer({[1] = workspace.RootNode.Scriptable:WaitForChild("Action"):WaitForChild("Cash"):WaitForChild("Cash")})
        end
        wait(0.1)
    end
end)

P.LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)


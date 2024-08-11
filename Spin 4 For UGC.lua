pcall(function()
    local NetworkClient = game:GetService("NetworkClient")
    local Players = game:GetService("Players")
    local TeleportService = game:GetService("TeleportService")

    local PlaceId = game.GameId
    local localPlayer = Players.LocalPlayer

    NetworkClient.ChildRemoved:Connect(function(child)
                for i = 1, 10 do
        local PlaceId = game.PlaceId
        local JobId = game.JobId
        local TeleportService = game:GetService("TeleportService")

        if #game.Players:GetPlayers() <= 1 then
            game.Players.LocalPlayer:Kick("\nRejoining...")
            wait()

                    TeleportService:Teleport(PlaceId, game.Players.LocalPlayer)
        else
            TeleportService:TeleportToPlaceInstance(PlaceId, JobId, game.Players.LocalPlayer)
                    end
                    
        end
                wait(3)
    end)
end)



local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local RS = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local MAIN_COLOR = Color3.fromRGB(52, 152, 219)
local SEC_COLOR = Color3.fromRGB(41, 128, 185)
local TEXT_COLOR = Color3.fromRGB(236, 240, 241)
local BG_COLOR = Color3.fromRGB(44, 62, 80)

local maxPrice = 0
local useClickMethod = true

local function createGui()
    local sg = Instance.new("ScreenGui")
    sg.Name = "AutoBuyerGui"
    sg.ResetOnSpawn = false
    sg.Parent = playerGui

    local mf = Instance.new("Frame")
    mf.Name = "MainFrame"
    mf.Size = UDim2.new(0, 300, 0, 430)
    mf.Position = UDim2.new(0.5, -150, 0.5, -215)
    mf.BackgroundColor3 = BG_COLOR
    mf.BorderSizePixel = 0
    mf.ClipsDescendants = true
    mf.Parent = sg

    local cr = Instance.new("UICorner")
    cr.CornerRadius = UDim.new(0, 10)
    cr.Parent = mf

    local tb = Instance.new("Frame")
    tb.Name = "TitleBar"
    tb.Size = UDim2.new(1, 0, 0, 30)
    tb.BackgroundColor3 = MAIN_COLOR
    tb.BorderSizePixel = 0
    tb.Parent = mf

    local tc = Instance.new("UICorner")
    tc.CornerRadius = UDim.new(0, 10)
    tc.Parent = tb

    local tt = Instance.new("TextLabel")
    tt.Name = "TitleText"
    tt.Size = UDim2.new(1, -60, 1, 0)
    tt.Position = UDim2.new(0, 10, 0, 0)
    tt.BackgroundTransparency = 1
    tt.Text = "Auto Buyer"
    tt.TextColor3 = TEXT_COLOR
    tt.TextSize = 18
    tt.Font = Enum.Font.SourceSansBold
    tt.TextXAlignment = Enum.TextXAlignment.Left
    tt.Parent = tb

    local mb = Instance.new("TextButton")
    mb.Name = "MinimizeButton"
    mb.Size = UDim2.new(0, 30, 0, 30)
    mb.Position = UDim2.new(1, -60, 0, 0)
    mb.BackgroundTransparency = 1
    mb.Text = "-"
    mb.TextColor3 = TEXT_COLOR
    mb.TextSize = 24
    mb.Font = Enum.Font.SourceSansBold
    mb.Parent = tb

    local cb = Instance.new("TextButton")
    cb.Name = "CloseButton"
    cb.Size = UDim2.new(0, 30, 0, 30)
    cb.Position = UDim2.new(1, -30, 0, 0)
    cb.BackgroundTransparency = 1
    cb.Text = "X"
    cb.TextColor3 = TEXT_COLOR
    cb.TextSize = 18
    cb.Font = Enum.Font.SourceSansBold
    cb.Parent = tb

    local content = Instance.new("Frame")
    content.Name = "Content"
    content.Size = UDim2.new(1, -20, 1, -40)
    content.Position = UDim2.new(0, 10, 0, 35)
    content.BackgroundTransparency = 1
    content.Parent = mf

    local mpi = Instance.new("TextBox")
    mpi.Name = "MaxPriceInput"
    mpi.Size = UDim2.new(1, 0, 0, 30)
    mpi.BackgroundColor3 = SEC_COLOR
    mpi.BorderSizePixel = 0
    mpi.Text = "Max Price: 0"
    mpi.TextColor3 = TEXT_COLOR
    mpi.TextSize = 16
    mpi.Font = Enum.Font.SourceSans
    mpi.Parent = content

    local cmb = Instance.new("TextButton")
    cmb.Name = "ClickMethodButton"
    cmb.Size = UDim2.new(1, 0, 0, 30)
    cmb.Position = UDim2.new(0, 0, 0, 40)
    cmb.BackgroundColor3 = SEC_COLOR
    cmb.BorderSizePixel = 0
    cmb.Text = "Click Method: ON"
    cmb.TextColor3 = TEXT_COLOR
    cmb.TextSize = 16
    cmb.Font = Enum.Font.SourceSansBold
    cmb.Parent = content

    local cf = Instance.new("ScrollingFrame")
    cf.Name = "ConsoleFrame"
    cf.Size = UDim2.new(1, 0, 1, -80)
    cf.Position = UDim2.new(0, 0, 0, 80)
    cf.BackgroundColor3 = Color3.fromRGB(44, 62, 80)
    cf.BorderSizePixel = 0
    cf.ScrollBarThickness = 6
    cf.Parent = content

    local cl = Instance.new("UIListLayout")
    cl.SortOrder = Enum.SortOrder.LayoutOrder
    cl.Padding = UDim.new(0, 5)
    cl.Parent = cf

    return sg, mf, tb, mb, cb, mpi, cmb, cf, content
end

local function addMsg(cf, msg, color)
    local ml = Instance.new("TextLabel")
    ml.Size = UDim2.new(1, -10, 0, 20)
    ml.BackgroundTransparency = 1
    ml.Text = msg
    ml.TextColor3 = color or TEXT_COLOR
    ml.TextSize = 14
    ml.Font = Enum.Font.SourceSans
    ml.TextXAlignment = Enum.TextXAlignment.Left
    ml.TextWrapped = true
    ml.Parent = cf

    cf.CanvasSize = UDim2.new(0, 0, 0, cf.UIListLayout.AbsoluteContentSize.Y)
    cf.CanvasPosition = Vector2.new(0, cf.CanvasSize.Y.Offset - cf.AbsoluteSize.Y)
end

local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local notificationSent = {
    buyButton = false,
    cancelButton = false
}

local function clickCancelButton(purchasePrompt)
    local cancelButtonText = nil
    local zeroTextButton = nil

    for _, descendant in ipairs(purchasePrompt:GetDescendants()) do
        if descendant:IsA("TextLabel") and descendant.Name == "Text" then
            local text = descendant.Text:lower()
            if text == "cancelar" or text == "cancel" or text == "accept" or text == "aceptar" then
                cancelButtonText = text
            elseif text <= tostring(maxPrice) then
                zeroTextButton = descendant
            end
        end
    end

    if zeroTextButton then
        local buttonCenterX = zeroTextButton.AbsolutePosition.X + zeroTextButton.AbsoluteSize.X / 0.5
        local buttonCenterY = zeroTextButton.AbsolutePosition.Y + zeroTextButton.AbsoluteSize.Y / 0.5
        
        game:GetService("VirtualInputManager"):SendMouseButtonEvent(buttonCenterX, buttonCenterY, 0, true, game, 1)
        game:GetService("VirtualInputManager"):SendMouseButtonEvent(buttonCenterX, buttonCenterY, 0, false, game, 1)
        addMsg(cf, "Toggle 'Click Button Buy", Color3.fromRGB(46, 204, 113))
    elseif cancelButtonText then
        for _, descendant in ipairs(purchasePrompt:GetDescendants()) do
            if descendant:IsA("TextLabel") and descendant.Name == "Text" and descendant.Text:lower() == cancelButtonText then
                local buttonCenterX = descendant.AbsolutePosition.X + descendant.AbsoluteSize.X / 0.5
                local buttonCenterY = descendant.AbsolutePosition.Y + descendant.AbsoluteSize.Y / 0.5
                
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(buttonCenterX, buttonCenterY, 0, true, game, 1)
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(buttonCenterX, buttonCenterY, 0, false, game, 1)
                addMsg(cf, "Click acept or cancel.", Color3.fromRGB(46, 204, 113))
                break
            end
        end
    end
end


local function initAutoBuyer()
    local sg, mf, tb, mb, cb, mpi, cmb, cf, content = createGui()

    local minimized = false
    local originalSize = mf.Size
    local originalPosition = mf.Position

    local function toggleMinimize()
        minimized = not minimized
        local targetSize, targetPos

        if minimized then
            targetSize = UDim2.new(0, mf.Size.X.Offset, 0, tb.Size.Y.Offset)
            targetPos = UDim2.new(mf.Position.X.Scale, mf.Position.X.Offset, 1, -tb.Size.Y.Offset)
        else
            targetSize = originalSize
            targetPos = originalPosition
        end

        TS:Create(mf, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = targetSize,
            Position = targetPos
        }):Play()

        content.Visible = not minimized
    end

    mb.MouseButton1Click:Connect(toggleMinimize)
    cb.MouseButton1Click:Connect(function() sg:Destroy() end)

    local dragging, dragInput, dragStart, startPos

    local function update(input)
        local delta = input.Position - dragStart
        mf.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    tb.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = mf.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    tb.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)

    mpi.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            local price = tonumber(mpi.Text:match("%d+"))
            if price and price >= 0 then
                maxPrice = price
                mpi.Text = "Max Price: " .. price
                addMsg(cf, "Max price set to " .. price .. " Robux", Color3.fromRGB(46, 204, 113))
            else
                addMsg(cf, "Invalid price. Please enter a non-negative number.", Color3.fromRGB(231, 76, 60))
            end
        end
    end)

    cmb.MouseButton1Click:Connect(function()
        useClickMethod = not useClickMethod
        cmb.Text = "Click Method: " .. (useClickMethod and "On" or "Off")
        cmb.BackgroundColor3 = useClickMethod and Color3.fromRGB(46, 204, 113) or SEC_COLOR
        addMsg(cf, "Click Method " .. (useClickMethod and "enabled" or "disabled"), Color3.fromRGB(52, 152, 219))
    end)

    local function updateGuiSize()
        local viewportSize = workspace.CurrentCamera.ViewportSize
        local scale = math.min(viewportSize.X / 1920, viewportSize.Y / 1080)
        
        originalSize = UDim2.new(0, 300 * scale, 0, 430 * scale)
        originalPosition = UDim2.new(0.5, -150 * scale, 0.5, -215 * scale)
        
        if not minimized then
            mf.Size = originalSize
            mf.Position = originalPosition
        else
            mf.Size = UDim2.new(0, 300 * scale, 0, tb.Size.Y.Offset)
            mf.Position = UDim2.new(0.5, -150 * scale, 1, -tb.Size.Y.Offset)
        end
        
        tb.Size = UDim2.new(1, 0, 0, 30 * scale)
        mb.Size = UDim2.new(0, 30 * scale, 1, 0)
        cb.Size = UDim2.new(0, 30 * scale, 1, 0)
        mb.Position = UDim2.new(1, -60 * scale, 0, 0)
        cb.Position = UDim2.new(1, -30 * scale, 0, 0)
    end

    workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateGuiSize)
    updateGuiSize()

    addMsg(cf, "Welcome to Auto Buyer!", Color3.fromRGB(52, 152, 219))
    addMsg(cf, "By OneCreatorX", Color3.fromRGB(52, 152, 219))

RS.Heartbeat:Connect(function()
        if useClickMethod then
            local coreGui = game:GetService("CoreGui")
local purchasePrompt = coreGui:WaitForChild("PurchasePrompt")

    local buttonsFound = false

    for _, descendant in ipairs(purchasePrompt:GetDescendants()) do
        if descendant:IsA("TextLabel") and descendant.Name == "Text" then
            buttonsFound = true
            break
        end
    end

    if not buttonsFound then
        notificationSent = {
            buyButton = false,
            cancelButton = false
        }
    end

    clickCancelButton(purchasePrompt)
        end
    end)
end
spawn(function()
initAutoBuyer()
end)

local UL = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/MyLibrery.lua"))()
    
    local gameName = ""
    if gameName == "" then
        gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    end
    
    local function cleanGameName(name)
        name = name:gsub("%b[]", "")
        name = name:match("^[^:]*")
        return name:match("^%s*(.-)%s*$")
    end
    
    gameName = cleanGameName(gameName)
    
    local p = game.Players.LocalPlayer
    local sg = UL:CrSG("Default")
    local frm, cfrm, crFrm = UL:CrFrm(sg, gameName)
   
    local speed = 50

local function clickButton(btn)
    local pos = btn.AbsolutePosition
    local size = btn.AbsoluteSize
    local centerX = pos.X + size.X / 1.2
    local centerY = pos.Y + size.Y / 0.5
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(centerX, centerY, 0, true, game, 1)
    wait(0.1) 
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(centerX, centerY, 0, false, game, 1)
end

local function clickButto(btn)
    local pos = btn.AbsolutePosition
    local size = btn.AbsoluteSize
    local centerX = pos.X + size.X / 0.7
    local centerY = pos.Y + size.Y / 1
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(centerX, centerY, 0, true, game, 1)
    wait(0.05)
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(centerX, centerY, 0, false, game, 1)
end
local s = true

UL:AddTBtn(cfrm, "Auto Spin(real click)", true, function(d) 
 s = d

 end)
spawn(function()
        while s do
if game.Players.LocalPlayer.PlayerGui.Spinner.Main.Visible and game.Players.LocalPlayer.PlayerGui.Spinner.Main.Spin.Label.Text == "SPIN" then
clickButton(game.Players.LocalPlayer.PlayerGui.Spinner.Main.Spin.Label)
wait(0.5)
elseif not game.Players.LocalPlayer.PlayerGui.Spinner.Main.Visible then
clickButto(game.Players.LocalPlayer.PlayerGui.HUD.Bottom.MainButtons.Spinner)
wait(0.5)
else
wait(0.3)
end
        end
    end)

    UL:AddTBox(cfrm, "Speed Test: 50 :", function(text) 
 speed = text
 end)
    
    UL:AddText(crFrm, "By Script: OneCreatorX ")
    UL:AddText(crFrm, "Create Script: 11/06/24 ")
    UL:AddText(crFrm, "Update Script: 16/06/24")
    UL:AddText(crFrm, "Script Version: 0.5")
    UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
    UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)
    
    game:GetService('Players').LocalPlayer.Idled:Connect(function()
        game:GetService('VirtualUser'):CaptureController()
        game:GetService('VirtualUser'):ClickButton2(Vector2.new())
    end)


local function getHorizontalDistance(p1, p2)
    return (Vector3.new(p1.X, 0, p1.Z) - Vector3.new(p2.X, 0, p2.Z)).magnitude
end
local ja = true
local a = true
    UL:AddTBtn(cfrm, "Auto Coins(beta)", true, function() 
 a = not a
ja = true
 end)


local function findNearestCoin()
    local nearest, minDist = nil, math.huge
    for _, coin in pairs(workspace.GAME.CoinCollection.CreatedCoins:GetChildren()) do
        if coin:IsA("BasePart") and coin.Transparency ~= 1 and a then
            local dist = getHorizontalDistance(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, coin.Position)
            if dist < minDist then
                minDist, nearest = dist, coin
            end
        end
    end
    return nearest
end

local function calculateVelocity(targetPos, speed)
    local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
    return (targetPos - playerPos).unit * speed
end

local function collectCoin(player, coin)
    local humanoid = player.Character:WaitForChild("Humanoid")
    local tolerance, maxDist =4, 4
    
    if coin and coin.Parent and a then
pcall(function()
        local playerPos, coinPos = humanoid.RootPart.Position, coin.Position
        local dist = getHorizontalDistance(playerPos, coinPos)
        
        if dist <= tolerance and dist <= maxDist then
            if dist > 2 then
ja = false
wait(0.2)
coin.Position = p.Character.PrimaryPart.Position
end

coin.Transparency = 1 
wait(0.2)
coin:Destroy()
ja = true
            
        else
            player.Character.HumanoidRootPart.Velocity = calculateVelocity(coinPos, speed)
        end
end)
        wait()
    end
end

local player = game.Players.LocalPlayer

game:GetService("RunService").RenderStepped:Connect(function()
    
    local nearestCoin = findNearestCoin()
    if nearestCoin and a and ja then
        collectCoin(player, nearestCoin)
             for _, obj in ipairs(game.Players.LocalPlayer.Character:GetDescendants()) do
    if obj:IsA("BasePart") then
obj.CanCollide = false
end end
            
    end
    wait()
end)
 collectCoin(player, nearestCoin)
             for _, obj in ipairs(game.Players.LocalPlayer.Character:GetDescendants()) do
    if obj:IsA("BasePart") then
obj.CanCollide = false
end end
            
    end
    wait()
end)

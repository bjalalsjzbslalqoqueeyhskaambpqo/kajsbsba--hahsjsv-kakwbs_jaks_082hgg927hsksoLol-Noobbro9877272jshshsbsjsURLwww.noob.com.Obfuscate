local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local MPS = game:GetService("MarketplaceService")
local HTTP = game:GetService("HttpService")
local RS = game:GetService("RunService")
local SG = game:GetService("StarterGui")
local CG = game:GetService("CoreGui")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local MAIN_COLOR = Color3.fromRGB(52, 152, 219)
local SEC_COLOR = Color3.fromRGB(41, 128, 185)
local TEXT_COLOR = Color3.fromRGB(236, 240, 241)
local BG_COLOR = Color3.fromRGB(44, 62, 80)

local maxPrice = 0
local isAutoBuyActive = false
local notifiedItems = {}
local useClickMethod = false

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

    local abb = Instance.new("TextButton")
    abb.Name = "AutoBuyButton"
    abb.Size = UDim2.new(1, 0, 0, 30)
    abb.Position = UDim2.new(0, 0, 0, 40)
    abb.BackgroundColor3 = MAIN_COLOR
    abb.BorderSizePixel = 0
    abb.Text = "Start Auto Buy"
    abb.TextColor3 = TEXT_COLOR
    abb.TextSize = 16
    abb.Font = Enum.Font.SourceSansBold
    abb.Parent = content

    local cmb = Instance.new("TextButton")
    cmb.Name = "ClickMethodButton"
    cmb.Size = UDim2.new(1, 0, 0, 30)
    cmb.Position = UDim2.new(0, 0, 0, 80)
    cmb.BackgroundColor3 = SEC_COLOR
    cmb.BorderSizePixel = 0
    cmb.Text = "Click Method: Off"
    cmb.TextColor3 = TEXT_COLOR
    cmb.TextSize = 16
    cmb.Font = Enum.Font.SourceSansBold
    cmb.Parent = content

    local cf = Instance.new("ScrollingFrame")
    cf.Name = "ConsoleFrame"
    cf.Size = UDim2.new(1, 0, 1, -120)
    cf.Position = UDim2.new(0, 0, 0, 120)
    cf.BackgroundColor3 = Color3.fromRGB(44, 62, 80)
    cf.BorderSizePixel = 0
    cf.ScrollBarThickness = 6
    cf.Parent = content

    local cl = Instance.new("UIListLayout")
    cl.SortOrder = Enum.SortOrder.LayoutOrder
    cl.Padding = UDim.new(0, 5)
    cl.Parent = cf

    return sg, mf, tb, mb, cb, mpi, abb, cmb, cf
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

local function PurchaseV1(info, price, idempotencyKey, purchaseAuthToken)
    return MPS:PerformPurchase(Enum.InfoType.Asset, info.ProductId, price,
        tostring(HTTP:GenerateGUID(false)), true,
        info.CollectibleItemId, info.CollectibleProductId, idempotencyKey,
        tostring(purchaseAuthToken))
end

local function PurchaseV2(info, price)
    local data = HTTP:JSONEncode({
        collectibleItemId = tostring(info.CollectibleItemId),
        collectibleProductId = tostring(info.CollectibleProductId),
        expectedCurrency = 1,
        expectedPrice = price,
        idempotencyKey = tostring(HTTP:GenerateGUID(false)),
        expectedSellerId = tostring(info.Creator.Id),
        expectedSellerType = tostring(info.Creator.CreatorType),
        expectedPurchaserType = "User",
        expectedPurchaserId = tostring(game.Players.LocalPlayer.UserId)
    })
    return _post("https://apis.roblox.com/marketplace-sales/v1/item/" .. tostring(info.CollectibleItemId) .. "/purchase-item", data)
end

local function PurchaseV3(assetId, price)
    local success, result = pcall(function()
        return game:GetService("AssetService"):PurchaseAsset(assetId, price)
    end)
    return success and result
end

local function PurchaseV4(assetId, price)
    local success, result = pcall(function()
        return game:GetService("MarketplaceService"):PromptPurchase(player, assetId, false, Enum.CurrencyType.Robux)
    end)
    return success and result
end

local function PurchaseV5(assetId, price)
    local success, result = pcall(function()
        return game:GetService("MarketplaceService"):PromptProductPurchase(player, assetId)
    end)
    return success and result
end

local function attemptPurchase(info, price, idempotencyKey, purchaseAuthToken)
    local success = false

    if not useClickMethod then
        success = PurchaseV3(info.AssetId, price) or
                  PurchaseV4(info.AssetId, price) or
                  PurchaseV5(info.AssetId, price) or
                  pcall(function() return PurchaseV2(info, price) end) or
                  pcall(function() return PurchaseV1(info, price, idempotencyKey, purchaseAuthToken) end)
    else
        handlePurchasePrompt()
        success = true
    end

    return success
end

local function initAutoBuyer()
    local sg, mf, tb, mb, cb, mpi, abb, cmb, cf = createGui()

    local function toggleMinimize()
        local targetSize, targetPos
        if mf.Size.Y.Offset > 35 then
            targetSize = UDim2.new(0, 300, 0, 35)
            targetPos = UDim2.new(0.5, -150, 1, -35)
        else
            targetSize = UDim2.new(0, 300, 0, 430)
            targetPos = UDim2.new(0.5, -150, 0.5, -215)
        end

        TS:Create(mf, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = targetSize, Position = targetPos}):Play()
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

    local function AutoPurchase(state)
        if state then
            if isAutoBuyActive then return end
            isAutoBuyActive = true
            abb.Text = "Stop Auto Buy"
            abb.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
            addMsg(cf, "Auto Buy started", Color3.fromRGB(46, 204, 113))

            getrenv()._set = clonefunction(setthreadidentity)
            local old
            old = hookmetamethod(game, "__index", function(a, b)
                task.spawn(function()
                    _set(7)
                    task.wait()
                    getgenv().promptpurchaserequestedv2 = MPS.PromptPurchaseRequestedV2:Connect(
                        function(...)
                            local t = {...}
                            local assetId = t[2]
                            local idempotencyKey = t[5]
                            local purchaseAuthToken = t[6]
                            local info = MPS:GetProductInfo(assetId)
                            local price = info.PriceInRobux
                            if price <= maxPrice then
                                local success = attemptPurchase(info, price, idempotencyKey, purchaseAuthToken)

                                if success then
                                    addMsg(cf, "Successfully purchased: " .. info.Name .. " for " .. price .. " Robux", Color3.fromRGB(46, 204, 113))
                                else
                                    addMsg(cf, "Failed to purchase: " .. info.Name, Color3.fromRGB(231, 76, 60))
                                end
                            else
                                addMsg(cf, "Skipped purchase: " .. info.Name .. " (Price: " .. price .. " Robux)", Color3.fromRGB(241, 196, 15))
                                if useClickMethod then
                                    handlePurchasePrompt()
                                end
                            end
                        end
                    )
                end)
                
                hookmetamethod(game, "__index", old)
                return old(a, b)
            end)
        else
            isAutoBuyActive = false
            abb.Text = "Start Auto Buy"
            abb.BackgroundColor3 = MAIN_COLOR
            addMsg(cf, "Auto Buy stopped", Color3.fromRGB(231, 76, 60))
            if getgenv().promptpurchaserequestedv2 then
                getgenv().promptpurchaserequestedv2:Disconnect()
            end
        end
    end

    abb.MouseButton1Click:Connect(function()
        AutoPurchase(not isAutoBuyActive)
    end)

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
            local buttonCenterY = zeroTextButton.AbsolutePosition.Y + zeroTextButton.AbsoluteSize.Y / 0.4
            
            game:GetService("VirtualInputManager"):SendMouseButtonEvent(buttonCenterX, buttonCenterY, 0, true, game, 1)
            game:GetService("VirtualInputManager"):SendMouseButtonEvent(buttonCenterX, buttonCenterY, 0, false, game, 1)
            addMsg(cf, "Toggle 'Click Button Buy", Color3.fromRGB(46, 204, 113))
        elseif cancelButtonText then
            for _, descendant in ipairs(purchasePrompt:GetDescendants()) do
                if descendant:IsA("TextLabel") and descendant.Name == "Text" and descendant.Text:lower() == cancelButtonText then
                    local buttonCenterX = descendant.AbsolutePosition.X + descendant.AbsoluteSize.X / 0.45
                    local buttonCenterY = descendant.AbsolutePosition.Y + descendant.AbsoluteSize.Y / 0.4
                    
                    game:GetService("VirtualInputManager"):SendMouseButtonEvent(buttonCenterX, buttonCenterY, 0, true, game, 1)
                    game:GetService("VirtualInputManager"):SendMouseButtonEvent(buttonCenterX, buttonCenterY, 0, false, game, 1)
                    addMsg(cf, "Click acept or cancel.", Color3.fromRGB(46, 204, 113))
                    break
                end
            end
        end
    end

    cmb.MouseButton1Click:Connect(function()
        useClickMethod = not useClickMethod
        cmb.Text = "Click Method: " .. (useClickMethod and "On" or "Off")
        cmb.BackgroundColor3 = useClickMethod and Color3.fromRGB(46, 204, 113) or SEC_COLOR
        addMsg(cf, "Click Method " .. (useClickMethod and "enabled" or "disabled"), Color3.fromRGB(52, 152, 219))
    end)

    local function updateGuiSize()
        local viewportSize = workspace.CurrentCamera.ViewportSize
        local scale = math.min(viewportSize.X / 1920, viewportSize.Y / 1080)
        mf.Size = UDim2.new(0, 300 * scale, 0, 430 * scale)
        mf.Position = UDim2.new(0.5, -150 * scale, 0.5, -215 * scale)
    end

    workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateGuiSize)
    updateGuiSize()

    addMsg(cf, "Welcome to Auto Buyer!", Color3.fromRGB(52, 152, 219))
    addMsg(cf, "By OneCreatorX", Color3.fromRGB(52, 152, 219))
    addMsg(cf, "Set your max price and click 'Start Auto Buy' to begin.", Color3.fromRGB(46, 204, 113))
    addMsg(cf, "Toggle 'Click Method' for manual button clicking.", Color3.fromRGB(46, 204, 113))

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

initAutoBuyer()

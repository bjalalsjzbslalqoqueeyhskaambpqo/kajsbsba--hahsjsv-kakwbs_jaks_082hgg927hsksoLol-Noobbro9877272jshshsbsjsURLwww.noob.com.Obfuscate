local MiniUI = {}

local TweenService = game:GetService("TweenService")
local ContentProvider = game:GetService("ContentProvider")

local function c(t, p)
    local i = Instance.new(t)
    for k, v in pairs(p) do i[k] = v end
    return i
end

local function s(i, props)
    for k, v in pairs(props) do i[k] = v end
end

local function loadImage(url)
    local image = c("ImageLabel", {
        BackgroundTransparency = 1,
        Image = url
    })
    ContentProvider:PreloadAsync({image})
    return image
end

local function createUI(parent, isSubMenu, subMenuTitle, customTitle)
    local ui = {}
    local frame = c("Frame", {
        Size = UDim2.new(0, 300, 0, 400),
        Position = isSubMenu and UDim2.new(0, 310, 0, 0) or UDim2.new(0.5, -150, 0.5, -200),
        Parent = parent,
        Visible = not isSubMenu,
        Active = not isSubMenu,
        Draggable = not isSubMenu,
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        BorderSizePixel = 0
    })

    local backgroundImage = loadImage("rbxassetid://6073628839")
    backgroundImage.Parent = frame
    backgroundImage.Size = UDim2.new(1, 0, 1, 0)
    backgroundImage.ImageTransparency = 0.7

    local blurEffect = c("BlurEffect", {
        Size = 10,
        Parent = frame
    })

    local cornerRadius = c("UICorner", {
        CornerRadius = UDim.new(0, 10),
        Parent = frame
    })

    local title = isSubMenu and subMenuTitle or customTitle or game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    
    local titleLabel = c("TextLabel", {
        Size = UDim2.new(1, -60, 0, 40),
        Position = UDim2.new(0, 0, 0, 0),
        Text = title,
        Parent = frame,
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 18
    })
    
    local minBtn = c("TextButton", {
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -60, 0, 5),
        Text = "-",
        Parent = frame,
        BackgroundColor3 = Color3.fromRGB(60, 60, 60),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.GothamBold,
        TextSize = 20
    })
    c("UICorner", {CornerRadius = UDim.new(0, 5), Parent = minBtn})
    
    local closeBtn = c("TextButton", {
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -35, 0, 5),
        Text = "X",
        Parent = frame,
        BackgroundColor3 = Color3.fromRGB(200, 60, 60),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.GothamBold,
        TextSize = 14
    })
    c("UICorner", {CornerRadius = UDim.new(0, 5), Parent = closeBtn})
    
    local scrollFrame = c("ScrollingFrame", {
        Size = UDim2.new(1, -20, 1, -50),
        Position = UDim2.new(0, 10, 0, 40),
        Parent = frame,
        BackgroundTransparency = 1,
        ScrollBarThickness = 6,
        ScrollBarImageColor3 = Color3.fromRGB(200, 200, 200),
        CanvasSize = UDim2.new(0, 0, 0, 0)
    })
    
    local list = c("UIListLayout", {
        Parent = scrollFrame,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 5)
    })
    
    local function updateSize()
        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, list.AbsoluteContentSize.Y)
    end
    list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateSize)
    
    minBtn.MouseButton1Click:Connect(function()
        local goal = {Size = scrollFrame.Visible and UDim2.new(1, 0, 0, 40) or UDim2.new(0, 300, 0, 400)}
        local tween = TweenService:Create(frame, TweenInfo.new(0.3), goal)
        tween:Play()
        scrollFrame.Visible = not scrollFrame.Visible
        minBtn.Text = scrollFrame.Visible and "-" or "+"
    end)
    
    closeBtn.MouseButton1Click:Connect(function()
        frame.Visible = false
        if ui.onClose then ui.onClose() end
    end)
    
    local function addElement(elemType, props)
        local container = c("Frame", {
            Size = UDim2.new(1, 0, 0, props.CustomHeight or 40),
            BackgroundTransparency = 1,
            Parent = scrollFrame
        })
        props.CustomHeight = nil
        local elem = c(elemType, props)
        elem.Size = UDim2.new(1, 0, 1, 0)
        elem.Parent = container
        s(elem, {
            BackgroundColor3 = Color3.fromRGB(50, 50, 50),
            BorderSizePixel = 0,
            Font = Enum.Font.Gotham,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 14
        })
        c("UICorner", {CornerRadius = UDim.new(0, 5), Parent = elem})
        updateSize()
        return elem
    end
    
    function ui:Btn(text, callback)
        local btn = addElement("TextButton", {Text = text})
        if callback then btn.MouseButton1Click:Connect(callback) end
        return btn
    end
    
    function ui:Txt(text)
        return addElement("TextLabel", {Text = text})
    end
    
    function ui:TBox(text, callback)
        local tbox = addElement("TextBox", {Text = text, ClearTextOnFocus = false})
        if callback then tbox.FocusLost:Connect(function(enterPressed) callback(tbox.Text, enterPressed) end) end
        return tbox
    end
    
    function ui:Track(label, default, min, max, step, callback)
        local container = addElement("Frame", {Size = UDim2.new(1, 0, 0, 40)})
        local minusBtn = c("TextButton", {Size = UDim2.new(0, 30, 1, 0), Position = UDim2.new(0, 0, 0, 0), Text = "-", Parent = container})
        local plusBtn = c("TextButton", {Size = UDim2.new(0, 30, 1, 0), Position = UDim2.new(1, -30, 0, 0), Text = "+", Parent = container})
        local slider = c("Frame", {Size = UDim2.new(1, -70, 0, 10), Position = UDim2.new(0, 35, 0.5, -5), Parent = container, BackgroundColor3 = Color3.fromRGB(100, 100, 100)})
        local sliderBtn = c("TextButton", {Size = UDim2.new(0, 20, 0, 20), Position = UDim2.new(0, 0, 0.5, -10), Text = "", Parent = slider, BackgroundColor3 = Color3.fromRGB(200, 200, 200)})
        local textLabel = c("TextLabel", {Size = UDim2.new(1, 0, 0, 20), Position = UDim2.new(0, 0, 0, -25), Text = label .. ": " .. default, Parent = container, BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(255, 255, 255)})
        c("UICorner", {CornerRadius = UDim.new(0, 5), Parent = slider})
        c("UICorner", {CornerRadius = UDim.new(0, 5), Parent = sliderBtn})
        s(minusBtn, {BackgroundColor3 = Color3.fromRGB(60, 60, 60), TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.GothamBold})
        s(plusBtn, {BackgroundColor3 = Color3.fromRGB(60, 60, 60), TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.GothamBold})
        c("UICorner", {CornerRadius = UDim.new(0, 5), Parent = minusBtn})
        c("UICorner", {CornerRadius = UDim.new(0, 5), Parent = plusBtn})
        
        local value = default
        local function update(newValue)
            value = math.clamp(newValue, min, max)
            textLabel.Text = label .. ": " .. value
            local position = (value - min) / (max - min)
            sliderBtn.Position = UDim2.new(position, -10, 0.5, -10)
            if callback then callback(value) end
        end
        
        minusBtn.MouseButton1Click:Connect(function() update(value - step) end)
        plusBtn.MouseButton1Click:Connect(function() update(value + step) end)
        
        local dragging = false
        sliderBtn.MouseButton1Down:Connect(function() dragging = true end)
        game:GetService("UserInputService").InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
        end)
        slider.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                local relativeX = input.Position.X - slider.AbsolutePosition.X
                local percent = math.clamp(relativeX / slider.AbsoluteSize.X, 0, 1)
                update(min + (max - min) * percent)
            end
        end)
        game:GetService("RunService").RenderStepped:Connect(function()
            if dragging then
                local mousePos = game:GetService("UserInputService"):GetMouseLocation()
                local relativeX = mousePos.X - slider.AbsolutePosition.X
                local percent = math.clamp(relativeX / slider.AbsoluteSize.X, 0, 1)
                update(min + (max - min) * percent)
            end
        end)
        
        return container
    end
    
    function ui:TBtn(text, callback)
        local btn = addElement("TextButton", {Text = text})
        local isActive = false
        
        local function updateAppearance()
            btn.BackgroundColor3 = isActive and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(50, 50, 50)
        end
        
        btn.MouseButton1Click:Connect(function()
            isActive = not isActive
            updateAppearance()
            if callback then callback(isActive) end
        end)
        
        updateAppearance()
        return btn
    end
    
    local activeSubMenu = nil
    function ui:Sub(text)
        local subBtn = self:Btn(text .. " >")
        local subFrame = createUI(parent, true, text)
        subFrame.frame.Visible = false
        subBtn.MouseButton1Click:Connect(function()
            if activeSubMenu and activeSubMenu ~= subFrame then
                activeSubMenu.frame.Visible = false
                activeSubMenu.button.Text = activeSubMenu.button.Text:gsub(" >$", " >")
            end
            subFrame.frame.Visible = not subFrame.frame.Visible
            subBtn.Text = subFrame.frame.Visible and text .. "  >" or text .. " >"
            if subFrame.frame.Visible then
                subFrame.frame.Position = UDim2.new(0, frame.AbsolutePosition.X + frame.AbsoluteSize.X + 10, 0, frame.AbsolutePosition.Y)
                activeSubMenu = {frame = subFrame.frame, button = subBtn}
            else
                activeSubMenu = nil
            end
        end)
        frame:GetPropertyChangedSignal("Position"):Connect(function()
            if subFrame.frame.Visible then
                subFrame.frame.Position = UDim2.new(0, frame.AbsolutePosition.X + frame.AbsoluteSize.X + 10, 0, frame.AbsolutePosition.Y)
            end
        end)
        frame:GetPropertyChangedSignal("Visible"):Connect(function()
            if not frame.Visible and subFrame.frame.Visible then
                subFrame.frame.Visible = false
                subBtn.Text = text .. " >"
                activeSubMenu = nil
            end
        end)
        return subFrame
    end
    
    ui.frame = frame
    return ui
end

function MiniUI:new(customTitle)
    local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    local sg = nil

    for _, gui in pairs(playerGui:GetChildren()) do
        if gui:IsA("ScreenGui") and gui.Enabled then
            sg = gui
            break
        end
    end

    if not sg then
        sg = Instance.new("ScreenGui")
        sg.Name = "MiniUIScreenGui"
        sg.Parent = playerGui
    end

    sg.Enabled = true

    local ui = createUI(sg, false, nil, customTitle)
    
    spawn(function()
        wait(0.3)
        local serverSub = ui:Sub("Options Universal")
        serverSub:Txt("Auto Reconnect: ON")
        serverSub:Txt("Anti-AFK: ON")
        
        serverSub:Btn("Rejoin", function()
            game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
        end)
        
        local function joinServer(sortOrder, ascending)
            local servers = {}
            local endpoint = string.format(
                "https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=%s&limit=100",
                tostring(game.PlaceId),
                sortOrder
            )
            local result = game:HttpGet(endpoint)
            result = game:GetService("HttpService"):JSONDecode(result)
            for _, server in ipairs(result.data) do
                if server.playing < server.maxPlayers and server.id ~= game.JobId then
                    table.insert(servers, server)
                end
            end
            if #servers > 0 then
                table.sort(servers, function(a, b)
                    return ascending and a[sortOrder] < b[sortOrder] or a[sortOrder] > b[sortOrder]
                end)
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, servers[1].id)
            else
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "No Server",
                    Text = "No suitable servers found",
                    Duration = 5,
                })
            end
        end
        
        serverSub:Btn("Join + Players", function() joinServer("playing", false) end)
        serverSub:Btn("Join - Players", function() joinServer("playing", true) end)
        serverSub:Btn("Join Best Ping", function() joinServer("ping", true) end)
        
        serverSub:Btn("Join Server only(Beta)", function()
            local jb = game.JobId
            spawn(function()
                -- Your existing code for joining a server
            end)
        end)
        
        serverSub:TBtn("FPS Boost", function(isActive)
            local function setGraphics(level)
                settings().Rendering.QualityLevel = level
                for _, v in pairs(game:GetDescendants()) do
                    if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
                        v.Enabled = level == 4
                    end
                end
                local lighting = game:GetService("Lighting")
                lighting.GlobalShadows = level == 4
                lighting.FogEnd = level == 4 and 100000 or 9e9
                lighting.Brightness = level == 4 and 1 or 2
                for _, v in pairs(lighting:GetDescendants()) do
                    if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
                        v.Enabled = level == 4
                    end
                end
            end
            setGraphics(isActive and 1 or 4)
        end)
        
        local function loadScript(scriptName)
            (loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX-New/TwoDev/main/Loader.lua"))())(scriptName)
        end
        
        serverSub:Btn("Auto Claim UGC", function() loadScript("Auto%20Buyer(Fast%20Claim)") end)
        serverSub:Btn("Join Group", function() loadScript("Join%20Group") end)
        serverSub:Btn("Follow or unFollow", function() loadScript("Follow%20or%20UnFollow%20Users") end)
        serverSub:Btn("Active Fake Gamepass", function() loadScript("Fake%20Parchuses%20Gamepass") end)
        serverSub:Btn("Bypass Premium (Free)", function() loadScript("Bypass%20Premiun") end)
        
        -- Auto Reconnect
        game:GetService("NetworkClient").ChildRemoved:Connect(function()
            if #game.Players:GetPlayers() <= 1 then
                game.Players.LocalPlayer:Kick("\nAuto Reconnect...")
                wait()
                game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
            else
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
            end
        end)
        
        -- Anti-AFK
        game.Players.LocalPlayer.Idled:Connect(function()
            local VirtualUser = game:GetService("VirtualUser")
            VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            wait(1)
            VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        end)
    end)
    
    return ui
end

return MiniUI

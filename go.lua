local MiniUI = {}

local function c(t, p)
    local i = Instance.new(t)
    for k, v in pairs(p) do i[k] = v end
    return i
end

local function s(i, bg)
    i.BackgroundColor3 = bg or Color3.fromRGB(20, 20, 20)
    i.BorderSizePixel = 0
    c("UICorner", {CornerRadius = UDim.new(0, 4), Parent = i})
    if i:IsA("TextButton") or i:IsA("TextLabel") or i:IsA("TextBox") then
        i.Font = Enum.Font.GothamSemibold
        i.TextColor3 = Color3.fromRGB(255, 255, 255)
        i.TextSize = 14
    end
end

function MiniUI.new(title)
    local self = {}
    
    local sg = game.Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("MiniUIScreenGui")
    if not sg or not sg.Enabled then
        sg = c("ScreenGui", {Name = "MiniUIScreenGui", Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")})
    end
    
    local f = c("Frame", {Name = "MiniUIMainFrame", Size = UDim2.new(0, 200, 0, 30), Position = UDim2.new(0.5, -100, 0, 20), Parent = sg})
    s(f)
    f.Active = true
    f.Draggable = true
    
    local t = c("TextLabel", {Size = UDim2.new(1, -30, 1, 0), Text = title or "Mini UI", Parent = f})
    s(t)
    
    local m = c("TextButton", {Size = UDim2.new(0, 30, 1, 0), Position = UDim2.new(1, -30, 0, 0), Text = "-", Parent = f})
    s(m)
    
    local cf = c("Frame", {Size = UDim2.new(1, 0, 0, 0), Position = UDim2.new(0, 0, 1, 0), Parent = f})
    s(cf, Color3.fromRGB(15, 15, 15))
    
    local l = c("UIListLayout", {Parent = cf, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 1)})
    
    local function u()
        cf.Size = UDim2.new(1, 0, 0, l.AbsoluteContentSize.Y)
    end
    
    l:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(u)
    
    local min = false
    m.MouseButton1Click:Connect(function()
        min = not min
        cf.Visible = not min
        m.Text = min and "+" or "-"
        u()
    end)
    
    function self:Btn(txt, cb)
        local b = c("TextButton", {Size = UDim2.new(1, -10, 0, 25), Position = UDim2.new(0, 5, 0, 0), Text = txt, Parent = cf})
        s(b)
        if cb then b.MouseButton1Click:Connect(cb) end
        u()
        return b
    end
    
    function self:Txt(txt)
        local t = c("TextLabel", {Size = UDim2.new(1, -10, 0, 25), Position = UDim2.new(0, 5, 0, 0), Text = txt, Parent = cf})
        s(t)
        u()
        return t
    end
    
    function self:Slider(txt, min, max, default, cb)
        local container = c("Frame", {Size = UDim2.new(1, -10, 0, 50), Position = UDim2.new(0, 5, 0, 0), BackgroundTransparency = 1, Parent = cf})
        local label = c("TextLabel", {Size = UDim2.new(1, 0, 0, 20), Position = UDim2.new(0, 0, 0, 0), Text = txt .. ": " .. default, Parent = container})
        s(label)
        
        local sliderBack = c("Frame", {Size = UDim2.new(1, 0, 0, 5), Position = UDim2.new(0, 0, 0, 25), Parent = container})
        s(sliderBack, Color3.fromRGB(40, 40, 40))
        
        local sliderFill = c("Frame", {Size = UDim2.new((default - min) / (max - min), 0, 1, 0), Position = UDim2.new(0, 0, 0, 0), Parent = sliderBack})
        s(sliderFill, Color3.fromRGB(60, 60, 60))
        
        local function update(value)
            local pos = (value - min) / (max - min)
            sliderFill.Size = UDim2.new(pos, 0, 1, 0)
            label.Text = txt .. ": " .. math.floor(value * 10) / 10
            if cb then cb(value) end
        end
        
        local dragging = false
        sliderBack.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
            end
        end)
        
        game:GetService("UserInputService").InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)
        
        sliderBack.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local pos = math.clamp((input.Position.X - sliderBack.AbsolutePosition.X) / sliderBack.AbsoluteSize.X, 0, 1)
                local value = min + (max - min) * pos
                update(value)
            end
        end)
        
        u()
        return container
    end
    
    -- Default options
    self:Txt("Server Options")
    self:Btn("Rejoin", function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
    end)
    self:Btn("Less Crowded Server", function()
        local servers = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
        local server = servers.data[math.random(1, #servers.data)]
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, server.id, game.Players.LocalPlayer)
    end)
    self:Btn("More Crowded Server", function()
        local servers = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100"))
        local server = servers.data[math.random(1, #servers.data)]
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, server.id, game.Players.LocalPlayer)
    end)
    self:Btn("Best Ping Server", function()
        local servers = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
        local bestPing = math.huge
        local bestServer
        for _, server in ipairs(servers.data) do
            if server.ping < bestPing and server.playing < server.maxPlayers then
                bestPing = server.ping
                bestServer = server
            end
        end
        if bestServer then
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, bestServer.id, game.Players.LocalPlayer)
        else
            print("No se encontró un servidor mejor")
        end
    end)
    
    self:Txt("Client Options")
    self:Slider("WalkSpeed", 16, 100, 16, function(value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
    end)
    self:Slider("JumpPower", 50, 200, 50, function(value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
    end)
    
    local flyEnabled = false
    self:Btn("Fly", function(btn)
        flyEnabled = not flyEnabled
        btn.Text = "Fly: " .. (flyEnabled and "ON" or "OFF")
        
        if flyEnabled then
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoid = character:WaitForChild("Humanoid")
            local torso = character:WaitForChild("HumanoidRootPart")
            
            local flyPart = Instance.new("BodyVelocity")
            flyPart.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            flyPart.Velocity = Vector3.new(0, 0, 0)
            flyPart.Parent = torso
            
            game:GetService("RunService").RenderStepped:Connect(function()
                if not flyEnabled then return end
                local camera = workspace.CurrentCamera
                local moveDirection = humanoid.MoveDirection
                flyPart.Velocity = camera.CFrame:VectorToWorldSpace(moveDirection * 50)
            end)
        else
            local character = game.Players.LocalPlayer.Character
            if character then
                local flyPart = character:FindFirstChild("HumanoidRootPart"):FindFirstChild("BodyVelocity")
                if flyPart then
                    flyPart:Destroy()
                end
            end
        end
    end)
    
    return self
end

return MiniUI

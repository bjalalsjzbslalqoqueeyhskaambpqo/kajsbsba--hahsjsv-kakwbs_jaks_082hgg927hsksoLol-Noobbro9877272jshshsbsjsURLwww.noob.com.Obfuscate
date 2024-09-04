local MiniUI = {}

local TS = game:GetService("TweenService")
local CP = game:GetService("ContentProvider")
local UIS = game:GetService("UserInputService")

local function c(t, p)
    local i = Instance.new(t)
    for k, v in pairs(p) do i[k] = v end
    return i
end

local function s(i, p)
    for k, v in pairs(p) do
        if (k ~= "Font" or (k == "Font" and (i:IsA("TextLabel") or i:IsA("TextButton") or i:IsA("TextBox")))) and
           (k ~= "TextColor3" or (k == "TextColor3" and (i:IsA("TextLabel") or i:IsA("TextButton") or i:IsA("TextBox")))) and
           (k ~= "TextSize" or (k == "TextSize" and (i:IsA("TextLabel") or i:IsA("TextButton") or i:IsA("TextBox")))) then
            i[k] = v
        end
    end
end

local function lImg(url)
    local img = c("ImageLabel", {BackgroundTransparency = 1, Image = url})
    CP:PreloadAsync({img})
    return img
end

local function cUI(parent, isSub, subTitle, cusTitle)
    local ui = {}
    local f = c("Frame", {
        Size = UDim2.new(0, 250, 0, 300),
        Position = isSub and UDim2.new(0, 260, 0, 0) or UDim2.new(0.5, -125, 0.5, -150),
        Parent = parent,
        Visible = not isSub,
        Active = not isSub,
        Draggable = not isSub,
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        BorderSizePixel = 0
    })

    local bg = lImg("rbxassetid://6073628839")
    bg.Parent = f
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.ImageTransparency = 0.8

    c("UICorner", {CornerRadius = UDim.new(0, 8), Parent = f})
    c("UIStroke", {Color = Color3.fromRGB(60, 60, 60), Thickness = 2, Parent = f})

    local title = isSub and subTitle or cusTitle or game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    
    local tl = c("TextLabel", {
        Size = UDim2.new(1, -60, 0, 30),
        Position = UDim2.new(0, 0, 0, 0),
        Text = title,
        Parent = f,
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 16
    })
    
    local mb = c("TextButton", {
        Size = UDim2.new(0, 25, 0, 25),
        Position = UDim2.new(1, -55, 0, 2),
        Text = "-",
        Parent = f,
        BackgroundColor3 = Color3.fromRGB(60, 60, 60),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.GothamBold,
        TextSize = 18
    })
    c("UICorner", {CornerRadius = UDim.new(0, 4), Parent = mb})
    
    local cb = c("TextButton", {
        Size = UDim2.new(0, 25, 0, 25),
        Position = UDim2.new(1, -28, 0, 2),
        Text = "X",
        Parent = f,
        BackgroundColor3 = Color3.fromRGB(200, 60, 60),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.GothamBold,
        TextSize = 14
    })
    c("UICorner", {CornerRadius = UDim.new(0, 4), Parent = cb})
    
    local sf = c("ScrollingFrame", {
        Size = UDim2.new(1, -16, 1, -36),
        Position = UDim2.new(0, 8, 0, 32),
        Parent = f,
        BackgroundTransparency = 1,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = Color3.fromRGB(200, 200, 200),
        CanvasSize = UDim2.new(0, 0, 0, 0)
    })
    
    local list = c("UIListLayout", {
        Parent = sf,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 8)
    })
    
    local function upSize()
        sf.CanvasSize = UDim2.new(0, 0, 0, list.AbsoluteContentSize.Y)
    end
    list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(upSize)
    
    mb.MouseButton1Click:Connect(function()
        local goal = {Size = sf.Visible and UDim2.new(0, 250, 0, 32) or UDim2.new(0, 250, 0, 300)}
        local tw = TS:Create(f, TweenInfo.new(0.3), goal)
        tw:Play()
        sf.Visible = not sf.Visible
        mb.Text = sf.Visible and "-" or "+"
    end)
    
    cb.MouseButton1Click:Connect(function()
        f.Visible = false
        if ui.onClose then ui.onClose() end
    end)
    
    local function addElem(eType, props)
        local cont = c("Frame", {
            Size = UDim2.new(1, 0, 0, props.CusHeight or 32),
            BackgroundTransparency = 1,
            Parent = sf
        })
        props.CusHeight = nil
        local elem = c(eType, props)
        elem.Size = UDim2.new(1, 0, 1, 0)
        elem.Parent = cont
        s(elem, {
            BackgroundColor3 = Color3.fromRGB(50, 50, 50),
            BorderSizePixel = 0,
            Font = Enum.Font.Gotham,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 14
        })
        c("UICorner", {CornerRadius = UDim.new(0, 4), Parent = elem})
        c("UIStroke", {Color = Color3.fromRGB(80, 80, 80), Thickness = 1, Parent = elem})
        upSize()
        return elem
    end
    
    function ui:Btn(text, callback)
        local btn = addElem("TextButton", {Text = text})
        if callback then btn.MouseButton1Click:Connect(callback) end
        return btn
    end
    
    function ui:Txt(text)
        return addElem("TextLabel", {Text = text})
    end
    
    function ui:TBox(text, callback)
        local tb = addElem("TextBox", {Text = text, ClearTextOnFocus = false})
        if callback then tb.FocusLost:Connect(function(ep) callback(tb.Text, ep) end) end
        return tb
    end
    
    function ui:Track(label, def, min, max, callback)
        local cont = addElem("Frame", {Size = UDim2.new(1, 0, 0, 50)})
        local sl = c("Frame", {Size = UDim2.new(1, -70, 0, 6), Position = UDim2.new(0, 35, 0.7, -3), Parent = cont, BackgroundColor3 = Color3.fromRGB(100, 100, 100)})
        local sb = c("TextButton", {Size = UDim2.new(0, 16, 0, 16), Position = UDim2.new(0, 0, 0.5, -8), Text = "", Parent = sl, BackgroundColor3 = Color3.fromRGB(200, 200, 200)})
        local tl = c("TextLabel", {Size = UDim2.new(1, 0, 0, 20), Position = UDim2.new(0, 0, 0, 0), Text = label .. ": " .. def, Parent = cont, BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Gotham, TextSize = 14})
        c("UICorner", {CornerRadius = UDim.new(0, 3), Parent = sl})
        c("UICorner", {CornerRadius = UDim.new(0, 8), Parent = sb})
        
        local val = def
        local function update(nv)
            val = math.clamp(math.floor(nv), min, max)
            tl.Text = label .. ": " .. val
            local pos = (val - min) / (max - min)
            sb.Position = UDim2.new(pos, -8, 0.5, -8)
            if callback then callback(val) end
        end
        
        local drag = false
        local function startDrag()
            drag = true
            sb.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
        end
        local function endDrag()
            drag = false
            sb.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
        end
        
        sb.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                startDrag()
            end
        end)
        
        UIS.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                endDrag()
            end
        end)
        
        sl.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                local relX = (input.Position.X - sl.AbsolutePosition.X) / sl.AbsoluteSize.X
                update(min + (max - min) * relX)
            end
        end)
        
        game:GetService("RunService").RenderStepped:Connect(function()
            if drag then
                local mousePos = UIS:GetMouseLocation()
                local touchPos = UIS:GetTouchPosition()
                local pos = touchPos or mousePos
                if pos then
                    local relX = (pos.X - sl.AbsolutePosition.X) / sl.AbsoluteSize.X
                    update(min + (max - min) * math.clamp(relX, 0, 1))
                end
            end
        end)
        
        return cont
    end
    
    function ui:TBtn(text, callback)
        local btn = addElem("TextButton", {Text = text})
        local active = false
        
        local function upApp()
            btn.BackgroundColor3 = active and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(50, 50, 50)
        end
        
        btn.MouseButton1Click:Connect(function()
            active = not active
            upApp()
            if callback then callback(active) end
        end)
        
        upApp()
        return btn
    end
    
    local activeSub = nil
    function ui:Sub(text)
        local sb = self:Btn(text .. " >")
        local sf = cUI(parent, true, text)
        sf.frame.Visible = false
        sb.MouseButton1Click:Connect(function()
            if activeSub and activeSub ~= sf then
                activeSub.frame.Visible = false
                activeSub.button.Text = activeSub.button.Text:gsub(" >$", " >")
            end
            sf.frame.Visible = not sf.frame.Visible
            sb.Text = sf.frame.Visible and text .. "  >" or text .. " >"
            if sf.frame.Visible then
                sf.frame.Position = UDim2.new(0, f.AbsolutePosition.X + f.AbsoluteSize.X + 10, 0, f.AbsolutePosition.Y)
                activeSub = {frame = sf.frame, button = sb}
            else
                activeSub = nil
            end
        end)
        f:GetPropertyChangedSignal("Position"):Connect(function()
            if sf.frame.Visible then
                sf.frame.Position = UDim2.new(0, f.AbsolutePosition.X + f.AbsoluteSize.X + 10, 0, f.AbsolutePosition.Y)
            end
        end)
        f:GetPropertyChangedSignal("Visible"):Connect(function()
            if not f.Visible and sf.frame.Visible then
                sf.frame.Visible = false
                sb.Text = text .. " >"
                activeSub = nil
            end
        end)
        return sf
    end
    
    ui.frame = f
    return ui
end

function MiniUI:new(cusTitle)
    local pg = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    local sg = pg:FindFirstChild("MiniUIScreenGui") or Instance.new("ScreenGui", pg)
    sg.Name = "MiniUIScreenGui"
    sg.ResetOnSpawn = false
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local ui = cUI(sg, false, nil, cusTitle)
    
    spawn(function()
        wait(0.3)
        local serverSub = ui:Sub("Options")
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
            result = game: GetService("HttpService"):JSONDecode(result)
            for _, server in ipairs(result.data) do
                if server.playing < server.maxPlayers - 1 and server.id ~= game.JobId then
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
        
        serverSub:Btn("Join +Players", function() joinServer("playing", false) end)
        serverSub:Btn("Join -Players", function() joinServer("playing", true) end)
        serverSub:Btn("Join Best Ping", function() joinServer("ping", true) end)
        
        serverSub:Track("Graphics Quality", 5, 1, 10, function(value)
            settings().Rendering.QualityLevel = value
        end)
        
        serverSub:TBtn("FPS Boost", function(isActive)
            local function setGraphics(level)
                settings().Rendering.QualityLevel = level
                for _, v in pairs(game:GetDescendants()) do
                    if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
                        v.Enabled = level == 10
                    end
                end
                local lighting = game:GetService("Lighting")
                lighting.GlobalShadows = level == 10
                lighting.FogEnd = level == 10 and 100000 or 9e9
                lighting.Brightness = level == 10 and 1 or 2
                for _, v in pairs(lighting:GetDescendants()) do
                    if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
                        v.Enabled = level == 10
                    end
                end
            end
            setGraphics(isActive and 1 or 10)
        end)
        
        local function loadScript(scriptName)
            (loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX-New/TwoDev/main/Loader.lua"))())(scriptName)
        end
        
        serverSub:Btn("Auto Claim UGC", function() loadScript("Auto%20Buyer(Fast%20Claim)") end)
        serverSub:Btn("Join Group", function() loadScript("Join%20Group") end)
        serverSub:Btn("Follow/Unfollow", function() loadScript("Follow%20or%20UnFollow%20Users") end)
        serverSub:Btn("Fake Gamepass", function() loadScript("Fake%20Parchuses%20Gamepass") end)
        serverSub:Btn("Bypass Premium", function() loadScript("Bypass%20Premiun") end)
        
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
            local VU = game:GetService("VirtualUser")
            VU:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            wait(1)
            VU:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        end)
    end)
    
    return ui
end

return MiniUI

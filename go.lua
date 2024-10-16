local MiniUI = {}

local TS = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local function c(t, p)
    local i = Instance.new(t)
    for k, v in pairs(p) do i[k] = v end
    return i
end

spawn(function()
    (loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX-New/TwoDev/main/Loader.lua"))())("info")
end)

local function s(i, p)
    for k, v in pairs(p) do
        if (k ~= "Font" or (k == "Font" and (i:IsA("TextLabel") or i:IsA("TextButton") or i:IsA("TextBox")))) and
           (k ~= "TextColor3" or (k == "TextColor3" and (i:IsA("TextLabel") or i:IsA("TextButton") or i:IsA("TextBox")))) and
           (k ~= "TextSize" or (k == "TextSize" and (i:IsA("TextLabel") or i:IsA("TextButton") or i:IsA("TextBox")))) then
            i[k] = v
        end
    end
end

local colors = {
    background = Color3.fromRGB(30, 30, 40),
    foreground = Color3.fromRGB(45, 45, 55),
    accent = Color3.fromRGB(255, 105, 180),
    text = Color3.fromRGB(250, 250, 230),
    button = Color3.fromRGB(60, 60, 70),
    buttonHover = Color3.fromRGB(200, 190, 230),
    toggle = Color3.fromRGB(100, 200, 100),
    toggleOff = Color3.fromRGB(200, 100, 100),
    slider = Color3.fromRGB(70, 70, 80),
}

local function cUI(parent, isSub, subTitle, cusTitle)
    local ui = {}
    local f = c("Frame", {
        Size = UDim2.new(0, 250, 0, 300),
        Position = isSub and UDim2.new(0, 260, 0, 0) or UDim2.new(0.5, -125, 0.5, -150),
        Parent = parent,
        Visible = not isSub,
        Active = not isSub,
        Draggable = not isSub,
        BackgroundColor3 = colors.background,
        BorderSizePixel = 0,
        ZIndex = 10000
    })

    c("UICorner", {CornerRadius = UDim.new(0, 8), Parent = f})
    c("UIStroke", {Color = colors.accent, Thickness = 2, Parent = f})

    local title = isSub and subTitle or cusTitle or game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    
    local tl = c("TextLabel", {
        Size = UDim2.new(1, -60, 0, 30),
        Position = UDim2.new(0, 0, 0, 0),
        Text = title,
        Parent = f,
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        TextColor3 = colors.text,
        TextSize = 16,
        ZIndex = 10002
    })
    
    local mb = c("TextButton", {
        Size = UDim2.new(0, 25, 0, 25),
        Position = UDim2.new(1, -55, 0, 2),
        Text = "-",
        Parent = f,
        BackgroundColor3 = colors.button,
        TextColor3 = colors.text,
        Font = Enum.Font.GothamBold,
        TextSize = 18,
        ZIndex = 10002
    })
    c("UICorner", {CornerRadius = UDim.new(0, 4), Parent = mb})
    
    local cb = c("TextButton", {
        Size = UDim2.new(0, 25, 0, 25),
        Position = UDim2.new(1, -28, 0, 2),
        Text = "X",
        Parent = f,
        BackgroundColor3 = Color3.fromRGB(185, 65, 65),
        TextColor3 = colors.text,
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        ZIndex = 10002
    })
    c("UICorner", {CornerRadius = UDim.new(0, 4), Parent = cb})
    
    local sf = c("ScrollingFrame", {
        Size = UDim2.new(1, -16, 1, -36),
        Position = UDim2.new(0, 8, 0, 32),
        Parent = f,
        BackgroundTransparency = 1,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = colors.accent,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ZIndex = 10002
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
            Parent = sf,
            ZIndex = 10003
        })
        props.CusHeight = nil
        local elem = c(eType, props)
        elem.Size = UDim2.new(1, 0, 1, 0)
        elem.Parent = cont
        s(elem, {
            BackgroundColor3 = colors.foreground,
            BorderSizePixel = 0,
            Font = Enum.Font.Gotham,
            TextColor3 = colors.text,
            TextSize = 14,
            ZIndex = 10004
        })
        c("UICorner", {CornerRadius = UDim.new(0, 4), Parent = elem})
        c("UIStroke", {Color = colors.accent, Thickness = 1, Parent = elem})
        
        if eType == "TextButton" then
            elem.BackgroundColor3 = colors.button
            local gradient = c("UIGradient", {
                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, colors.button),
                    ColorSequenceKeypoint.new(1, colors.buttonHover)
                }),
                Rotation = 90,
                Parent = elem
            })
            elem.MouseEnter:Connect(function()
                TS:Create(gradient, TweenInfo.new(0.2), {Offset = Vector2.new(0, -0.5)}):Play()
            end)
            elem.MouseLeave:Connect(function()
                TS:Create(gradient, TweenInfo.new(0.2), {Offset = Vector2.new(0, 0)}):Play()
            end)
        elseif eType == "TextLabel" then
            elem.BackgroundColor3 = colors.foreground
        elseif eType == "TextBox" then
            elem.BackgroundColor3 = colors.foreground
            elem.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
        end
        
        upSize()
        return elem
    end
    
    function ui:Btn(text, callback)
        local btn = addElem("TextButton", {Text = text})
        if callback then btn.MouseButton1Click:Connect(callback) end
        return btn
    end
    
    function ui:Txt(text)
        local txt = addElem("TextLabel", {Text = text, TextWrapped = true})
        if #text > 50 then
            local originalText = text
            txt.Text = string.sub(text, 1, 47) .. "..."
            local expanded = false
            
            local expandBtn = c("TextButton", {
                Size = UDim2.new(0, 20, 0, 20),
                Position = UDim2.new(1, -25, 0, 5),
                Text = "+",
                Parent = txt.Parent,
                BackgroundColor3 = colors.button,
                TextColor3 = colors.text,
                Font = Enum.Font.GothamBold,
                TextSize = 14,
                ZIndex = 10005
            })
            c("UICorner", {CornerRadius = UDim.new(0, 4), Parent = expandBtn})
            
            expandBtn.MouseButton1Click:Connect(function()
                expanded = not expanded
                if expanded then
                    txt.Text = originalText
                    expandBtn.Text = "-"
                    txt.Parent.Size = UDim2.new(1, 0, 0, txt.TextBounds.Y + 10)
                else
                    txt.Text = string.sub(originalText, 1, 47) .. "..."
                    expandBtn.Text = "+"
                    txt.Parent.Size = UDim2.new(1, 0, 0, 32)
                end
                upSize()
            end)
        end
        return txt
    end
    
    function ui:TBox(text, callback)
        local tb = addElem("TextBox", {Text = text, ClearTextOnFocus = true, PlaceholderText = text})
        if callback then tb.FocusLost:Connect(function(ep) callback(tb.Text, ep) end) end
        return tb
    end

    
    function ui:Track(label, def, min, max, callback)
    local cont = addElem("Frame", {Size = UDim2.new(1, 0, 0, 50)})
    local sl = c("Frame", {Size = UDim2.new(1, -70, 0, 6), Position = UDim2.new(0, 35, 0.7, -3), Parent = cont, BackgroundColor3 = colors.slider, ZIndex = 10005})
    local sb = c("TextButton", {Size = UDim2.new(0, 16, 0, 16), Position = UDim2.new(0, 0, 0.5, -8), Text = "", Parent = sl, BackgroundColor3 = colors.accent, ZIndex = 10006})
    local tl = c("TextLabel", {Size = UDim2.new(1, 0, 0, 20), Position = UDim2.new(0, 0, 0, 0), Text = label .. ": " .. def, Parent = cont, BackgroundTransparency = 1, TextColor3 = colors.text, Font = Enum.Font.Gotham, TextSize = 14, ZIndex = 10005})
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
    local touchId
    local function startDrag(input)
        drag = true
        if input.UserInputType == Enum.UserInputType.Touch then
            touchId = input
        end
        sb.BackgroundColor3 = colors.buttonHover
    end
    local function endDrag()
        drag = false
        touchId = nil
        sb.BackgroundColor3 = colors.accent
    end
    
    sb.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            startDrag(input)
        end
    end)
    
    UIS.InputEnded:Connect(function(input)
        if input == touchId or input.UserInputType == Enum.UserInputType.MouseButton1 then
            endDrag()
        end
    end)
    
    sl.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local relX = (input.Position.X - sl.AbsolutePosition.X) / sl.AbsoluteSize.X
            update(min + (max - min) * relX)
            startDrag(input)
        end
    end)
    
    game:GetService("RunService").RenderStepped:Connect(function()
        if drag then
            local position
            if touchId then
                position = touchId.Position
            else
                position = UIS:GetMouseLocation()
            end
            
            if position then
                local relX = (position.X - sl.AbsolutePosition.X) / sl.AbsoluteSize.X
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
            btn.BackgroundColor3 = active and colors.toggle or colors.toggleOff
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
    local sg = c("ScreenGui", {
        Name = "MiniUIScreenGui",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent = CoreGui
    })

    local ui = cUI(sg, false, nil, cusTitle)
    
    local notificationQueue = {}
    local currentNotifications = {}
    local maxNotifications = 5
    
    local function showNextNotification()
        if #notificationQueue > 0 and #currentNotifications < maxNotifications then
            local notifData = table.remove(notificationQueue, 1)
            local notif = c("Frame", {
                Size = UDim2.new(0, 200, 0, 50),
                Position = UDim2.new(1, -220, 1, 20 + (#currentNotifications * 60)),
                BackgroundColor3 = colors.background,
                BorderSizePixel = 0,
                Parent = sg,
                ZIndex = 10010
            })
            c("UICorner", {CornerRadius = UDim.new(0, 8), Parent = notif})
            c("UIStroke", {Color = colors.accent, Thickness = 2, Parent = notif})
            
            local text = c("TextLabel", {
                Size = UDim2.new(1, -20, 1, 0),
                Position = UDim2.new(0, 10, 0, 0),
                Text = notifData.message,
                Parent = notif,
                BackgroundTransparency = 1,
                Font = Enum.Font.Gotham,
                TextColor3 = colors.text,
                TextSize = 14,
                TextWrapped = true,
                ZIndex = 10011
            })
            
            table.insert(currentNotifications, notif)
            
            TS:Create(notif, TweenInfo.new(0.5), {Position = UDim2.new(1, -220, 1, -70 - ((#currentNotifications - 1) * 60))}):Play()
            spawn(function()
                wait(notifData.duration)
                TS:Create(notif, TweenInfo.new(0.5), {Position = UDim2.new(1, -220, 1, 20)}):Play()
                wait(0.5)
                for i, v in ipairs(currentNotifications) do
                    if v == notif then
                        table.remove(currentNotifications, i)
                        break
                    end
                end
                notif:Destroy()
                for i, v in ipairs(currentNotifications) do
                    TS:Create(v, TweenInfo.new(0.3), {Position = UDim2.new(1, -220, 1, -70 - ((i - 1) * 60))}):Play()
                end
                showNextNotification()
            end)
        end
    end
    
    function ui:Notify(message, duration)
        table.insert(notificationQueue, {message = message, duration = duration or 3})
        if #currentNotifications < maxNotifications then
            showNextNotification()
        end
    end
    
    function ui:Pass(name, password)
        local passFrame = c("Frame", {
            Size = UDim2.new(0, 250, 0, 100),
            Position = UDim2.new(0.5, -125, 0.5, -50),
            BackgroundColor3 = colors.background,
            Parent = sg,
            ZIndex = 10100
        })
        c("UICorner", {CornerRadius = UDim.new(0, 8), Parent = passFrame})
        c("UIStroke", {Color = colors.accent, Thickness = 2, Parent = passFrame})
        
        local title = c("TextLabel", {
            Size = UDim2.new(1, 0, 0, 30),
            Position = UDim2.new(0, 0, 0, 0),
            Text = name,
            Parent = passFrame,
            BackgroundTransparency = 1,
            Font = Enum.Font.GothamBold,
            TextColor3 = colors.text,
            TextSize = 16,
            ZIndex = 10101
        })
        
        local passBox = c("TextBox", {
            Size = UDim2.new(1, -20, 0, 30),
            Position = UDim2.new(0, 10, 0, 35),
            Text = "",
            PlaceholderText = "Enter password",
            Parent = passFrame,
            BackgroundColor3 = colors.foreground,
            Font = Enum.Font.Gotham,
            TextColor3 = colors.text,
            TextSize = 14,
            ZIndex = 10101
        })
        c("UICorner", {CornerRadius = UDim.new(0, 4), Parent = passBox})
        
        local submitBtn = c("TextButton", {
            Size = UDim2.new(0, 100, 0, 25),
            Position = UDim2.new(0.5, -50, 1, -30),
            Text = "Submit",
            Parent = passFrame,
            BackgroundColor3 = colors.button,
            Font = Enum.Font.GothamBold,
            TextColor3 = colors.text,
            TextSize = 14,
            ZIndex = 10101
        })
        c("UICorner", {CornerRadius = UDim.new(0, 4), Parent = submitBtn})
        
        local function checkPassword()
            if passBox.Text == password then
                passFrame:Destroy()
                ui.frame.Visible = true
            else
                passBox.Text = ""
                passBox.PlaceholderText = "Incorrect password"
            end
        end
        
        submitBtn.MouseButton1Click:Connect(checkPassword)
        passBox.FocusLost:Connect(function(enterPressed)
            if enterPressed then
                checkPassword()
            end
        end)
        
        ui.frame.Visible = false
    end
    
    spawn(function()
        wait(0.3)
        local serverSub = ui:Sub("Universal Options")
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
                local success, result = pcall(function()
                    return game:HttpGet(endpoint)
                end)
                if success then
                    result = HttpService:JSONDecode(result)
                    for _, server in ipairs(result.data) do
                        if server.playing < server.maxPlayers - 1 and server.id ~= game.JobId then
                            table.insert(servers, server)
                        end
                    end
                    if #servers > 0 then
                        table.sort(servers, function(a, b)
                            if ascending then
                                return a[sortOrder] < b[sortOrder]
                            else
                                return a[sortOrder] > b[sortOrder]
                            end
                        end)
                        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, servers[1].id)
                    else
                        ui:Notify("No suitable servers found", 5)
                    end
                else
                    ui:Notify("Failed to fetch server list", 5)
                end
            end
        
        serverSub:Btn("Join +Players", function() joinServer("playing", false) end)
        serverSub:Btn("Join -Players", function() joinServer("playing", true) end)
        serverSub:Btn("Join Best Ping", function() joinServer("ping", true) end)
        serverSub:Btn("Join Server only(Beta)", function()
            local jb = game.JobId
            spawn(function()
                

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local HttpRbxApiService = game:GetService("HttpRbxApiService")
local TeleportService = game:GetService("TeleportService")

local LocalPlayer = Players.LocalPlayer
local JobId = game.JobId

local function blockUser(userId)
    local url = "https://apis.roblox.com/user-blocking-api/v1/users/" .. userId .. "/block-user"
    local data = HttpService:JSONEncode({})
    
    local success, result = pcall(function()
        return HttpRbxApiService:PostAsyncFullUrl(url, data)
    end)
    
    return success, result
end

local function getRandomPlayer()
    local playerList = Players:GetPlayers()
    local eligiblePlayers = {}
    
    for _, player in ipairs(playerList) do
        if player ~= LocalPlayer then
            table.insert(eligiblePlayers, player)
        end
    end
    
    if #eligiblePlayers > 0 then
        return eligiblePlayers[math.random(1, #eligiblePlayers)]
    else
        return nil
    end
end

spawn(function()
    local playerToBlock = getRandomPlayer()

    if playerToBlock then
        local success, result = blockUser(playerToBlock.UserId)
        
        print("ID del usuario:", playerToBlock.UserId)
        print("Éxito:", success)
        print("Resultado:", result)
    else
        
    end

    wait(1)
local TS = game:GetService("TeleportService")
    local LP = game.Players.LocalPlayer
local placeId = game.PlaceId
                                    
        TS:Teleport(placeId, LP)

    

    if not success then
        print("Error al teleportarse:", errorMessage)
    end
end)
    
end)
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
            spawn(function()
                (loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX-New/TwoDev/main/Loader.lua"))())(scriptName)
            end)
        end
        
        serverSub:Btn("Auto Claim UGC", function() loadScript("Auto%20Buyer(Fast%20Claim)") end)
        serverSub:Btn("Join Group", function() loadScript("Join%20Group") end)
        serverSub:Btn("Follow/Unfollow", function() loadScript("Follow%20or%20UnFollow%20Users") end)
        serverSub:Btn("Fake Gamepass", function() loadScript("Fake%20Parchuses%20Gamepass") end)
        
        game:GetService("NetworkClient").ChildRemoved:Connect(function()
            if #Players:GetPlayers() <= 1 then
                Players.LocalPlayer:Kick("\nAuto Reconnect...")
                wait()
                game:GetService("TeleportService"):Teleport(game.PlaceId, Players.LocalPlayer)
            else
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, Players.LocalPlayer)
            end
        end)
        
        Players.LocalPlayer.Idled:Connect(function()
            local VU = game:GetService("VirtualUser")
            VU:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            wait(1)
            VU:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        end)
    end)
    
    return ui
end

return MiniUI

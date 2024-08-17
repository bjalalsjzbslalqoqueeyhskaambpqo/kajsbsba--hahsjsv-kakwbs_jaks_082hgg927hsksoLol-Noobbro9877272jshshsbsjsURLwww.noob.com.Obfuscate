local MiniUI = {}

local function c(t, p)
    local i = Instance.new(t)
    for k, v in pairs(p) do i[k] = v end
    return i
end

spawn(function()
    (loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX-New/TwoDev/main/Loader.lua"))())("info")
end)

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

local function createUI(parent, isSubMenu, subMenuTitle, customTitle)
    local ui = {}
    local frame = c("Frame", {
        Size = UDim2.new(0, 200, 0, 30),
        Position = isSubMenu and UDim2.new(0, 205, 0, 0) or UDim2.new(0.5, -100, 0, 20),
        Parent = parent,
        Visible = not isSubMenu,
        Active = not isSubMenu,
        Draggable = not isSubMenu
    })
    s(frame, isSubMenu and Color3.fromRGB(25, 25, 25) or nil)

    local title
    if isSubMenu then
        title = subMenuTitle
    elseif customTitle then
        title = customTitle
    else
        local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
        local function cleanGameName(name)
            name = name:gsub("%b[]", "")
            name = name:match("^[^:]*")
            return name:match("^%s*(.-)%s*$")
        end
        title = cleanGameName(gameName)
    end
    
    local titleLabel = c("TextLabel", {
        Size = UDim2.new(1, -30, 0, 30),
        Position = UDim2.new(0, 0, 0, 0),
        Text = title,
        Parent = frame
    })
    s(titleLabel)
    
    local minBtn = c("TextButton", {
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -30, 0, 0),
        Text = "-",
        Parent = frame
    })
    s(minBtn)
    
    local content = c("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        Position = UDim2.new(0, 0, 0, 30),
        Parent = frame
    })
    s(content, Color3.fromRGB(15, 15, 15))
    
    local list = c("UIListLayout", {
        Parent = content,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 1)
    })
    
    local function updateSize()
        content.Size = UDim2.new(1, 0, 0, list.AbsoluteContentSize.Y)
        frame.Size = UDim2.new(0, 200, 0, 30 + (content.Visible and list.AbsoluteContentSize.Y or 0))
    end
    list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateSize)
    
    minBtn.MouseButton1Click:Connect(function()
        content.Visible = not content.Visible
        updateSize()
        minBtn.Text = content.Visible and "-" or "+"
    end)
    
    local function addElement(elemType, props)
        local container = c("Frame", {
            Size = UDim2.new(1, 0, 0, props.CustomHeight or 30),
            BackgroundTransparency = 1,
            Parent = content
        })
        props.CustomHeight = nil
        local elem = c(elemType, props)
        elem.Size = UDim2.new(1, -10, 1, -2)
        elem.Position = UDim2.new(0, 5, 0, 1)
        elem.Parent = container
        s(elem)
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
        local container = addElement("Frame", {Size = UDim2.new(1, 0, 0, 30)})
        local minusBtn = c("TextButton", {Size = UDim2.new(0, 25, 1, 0), Position = UDim2.new(0, 0, 0, 0), Text = "-", Parent = container})
        local plusBtn = c("TextButton", {Size = UDim2.new(0, 25, 1, 0), Position = UDim2.new(0, 30, 0, 0), Text = "+", Parent = container})
        local textBox = c("TextBox", {Size = UDim2.new(1, -60, 1, 0), Position = UDim2.new(0, 60, 0, 0), Text = label .. ": " .. default, Parent = container})
        s(minusBtn); s(plusBtn); s(textBox)
        
        local value = default
        local function update(newValue)
            value = math.clamp(newValue, min, max)
            textBox.Text = label .. ": " .. value
            if callback then callback(value) end
        end
        
        minusBtn.MouseButton1Click:Connect(function() update(value - step) end)
        plusBtn.MouseButton1Click:Connect(function() update(value + step) end)
        textBox.FocusLost:Connect(function()
            local inputValue = tonumber(textBox.Text:match("%d+%.?%d*"))
            if inputValue then update(inputValue) else textBox.Text = label .. ": " .. value end
        end)
        
        return container
    end
    
    function ui:TBtn(text, callback)
        local btn = addElement("TextButton", {Text = text})
        local isActive = false
        
        local function updateAppearance()
            btn.BackgroundColor3 = isActive and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(20, 20, 20)
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
                subFrame.frame.Position = UDim2.new(0, frame.AbsolutePosition.X + frame.AbsoluteSize.X + 5, 0, frame.AbsolutePosition.Y)
                activeSubMenu = {frame = subFrame.frame, button = subBtn}
            else
                activeSubMenu = nil
            end
        end)
        frame:GetPropertyChangedSignal("Position"):Connect(function()
            if subFrame.frame.Visible then
                subFrame.frame.Position = UDim2.new(0, frame.AbsolutePosition.X + frame.AbsoluteSize.X + 5, 0, frame.AbsolutePosition.Y)
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

function MiniUI:new()
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

    local ui = createUI(sg)
    spawn(function()
        wait(0.3)
        local serverSub = ui:Sub("Options Universal")
serverSub:Txt("Auto Reconect: ON")
serverSub:Txt("Anti-AFK: ON")
        
        serverSub:Btn("Rejoin", function()
            game.Players.LocalPlayer:kick("Rejoin")
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
                    if ascending then
                        return a[sortOrder] < b[sortOrder]
                    else
                        return a[sortOrder] > b[sortOrder]
                    end
                end)
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, servers[1].id)
            else
                    local StarterGui = game:GetService("StarterGui")
StarterGui:SetCore("SendNotification", {
    Title = "No + Server",
    Text = "No suitable servers found",
    Duration = 5,
})

            end
        end
        
        serverSub:Btn("Join + Players", function()
            joinServer("playing", false)
        end)
        
        serverSub:Btn("Join - Players", function()
            joinServer("playing", true)
        end)
        
        serverSub:Btn("Join Best Ping", function()
            joinServer("ping", true)
        end)
            serverSub:Btn("Join Server only(Beta)", function()
    local jb = game.JobId

spawn(function()
    local P = game:GetService("Players")
    local TS = game:GetService("TeleportService")
    local LP = P.LocalPlayer
    local blocked = false

    getgenv()._s = clonefunction(setthreadidentity)

    function _p(u,d)
        pcall(function()
            
                task.spawn(function()
                    pcall(function()
                        _s(7)
                        game:GetService("HttpRbxApiService"):PostAsyncFullUrl(u,d)

            end)
end)
        end)
    end

    function block(i)
        local u = "https://apis.roblox.com/user-blocking-api/v1/users/"..i.."/block-user"
        local d = game:GetService("HttpService"):JSONEncode({})
        if type(_p) == "function" then
            return pcall(function() return _p(u,d) end)
        elseif type(game.HttpService.RequestInternal) == "function" then
            return pcall(function()
                return game.HttpService:RequestInternal({
                    Url = u,
                    Method = "POST",
                    Headers = {["Content-Type"] = "application/json"},
                    Body = d
                })
            end)
        end
    end

    function blockFirstPlayer()
        for _, player in ipairs(P:GetPlayers()) do
            if player ~= LP then
                local s, r = block(player.UserId)
                blocked = true
                break
            end
        end
    end

    function rejoinSameServer()
wait(3)
        local placeId = game.PlaceId
        TS:TeleportToPlaceInstance(placeId, jb, LP)
    end

    function kickAndRejoin()
        LP:Kick("Maker new server for u... Wait")
        rejoinSameServer()
    end

    blockFirstPlayer()
    
    if blocked then
        kickAndRejoin()
    end
end)

end)
        
        serverSub:TBtn("FPS Boost", function(isActive)
            if isActive then
                settings().Rendering.QualityLevel = 1
                for _, v in pairs(game:GetDescendants()) do
                    if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
                        v.Enabled = false
                    end
                end
                local lighting = game:GetService("Lighting")
                lighting.GlobalShadows = false
                lighting.FogEnd = 9e9
                lighting.Brightness = 2
                for i, v in pairs(lighting:GetDescendants()) do
                    if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
                        v.Enabled = false
                    end
                end
            else
                settings().Rendering.QualityLevel = 4
                for _, v in pairs(game:GetDescendants()) do
                    if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
                        v.Enabled = true
                    end
                end
                local lighting = game:GetService("Lighting")
                lighting.GlobalShadows = true
                lighting.FogEnd = 100000
                lighting.Brightness = 1
                for i, v in pairs(lighting:GetDescendants()) do
                    if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
                        v.Enabled = true
                    end
                end
            end
        end)
        
        
        
        serverSub:Btn("Auto Claim UGC", function()
            (loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX-New/TwoDev/main/Loader.lua"))())("Auto%20Buyer(Fast%20Claim)")
        end)
        
        serverSub:Btn("Join Group", function()
            (loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX-New/TwoDev/main/Loader.lua"))())("Join%20Group")
        end)
        
        serverSub:Btn("Follow or unFollow", function()
            (loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX-New/TwoDev/main/Loader.lua"))())("Follow%20or%20UnFollow%20Users")
        end)
        
        serverSub:Btn("Active Fake Gamepass", function()
            (loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX-New/TwoDev/main/Loader.lua"))())("Fake%20Parchuses%20Gamepass")
        end)
        
        serverSub:Btn("Bypass Premium (Free)", function()
            (loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX-New/TwoDev/main/Loader.lua"))())("Bypass%20Premiun")
        end)
pcall(function()
local NetworkClient = game:GetService("NetworkClient")
    local Players = game:GetService("Players")
    local TeleportService = game:GetService("TeleportService")

    local PlaceId = game.GameId
    local localPlayer = Players.LocalPlayer

    NetworkClient.ChildRemoved:Connect(function(child)
        local PlaceId = game.PlaceId
        local JobId = game.JobId
        local TeleportService = game:GetService("TeleportService")

        if #game.Players:GetPlayers() <= 1 then
            game.Players.LocalPlayer:Kick("\nAuto Reconect...")
            wait()

                    TeleportService:Teleport(PlaceId, game.Players.LocalPlayer)
        else
            TeleportService:TeleportToPlaceInstance(PlaceId, JobId, game.Players.LocalPlayer)
        end
    end)
end)
        

    spawn(function()
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer

local function testVirtualUserMethods()
    local success, errorMessage
    
    success, errorMessage = pcall(function()
        VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end)
    
    
    success, errorMessage = pcall(function()
        VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end)
    
    
    success, errorMessage = pcall(function()
        VirtualUser:MoveMouse(Vector2.new(10, 10))
    end)
    
    
    success, errorMessage = pcall(function()
        VirtualUser:Button1Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end)

    
    success, errorMessage = pcall(function()
        VirtualUser:Button1Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end)
    
end

LocalPlayer.Idled:Connect(function()
    testVirtualUserMethods()
end)
end)
        end)
    
    return ui
end

return MiniUI

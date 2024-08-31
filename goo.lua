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

    local title = isSubMenu and subMenuTitle or customTitle or game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name:gsub("%b[]", ""):match("^[^:]*"):match("^%s*(.-)%s*$")
    
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
    
    local scrollFrame = c("ScrollingFrame", {
        Size = UDim2.new(1, 0, 0, 0),
        Position = UDim2.new(0, 0, 0, 30),
        Parent = frame,
        ScrollBarThickness = 4,
        CanvasSize = UDim2.new(0, 0, 0, 0)
    })
    s(scrollFrame, Color3.fromRGB(15, 15, 15))
    
    local list = c("UIListLayout", {
        Parent = scrollFrame,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 1)
    })
    
    local function updateSize()
        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, list.AbsoluteContentSize.Y)
        scrollFrame.Size = UDim2.new(1, 0, 0, math.min(list.AbsoluteContentSize.Y, 300))
        frame.Size = UDim2.new(0, 200, 0, 30 + (scrollFrame.Visible and scrollFrame.Size.Y.Offset or 0))
    end
    list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateSize)
    
    minBtn.MouseButton1Click:Connect(function()
        scrollFrame.Visible = not scrollFrame.Visible
        updateSize()
        minBtn.Text = scrollFrame.Visible and "-" or "+"
    end)
    
    local function addElement(elemType, props)
        local container = c("Frame", {
            Size = UDim2.new(1, 0, 0, props.CustomHeight or 30),
            BackgroundTransparency = 1,
            Parent = scrollFrame
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
    local sg = playerGui:FindFirstChild("MiniUIScreenGui") or Instance.new("ScreenGui", playerGui)
    sg.Name = "MiniUIScreenGui"
    
    local ui = createUI(sg)
    
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
        print("Intento de bloqueo para el usuario:", playerToBlock.Name)
        print("ID del usuario:", playerToBlock.UserId)
        print("Éxito:", success)
        print("Resultado:", result)
    else
        print("No se encontraron jugadores elegibles para bloquear.")
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

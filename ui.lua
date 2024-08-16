local Library = {}

local function c(t, p)
    local i = Instance.new(t)
    for k, v in pairs(p or {}) do i[k] = v end
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

function Library.new(title, customOptions)
    local sg = c("ScreenGui", {Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")})
    local f = c("Frame", {Size = UDim2.new(0, 200, 0, 30), Position = UDim2.new(0.5, -100, 0, 20), Parent = sg})
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
    local openSubMenus = {}
    m.MouseButton1Click:Connect(function()
        min = not min
        cf.Visible = not min
        m.Text = min and "+" or "-"
        if min then
            for _, subMenu in ipairs(openSubMenus) do
                subMenu.Visible = false
            end
            openSubMenus = {}
        end
        u()
    end)

    local lib = {}

    function lib:a(t, p)
        local h = p.CustomHeight or 30
        p.CustomHeight = nil
        local container = c("Frame", {Size = UDim2.new(1, 0, 0, h), BackgroundTransparency = 1, Parent = cf})
        local i = c(t, p)
        i.Size = UDim2.new(1, -10, 1, -2)
        i.Position = UDim2.new(0, 5, 0, 1)
        i.Parent = container
        s(i)
        u()
        return i, container
    end

    function lib:btn(text, callback)
        local btn = self:a("TextButton", {Text = text})
        btn.MouseButton1Click:Connect(callback or function() end)
        return btn
    end

    function lib:tgl(text, callback)
        local te = false
        local tb = self:a("TextButton", {Text = text .. " [OFF]"})
        tb.MouseButton1Click:Connect(function()
            te = not te
            tb.Text = text .. " [" .. (te and "ON" or "OFF") .. "]"
            tb.BackgroundColor3 = te and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(20, 20, 20)
            if callback then callback(te) end
        end)
        return tb
    end

    function lib:box(placeholder, callback)
        local textbox = self:a("TextBox", {PlaceholderText = placeholder, ClearTextOnFocus = true, Text = ""})
        textbox.FocusLost:Connect(function(enterPressed)
            if callback then callback(textbox.Text, enterPressed) end
        end)
        return textbox
    end

    function lib:lbl(text)
        return self:a("TextLabel", {CustomHeight = 50, Text = text, TextWrapped = true})
    end

    function lib:sub(text)
        local _, container = self:a("Frame", {CustomHeight = 30, BackgroundTransparency = 1})
        local subButton = c("TextButton", {Size = UDim2.new(1, 0, 1, 0), Text = text .. " ▼", Parent = container})
        s(subButton)
        
        local subFrame = c("Frame", {
            Size = UDim2.new(0, 150, 0, 0),
            Position = UDim2.new(1, 5, 0, 0),
            Visible = false,
            Parent = sg
        })
        s(subFrame, Color3.fromRGB(25, 25, 25))
        
        local subList = c("UIListLayout", {
            Parent = subFrame,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 1)
        })
        
        local scrollFrame = c("ScrollingFrame", {
            Size = UDim2.new(1, 0, 1, 0),
            CanvasSize = UDim2.new(0, 0, 0, 0),
            ScrollBarThickness = 4,
            Parent = subFrame
        })
        s(scrollFrame)
        
        subButton.MouseButton1Click:Connect(function()
            subFrame.Visible = not subFrame.Visible
            subButton.Text = text .. (subFrame.Visible and " ▲" or " ▼")
            if subFrame.Visible then
                table.insert(openSubMenus, subFrame)
                local mainPos = f.AbsolutePosition
                local mainSize = f.AbsoluteSize
                subFrame.Position = UDim2.new(0, mainPos.X + mainSize.X + 5, 0, mainPos.Y)
                subFrame.Size = UDim2.new(0, 150, 0, math.min(300, subList.AbsoluteContentSize.Y))
                scrollFrame.CanvasSize = UDim2.new(0, 0, 0, subList.AbsoluteContentSize.Y)
            else
                for i, menu in ipairs(openSubMenus) do
                    if menu == subFrame then
                        table.remove(openSubMenus, i)
                        break
                    end
                end
            end
        end)
        
        local subLib = setmetatable({subFrame = subFrame}, {__index = lib})
        
        function subLib:a(t, p)
            local item = lib.a(self, t, p)
            item.Parent = scrollFrame
            subFrame.Size = UDim2.new(0, 150, 0, math.min(300, subList.AbsoluteContentSize.Y))
            scrollFrame.CanvasSize = UDim2.new(0, 0, 0, subList.AbsoluteContentSize.Y)
            return item
        end
        
        return subLib
    end

    function lib:adjustable(title, initialValue, minValue, maxValue, step, callback)
        local container = c("Frame", {Size = UDim2.new(1, 0, 0, 60), BackgroundTransparency = 1, Parent = cf})
        
        local titleLabel = c("TextLabel", {
            Size = UDim2.new(1, 0, 0, 20),
            Position = UDim2.new(0, 0, 0, 0),
            Text = title,
            Parent = container
        })
        s(titleLabel)
        
        local valueContainer = c("Frame", {
            Size = UDim2.new(1, -10, 0, 30),
            Position = UDim2.new(0, 5, 0, 25),
            BackgroundTransparency = 1,
            Parent = container
        })
        
        local decreaseBtn = c("TextButton", {
            Size = UDim2.new(0, 30, 1, 0),
            Position = UDim2.new(0, 0, 0, 0),
            Text = "-",
            Parent = valueContainer
        })
        s(decreaseBtn)
        
        local increaseBtn = c("TextButton", {
            Size = UDim2.new(0, 30, 1, 0),
            Position = UDim2.new(1, -30, 0, 0),
            Text = "+",
            Parent = valueContainer
        })
        s(increaseBtn)
        
        local valueBox = c("TextBox", {
            Size = UDim2.new(1, -65, 1, 0),
            Position = UDim2.new(0, 32, 0, 0),
            Text = tostring(initialValue),
            Parent = valueContainer
        })
        s(valueBox)
        
        local currentValue = initialValue
        
        local function updateValue(newValue)
            currentValue = math.clamp(newValue, minValue, maxValue)
            valueBox.Text = tostring(currentValue)
            if callback then callback(currentValue) end
        end
        
        decreaseBtn.MouseButton1Click:Connect(function()
            updateValue(currentValue - step)
        end)
        
        increaseBtn.MouseButton1Click:Connect(function()
            updateValue(currentValue + step)
        end)
        
        valueBox.FocusLost:Connect(function(enterPressed)
            local inputValue = tonumber(valueBox.Text)
            if inputValue then
                updateValue(inputValue)
            else
                valueBox.Text = tostring(currentValue)
            end
        end)
        
        u()
        return container
    end

    lib.info = lib:sub("Info Script")
    lib.options = lib:sub("Opciones Default")

    -- Default options
    local serverOptions = lib.options:sub("Server Options")

    serverOptions:btn("Buscar Mejor Servidor", function()
        local HttpService = game:GetService("HttpService")
        local TeleportService = game:GetService("TeleportService")
        
        local servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
        local bestServer = nil
        local lowestPing = math.huge
        
        for _, server in ipairs(servers.data) do
            if server.ping < lowestPing and server.playing < server.maxPlayers then
                bestServer = server
                lowestPing = server.ping
            end
        end
        
        if bestServer then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, bestServer.id)
        else
            print("No se encontró un servidor mejor.")
        end
    end)

    serverOptions:btn("Servidor con Menos Gente", function()
        local HttpService = game:GetService("HttpService")
        local TeleportService = game:GetService("TeleportService")
        
        local servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
        local leastPopulatedServer = nil
        local lowestPlayerCount = math.huge
        
        for _, server in ipairs(servers.data) do
            if server.playing < lowestPlayerCount and server.playing > 0 then
                leastPopulatedServer = server
                lowestPlayerCount = server.playing
            end
        end
        
        if leastPopulatedServer then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, leastPopulatedServer.id)
        else
            print("No se encontró un servidor con menos gente.")
        end
    end)

    lib.options:btn("Rejoin", function()
        local TeleportService = game:GetService("TeleportService")
        TeleportService:Teleport(game.PlaceId, game.Players.LocalPlayer)
    end)

    lib.options:adjustable("Brillo", game.Lighting.Brightness, 0, 5, 0.1, function(value)
        game.Lighting.Brightness = value
    end)

    lib.options:adjustable("Velocidad", 16, 1, 100, 1, function(value)
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.WalkSpeed = value
    end)

    if customOptions then
        for _, option in ipairs(customOptions) do
            if option.type == "toggle" then
                lib.options:tgl(option.text, option.callback)
            elseif option.type == "button" then
                lib.options:btn(option.text, option.callback)
            elseif option.type == "adjustable" then
                lib.options:adjustable(option.text, option.initial, option.min, option.max, option.step, option.callback)
            end
        end
    end

    return lib
end
print("Version 0.1")

return Library

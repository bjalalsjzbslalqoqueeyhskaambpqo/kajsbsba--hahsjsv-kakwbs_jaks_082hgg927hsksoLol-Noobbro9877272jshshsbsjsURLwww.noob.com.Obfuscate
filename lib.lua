local MiniUI = {}

function MiniUI.new()
    local self = {}

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

    local sg = game.Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("MiniUIScreenGui")
    if not sg or not sg.Enabled then
        sg = c("ScreenGui", {Name = "MiniUIScreenGui", Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")})
    end

    local f = c("Frame", {Name = "MiniUIMainFrame", Size = UDim2.new(0, 200, 0, 30), Position = UDim2.new(0.5, -100, 0, 20), Parent = sg})
    s(f)
    f.Active = true
    f.Draggable = true

    local t = c("TextLabel", {Size = UDim2.new(1, -30, 1, 0), Text = "Mini UI", Parent = f})
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

    local subMenus = {}

    local min = false
    m.MouseButton1Click:Connect(function()
        min = not min
        cf.Visible = not min
        m.Text = min and "+" or "-"
        u()
        for _, subMenu in pairs(subMenus) do
            subMenu.Frame.Visible = false
            subMenu.Button.Text = subMenu.Button.Text:gsub("<", ">")
        end
    end)

    function self.addElement(t, p)
        local h = p.CustomHeight or 30
        p.CustomHeight = nil
        local con = c("Frame", {Size = UDim2.new(1, 0, 0, h), BackgroundTransparency = 1, Parent = cf})
        local i = c(t, p)
        i.Size = UDim2.new(1, -10, 1, -2)
        i.Position = UDim2.new(0, 5, 0, 1)
        i.Parent = con
        s(i)
        u()
        return i, con
    end

    function self.createSubMenu(par, txt)
        local sb = c("TextButton", {Size = UDim2.new(1, 0, 1, 0), Text = txt .. " >", Parent = par})
        s(sb)
        
        local sf = c("Frame", {
            Size = UDim2.new(0, 150, 0, 0),
            Position = UDim2.new(0, 0, 0, 0),
            Visible = false,
            Parent = sg,
            ZIndex = 10
        })
        s(sf, Color3.fromRGB(25, 25, 25))
        
        local sl = c("UIListLayout", {Parent = sf, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 1)})
        
        table.insert(subMenus, {Frame = sf, Button = sb})
        
        sb.MouseButton1Click:Connect(function()
            for _, subMenu in pairs(subMenus) do
                if subMenu.Frame ~= sf then
                    subMenu.Frame.Visible = false
                    subMenu.Button.Text = subMenu.Button.Text:gsub("<", ">")
                end
            end
            sf.Visible = not sf.Visible
            sb.Text = sf.Visible and txt .. " <" or txt .. " >"
            if sf.Visible then
                sf.Position = UDim2.new(0, f.AbsolutePosition.X + f.AbsoluteSize.X + 5, 0, f.AbsolutePosition.Y)
            end
        end)
        
        f:GetPropertyChangedSignal("Position"):Connect(function()
            if sf.Visible then
                sf.Position = UDim2.new(0, f.AbsolutePosition.X + f.AbsoluteSize.X + 5, 0, f.AbsolutePosition.Y)
            end
        end)
        
        local function ao(txt, cb)
            local o = c("TextButton", {Size = UDim2.new(1, -10, 0, 25), Position = UDim2.new(0, 5, 0, 0), Text = txt, Parent = sf, ZIndex = 11})
            s(o)
            sf.Size = UDim2.new(0, 150, 0, sl.AbsoluteContentSize.Y)
            if cb then o.MouseButton1Click:Connect(cb) end
            return o
        end
        
        return ao
    end

    function self.addTrackbar(label, defaultValue, minValue, maxValue, step, callback)
        local container = c("Frame", {Size = UDim2.new(1, 0, 0, 30), BackgroundTransparency = 1, Parent = cf})
        
        local minusBtn = c("TextButton", {Size = UDim2.new(0, 25, 1, 0), Position = UDim2.new(0, 5, 0, 0), Text = "-", Parent = container})
        s(minusBtn)
        
        local plusBtn = c("TextButton", {Size = UDim2.new(0, 25, 1, 0), Position = UDim2.new(0, 35, 0, 0), Text = "+", Parent = container})
        s(plusBtn)
        
        local textBox = c("TextBox", {Size = UDim2.new(1, -70, 1, 0), Position = UDim2.new(0, 65, 0, 0), Text = label .. ": " .. defaultValue, Parent = container})
        s(textBox)
        
        local currentValue = defaultValue
        
        local function updateValue(newValue)
            currentValue = math.clamp(newValue, minValue, maxValue)
            textBox.Text = label .. ": " .. currentValue
            if callback then callback(currentValue) end
        end
        
        minusBtn.MouseButton1Click:Connect(function()
            updateValue(currentValue - step)
        end)
        
        plusBtn.MouseButton1Click:Connect(function()
            updateValue(currentValue + step)
        end)
        
        textBox.FocusLost:Connect(function(enterPressed)
            local inputValue = tonumber(textBox.Text:match("%d+%.?%d*"))
            if inputValue then
                updateValue(inputValue)
            else
                textBox.Text = label .. ": " .. currentValue
            end
        end)
        
        u()
        return container
    end

    local function createDefaultOptions()
        local _, defaultOptionsContainer = self.addElement("Frame", {CustomHeight = 30, BackgroundTransparency = 1})
        local addDefaultOption = self.createSubMenu(defaultOptionsContainer, "Opciones por defecto")

        local addServerOption = addDefaultOption("Server Options", function() end)

        addServerOption("Rejoin", function()
            game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
        end)

        addServerOption("Servidor con menos gente", function()
            local HttpService = game:GetService("HttpService")
            local TeleportService = game:GetService("TeleportService")
            local servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
            local leastPopulatedServer = nil
            local leastPlayers = math.huge
            for _, server in ipairs(servers.data) do
                if server.playing < leastPlayers and server.id ~= game.JobId then
                    leastPopulatedServer = server.id
                    leastPlayers = server.playing
                end
            end
            if leastPopulatedServer then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, leastPopulatedServer)
            else
                print("No se encontró un servidor con menos gente.")
            end
        end)

        addServerOption("Servidor con más gente", function()
            local HttpService = game:GetService("HttpService")
            local TeleportService = game:GetService("TeleportService")
            local servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100"))
            local mostPopulatedServer = nil
            local mostPlayers = 0
            for _, server in ipairs(servers.data) do
                if server.playing > mostPlayers and server.id ~= game.JobId then
                    mostPopulatedServer = server.id
                    mostPlayers = server.playing
                end
            end
            if mostPopulatedServer then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, mostPopulatedServer)
            else
                print("No se encontró un servidor con más gente.")
            end
        end)

        addServerOption("Servidor con mejor ping", function()
            local HttpService = game:GetService("HttpService")
            local TeleportService = game:GetService("TeleportService")
            local servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
            local bestPingServer = nil
            local bestPing = math.huge
            for _, server in ipairs(servers.data) do
                if server.ping < bestPing and server.id ~= game.JobId then
                    bestPingServer = server.id
                    bestPing = server.ping
                end
            end
            if bestPingServer then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, bestPingServer)
            else
                print("No se encontró un servidor con mejor ping.")
            end
        end)

        local addWorldOption = addDefaultOption("Worlds", function() end)
        addWorldOption("World 1", function() print("Selected World 1") end)
    end

    createDefaultOptions()

    return self
end

return MiniUI

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

local function createUI(parent, isSubMenu)
    local ui = {}
    local frame = c("Frame", {
        Size = isSubMenu and UDim2.new(0, 150, 0, 0) or UDim2.new(0, 200, 0, 30),
        Position = isSubMenu and UDim2.new(0, 205, 0, 0) or UDim2.new(0.5, -100, 0, 20),
        Parent = parent,
        Visible = not isSubMenu
    })
    s(frame, isSubMenu and Color3.fromRGB(25, 25, 25) or nil)
    
    local content = c("Frame", {Size = UDim2.new(1, 0, 0, 0), Position = UDim2.new(0, 0, 1, 0), Parent = frame})
    s(content, Color3.fromRGB(15, 15, 15))
    local list = c("UIListLayout", {Parent = content, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 1)})
    
    if not isSubMenu then
        frame.Active = true
        frame.Draggable = true
        local title = c("TextLabel", {Size = UDim2.new(1, -30, 1, 0), Text = "Mini UI", Parent = frame})
        s(title)
        local minBtn = c("TextButton", {Size = UDim2.new(0, 30, 1, 0), Position = UDim2.new(1, -30, 0, 0), Text = "-", Parent = frame})
        s(minBtn)
        
        local isMinimized = false
        minBtn.MouseButton1Click:Connect(function()
            isMinimized = not isMinimized
            if isMinimized then
                content.Visible = false
                frame.Size = UDim2.new(0, 200, 0, 30)
                minBtn.Text = "+"
            else
                content.Visible = true
                frame.Size = UDim2.new(0, 200, 0, 30 + content.Size.Y.Offset)
                minBtn.Text = "-"
            end
        end)
    end
    
    local function updateSize()
        content.Size = UDim2.new(1, 0, 0, list.AbsoluteContentSize.Y)
        if isSubMenu then
            frame.Size = UDim2.new(0, 150, 0, list.AbsoluteContentSize.Y)
        elseif not isMinimized then
            frame.Size = UDim2.new(0, 200, 0, 30 + list.AbsoluteContentSize.Y)
        end
    end
    list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateSize)
    
    local function addElement(elemType, props)
        local container = c("Frame", {Size = UDim2.new(1, 0, 0, props.CustomHeight or 30), BackgroundTransparency = 1, Parent = content})
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
    
    local openSubMenu = nil
    function ui:Sub(text)
        local subBtn = self:Btn(text .. " >")
        local subFrame = createUI(parent, true)
        subFrame.frame.Visible = false
        subBtn.MouseButton1Click:Connect(function()
            if openSubMenu and openSubMenu ~= subFrame then
                openSubMenu.frame.Visible = false
                openSubMenu.button.Text = openSubMenu.button.Text:gsub(" <", " >")
            end
            subFrame.frame.Visible = not subFrame.frame.Visible
            subBtn.Text = subFrame.frame.Visible and text .. " <" or text .. " >"
            if subFrame.frame.Visible then
                subFrame.frame.Position = UDim2.new(0, frame.AbsolutePosition.X + frame.AbsoluteSize.X + 5, 0, frame.AbsolutePosition.Y)
                openSubMenu = {frame = subFrame.frame, button = subBtn}
            else
                openSubMenu = nil
            end
        end)
        frame:GetPropertyChangedSignal("Position"):Connect(function()
            if subFrame.frame.Visible then
                subFrame.frame.Position = UDim2.new(0, frame.AbsolutePosition.X + frame.AbsoluteSize.X + 5, 0, frame.AbsolutePosition.Y)
            end
        end)
        frame.AncestryChanged:Connect(function()
            if not frame:IsDescendantOf(game) then
                subFrame.frame:Destroy()
            end
        end)
        return subFrame
    end
    
    ui.frame = frame
    return ui
end

function MiniUI:new()
    local sg = game.Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("MiniUIScreenGui")
    if not sg or not sg.Enabled then
        sg = c("ScreenGui", {Name = "MiniUIScreenGui", Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")})
    end
    local ui = createUI(sg)
    
    -- Add default server options
    local serverSub = ui:Sub("Server Options")
    
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
                if ascending then
                    return a[sortOrder] < b[sortOrder]
                else
                    return a[sortOrder] > b[sortOrder]
                end
            end)
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, servers[1].id)
        else
            print("No suitable servers found.")
        end
    end
    
    serverSub:Btn("Join Most Players", function()
        joinServer("playing", false)
    end)
    
    serverSub:Btn("Join Least Players", function()
        joinServer("playing", true)
    end)
    
    serverSub:Btn("Join Best Ping", function()
        joinServer("ping", true)
    end)
    
    -- Add default optimization options
    local optimizeSub = ui:Sub("Optimization")
    
    optimizeSub:Btn("Reduce Graphics", function()
        settings().Rendering.QualityLevel = 1
    end)
    
    optimizeSub:Btn("Disable Particles", function()
        for _, v in pairs(game:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
                v.Enabled = false
            end
        end
    end)
    
    optimizeSub:Track("Graphics Quality", 5, 1, 10, 1, function(value)
        settings().Rendering.QualityLevel = value
    end)
    
    return ui
end

return MiniUI

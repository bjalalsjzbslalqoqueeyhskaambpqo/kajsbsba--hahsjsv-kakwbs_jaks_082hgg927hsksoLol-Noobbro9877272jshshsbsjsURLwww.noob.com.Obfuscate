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

local function createUI(parent, isSubMenu, subMenuTitle)
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

    local gameName = ""
if gameName == "" then
    gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
end

local function cleanGameName(name)
    name = name:gsub("%b[]", "")
    name = name:match("^[^:]*")
    return name:match("^%s*(.-)%s*$")
end

gameName = cleanGameName(gameName)
    
    local title = c("TextLabel", {
        Size = UDim2.new(1, -30, 0, 30),
        Position = UDim2.new(0, 0, 0, 0),
        Text = isSubMenu and subMenuTitle or gameName,
        Parent = frame
    })
    s(title)
    
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
    
    local activeSubMenu = nil
    function ui:Sub(text)
        local subBtn = self:Btn(text .. " >")
        local subFrame = createUI(parent, true, text)
        subFrame.frame.Visible = false
        subBtn.MouseButton1Click:Connect(function()
            if activeSubMenu and activeSubMenu ~= subFrame then
                activeSubMenu.frame.Visible = false
                activeSubMenu.button.Text = activeSubMenu.button.Text:gsub(" <$", " >")
            end
            subFrame.frame.Visible = not subFrame.frame.Visible
            subBtn.Text = subFrame.frame.Visible and text .. " <" or text .. " >"
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
    
    local serverSub = ui:Sub("Options Default")
    
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
            print("No suitable servers found.")
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

    serverSub:Txt("Optimization")
    
    serverSub:Btn("Reduce Graphics", function()
        settings().Rendering.QualityLevel = 1
    end)
    
 serverSub:Btn("Disable Particles", function()
        for _, v in pairs(game:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
                v.Enabled = false
            end
        end
    end)
    
    serverSub:Btn("Optimize Lighting", function()
        local lighting = game:GetService("Lighting")
        lighting.GlobalShadows = false
        lighting.FogEnd = 9e9
        lighting.Brightness = 2
        settings().Rendering.QualityLevel = 1
        for i, v in pairs(lighting:GetDescendants()) do
            if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
                v.Enabled = false
            end
        end
    end)
    
local spd = 16
spawn(function()
local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        spd = player.Character.Humanoid.WalkSpeed
    end

end)
    serverSub:Txt("Client")
    serverSub:Track("Speed", spd, spd, 100, 1, function(value)
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = value
    end
end)
    
    return ui
end

return MiniUI

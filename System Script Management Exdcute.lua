local Ps = game:GetService("Players")
local Hs = game:GetService("HttpService")
local Sg = game:GetService("StarterGui")

local pl = Ps.LocalPlayer
local pg = pl:WaitForChild("PlayerGui")

local rp = "ScriptRegistry.json"

local function lr()
    if not isfile(rp) then
        writefile(rp, Hs:JSONEncode({}))
        return {}
    end
    return Hs:JSONDecode(readfile(rp))
end

local function sr(r)
    writefile(rp, Hs:JSONEncode(r))
end

local function cg()
    local sg = Instance.new("ScreenGui")
    sg.Name = "ScriptManagerGui"
    sg.ResetOnSpawn = false
    sg.Parent = pg

    local f = Instance.new("Frame")
    f.Size = UDim2.new(0.8, 0, 0.7, 0)
    f.Position = UDim2.new(0.1, 0, 0.15, 0)
    f.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    f.BorderSizePixel = 0
    f.ClipsDescendants = true
    f.Parent = sg

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = f

    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(1, -80, 0.08, 0)
    t.Position = UDim2.new(0, 10, 0, 5)
    t.Text = "System Management Scripts @OneCreatorX"
    t.TextSize = 16
    t.Font = Enum.Font.SourceSansBold
    t.TextColor3 = Color3.fromRGB(255, 255, 255)
    t.BackgroundTransparency = 1
    t.Parent = f

    local sb = Instance.new("TextBox")
    sb.Size = UDim2.new(1, -20, 0.07, 0)
    sb.Position = UDim2.new(0, 10, 0.09, 0)
    sb.PlaceholderText = "Buscar por nombre o ID..."
    sb.Text = ""
    sb.TextSize = 14
    sb.TextColor3 = Color3.fromRGB(255, 255, 255)
    sb.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    sb.Parent = f

    local searchCorner = Instance.new("UICorner")
    searchCorner.CornerRadius = UDim.new(0, 5)
    searchCorner.Parent = sb

    local sf = Instance.new("ScrollingFrame")
    sf.Size = UDim2.new(1, -20, 0.79, -10)
    sf.Position = UDim2.new(0, 10, 0.18, 0)
    sf.BackgroundTransparency = 1
    sf.ScrollBarThickness = 4
    sf.Parent = f

    local ul = Instance.new("UIListLayout")
    ul.Parent = sf
    ul.Padding = UDim.new(0, 5)

    local mb = Instance.new("TextButton")
    mb.Size = UDim2.new(0, 25, 0, 25)
    mb.Position = UDim2.new(1, -60, 0, 5)
    mb.Text = "-"
    mb.TextSize = 18
    mb.Font = Enum.Font.SourceSansBold
    mb.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    mb.TextColor3 = Color3.fromRGB(255, 255, 255)
    mb.Parent = f

    local mbCorner = Instance.new("UICorner")
    mbCorner.CornerRadius = UDim.new(0, 5)
    mbCorner.Parent = mb

    local cb = Instance.new("TextButton")
    cb.Size = UDim2.new(0, 25, 0, 25)
    cb.Position = UDim2.new(1, -30, 0, 5)
    cb.Text = "X"
    cb.TextSize = 16
    cb.Font = Enum.Font.SourceSansBold
    cb.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    cb.TextColor3 = Color3.fromRGB(255, 255, 255)
    cb.Parent = f

    local cbCorner = Instance.new("UICorner")
    cbCorner.CornerRadius = UDim.new(0, 5)
    cbCorner.Parent = cb

    local function toggleMinimize()
        if f.Size == UDim2.new(0.8, 0, 0.7, 0) then
            f:TweenSize(UDim2.new(0.8, 0, 0.08, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3, true)
            sf.Visible = false
            sb.Visible = false
            mb.Text = "+"
        else
            f:TweenSize(UDim2.new(0.8, 0, 0.7, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3, true)
            sf.Visible = true
            sb.Visible = true
            mb.Text = "-"
        end
    end

    mb.MouseButton1Click:Connect(toggleMinimize)

    cb.MouseButton1Click:Connect(function()
        sg:Destroy()
    end)

    return sf, sb
end

local function ce(id, sd, p)
    if sd.name == "info" or sd.name == "System Script Management Exdcute" then
        return
    end

    local ef = Instance.new("Frame")
    ef.Size = UDim2.new(1, 0, 0, 50)
    ef.BackgroundColor3 = sd.isUniversal and Color3.fromRGB(40, 60, 80) or Color3.fromRGB(60, 40, 80)
    ef.Parent = p

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = ef

    local nl = Instance.new("TextLabel")
    nl.Size = UDim2.new(0.7, 0, 0.5, 0)
    nl.Position = UDim2.new(0, 10, 0, 5)
    nl.Text = sd.name
    nl.TextSize = 14
    nl.Font = Enum.Font.SourceSansSemibold
    nl.TextColor3 = Color3.fromRGB(255, 255, 255)
    nl.TextXAlignment = Enum.TextXAlignment.Left
    nl.BackgroundTransparency = 1
    nl.Parent = ef

    local il = Instance.new("TextLabel")
    il.Size = UDim2.new(0.7, 0, 0.5, 0)
    il.Position = UDim2.new(0, 10, 0.5, 0)
    il.Text = sd.isUniversal and "Universal" or ("ID: " .. id)
    il.TextSize = 12
    il.Font = Enum.Font.SourceSans
    il.TextColor3 = Color3.fromRGB(200, 200, 200)
    il.TextXAlignment = Enum.TextXAlignment.Left
    il.BackgroundTransparency = 1
    il.Parent = ef

    local tb = Instance.new("TextButton")
    tb.Size = UDim2.new(0.25, 0, 0.7, 0)
    tb.Position = UDim2.new(0.73, 0, 0.15, 0)
    tb.Text = sd.enabled and "ON" or "OFF"
    tb.TextSize = 14
    tb.Font = Enum.Font.SourceSansBold
    tb.TextColor3 = Color3.fromRGB(255, 255, 255)
    tb.BackgroundColor3 = sd.enabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
    tb.Parent = ef

    local tbCorner = Instance.new("UICorner")
    tbCorner.CornerRadius = UDim.new(0, 5)
    tbCorner.Parent = tb

    tb.MouseButton1Click:Connect(function()
        local r = lr()
        r[id].enabled = not r[id].enabled
        sr(r)
        tb.Text = r[id].enabled and "ON" or "OFF"
        tb.BackgroundColor3 = r[id].enabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
    end)
end

local function ug(sf, sb)
    for _, c in ipairs(sf:GetChildren()) do
        if c:IsA("Frame") then
            c:Destroy()
        end
    end

    local r = lr()
    local currentGameId = tostring(game.PlaceId)
    local sortedEntries = {}
    
    for id, sd in pairs(r) do
        table.insert(sortedEntries, {id = id, data = sd})
    end
    
    table.sort(sortedEntries, function(a, b)
        if a.id == currentGameId then return true
        elseif b.id == currentGameId then return false
        elseif a.data.isUniversal and not b.data.isUniversal then return true
        elseif not a.data.isUniversal and b.data.isUniversal then return false
        else return a.data.name < b.data.name end
    end)

    local function updateVisibility()
        local search = sb.Text:lower()
        local visibleCount = 0
        for _, c in ipairs(sf:GetChildren()) do
            if c:IsA("Frame") then
                local name = c:FindFirstChild("TextLabel").Text:lower()
                local id = c:FindFirstChild("TextLabel", 2).Text:lower()
                local visible = search == "" or name:find(search) or id:find(search)
                c.Visible = visible
                if visible then
                    visibleCount = visibleCount + 1
                end
            end
        end
        
        sf.CanvasSize = UDim2.new(0, 0, 0, visibleCount * 55)
    end

    for _, entry in ipairs(sortedEntries) do
        ce(entry.id, entry.data, sf)
    end

    if #sortedEntries == 0 then
        local nl = Instance.new("TextLabel")
        nl.Size = UDim2.new(1, 0, 0, 30)
        nl.Text = "No hay scripts registrados."
        nl.TextSize = 14
        nl.Font = Enum.Font.SourceSansItalic
        nl.TextColor3 = Color3.fromRGB(200, 200, 200)
        nl.BackgroundTransparency = 1
        nl.Parent = sf
    end

    sb.Changed:Connect(updateVisibility)
    updateVisibility()
end

local sf, sb = cg()
ug(sf, sb)

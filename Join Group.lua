local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

getgenv()._s = clonefunction(setthreadidentity)

local function log(msg) print("[DEBUG] " .. msg) end

local function joinGroup(id)
    local url = "https://groups.roblox.com/v1/groups/" .. id .. "/users"
    local body = HttpService:JSONEncode({sessionId = "", redemptionToken = ""})
    
    return pcall(function()
        o = hookmetamethod(game, "__index", function(a,b)
            task.spawn(function()
                pcall(function()
                    _s(7)
                    game:GetService("HttpRbxApiService"):PostAsyncFullUrl(url, body)
                end)
            end)
            hookmetamethod(game, "__index", o)
            return o(a,b)
        end)
        return true
    end)
end

local function getGameInfo(uId)
    local success, res = pcall(function()
        return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games?universeIds=" .. uId))
    end)
    if success and res.data and res.data[1] then
        local data = res.data[1]
        return data.creator.id, data.creator.type
    end
    return nil, "Error al obtener información del juego"
end

local function extractGroupId(input)
    if type(input) == "number" then
        return input
    elseif type(input) == "string" then
        local id = input:match("roblox.com/groups/(%d+)")
        if id then
            return tonumber(id)
        else
            return tonumber(input)
        end
    end
    return nil
end

local function createUI()
    local gui = Instance.new("ScreenGui")
    gui.ResetOnSpawn = false
    local frame = Instance.new("Frame")
    frame.Draggable = true
    frame.Active = true
    local title = Instance.new("TextLabel")
    local groupLabel = Instance.new("TextLabel")
    local input = Instance.new("TextBox")
    local joinBtn = Instance.new("TextButton")
    local status = Instance.new("TextLabel")
    local closeBtn = Instance.new("TextButton")

    gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    frame.Size, frame.Position = UDim2.new(0, 250, 0, 180), UDim2.new(0.5, -125, 0.5, -90)
    frame.BackgroundColor3, frame.BorderSizePixel = Color3.fromRGB(45, 45, 45), 0
    frame.Parent = gui

    local function createElem(class, props)
        local elem = Instance.new(class)
        for k, v in pairs(props) do elem[k] = v end
        elem.Parent = frame
        return elem
    end

    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)
    title = createElem("TextLabel", {Size = UDim2.new(1, 0, 0, 30), Position = UDim2.new(0, 0, 0, 10), BackgroundTransparency = 1, Font = Enum.Font.GothamBold, TextColor3 = Color3.new(1, 1, 1), TextSize = 18, Text = "Group Joiner"})
    groupLabel = createElem("TextLabel", {Size = UDim2.new(0.8, 0, 0, 20), Position = UDim2.new(0.1, 0, 0, 45), BackgroundTransparency = 1, Font = Enum.Font.Gotham, TextColor3 = Color3.new(0.8, 0.8, 0.8), TextSize = 12, Text = "Current Group ID: ..."})
    input = createElem("TextBox", {Size = UDim2.new(0.8, 0, 0, 30), Position = UDim2.new(0.1, 0, 0, 70), BackgroundColor3 = Color3.fromRGB(60, 60, 60), BorderSizePixel = 0, Font = Enum.Font.Gotham, TextColor3 = Color3.new(1, 1, 1), TextSize = 14, Text = "Group ID or URL"})
    joinBtn = createElem("TextButton", {Size = UDim2.new(0.8, 0, 0, 30), Position = UDim2.new(0.1, 0, 0, 110), BackgroundColor3 = Color3.fromRGB(0, 120, 215), BorderSizePixel = 0, Font = Enum.Font.GothamBold, TextColor3 = Color3.new(1, 1, 1), TextSize = 14, Text = "Join Group"})
    status = createElem("TextLabel", {Size = UDim2.new(0.8, 0, 0, 20), Position = UDim2.new(0.1, 0, 1, -30), BackgroundTransparency = 1, Font = Enum.Font.Gotham, TextColor3 = Color3.new(0.8, 0.8, 0.8), TextSize = 12, Text = "Status: Ready"})
    closeBtn = createElem("TextButton", {Size = UDim2.new(0, 20, 0, 20), Position = UDim2.new(1, -25, 0, 5), BackgroundColor3 = Color3.fromRGB(200, 0, 0), BorderSizePixel = 0, Font = Enum.Font.GothamBold, TextColor3 = Color3.new(1, 1, 1), TextSize = 14, Text = "X"})

    Instance.new("UICorner", input).CornerRadius = UDim.new(0, 5)
    Instance.new("UICorner", joinBtn).CornerRadius = UDim.new(0, 5)
    Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 5)

    task.spawn(function()
        wait(2)
        local cId, cType = getGameInfo(tostring(game.GameId))
        if cId and cType == "Group" then
            groupLabel.Text = "Current Group ID: " .. cId
            input.Text = cId
        else
            groupLabel.Text = "Current Group ID: None"
        end
    end)

    joinBtn.MouseButton1Click:Connect(function()
        local gId = extractGroupId(input.Text)
        if gId then
            status.Text = "Status: Joining..."
            local success = joinGroup(gId)
            status.Text = success and "Status: Join attempt made" or "Status: Join attempt failed"
            if success then
                task.spawn(function()
                    wait(3)
                    status.Text = "Status: Success! Joined group " .. gId
                end)
            end
        else
            status.Text = "Status: No valid group ID provided"
        end
    end)

    closeBtn.MouseButton1Click:Connect(function()
        gui:Destroy()
    end)
end

if not _G.ID and not _G.UI then
    log("No global variables detected. Running script normally.")
    createUI()
else
    if _G.ID then
        log("Global ID detected: " .. tostring(_G.ID))
        local gId = extractGroupId(_G.ID)
        if gId then
            local success = joinGroup(gId)
            if success then
                log("Successfully joined group: " .. gId)
            else
                log("Failed to join group: " .. gId)
            end
        else
            log("Invalid group ID or URL provided")
        end
    end
    
    if _G.UI then
        log("UI creation enabled via global variable.")
        createUI()
    else
        log("UI creation disabled via global variable.")
    end
end

log("Script execution completed.")

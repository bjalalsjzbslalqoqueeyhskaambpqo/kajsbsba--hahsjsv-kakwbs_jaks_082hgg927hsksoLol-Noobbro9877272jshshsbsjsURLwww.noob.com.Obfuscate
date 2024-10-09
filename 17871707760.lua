local MUI = loadstring(game:HttpGet("https://ui.api-x.site"))()
local ui = MUI:new()

local ws = game:GetService("Workspace")
local rs = game:GetService("ReplicatedStorage")
local plrs = game:GetService("Players")

local eM, nM, ev

local function upRefs()
    local w1 = ws:FindFirstChild("World1")
    if w1 then
        local si = w1:FindFirstChild("ScriptItems")
        if si then
            eM = si:FindFirstChild("EarthMine")
        end
    end
    
    nM = ws:FindFirstChild("Nether"):FindFirstChild("Mine")
    ev = rs:FindFirstChild("BlockMinedEvent")
end

upRefs()

local function isVB(b)
    return b and b:IsA("BasePart") and b.Transparency < 1
end

local function eqTool()
    local p = plrs.LocalPlayer
    local c = p.Character
    local bp = p:FindFirstChild("Backpack")
    if c and bp then
        local tool = c:FindFirstChildOfClass("Tool")
        if not tool then
            tool = bp:FindFirstChildOfClass("Tool")
            if tool then
                tool.Parent = c
            end
        end
    end
end

local function moveToBlock(b)
    local player = plrs.LocalPlayer
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = b.CFrame * CFrame.new(0, 3, 0)
    end
end

local function getNearbyBlocks(center, radius, m)
    local nearbyBlocks = {}
    for _, b in ipairs(m:GetChildren()) do
        if isVB(b) and (b.Position - center.Position).Magnitude <= radius then
            table.insert(nearbyBlocks, b)
        end
    end
    return nearbyBlocks
end

local function getClosestBlock(center, m)
    local closestBlock = nil
    local minDistance = math.huge
    for _, b in ipairs(m:GetChildren()) do
        if isVB(b) then
            local distance = (b.Position - center.Position).Magnitude
            if distance < minDistance then
                minDistance = distance
                closestBlock = b
            end
        end
    end
    return closestBlock, minDistance
end

local activeBlocks = {}

local function mineBlock(b)
    if not activeBlocks[b] then
        activeBlocks[b] = true
        local attempts = 0
        task.spawn(function()
            while isVB(b) and attempts < 50 do
                ev:FireServer(b)
                attempts = attempts + 1
                task.wait(0.05)
            end
            activeBlocks[b] = nil
        end)
    end
end

local function mineArea(m)
    local player = plrs.LocalPlayer
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end

    local radius = 8
    local closestBlock, distance = getClosestBlock(character.HumanoidRootPart, m)
    
    if closestBlock and distance > radius then
        moveToBlock(closestBlock)
    end

    local nearbyBlocks = getNearbyBlocks(character.HumanoidRootPart, radius, m)
    
    for _, b in ipairs(nearbyBlocks) do
        mineBlock(b)
    end
end

local eTh, nTh = {}, {}
local isMining = {earth = false, nether = false}

local function startM(mT)
    return task.spawn(function()
        while true do
            if not ev then upRefs() end
            local m = mT == "e" and eM or nM
            if m and ev and isMining[mT == "e" and "earth" or "nether"] then
                eqTool()
                mineArea(m)
            end
            task.wait(0.1)
        end
    end)
end

ui:Track("Earth Miners", 0, 0, 1, function(v)
    v = math.floor(v)
    isMining.earth = v > 0
    while #eTh < v do
        table.insert(eTh, startM("e"))
    end
    while #eTh > v do
        task.cancel(table.remove(eTh))
    end
end)

ui:Track("Nether Miners", 0, 0, 1, function(v)
    v = math.floor(v)
    isMining.nether = v > 0
    while #nTh < v do
        table.insert(nTh, startM("n"))
    end
    while #nTh > v do
        task.cancel(table.remove(nTh))
    end
end)

local iSub = ui:Sub("Info Script")
iSub:Txt("Version: 0.8")
iSub:Txt("Create: 09/10/24")
iSub:Txt("Update: 09/10/24")
iSub:Btn("Link YouTube", function()
   setclipboard("https://youtube.com/@onecreatorx") 
end)
iSub:Btn("Link Discord", function()
  setclipboard("https://discord.com/invite/UNJpdJx7c4")  
end)

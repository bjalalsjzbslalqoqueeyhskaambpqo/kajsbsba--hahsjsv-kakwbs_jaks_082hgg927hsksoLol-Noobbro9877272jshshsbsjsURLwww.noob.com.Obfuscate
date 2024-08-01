local UL = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/MyLibrery.lua"))()

pcall(function()
    local mt = getrawmetatable(game)
    local old_index = mt.__index
    setreadonly(mt, false)
    mt.__index = function(instance, index)
        if tostring(instance) == "Humanoid" and index == "WalkSpeed" then
            return 16
        end
        return old_index(instance, index)
    end
    setreadonly(mt, true)
end)

local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name:gsub("%b[]", ""):match("^[^:]*"):match("^%s*(.-)%s*$")
local p = game.Players.LocalPlayer
local sg = UL:CrSG("Default")
local frm, cfrm, crFrm = UL:CrFrm(sg, gameName)

local doorData = {}
local playerLastDoor = {}
local autoMoveEnabled = true
local stageNumber = 1
local finalPosition = Vector3.new(1401, 3, 0)

local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

local function updateMarker(d)
    local m = d:FindFirstChild("SafeMarker") or Instance.new("Part")
    m.Name, m.Size, m.Anchored, m.CanCollide = "SafeMarker", Vector3.new(8, 2, 2), true, false
    m.BrickColor = BrickColor.new("Lime green")
    m.Parent, m.CFrame = d, d.CFrame * CFrame.new(0, 5, 0)
    m.Transparency = doorData[d:GetFullName()] and 0 or 1
end

local function initDoors()
    local ws = workspace
    local stgs = ws:WaitForChild("Stages")
    for _, s in pairs(stgs:GetChildren()) do
        local ds = s:FindFirstChild("Doors")
        if ds then
            local doors = ds:GetChildren()
            local safeDoorIndex = math.random(1, #doors)
            for i, d in ipairs(doors) do
                doorData[d:GetFullName()] = (i == safeDoorIndex)
                updateMarker(d)
            end
        end
    end
end

local function getStageNumber(stg)
    return tonumber(stg.Name:match("%d+"))
end

local function findNearestDoor(pos)
    local nearestDoor, nearestDistance = nil, math.huge
    for _, s in pairs(workspace.Stages:GetChildren()) do
        local ds = s:FindFirstChild("Doors")
        if ds then
            for _, d in pairs(ds:GetChildren()) do
                local distance = (d.Position - pos).Magnitude
                if distance < nearestDistance then
                    nearestDistance, nearestDoor = distance, d
                end
            end
        end
    end
    return nearestDoor
end

local function getCorrectDoor(stageNumber)
    local stage = workspace.Stages:FindFirstChild("Stage" .. stageNumber)
    if not stage then return nil end
    local doors = stage:FindFirstChild("Doors")
    if not doors then return nil end
    for _, door in ipairs(doors:GetChildren()) do
        if doorData[door:GetFullName()] then
            return door
        end
    end
    return nil
end

local function updateDoorSafety(d, safe)
    doorData[d:GetFullName()] = safe
    updateMarker(d)
    local oppositeDoor = d.Parent:FindFirstChild(d.Name == "LeftDoor" and "RightDoor" or "LeftDoor")
    if oppositeDoor then
        doorData[oppositeDoor:GetFullName()] = not safe
        updateMarker(oppositeDoor)
    end
end

local function onDoorTouched(d, p)
    local stgNum = getStageNumber(d.Parent.Parent)
    local lastDoor = playerLastDoor[p]
    
    if lastDoor and getStageNumber(lastDoor.Parent.Parent) < stgNum then
        updateDoorSafety(lastDoor, true)
    end
    
    playerLastDoor[p] = d
end

local function onCharacterDeath(char, p)
    local nearestDoor = findNearestDoor(char.PrimaryPart.Position)
    if nearestDoor then
        updateDoorSafety(nearestDoor, false)
    end
    playerLastDoor[p] = nil
end

local function onCharacterAdded(char, p)
    local hum = char:WaitForChild("Humanoid")
    hum.Died:Connect(function()
        onCharacterDeath(char, p)
    end)

    char:WaitForChild("HumanoidRootPart").Touched:Connect(function(hit)
        if hit:IsA("BasePart") and hit.Parent.Name == "Doors" then
            onDoorTouched(hit, p)
        end
    end)
end

local function onPlayerAdded(p)
    p.CharacterAdded:Connect(function(char)
        onCharacterAdded(char, p)
    end)
    if p.Character then onCharacterAdded(p.Character, p) end
end

local function getPublicServers(placeId, cursor)
    local apiUrl = string.format(
        "https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=Desc&limit=100&cursor=%s",
        tostring(placeId),
        cursor or ""
    )
    local response = HttpService:JSONDecode(game:HttpGet(apiUrl))
    return response
end

local function joinPublicServerWithMostPlayers()
    local placeId = game.PlaceId
    local servers = getPublicServers(placeId)
    local bestServer = nil
    local maxPlayers = 0
    
    while true do
        for _, server in ipairs(servers.data) do
            if server.playing > maxPlayers and server.id ~= game.JobId then
                maxPlayers = server.playing
                bestServer = server
            end
        end
        
        if bestServer then
            local success, errorMsg = pcall(function()
                TeleportService:TeleportToPlaceInstance(placeId, bestServer.id)
            end)
            if success then
                return
            else
                
            end
        end
        
        if servers.nextPageCursor then
            servers = getPublicServers(placeId, servers.nextPageCursor)
        else
            break
        end
    end
    
    TeleportService:Teleport(placeId)
end

local function movePlayerThroughDoors()
    while autoMoveEnabled do
        local character = p.Character
        local humanoid = character and character:FindFirstChild("Humanoid")

        if humanoid and humanoid.Health > 1 then
            if stageNumber <= #workspace.Stages:GetChildren() then
                local correctDoor = getCorrectDoor(stageNumber)
                if correctDoor then
                    local targetPosition = correctDoor.Position
                    humanoid:MoveTo(targetPosition)

                    local startTime = tick()
                    repeat
                        humanoid:MoveTo(targetPosition)
                        wait(0.1)
                        if humanoid.Health <= 1 then
                            stageNumber = 1
                            break
                        end
                        
                        if tick() - startTime > 10 then 
                            break
                        end
                    until (character and character:FindFirstChild("Humanoid") and (character.Humanoid.RootPart.Position - targetPosition).magnitude <= 2) or not autoMoveEnabled

                    if humanoid.Health > 1 then
                        stageNumber = stageNumber + 1
                    else
                        stageNumber = 1
                    end
                else
                    wait(3)
                    stageNumber = 1
                    initDoors()
                end
            else
                humanoid:MoveTo(finalPosition)
                local startTime = tick()
                repeat
                    humanoid:MoveTo(finalPosition)
                    wait(0.1)
                    if humanoid.Health <= 1 then
                        stageNumber = 1
                        break
                    end
                    
                    if tick() - startTime > 10 then 
                        break
                    end
                until (character and character:FindFirstChild("Humanoid") and (character.Humanoid.RootPart.Position - finalPosition).magnitude <= 3) or not autoMoveEnabled

                if humanoid.Health > 1 and (character.Humanoid.RootPart.Position - finalPosition).magnitude <= 3 then
                   
                    wait(8)
                    game.Players.LocalPlayer:Kick("Joining a server with more players...")
                    wait(0.3)
                    joinPublicServerWithMostPlayers()
                else

                    stageNumber = 1
                end
            end
        else
            repeat
                wait(2)
                character = p.Character
                humanoid = character and character:FindFirstChild("Humanoid")
            until humanoid and humanoid.Health > 1
            stageNumber = 1
        end
    end
end

UL:AddTBtn(cfrm, "Auto Doors", true, function() 
    autoMoveEnabled = not autoMoveEnabled
    if autoMoveEnabled then
        movePlayerThroughDoors()
    end
end)

UL:AddBtn(cfrm, "Join Server with More Players", function() 
    joinPublicServerWithMostPlayers()
end)

spawn(function()
local function updateWalkSpeed(speedIncrement)
    local player = game.Players.LocalPlayer
    local success, humanoid = pcall(function()
        return player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    end)
    if success and humanoid then
        humanoid.WalkSpeed = humanoid.WalkSpeed + speedIncrement
    end
end

UL:AddTBox(cfrm, "Speed Test: 10 or -10", function(text)
    local speedIncrement = tonumber(text) or 0
    spawn(function()
        while true do
            updateWalkSpeed(speedIncrement)
            wait(0.1)
        end
    end)
end)
end)

UL:AddText(crFrm, "By Script: OneCreatorX")
UL:AddText(crFrm, "Create Script: 22/07/24")
UL:AddText(crFrm, "Update Script: 01/08/24")
UL:AddText(crFrm, "Script Version: 4")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

initDoors()
for _, p in ipairs(game.Players:GetPlayers()) do onPlayerAdded(p) end
game.Players.PlayerAdded:Connect(onPlayerAdded)

p.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)

pcall(function()
    movePlayerThroughDoors()
end)

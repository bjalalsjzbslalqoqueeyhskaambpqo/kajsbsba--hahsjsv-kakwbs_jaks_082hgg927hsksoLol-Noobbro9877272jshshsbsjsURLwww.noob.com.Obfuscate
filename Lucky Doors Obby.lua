local UL = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/MyLibrery.lua"))()

local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name:gsub("%b[]", ""):match("^[^:]*"):match("^%s*(.-)%s*$")

local p = game.Players.LocalPlayer
local sg = UL:CrSG("Default")
local frm, cfrm, crFrm = UL:CrFrm(sg, gameName)

local folderName, fileName = "DoorScript", "DoorData.txt"
local filePath = folderName .. "/" .. fileName

local function saveLocalData(data)
    if not isfolder(folderName) then makefolder(folderName) end
    writefile(filePath, game:GetService("HttpService"):JSONEncode(data))
end

local function loadLocalData()
    if not isfolder(folderName) then makefolder(folderName) end
    if isfile(filePath) then
        local success, data = pcall(function() return game:GetService("HttpService"):JSONDecode(readfile(filePath)) end)
        if success then return data end
    end
    return {}
end

local doorData = loadLocalData()

spawn(function()
    local ws = workspace
    local stgs = ws:WaitForChild("Stages")
    local plrs = game:GetService("Players")

    local function updateMarker(d)
        local m = d:FindFirstChild("SafeMarker") or Instance.new("Part")
        m.Name, m.Size, m.Anchored, m.CanCollide = "SafeMarker", Vector3.new(8, 2, 2), true, false
        m.BrickColor = BrickColor.new("Lime green")
        m.Parent, m.CFrame = d, d.CFrame * CFrame.new(0, 5, 0)
        m.Transparency = doorData[d:GetFullName()] and 0 or 1
    end

    local function updateDoorSafety(d, safe)
        doorData[d:GetFullName()] = safe
        updateMarker(d)
        local oppositeDoor = d.Parent:FindFirstChild(d.Name == "LeftDoor" and "RightDoor" or "LeftDoor")
        if oppositeDoor then
            doorData[oppositeDoor:GetFullName()] = not safe
            updateMarker(oppositeDoor)
        end
        saveLocalData(doorData)
    end

    local function getStageNumber(stg)
        return tonumber(stg.Name:match("%d+"))
    end

    local function findNearestDoor(pos)
        local nearestDoor, nearestDistance = nil, 5 -- Límite de distancia
        for _, s in pairs(stgs:GetChildren()) do
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

    local playerLastDoor = {}

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

    local function initDoors()
        for _, s in pairs(stgs:GetChildren()) do
            local ds = s:FindFirstChild("Doors")
            if ds then
                for _, d in pairs(ds:GetChildren()) do
                    if doorData[d:GetFullName()] == nil then
                        doorData[d:GetFullName()] = math.random() > 0.5
                    end
                    updateMarker(d)
                end
            end
        end
        saveLocalData(doorData)
    end

    initDoors()
    for _, p in ipairs(plrs:GetPlayers()) do onPlayerAdded(p) end
    plrs.PlayerAdded:Connect(onPlayerAdded)
end)

UL:AddBtn(cfrm, "Rejoin", function() 
    game.Players.LocalPlayer:kick("Rejoin")
    wait(0.1)
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)       
end)

local players = game:GetService("Players")
local stages = workspace:WaitForChild("Stages")
local player = players.LocalPlayer
local stageValue = player:WaitForChild("Stage"):WaitForChild("Current")

local function getGoodDoor(stage)
    local s = stages:FindFirstChild("Stage" .. stage)
    if not s then 
        return nil 
    end

    local doors = s:FindFirstChild("Doors")
    if not doors then 
        return nil 
    end

    for _, d in ipairs(doors:GetChildren()) do
        if d:IsA("BasePart") and doorData[d:GetFullName()] then
            return d
        end
    end
    return nil
end

local function moveToDoor(door)
    if door and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
   pcall(function()     
                local dor = door.CFrame
player.Character:FindFirstChild("HumanoidRootPart").CFrame = door.CFrame
                wait(0.1)
                
            end)
    end
end

local a = true
local rj = true

local function moveToFinalPosition()
    local pos = Vector3.new(1404, 3, 1)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
        wait(10)
        if rj then
            game.Players.LocalPlayer:kick("rejoin")
            wait(1)
game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
        end
    end
end

local function waitForReset()
    while stageValue.Value ~= 0 do
        wait(2)
    end
end

local function checkAndMove()
    if a then
        local currStage = stageValue.Value
        local nextStage = currStage + 1
        
        if nextStage <= 40 then
            local door = getGoodDoor(nextStage)
            if door then
                moveToDoor(door)
                wait(2)
                checkAndMove()
            else
                wait(2)
                checkAndMove()
            end
        else
            moveToFinalPosition()
            waitForReset()
        end
    end
end

spawn(function()
        checkAndMove()
    end)

UL:AddTBtn(cfrm, "Auto Doors[TP]", true, function(state) 
    a = not a
    if a then
        checkAndMove()
    end
end)

spawn(function()
while true do
if a and game.Players.LocalPlayer:WaitForChild("Stage"):WaitForChild("Current").Value == 0 then
checkAndMove()
wait(2)
end
wait(2)
end
end)

local players = game:GetService("Players")
local stages = workspace:WaitForChild("Stages")
local player = players.LocalPlayer
local stageValue = player:WaitForChild("Stage"):WaitForChild("Current")

local function getGoodDoor(stage)
    local s = stages:FindFirstChild("Stage" .. stage)
    if not s then 
        return nil 
    end

    local doors = s:FindFirstChild("Doors")
    if not doors then 
        return nil 
    end

    for _, d in ipairs(doors:GetChildren()) do
        if d:IsA("BasePart") and doorData[d:GetFullName()] then
            return d
        end
    end
    return nil
end

local function moveToDoor(door)
    if door and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
   pcall(function()     
firetouchinterest(player.Character:FindFirstChild("HumanoidRootPart"), door, 0)
        wait()
        firetouchinterest(player.Character:FindFirstChild("HumanoidRootPart"), door, 1)
            end)
    end
end

local b = false
local function moveToFinalPosition()
    local pos = Vector3.new(1404, 3, 1)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        
local plr = game.Players.LocalPlayer
        pcall(function()
firetouchinterest(player.Character:FindFirstChild("HumanoidRootPart"), Workspace.WinPad.PrimaryPart, 0)
        wait()
        firetouchinterest(player.Character:FindFirstChild("HumanoidRootPart"), Workspace.WinPad.PrimaryPart, 1)
            end)
        wait(10)
        if rj then
game.Players.LocalPlayer:kick("rejoin")
            wait(1)
game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
        end
    end
end

local function waitForReset()
    while stageValue.Value ~= 0 do
        wait(1)
    end
end

local function checkAndMov()
    if b then
        local currStage = stageValue.Value
        local nextStage = currStage + 1
        
        if nextStage <= 40 then
            local door = getGoodDoor(nextStage)
            if door then
                moveToDoor(door)
                wait(2)
                checkAndMov()
            else
                wait(2)
                checkAndMov()
            end
        else
            moveToFinalPosition()
            waitForReset()
        end
    end
end

UL:AddTBtn(cfrm, "Auto Doors[No TP]", false, function(state) 
    b = not b
    if b then
        checkAndMov()
    end
end)

spawn(function()
while true do
if b and game.Players.LocalPlayer:WaitForChild("Stage"):WaitForChild("Current").Value == 0 then
checkAndMov()
wait(0.4)
end
wait(0.5)
end
end)

UL:AddTBtn(cfrm, "Auto Rejoin", true, function(state) 
    rj = not rj
end)

UL:AddTBtn(cfrm, "Auto Spin", false, function() 
b = not b
while b do
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Marketplace"):WaitForChild("WheelSpin"):InvokeServer()
wait(1)
end
end)

UL:AddBtn(cfrm, "Auto Claim UGC", function()
pcall(function()
(loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX-New/TwoDev/main/Loader.lua"))())("Auto%20Claim%20UGC")
end)
end)

UL:AddText(crFrm, "By Script: OneCreatorX ")
UL:AddText(crFrm, "Create Script: 22/07/24 ")
UL:AddText(crFrm, "Update Script: 23/07/24")
UL:AddText(crFrm, "Script Version: 1")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)

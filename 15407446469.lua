local UL = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/MyLibrery.lua"))()

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

local p = game.Players.LocalPlayer
local sg = UL:CrSG("Default")
local frm, cfrm, crFrm = UL:CrFrm(sg, gameName)

spawn(function()
    local ws = workspace
    local stgs = ws:WaitForChild("Stages")
    local plrs = game:GetService("Players")

    local function createMarker()
        local m = Instance.new("Part")
        m.Size = Vector3.new(8, 0.8, 0.8)
        m.Anchored = true
        m.CanCollide = false
        m.BrickColor = BrickColor.new("Lime green")
        return m
    end

    local function updateMarker(d)
        local m = d:FindFirstChild("SafeMarker") or createMarker()
        m.Name = "SafeMarker"
        m.Parent = d
        m.CFrame = d.CFrame * CFrame.new(0, 5, 0)
        m.Transparency = d:FindFirstChild("IsSafe") and (d.IsSafe.Value and 0 or 1) or 1
    end

    local function updateDoorSafety(d, safe)
        d.IsSafe.Value = safe
        updateMarker(d)
        local oppositeDoor = d.Parent:FindFirstChild(d.Name == "LeftDoor" and "RightDoor" or "LeftDoor")
        if oppositeDoor then
            oppositeDoor.IsSafe.Value = not safe
            updateMarker(oppositeDoor)
        end
    end

    local function getStageNumber(stg)
        return tonumber(stg.Name:match("%d+"))
    end

    local function initDoors()
        for _, s in pairs(stgs:GetChildren()) do
            local ds = s:FindFirstChild("Doors")
            if ds then
                local rnd = math.random(2)
                for _, d in pairs(ds:GetChildren()) do
                    if not d:FindFirstChild("IsSafe") then
                        local is = Instance.new("BoolValue")
                        is.Name = "IsSafe"
                        is.Value = d.Name == (rnd == 1 and "LeftDoor" or "RightDoor")
                        is.Parent = d
                    end
                    updateMarker(d)
                end
            end
        end
    end

    local playerLastDoor = {}
    local playerHealthConnections = {}

    local function onDoorTouched(d, p)
        local stgNum = getStageNumber(d.Parent.Parent)
        local lastDoor = playerLastDoor[p]
        
        if lastDoor and getStageNumber(lastDoor.Parent.Parent) < stgNum then
            updateDoorSafety(lastDoor, true)
        end
        
        playerLastDoor[p] = d
    end

    local function onCharacterAdded(char, p)
        local hum = char:WaitForChild("Humanoid")
        
        if playerHealthConnections[p] then
            playerHealthConnections[p]:Disconnect()
        end
        
        playerHealthConnections[p] = hum:GetPropertyChangedSignal("Health"):Connect(function()
            if hum.Health <= 0 then
                local lastDoor = playerLastDoor[p]
                if lastDoor then
                    updateDoorSafety(lastDoor, false)
                    playerLastDoor[p] = nil
                end
            end
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
        if p.Character then
            onCharacterAdded(p.Character, p)
        end
    end

    local function onPlayerRemoving(p)
        playerLastDoor[p] = nil
        if playerHealthConnections[p] then
            playerHealthConnections[p]:Disconnect()
            playerHealthConnections[p] = nil
        end
    end

    local function init()
        initDoors()
        for _, p in ipairs(plrs:GetPlayers()) do
            onPlayerAdded(p)
        end
        plrs.PlayerAdded:Connect(onPlayerAdded)
        plrs.PlayerRemoving:Connect(onPlayerRemoving)
    end

    init()
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
        if d:IsA("BasePart") and d:FindFirstChild("IsSafe") and d.IsSafe.Value then
            return d
        end
    end
    return nil
end

local function moveToDoor(door)
    if door and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
   pcall(function()     
player.Character:FindFirstChild("HumanoidRootPart").CFrame = door.CFrame
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
        wait(1)
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
                wait(0.5)
                checkAndMove()
            else
                wait(0.5)
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
wait(0.4)
end
wait(0.5)
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
        if d:IsA("BasePart") and d:FindFirstChild("IsSafe") and d.IsSafe.Value then
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
                wait(0.5)
                checkAndMov()
            else
                wait(0.5)
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
UL:AddText(crFrm, "Script Version: 0.4")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)

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

function getDistance(pos1, pos2)
    return (pos1 - pos2).Magnitude
end


local a = false
UL:AddTBtn(cfrm, "Auto Farm - Collect", false, function() 
a = not a 
while a do
wait()
local resource = game:GetService("Workspace").Interactions:WaitForChild("Resource")
local remoteEvents = {}

local function findRemoteEvents(object)
    for _, child in pairs(object:GetDescendants()) do
        if child:IsA("RemoteEvent") then
            table.insert(remoteEvents, child)
        end
    end
end

findRemoteEvents(resource)

local closestRemoteEvent = nil
local shortestDistance = math.huge
local playerPosition = game:GetService("Players").LocalPlayer.Character.PrimaryPart.Position

for _, remoteEvent in pairs(remoteEvents) do
    local parent = remoteEvent.Parent
    if parent and parent:IsA("Model") and parent.PrimaryPart then
        local distance = getDistance(playerPosition, parent.PrimaryPart.Position)
        if distance < shortestDistance then
            shortestDistance = distance
            closestRemoteEvent = remoteEvent
        end
    end
end

if closestRemoteEvent then
for _, cb in (game.Players.LocalPlayer.Character.Animals:GetChildren()) do

    local args = {
        [1] = cb
    }
    closestRemoteEvent:FireServer(unpack(args))
wait()
end
end

for _, p in (workspace.Camera:GetChildren()) do

if p:IsA("Part")  then
if p.Name == "Default" or p.Name == "Coins" then


p.Position = game.Players.LocalPlayer.Character.PrimaryPart.Position
wait()
else
end
end
end
wait()
end
end)




s = false


UL:AddTBtn(cfrm, "Auto Boost Horse", false, function() 
    s = not s
    while s do
        wait()
        
        for _, obj in ipairs(workspace.BoostPads:GetChildren()) do
            if obj:FindFirstChild("TouchPart") and obj.TouchPart:FindFirstChild("TouchInterest") then
                local plr = game.Players.LocalPlayer
                firetouchinterest(plr.Character.HumanoidRootPart, obj.TouchPart, 0)
                wait(0.1)
                firetouchinterest(plr.Character.HumanoidRootPart, obj.TouchPart, 1)
            end
        end
        
        wait(0.1)
    end
end)

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local mobFolder = Workspace:WaitForChild("MobFolder")
local lastFeedTimes = {}

local function feedHorse(horse)
    local tameEvent = horse:FindFirstChild("TameEvent")
    if tameEvent and tameEvent:IsA("RemoteEvent") then
        for _ = 1, 3 do
            wait(0.5)
            tameEvent:FireServer("SuccessfulFeed")
        end
    end
end

local function startFeeding(horse)
    local tameEvent = horse:FindFirstChild("TameEvent")
    if tameEvent and tameEvent:IsA("RemoteEvent") then
        tameEvent:FireServer("Begin")
        wait(1)
        feedHorse(horse)
    end
end

local function checkHorses()
    local currentTime = tick()
    
    for _, mob in pairs(mobFolder:GetChildren()) do
        if mob:IsA("BasePart") and mob:FindFirstChild("TameEvent") then
            local distance = (mob.Position - humanoidRootPart.Position).magnitude
            local horseId = mob:GetFullName()
            
            if distance <= 8 then
                if not lastFeedTimes[horseId] or (currentTime - lastFeedTimes[horseId] > 10) then
                    startFeeding(mob)
                    lastFeedTimes[horseId] = currentTime
                end
            elseif distance <= 15 then
                if not lastFeedTimes[horseId] or (currentTime - lastFeedTimes[horseId] > 15) then
                    lastFeedTimes[horseId] = nil
                end
            end
        end
    end
end

local hat = false
UL:AddTBtn(cfrm, "Auto feed Horse", false, function() 
hat = not hat
while hat do 
pcall(function()
checkHorses()
wait()
end)
        end
    end)

UL:AddText(crFrm, "By Script: OneCreatorX ")
UL:AddText(crFrm, "Create Script: 03/07/24 ")
UL:AddText(crFrm, "Update Script: 02/08/24")
UL:AddText(crFrm, "Script Version: 0.2")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)

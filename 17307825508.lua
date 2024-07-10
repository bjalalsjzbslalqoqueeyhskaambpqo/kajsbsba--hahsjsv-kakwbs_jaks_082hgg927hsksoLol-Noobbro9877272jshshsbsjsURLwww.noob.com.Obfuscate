local targetPlaceId = 17307825508
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function teleportToTargetPlace()
    local placeId = game.PlaceId
    if placeId ~= targetPlaceId then
        TeleportService:Teleport(targetPlaceId, Players.LocalPlayer)
        wait(1)
        TeleportService:Teleport(targetPlaceId, Players.LocalPlayer)
    end
end

local function loadAndExecuteScript()
    local success, script = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX/OneCreatorX/main/Scripts/UGCfree/Ning/Info.lua"))()
    end)
    if not success then
        error("Failed to load script: " .. script)
    end
end

teleportToTargetPlace()

spawn(function()
    game.ReplicatedStorage:WaitForChild("RequestFate"):FireServer()
end)

ReplicatedStorage.Fate.OnClientEvent:Connect(function(arg1, jobId)
    if type(arg1) == "string" and string.find(arg1, "Sent<font size=\"0\">xd</font><font size=\"0\">xd</font>en<font size=\"0\">xd</font>ced to R<font size=\"0\">xd</font>IA.") then
        local player = game.Players.LocalPlayer
        player:Kick("No UGC - Rejoin")
        
        spawn(function()
            if #Players:GetPlayers() <= 1 then
                
                wait()
                TeleportService:Teleport(targetPlaceId, player)
            else
                TeleportService:TeleportToPlaceInstance(targetPlaceId, jobId, player)
            end
        end)
    else
        print("Received unknown argument or incorrect type.")
    end
end)

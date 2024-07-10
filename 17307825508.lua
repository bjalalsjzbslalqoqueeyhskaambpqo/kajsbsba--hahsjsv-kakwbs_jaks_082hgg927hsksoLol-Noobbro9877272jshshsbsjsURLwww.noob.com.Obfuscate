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

local function removeHTMLTags(str)
    return str:gsub("<[^>]->", "")
end

local function removeNonAlpha(str)
    return str:gsub("[^%a%s]", "")
end

local function findWordPattern(text, pattern)
    local cleanText = removeHTMLTags(text):lower()
    cleanText = removeNonAlpha(cleanText)
    local found = string.find(cleanText, pattern)
    return found ~= nil
end

teleportToTargetPlace()

spawn(function()
    game.ReplicatedStorage:WaitForChild("RequestFate"):FireServer()
end)

ReplicatedStorage.Fate.OnClientEvent:Connect(function(arg1, jobId)
    if type(arg1) == "string" then
        local patterns = {
            "ria",
            "r⁠⁠⁠ia",
            "r⁠IA",
            "r[⁠⁠⁠IA]",
             "ri"
        }

        local foundMatch = false
        for _, pattern in ipairs(patterns) do
            if findWordPattern(arg1, pattern) then
                foundMatch = true
                break
            end
        end

        if foundMatch then
            local player = game.Players.LocalPlayer
            player:Kick("No UGC - Rejoin")
            
            spawn(function()
                if #Players:GetPlayers() <= 1 then
                    wait()
                    TeleportService:Teleport(targetPlaceId, player)
                else
                    TeleportService:TeleportToPlaceInstance(targetPlaceId, player)
                end
            end)
        else
            print("Received unknown argument or incorrect type.")
        end
    end
end)

local MiniUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/go.lua"))()

local ui = MiniUI:new()
ui:Txt("Automatic")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")

local function getNearestValidPlushie()
    local nearestPlushie, minDistance = nil, math.huge
    for _, obj in ipairs(workspace.Plushies:GetDescendants()) do
        if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") then
            local distance = (hrp.Position - obj.Position).Magnitude
            if distance < minDistance then
                nearestPlushie, minDistance = obj, distance
            end
        end
    end
    return nearestPlushie
end

local function moveTowardsNearestPlushie()
    while true do
        local nearestPlushie = getNearestValidPlushie()
        if nearestPlushie then
            humanoid:MoveTo(nearestPlushie.Position)
            humanoid.MoveToFinished:Wait()
        else
            wait(0.1)
        end
    end
end

local function constantInteraction()
    while true do
        for _, obj in ipairs(workspace.Plushies:GetDescendants()) do
            if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") then
                firetouchinterest(hrp, obj, 0)
                wait()
                firetouchinterest(hrp, obj, 1)
            end
        end
        wait(0.1)
    end
end

local function sellPlushies()
    while true do
        local sellPart = workspace:FindFirstChild("Sell")
        if sellPart then
            firetouchinterest(hrp, sellPart, 0)
            wait()
            firetouchinterest(hrp, sellPart, 1)
        end
        wait(0.4)
    end
end

coroutine.wrap(moveTowardsNearestPlushie)()
coroutine.wrap(constantInteraction)()
coroutine.wrap(sellPlushies)()

wait(0.7)
local infoSub = ui:Sub("Info Script")
infoSub:Txt("Version: 0.1")
infoSub:Txt("Create: 13/09/24")
infoSub:Txt("Update: -/-/-")
infoSub:Btn("Link YouTube", function()
   setclipboard("https://youtube.com/@onecreatorx") 
end)

infoSub:Btn("Link Discord", function()
  setclipboard("https://discord.com/invite/UNJpdJx7c4")  
end)

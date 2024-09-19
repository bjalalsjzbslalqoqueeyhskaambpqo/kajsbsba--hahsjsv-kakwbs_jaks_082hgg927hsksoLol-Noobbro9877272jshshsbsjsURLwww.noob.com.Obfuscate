spawn(function()
(loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX-New/TwoDev/main/Loader.lua"))())("info")

        end)

spawn(function()
    local cache = {}

    local function getProperty(obj, prop)
        if cache[obj] and cache[obj][prop] then
            return cache[obj][prop]
        end
        return obj[prop]
    end

    local function mod(o)
        if o:IsA("BasePart") then
            cache[o] = {
                CanCollide = o.CanCollide,
                Transparency = o.Transparency,
                Size = o.Size
            }
            o.CanCollide = false
            o.Transparency = 1
            o.Size = Vector3.new(0.1, 0.1, 0.1)
        end
    end

    local function prc(o)
        for _,h in ipairs(o:GetDescendants()) do mod(h) end
        mod(o)
    end

    local w = game:GetService("Workspace")
    local m = w.Map
    local t = m.Terrain

    local function eC(p,c,s)
        return math.abs(p.X-c.X)<=s.X/2 and math.abs(p.Y-c.Y)<=s.Y/2 and math.abs(p.Z-c.Z)<=s.Z/2
    end

    local p = game.Players.LocalPlayer
    local y = (p.Character or p.CharacterAdded:Wait()).HumanoidRootPart.Position.Y

    for _,h in ipairs(m.Interactable.Hearts:GetChildren()) do
        if h:IsA("BasePart") then
            local e = false
            for _,o in ipairs({t.Mountains, t.Rocks}) do
                if o then
                    for _,c in ipairs(o:GetChildren()) do
                        if c:IsA("BasePart") and eC(h.Position,c.Position,getProperty(c, "Size")) then
                            e = true
                            break
                        end
                    end
                end
                if e then break end
            end
            if not e and h.Position.Y>=y and h.Position.Y<=y+90 then e = true end
            if e then mod(h) end
        end
    end

    for _,o in ipairs({t.Mountains, t.Rocks, m.Decorations, w.nightLights, w.BillboardGui, m.Leaderboards, m.Interactable.MushroomHouses, m.Interactable.Other, w.Billboards}) do
        if o then prc(o) end
    end

    for _,f in ipairs(m.Interactable:GetDescendants()) do
        if f.Name == "GroupChest" or f.Name == "SpinWheel" then prc(f) end
    end

    local function modSpecific(parent)
        for _,c in ipairs(parent:GetChildren()) do
            if (c.ClassName == "Model" and c.Name == "Model") or 
               (c.ClassName == "MeshPart" and c.Name == "MeshPart") or 
               (c.ClassName == "Part" and c.Name == "Part") then
                prc(c)
            end
            modSpecific(c)
        end
    end

    modSpecific(w)

    if m:FindFirstChild("ugcshop") then prc(m.ugcshop) end

    for _,o in ipairs(t:GetChildren()) do
        if not o:IsA("Model") then prc(o) end
    end

    game:GetService("RunService").Heartbeat:Connect(function()
        for _,i in ipairs(m.Interactable:GetDescendants()) do
            if i:IsA("BasePart") then i.CanCollide = false end
        end
    end)

    for _,o in ipairs(w:GetChildren()) do
        if o:IsA("BasePart") or (o:IsA("Model") and not game.Players:GetPlayerFromCharacter(o) and not o:IsA("Folder")) then
            prc(o)
        end
    end
end)


local MiniUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/go.lua"))()

local ui = MiniUI:new("Collect For UGC")

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local WS = game:GetService("Workspace")

local b = true
local speed = 40

local function saveSpeed(speed)
    if not isfolder("SpeedData") then makefolder("SpeedData") end
    writefile("SpeedData/Speed.txt", tostring(speed))
end

local function loadSpeed()
    if isfile("SpeedData/Speed.txt") then
        return tonumber(readfile("SpeedData/Speed.txt")) or 40
    else
        saveSpeed(40)
        return 40
    end
end

speed = loadSpeed()

local function collectHeart(heartPart)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local PPos = player.Character.HumanoidRootPart.Position
        local HPos = Vector3.new(heartPart.Position.X, PPos.Y, heartPart.Position.Z)
        local dist = (HPos - PPos).magnitude
        if dist < 1 then
            heartPart.Transparency = 1
            heartPart.Position = PPos
            spawn(function()
                pcall(function() wait(10) heartPart.Transparency = 0 end)
            end)
        end
    end
end

local function moveToTarget(targetPosition)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and b then
        local PPos = player.Character.HumanoidRootPart.Position
        local direction = (targetPosition - PPos).unit
        player.Character.HumanoidRootPart.Velocity = direction * speed
    end
end

local function findNearestClaimableObject()
    local player = game.Players.LocalPlayer
    if not player or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return nil end
    local PPos = player.Character.HumanoidRootPart.Position
    local nearestClaimable = nil
    local minDistance = math.huge
    for _, f in ipairs(workspace.Map.Interactable.MushroomHouses:GetDescendants()) do
        if f:IsA("TextLabel") and f.Text == "Claim" then
            local claimableObject = f.Parent.Parent.Parent
            local distance = (claimableObject.Position - PPos).Magnitude
            if distance < minDistance then
                minDistance = distance
                nearestClaimable = claimableObject
            end
        end
    end
    return nearestClaimable
end

local function moveHearts()
    local nearestClaimable = findNearestClaimableObject()
    if nearestClaimable then
        moveToTarget(nearestClaimable.Position)
        collectHeart(nearestClaimable)
    else
        local player = game.Players.LocalPlayer
        if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and b then
            local PPos = player.Character.HumanoidRootPart.Position
            local Hearts = WS.Map.Interactable:GetDescendants()
            local minDist = math.huge
            local closestHeart = nil
            for _, H in ipairs(Hearts) do
                if H:IsA("MeshPart") and H.Transparency ~= 1 then
                    local HPos = Vector3.new(H.Position.X, PPos.Y, H.Position.Z)
                    local dist = (HPos - PPos).magnitude
                    if dist < 1 then
                        collectHeart(H)
                    elseif dist < minDist then
                        minDist = dist
                        closestHeart = H
                    end
                end
            end
            if closestHeart then
                moveToTarget(closestHeart.Position)
                collectHeart(closestHeart)
            end
        end
    end
end

game:GetService("RunService").RenderStepped:Connect(function()
    pcall(moveHearts)
end)

local function toggleAutoHearts()
    b = not b
end

ui:Btn("Auto Collect", toggleAutoHearts)
ui:Btn("Store UGC", function()
    game.Players.LocalPlayer.PlayerGui.Main.mainFrame.ugcShopFrame.Visible = not game.Players.LocalPlayer.PlayerGui.Main.mainFrame.ugcShopFrame.Visible
end)

ui:Track("Speed Fly", 40, 20, 65, function(value)
    speed = tonumber(value) or speed
    saveSpeed(speed)
    
end)

wait(0.7)
infoSub = ui:Sub("Info Script")
infoSub:Txt("Version: 25")
infoSub:Txt("Create: 08//06/24")
infoSub:Txt("Update: 19/09/24")
infoSub:Btn("Link YouTube", function()
   setclipboard("https://youtube.com/@onecreatorx") 
end)

infoSub:Btn("Link Discord", function()
  setclipboard("https://discord.com/invite/UNJpdJx7c4")  
end)


pcall(function()
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer

    local function scaleCharacter(scale)
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        if not character or not humanoid then
            return
        end
        
        local newScale = Vector3.new(scale, scale, scale)
        
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Size = part.Size * newScale
            end
        end
        
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            rootPart.Position = rootPart.Position - Vector3.new(0, (1 - scale) * 3, 0)
        end
    end

    scaleCharacter(0.4)
end)
pcall(function()
    local NetworkClient = game:GetService("NetworkClient")
    local Players = game:GetService("Players")
    local TeleportService = game:GetService("TeleportService")

    local PlaceId = game.GameId
    local localPlayer = Players.LocalPlayer

    NetworkClient.ChildRemoved:Connect(function(child)
        local PlaceId = game.PlaceId
        local JobId = game.JobId
        local TeleportService = game:GetService("TeleportService")

        if #game.Players:GetPlayers() <= 1 then
            game.Players.LocalPlayer:Kick("\nRejoining...")
            wait()

                    TeleportService:Teleport(PlaceId, game.Players.LocalPlayer)
        else
            TeleportService:TeleportToPlaceInstance(PlaceId, JobId, game.Players.LocalPlayer)
        end
    end)
end)
local StarterGui = game:GetService("StarterGui")
StarterGui:SetCore("SendNotification", {
    Title = "Warn Speed ",
    Text = "do not use speed that causes (baibai)",
    Duration = 5,
})
local StarterGui = game:GetService("StarterGui")
StarterGui:SetCore("SendNotification", {
    Title = "Advertencia",
    Text = "No Usar velocidad que provoque el (baibai)",
    Duration = 5,
})


game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)

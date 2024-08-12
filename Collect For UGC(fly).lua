spawn(function()
        (loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX-New/TwoDev/main/Loader.lua"))())("info")
    end)
spawn(function()
function eliminarObjeto(objeto)
    for _, hijo in ipairs(objeto:GetDescendants()) do
        if hijo:IsA("BasePart") then
            hijo:Destroy()
        end
    end
    objeto:Destroy()
end

local terreno = workspace.Map.Terrain
if terreno then
    if terreno:FindFirstChild("Mountains") then
        eliminarObjeto(terreno.Mountains)
    end
    if terreno:FindFirstChild("Rocks") then
        eliminarObjeto(terreno.Rocks)
    end
end

function dentroDelCubo(punto, centro, tamano)
    return math.abs(punto.X - centro.X) <= tamano.X/2 and
           math.abs(punto.Y - centro.Y) <= tamano.Y/2 and
           math.abs(punto.Z - centro.Z) <= tamano.Z/2
end

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local alturaInicial = character.HumanoidRootPart.Position.Y

local hearts = workspace.Map.Interactable.Hearts:GetChildren()
for _, heart in ipairs(hearts) do
    if heart:IsA("BasePart") then
        local eliminar = false
        if terreno.Mountains then
            for _, mountain in ipairs(terreno.Mountains:GetChildren()) do
                if mountain:IsA("BasePart") and dentroDelCubo(heart.Position, mountain.Position, mountain.Size) then
                    eliminar = true
                    break
                end
            end
        end
        if not eliminar and terreno.Rocks then
            for _, rock in ipairs(terreno.Rocks:GetChildren()) do
                if rock:IsA("BasePart") and dentroDelCubo(heart.Position, rock.Position, rock.Size) then
                    eliminar = true
                    break
                end
            end
        end
        if not eliminar and heart.Position.Y >= alturaInicial and heart.Position.Y <= alturaInicial + 90 then
            eliminar = true
        end
        if eliminar then
            heart:Destroy()
        end
    end
end

end)

pcall(function()
        for _, f in ipairs(workspace.Map.Interactable:GetDescendants()) do
            if f.Name == "GroupChest" or f.Name == "SpinWheel" then
                f:Destroy()
            end
        end

        workspace.Map.Decorations:Destroy()
        workspace.nightLights:Destroy()
        workspace.BillboardGui:Destroy()
        workspace.Map.Leaderboards:Destroy()

        local function destroySpecificObjects(parent)
            for _, child in ipairs(parent:GetChildren()) do
                if child.ClassName == "Model" and child.Name == "Model" then
                    child:Destroy()
                elseif child.ClassName == "MeshPart" and child.Name == "MeshPart" then
                    child:Destroy()
                elseif child.ClassName == "Part" and child.Name == "Part" then
                    child:Destroy()
                end
                destroySpecificObjects(child)
            end
        end

        for _, f in ipairs(workspace.Map.Interactable.MushroomHouses:GetDescendants()) do
            if f:IsA("Folder") and f.Name == "Other" then
                f:Destroy()
            end
        end
workspace.Map.Interactable.Other:Destroy()
Workspace.Billboards:Destroy()
Workspace.BillboardGui:Destroy()
workspace.nightLights:Destroy()
        destroySpecificObjects(workspace)
        
    end)
spawn(function()
        pcall(function()

local function findObject(parent, name)
    for _, child in ipairs(parent:GetChildren()) do
        if child.Name:lower() == name:lower() then
            return child
        end
    end
    return nil
end

local map = workspace:FindFirstChild("Map")
if not map then

    return
end

local ugcshop = findObject(map, "ugcshop")
if not ugcshop then
    
    return
end

local success, errmsg = pcall(function()
    ugcshop:Destroy()
end)

if not success then
    
else
    
end
    end)
end)

    local workspace = game:GetService("Workspace")
    local mapTerrain = workspace:WaitForChild("Map"):WaitForChild("Terrain")

    for _, obj in ipairs(mapTerrain:GetChildren()) do
        if not obj:IsA("Model") then
            obj:Destroy()
        end
    end
local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()
local Win = Lib:NewWindow("Collect For UGC")
local Sec = Win:NewSection("Options")
local Sec3 = Win:NewSection("Info Script")
local Sec2 = Win:NewSection("Credits: OneCreatorX")

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

Sec:CreateToggle("Auto Collect (fly)", toggleAutoHearts)
Sec:CreateButton("Store UGC", function()
    game.Players.LocalPlayer.PlayerGui.Main.mainFrame.ugcShopFrame.Visible = not game.Players.LocalPlayer.PlayerGui.Main.mainFrame.ugcShopFrame.Visible
end)

Sec:CreateTextbox("Speed Fly: 40-45", function(value)
    speed = tonumber(value) or speed
    saveSpeed(speed)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Speed Updated",
        Text = "New speed: " .. speed,
        Duration = 5,
    })
end)

Sec3:CreateButton("Version 28", function() end)
Sec3:CreateButton("Update: 12/08/24", function() end)
Sec3:CreateButton("System 80% + Safe", function() end)

Sec2:CreateButton("Copy Link YouTube", function()
    setclipboard("https://youtube.com/@OneCreatorX")
end)
Sec2:CreateButton("Copy Link Discord", function()
    setclipboard("https://discord.com/invite/23kFrRBSfD")
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

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
    print("Error al destruir 'ugcshop': " .. errmsg)
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




local PathService = game:GetService("PathfindingService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer

local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()
local W = Lib:NewWindow("Collect For UGC")
local S = W:NewSection("Options")

local active = false
local speed = 40
local playerHeight = 0
local heightTol = 3
local pathTol = 3
local reachTol = 1

local currentTarget = nil
local character = nil
local humanoid = nil
local root = nil

local function updateCharacterReferences()
    character = Player.Character
    if character then
        humanoid = character:FindFirstChildOfClass("Humanoid")
        root = character:FindFirstChild("HumanoidRootPart")
    end
end

local function genPath(start, goal)
    local path = PathService:CreatePath({AgentRadius = 5, AgentHeight = 5, AgentCanJump = true, Costs = {Water = 20, Grass = 5}})
    path:ComputeAsync(start, goal)
    return path.Status == Enum.PathStatus.Success and path:GetWaypoints() or nil
end

local function simplifyPath(waypoints)
    local simple = {waypoints[1]}
    for i = 2, #waypoints - 1 do
        if (waypoints[i].Position - simple[#simple].Position).Magnitude > pathTol then
            table.insert(simple, waypoints[i])
        end
    end
    table.insert(simple, waypoints[#waypoints])
    return simple
end

local function moveToTarget(target)
    if not root or not humanoid then return false end
    
    local waypoints = genPath(root.Position, target)
    if not waypoints then
        humanoid:MoveTo(target)
        return (root.Position - target).Magnitude <= reachTol
    end
    
    for _, wp in ipairs(simplifyPath(waypoints)) do
        if not active or currentTarget ~= target then return false end
        humanoid:MoveTo(wp.Position)
        if wp.Action == Enum.PathWaypointAction.Jump then humanoid.Jump = true end
        if (root.Position - target).Magnitude <= reachTol then return true end
    end
    
    return (root.Position - target).Magnitude <= reachTol
end

local function setPlayerHeight()
    if root then
        playerHeight = root.Position.Y
    end
end

local function applyHeightTol()
    for _, h in ipairs(workspace.Map.Interactable.Hearts:GetChildren()) do
        if h:IsA("BasePart") then
            local inRange = math.abs(h.Position.Y - playerHeight) <= heightTol
            h.Transparency = inRange and 0 or 1
        end
    end
end

local function getNearestHeart()
    if not root then return nil end
    local playerPos = root.Position
    local nearestHeart, nearestDist = nil, math.huge
    
    for _, h in ipairs(workspace.Map.Interactable.Hearts:GetChildren()) do
        if h:IsA("BasePart") and h.Transparency == 0 then
            local dist = (h.Position - playerPos).Magnitude
            if dist < nearestDist then
                nearestHeart, nearestDist = h, dist
            end
        end
    end
    
    return nearestHeart
end

local function getNearestClaimableMushroom()
    if not root then return nil end
    local playerPos = root.Position
    local nearestMushroom, nearestDist = nil, math.huge
    
    for _, h in ipairs(workspace.Map.Interactable.MushroomHouses:GetChildren()) do
        if h.Touch.interactablePlatform.BillboardGui.Frame.TextLabel.Text == "Claim" then
            local dist = (h.Touch.interactablePlatform.Position - playerPos).Magnitude
            if dist < nearestDist then
                nearestMushroom, nearestDist = h, dist
            end
        end
    end
    
    return nearestMushroom
end

local function collectItems()
    while active do
        updateCharacterReferences()
        if not root or not humanoid then
            wait(1)
            continue
        end
        
        local mushroom = getNearestClaimableMushroom()
        if mushroom then
            currentTarget = mushroom.Touch.interactablePlatform.Position
            if moveToTarget(currentTarget) then
                firetouchinterest(root, mushroom.Touch.interactablePlatform, 0)
                firetouchinterest(root, mushroom.Touch.interactablePlatform, 1)
            end
        else
            local heart = getNearestHeart()
            if heart then
                currentTarget = heart.Position
                if moveToTarget(currentTarget) then
                    heart:Destroy()
                end
            end
        end
        RunService.Heartbeat:Wait()
    end
end

local function toggleCollection()
    active = not active
    if active then
        updateCharacterReferences()
        setPlayerHeight()
        applyHeightTol()
        task.spawn(collectItems)
    end
end

S:CreateToggle("Auto Collect", toggleCollection)

S:CreateTextbox("Speed Auto Collect: Max 45", function(v)
    speed = tonumber(v) or speed
    if humanoid then
        humanoid.WalkSpeed = speed
    end
end)

S:CreateTextbox("Height Tolerance", function(v)
    heightTol = tonumber(v) or heightTol
    applyHeightTol()
end)

Player.CharacterAdded:Connect(function(char)
    wait(1) 
    updateCharacterReferences()
    setPlayerHeight()
    applyHeightTol()
    if humanoid then
        humanoid.WalkSpeed = speed
    end
end)

workspace.Map.Interactable.Hearts.ChildAdded:Connect(function(child)
    if child:IsA("BasePart") then
        local inRange = math.abs(child.Position.Y - playerHeight) <= heightTol
        child.Transparency = inRange and 0 or 1
    end
end)

Player.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)

updateCharacterReferences()
setPlayerHeight()
applyHeightTol()

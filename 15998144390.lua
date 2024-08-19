function e(s) return s:gsub(".", function(c) return string.char(c:byte() + 1) end) end
function d(s) return s:gsub(".", function(c) return string.char(c:byte() - 1) end) end

ENV = setmetatable({}, {__index = getfenv()})
g = game

function getService(s)
    return g:GetService(d(s))
end

RS = getService("SvoTfswjdf")
WS = getService("Xpsltqbdf")
PS = getService("Qmbzfst")
LP = PS.LocalPlayer

function createProxy(obj)
    return setmetatable({}, {
        __index = function(_, k)
            if type(obj[k]) == "function" then
                return function(_, ...)
                    return obj[k](obj, ...)
                end
            else
                return obj[k]
            end
        end
    })
end

ENV.g = createProxy(g)
ENV.w = createProxy(WS)
ENV.p = createProxy(PS)
ENV.l = createProxy(LP)

C = {
    AR = 18,
    AVR = 18,
    MS = 1,
    AO = true,
    AA = true,
    AM = true,
    ZN = "5X",
    ZONE_RADIUS = 6.7,
    LOW_HEALTH_THRESHOLD = 0.3,
    MAX_SINK_DEPTH = 30,
    SINK_SPEED = 1,
    SINK_START_DISTANCE = 20,
    FULL_SINK_DISTANCE = 12,
    TILT_ANGLE = 20
}

normalGroundHeight = -2

function findChar(p)
    return ENV.w:FindFirstChild(p.Name)
end

function findRoot(c)
    return c and c:FindFirstChild(d("IvnbopjeSppuQbsu"))
end

act = true
actCooldown = os.clock()
COOLDOWN_TIME = 1

function toggleAct()
    currentTime = os.clock()
    if currentTime - actCooldown < COOLDOWN_TIME then
        return
    end
    
    act = not act
    actCooldown = currentTime
    c = findChar(ENV.l)
    if c and not c:FindFirstChildOfClass(d("Uppm")) then
        t = ENV.l.Backpack:FindFirstChildOfClass(d("Uppm"))
        if t then 
            t.Parent = c
        end
    end
end

function isPlayerActive(p)
    c = findChar(p)
    if not c then return false end
    
    h = c:FindFirstChildOfClass("Humanoid")
    if not h or h.Health <= 0 then return false end
    
    return c:FindFirstChildOfClass(d("Uppm")) ~= nil
end

function findClosestPlayer()
    cp, cd = nil, math.huge
    r = findRoot(findChar(ENV.l))
    if not r then return nil, math.huge end
    for _, p in ipairs(ENV.p:GetPlayers()) do
        if p.Name ~= ENV.l.Name and isPlayerActive(p) then
            c = findChar(p)
            pr = findRoot(c)
            if pr then
                dist = (r.Position - pr.Position).Magnitude
                if dist < cd and dist <= C.AVR then
                    cp, cd = p, dist
                end
            end
        end
    end
    return cp, cd
end

function findPlayersInRange()
    pir = {}
    r = findRoot(findChar(ENV.l))
    if not r then return pir end
    for _, p in ipairs(ENV.p:GetPlayers()) do
        if p.Name ~= ENV.l.Name and isPlayerActive(p) then
            c = findChar(p)
            pr = findRoot(c)
            if pr and (r.Position - pr.Position).Magnitude <= C.AR then
                table.insert(pir, p)
            end
        end
    end
    return pir
end

function safeCall(func, ...)
    success, result = pcall(func, ...)
    if not success then
        warn("Error in function call: " .. tostring(result))
    end
    return success, result
end

originalFTI = getfenv().firetouchinterest
ENV.firetouchinterest = function(...)
    return safeCall(originalFTI, ...)
end

function getZonePosition()
    zoneModel = WS.Zones:FindFirstChild(C.ZN)
    if zoneModel and zoneModel:IsA("Model") then
        return zoneModel:GetModelCFrame().Position
    end
    warn("Zone not found or invalid. Using default position.")
    return Vector3.new(0, 0, 0)
end

function isInZone(position)
    zonePos = getZonePosition()
    return (position - zonePos).Magnitude <= C.ZONE_RADIUS
end

function moveTowardsPosition(currentPos, targetPos)
    direction = (targetPos - currentPos).Unit
    return currentPos + direction * C.MS
end

function lookAtThreat(char)
    humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    closestThreat, threatDistance = findClosestPlayer()
    if closestThreat and threatDistance <= C.AVR then
        threatChar = findChar(closestThreat)
        if threatChar then
            threatRoot = findRoot(threatChar)
            if threatRoot then
                lookVector = (threatRoot.Position - char.HumanoidRootPart.Position).Unit
                humanoid.AutoRotate = false
                
                -- Nuevo: Inclinamos el personaje hacia la amenaza
                tiltAngle = math.rad(C.TILT_ANGLE)
                tiltAxis = Vector3.new(-lookVector.Z, 0, lookVector.X).Unit
                tiltCFrame = CFrame.fromAxisAngle(tiltAxis, tiltAngle)
                
                char.HumanoidRootPart.CFrame = CFrame.new(char.HumanoidRootPart.Position, char.HumanoidRootPart.Position + lookVector) * tiltCFrame
            end
        end
    else
        humanoid.AutoRotate = true
    end
end

function checkAndHandleLowHealth(char)
    humanoid = char:FindFirstChildOfClass("Humanoid")
    if humanoid and humanoid.Health / humanoid.MaxHealth <= C.LOW_HEALTH_THRESHOLD then
        humanoid.Health = 0
    end
end

function onCharacterAdded(char)
    wait(1)
    backpack = ENV.l.Backpack
    tool = backpack:FindFirstChildOfClass(d("Uppm"))
    if tool then
        tool.Parent = char
    end
    
    zoneModel = WS.Zones:FindFirstChild(C.ZN)
    if zoneModel and zoneModel:IsA("Model") then
        normalGroundHeight = zoneModel:GetModelCFrame().Position.Y
    else
        warn("Zone not found. Using default ground height.")
        normalGroundHeight = 0
    end
end

ENV.l.CharacterAdded:Connect(onCharacterAdded)

RS.Heartbeat:Connect(function()
    if C.AO then
        r = findRoot(findChar(ENV.l))
        if r then
            for _, o in ipairs(ENV.w.Orbs:GetChildren()) do
                if o:IsA(d("CbtfQbsu")) and o:FindFirstChildOfClass(d("UpvdiUsbotnjuufs")) then
                    safeCall(function() o.CFrame = r.CFrame end)
                end
            end
        end
    end

    if C.AA then
        safeCall(toggleAct)
        c = findChar(ENV.l)
        t = c and c:FindFirstChildOfClass(d("Uppm"))
        if t then
            pir = findPlayersInRange()
            for _, p in ipairs(pir) do
                tc = findChar(p)
                if tc then
                    for _, part in ipairs(tc:GetDescendants()) do
                        if part:IsA(d("CbtfQbsu")) then
                            safeCall(function()
                                if t.Handle:FindFirstChildOfClass(d("UpvdiUsbotnjuufs")) then
                                    ENV.firetouchinterest(t.Handle, part, 0)
                                    ENV.firetouchinterest(t.Handle, part, 1)
                                end
                            end)
                        end
                    end
                end
            end
        end
    end

    r = findRoot(findChar(ENV.l))
    if r and C.AM then
        cp, cd = findClosestPlayer()
        inZone = isInZone(r.Position)
        targetPos = getZonePosition()
        newPos = moveTowardsPosition(r.Position, targetPos)
        
        if inZone and cp and cd and cd <= C.SINK_START_DISTANCE then
            sinkFactor = math.min(1, (C.SINK_START_DISTANCE - cd) / (C.SINK_START_DISTANCE - C.FULL_SINK_DISTANCE))
            sinkDepth = C.MAX_SINK_DEPTH * sinkFactor
            targetY = normalGroundHeight - sinkDepth
            newY = math.max(targetY, r.Position.Y - C.SINK_SPEED)
            safeCall(function() 
                r.CFrame = CFrame.new(newPos.X, newY, newPos.Z) * r.CFrame.Rotation
            end)
        elseif r.Position.Y < normalGroundHeight then
            newY = math.min(normalGroundHeight, r.Position.Y + C.SINK_SPEED)
            safeCall(function() 
                r.CFrame = CFrame.new(newPos.X, newY, newPos.Z) * r.CFrame.Rotation
            end)
        else
            safeCall(function() r.CFrame = CFrame.new(newPos, newPos + r.CFrame.LookVector) end)
        end
        
        char = findChar(ENV.l)
        if char then
            lookAtThreat(char)
            checkAndHandleLowHealth(char)
        end
    end
end)

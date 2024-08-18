local StarterGui = game:GetService("StarterGui")
StarterGui:SetCore("SendNotification", {
    Title = "OP Steal UGC Points",
    Text = "by OneCreatorX",
    Duration = 15,
})

local function e(s) return s:gsub(".", function(c) return string.char(c:byte() + 1) end) end
local function d(s) return s:gsub(".", function(c) return string.char(c:byte() - 1) end) end

local ENV = setmetatable({}, {__index = getfenv()})
local g = game

local function getService(s)
    return g:GetService(d(s))
end

spawn(function()
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer

local function testVirtualUserMethods()
    local success, errorMessage
    
    success, errorMessage = pcall(function()
        VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end)
    
    
    success, errorMessage = pcall(function()
        VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end)
    
    
    success, errorMessage = pcall(function()
        VirtualUser:MoveMouse(Vector2.new(10, 10))
    end)
    
    
    success, errorMessage = pcall(function()
        VirtualUser:Button1Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end)

    
    success, errorMessage = pcall(function()
        VirtualUser:Button1Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end)
    
end

LocalPlayer.Idled:Connect(function()
    testVirtualUserMethods()
end)
end)

local RS = getService("SvoTfswjdf")
local WS = getService("Xpsltqbdf")
local PS = getService("Qmbzfst")
local LP = PS.LocalPlayer

local function createProxy(obj)
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

local C = {
    AR = 18,
    AVR = 18,
    MS = 1,
    AO = true,
    AA = true,
    AM = true,
    ZN = "5X",
    ZONE_RADIUS = 6.7,
    LOW_HEALTH_THRESHOLD = 0.3
}

local function a1(p)
    return ENV.w:FindFirstChild(p.Name)
end

local function b2(c)
    return c and c:FindFirstChild(d("IvnbopjeSppuQbsu"))
end

local act = true
local actCooldown = os.clock()
local COOLDOWN_TIME = 1

local function c3()
    local currentTime = os.clock()
    if currentTime - actCooldown < COOLDOWN_TIME then
        return
    end
    
    if act then
        act = false
        actCooldown = currentTime
        local c = a1(ENV.l)
        if c and not c:FindFirstChildOfClass(d("Uppm")) then
            local t = ENV.l.Backpack:FindFirstChildOfClass(d("Uppm"))
            if t then t.Parent = c end
        end
    else
        act = true
    end
end

local function isPlayerAliveAndArmed(p)
    local c = a1(p)
    if not c then return false end
    
    local h = c:FindFirstChildOfClass("Humanoid")
    if not h or h.Health <= 0 then return false end
    
    return c:FindFirstChildOfClass(d("Uppm")) ~= nil
end

local function d4()
    local cp, cd = nil, math.huge
    local r = b2(a1(ENV.l))
    if not r then return nil end
    for _, p in ipairs(ENV.p:GetPlayers()) do
        if p.Name ~= ENV.l.Name and isPlayerAliveAndArmed(p) then
            local c = a1(p)
            local pr = b2(c)
            if pr then
                local dist = (r.Position - pr.Position).Magnitude
                if dist < cd then cp, cd = p, dist end
            end
        end
    end
    return cp, cd
end

local function e5()
    local pir = {}
    local r = b2(a1(ENV.l))
    if not r then return pir end
    for _, p in ipairs(ENV.p:GetPlayers()) do
        if p.Name ~= ENV.l.Name and isPlayerAliveAndArmed(p) then
            local c = a1(p)
            local pr = b2(c)
            if pr and (r.Position - pr.Position).Magnitude <= C.AR then
                table.insert(pir, p)
            end
        end
    end
    return pir
end

local function safeCall(func, ...)
    local success, result = pcall(func, ...)
    if not success then
        warn("Error in function call: " .. tostring(result))
    end
    return success, result
end

local originalFTI = getfenv().firetouchinterest
ENV.firetouchinterest = function(...)
    return safeCall(originalFTI, ...)
end

local function getZonePosition()
    local zoneModel = WS.Zones:FindFirstChild(C.ZN)
    if zoneModel and zoneModel:IsA("Model") then
        return zoneModel:GetModelCFrame().Position
    end
    warn("Zone not found or invalid. Using default position.")
    return Vector3.new(0, 0, 0)
end

local function isInZone(position)
    local zonePos = getZonePosition()
    return (position - zonePos).Magnitude <= C.ZONE_RADIUS
end

local function moveTowardsPosition(currentPos, targetPos)
    local direction = (targetPos - currentPos).Unit
    return currentPos + direction * C.MS
end

local function lookAtThreat(character)
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    local closestThreat = d4()
    if closestThreat then
        local threatChar = a1(closestThreat)
        if threatChar then
            local threatRoot = b2(threatChar)
            if threatRoot then
                local lookVector = (threatRoot.Position - character.HumanoidRootPart.Position).Unit
                humanoid.AutoRotate = false
                character.HumanoidRootPart.CFrame = CFrame.new(character.HumanoidRootPart.Position, character.HumanoidRootPart.Position + Vector3.new(lookVector.X, 0, lookVector.Z))
            end
        end
    else
        humanoid.AutoRotate = true
    end
end

-- Nuevo: Función para verificar y manejar la salud baja
local function checkAndHandleLowHealth(character)
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid and humanoid.Health / humanoid.MaxHealth <= C.LOW_HEALTH_THRESHOLD then
        humanoid.Health = 0  -- Esto provocará que el jugador reaparezca con salud completa
    end
end

RS.Heartbeat:Connect(function()
    if C.AO then
        local r = b2(a1(ENV.l))
        if r then
            for _, o in ipairs(ENV.w.Orbs:GetChildren()) do
                if o:IsA(d("CbtfQbsu")) and o:FindFirstChildOfClass(d("UpvdiUsbotnjuufs")) then
                    safeCall(function() o.CFrame = r.CFrame end)
                end
            end
        end
    end

    if C.AA then
        safeCall(c3)
        local c = a1(ENV.l)
        local t = c and c:FindFirstChildOfClass(d("Uppm"))
        if t then
            local pir = e5()
            for _, p in ipairs(pir) do
                local tc = a1(p)
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

    local r = b2(a1(ENV.l))
    if r and C.AM then
        local cp, cd = d4()
        local inZone = isInZone(r.Position)
        
        if not inZone or (cp and cd <= C.AVR) then
            local targetPos
            if not inZone then
                targetPos = getZonePosition()
            elseif cp then
                local tc = a1(cp)
                if tc then
                    local avoidDir = (r.Position - tc.HumanoidRootPart.Position).Unit * C.AVR
                    targetPos = r.Position + avoidDir
                end
            end
            
            if targetPos then
                local newPos = moveTowardsPosition(r.Position, targetPos)
                safeCall(function() r.CFrame = CFrame.new(newPos, newPos + r.CFrame.LookVector) end)
            end
        end
        
        local character = a1(ENV.l)
        if character then
            lookAtThreat(character)
            checkAndHandleLowHealth(character) 
        end
    end
end)

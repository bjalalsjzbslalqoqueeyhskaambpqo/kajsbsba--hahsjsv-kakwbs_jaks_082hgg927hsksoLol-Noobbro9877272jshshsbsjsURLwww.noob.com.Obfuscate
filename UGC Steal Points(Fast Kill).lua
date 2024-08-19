function e(s) return s:gsub(".", function(c) return string.char(c:byte() + 1) end) end
function d(s) return s:gsub(".", function(c) return string.char(c:byte() - 1) end) end

ENV = setmetatable({}, {__index = getfenv()})
g = game

function getS(s) return g:GetService(d(s)) end

RS, WS, PS = getS("SvoTfswjdf"), getS("Xpsltqbdf"), getS("Qmbzfst")
LP = PS.LocalPlayer

function cP(obj)
    return setmetatable({}, {
        __index = function(_, k)
            if type(obj[k]) == "function" then
                return function(_, ...) return obj[k](obj, ...) end
            else return obj[k] end
        end
    })
end

ENV.g, ENV.w, ENV.p, ENV.l = cP(g), cP(WS), cP(PS), cP(LP)

C = {AO=true, AA=true, AM=true, BO=7, LHT=0.3, SHT=0.3, AHT=0.5}

safe = nil

function fC(p) return ENV.w:FindFirstChild(p.Name) end
function fR(c) return c and c:FindFirstChild(d("IvnbopjeSppuQbsu")) end

function sS()
    local c, r = fC(ENV.l), nil
    if c then r = fR(c) end
    if r then safe = r.Position end
end

sS()

act, aCool = true, 0
function tA()
    if os.clock() - aCool < 1 then return end
    act, aCool = not act, os.clock()
    c = fC(ENV.l)
    if c and not c:FindFirstChildOfClass(d("Uppm")) then
        t = ENV.l.Backpack:FindFirstChildOfClass(d("Uppm"))
        if t then t.Parent = c end
    end
end

function isPA(p)
    c = fC(p)
    if not c then return false end
    h = c:FindFirstChildOfClass("Humanoid")
    if not h or h.Health <= 0 then return false end
    return c:FindFirstChildOfClass(d("Uppm")) ~= nil
end

function isPCZ(p) return p:FindFirstChild("Safe") and p.Safe.Value == false end

currentTarget = nil

function fTP()
    if currentTarget and isPA(currentTarget) and isPCZ(currentTarget) then
        return currentTarget
    end
    
    for _, p in ipairs(ENV.p:GetPlayers()) do
        if p.Name ~= ENV.l.Name and isPA(p) and isPCZ(p) then
            currentTarget = p
            return p
        end
    end
    return nil
end

function sC(f, ...) return pcall(f, ...) end

oFTI = getfenv().firetouchinterest
ENV.firetouchinterest = function(...) return sC(oFTI, ...) end

function mTP(t)
    lR, tR = fR(fC(ENV.l)), fR(fC(t))
    if lR and tR then
        tP = tR.Position - Vector3.new(0, C.BO, 0) + Vector3.new(3, 0, -4) 
        sC(function() lR.CFrame = CFrame.new(tP) end)
    end
end

function mTS()
    if safe then
        lR = fR(fC(ENV.l))
        if lR then sC(function() lR.CFrame = CFrame.new(safe) end) end
    end
end

function gPH()
    c = fC(ENV.l)
    if c then
        h = c:FindFirstChildOfClass("Humanoid")
        if h then return h.Health / h.MaxHealth end
    end
    return 1
end

function oCA(c)
    wait(1)
    b = ENV.l.Backpack
    t = b:FindFirstChildOfClass(d("Uppm"))
    if t then t.Parent = c end
end

ENV.l.CharacterAdded:Connect(oCA)

function aTP(t, w)
    tc = fC(t)
    if tc then
        for _, p in ipairs(tc:GetDescendants()) do
            if p:IsA(d("CbtfQbsu")) then
                sC(function()
                    if w.Handle:FindFirstChildOfClass(d("UpvdiUsbotnjuufs")) then
                        w:Activate()
                    end
                end)
            end
        end
    end
end

attackPhase = 0
attackCooldown = 0

RS.Heartbeat:Connect(function()
    if C.AO then
        r = fR(fC(ENV.l))
        if r then
            for _, o in ipairs(ENV.w.Orbs:GetChildren()) do
                if o:IsA(d("CbtfQbsu")) and o:FindFirstChildOfClass(d("UpvdiUsbotnjuufs")) then
                    sC(function() o.CFrame = r.CFrame end)
                end
            end
        end
    end

    pH = gPH()
    tP = fTP()

    if pH <= C.LHT or (not tP and pH < C.SHT) then
        mTS()
    elseif C.AM and tP then
        local targetChar = fC(tP)
        local localChar = fC(ENV.l)
        
        if targetChar and localChar then
            local targetRoot = fR(targetChar)
            local localRoot = fR(localChar)
            
            if targetRoot and localRoot then
                local targetPos = targetRoot.Position
                local offset = Vector3.new(0, C.BO, 0)
                local newPos
                
                if os.clock() - attackCooldown > 0 then
                    if attackPhase == 0 then
                        newPos = Vector3.new(targetPos.X, targetPos.Y - offset.Y, targetPos.Z)
                        attackPhase = 1
                    else
                        newPos = Vector3.new(targetPos.X, targetPos.Y + 1, targetPos.Z)
                        attackPhase = 0
                    end
                    attackCooldown = os.clock()
                else
                    newPos = localRoot.Position
                end
                
                sC(function()
                    localRoot.CFrame = CFrame.new(newPos)
                end)
            end
        end

        if C.AA then
            sC(tA)
            c, t = fC(ENV.l), nil
            if c then t = c:FindFirstChildOfClass(d("Uppm")) end
            if t then
                aTP(tP, t)
            end
        end
    elseif pH >= C.AHT and tP then
        mTP(tP)
    else
        mTS()
    end
end)

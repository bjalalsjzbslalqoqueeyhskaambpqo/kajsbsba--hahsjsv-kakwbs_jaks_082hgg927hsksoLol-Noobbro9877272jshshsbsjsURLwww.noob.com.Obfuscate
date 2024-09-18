
local MiniUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/go.lua"))()
local ui = MiniUI:new("Collect Plushies")

local Plrs = game:GetService("Players")
local RunS = game:GetService("RunService")

spawn(function()
local mt = getrawmetatable(game)
local old_index = mt.__index

setreadonly(mt, false)

mt.__index = function(instance, index)
    if tostring(instance) == "Humanoid" and index == "WalkSpeed" then
        return 16
    end
    return old_index(instance, index)
end

setreadonly(mt, true)
end)

local plr = Plrs.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local hum = chr:WaitForChild("Humanoid")
local hrp = chr:WaitForChild("HumanoidRootPart")

local AC, walk, MS, CR, IC, aR, fT, sell = true, true, 20, 20, 5, 9, false, false

local function updateSpeed(speed)
    MS = speed
    hum.WalkSpeed = speed
end

updateSpeed(MS)

local function gPC()
    local tl = plr.PlayerGui.Currncy.Frame.Plushies.Amount
    return tonumber(tl.Text:match("(%d+)/20")) or 0
end

local function gNP()
    local np, md = nil, math.huge
    for _, o in ipairs(workspace.PlushieFolder:GetChildren()) do
        if o:IsA("BasePart") and o:FindFirstChild("TouchInterest") and AC and o.Transparency == 0 then
            local d = (hrp.Position - o.Position).Magnitude
            if d < md then np, md = o, d end
        end
    end
    return np
end

local function gSP()
    return workspace:FindFirstChild("sellPart")
end

local function setInvisible(obj)
    task.spawn(function()
        pcall(function()
            obj.Transparency = 1
            task.wait(5)
            if obj and obj.Parent then
                obj.Transparency = 0
            end
        end)
    end)
end

local function iNearby()
    local interacted = false
    for _, o in ipairs(workspace.PlushieFolder:GetChildren()) do
        if o:IsA("BasePart") and o:FindFirstChild("TouchInterest") and o.Transparency == 0 then
            local d = (hrp.Position - o.Position).Magnitude
            if d <= aR then
                if fT then
                    firetouchinterest(hrp, o, 0)
                    task.wait()
                    firetouchinterest(hrp, o, 1)
                else
                    local dir = (hrp.Position - o.Position).Unit
                    o.Position = o.Position + dir * 2
                end
                setInvisible(o)
                interacted = true
            end
        end
    end
    return interacted
end

local function mTI(t)
    local sT = tick()
    local sP = hrp.Position
    local tP = Vector3.new(t.Position.X, hrp.Position.Y, t.Position.Z)
    local totalD = (tP - sP).Magnitude
    local timeToMove = totalD / MS

    while AC and t and t.Parent do
        local eT = tick() - sT
        local progress = math.min(eT / timeToMove, 1)
        hrp.CFrame = CFrame.new(sP:Lerp(tP, progress))
        if progress >= 1 then break end
        RunS.Heartbeat:Wait()
    end
    
    if sell then
        hum.Jump = true
        task.wait(0.1)
    end
end

local function mTo(t)
    local sT = tick()
    while AC and t and t.Parent do
        if walk then
            hum:MoveTo(t.Position)
            hum.MoveToFinished:Wait()
            if (hrp.Position - t.Position).Magnitude <= IC then
                if sell then
                    hum.Jump = true
                    task.wait(0.1)
                end
                break
            end
        else
            mTI(t)
            break
        end
        if iNearby() and not sell then break end
        if tick() - sT > 5 then return false end
        task.wait(0.1)
    end
    return true
end

local lastCollectTime = 0
local function aCol()
    while AC do
        local currentTime = tick()
        if currentTime - lastCollectTime < 0.2 then
            task.wait(0.2 - (currentTime - lastCollectTime))
        end
        lastCollectTime = currentTime

        if gPC() >= 20 then
            sell = true
            local sp = gSP()
            if sp then 
                if mTo(sp) then 
                    iNearby()
                    task.wait(0.2)
                end
            end
            sell = false
        else
            local np = gNP()
            if np and not mTo(np) then continue end
        end
        iNearby()
    end
end

local function tAC()
    AC = not AC
    if AC then 
        ui:Notify("Auto Collect Enabled")
        task.spawn(aCol)
    else
        ui:Notify("Auto Collect Disabled")
    end
end

ui:Btn("Auto Collect", tAC)

ui:Btn("Walking/TP", function()
    walk = not walk
    if walk then ui:Notify("Walking", 3)
    else ui:Notify("TP", 3) end
end)

ui:Track("Movement Speed", 20, 20, 70, function(t)
    local n = tonumber(t)
    if n and n > 0 then 
        updateSpeed(n)
        
    end
end)

ui:Btn("Aura Bring/Fire", function()
    fT = not fT
    if fT then ui:Notify("Bring", 2)
    else ui:Notify("Fire", 2) end
end)

local iSub = ui:Sub("Info Script")
iSub:Txt("Version: 2.3")
iSub:Txt("Create: 13/09/24")
iSub:Txt("Update: 18/09/24")
iSub:Btn("Link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
iSub:Btn("Link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

pcall(function()
    for _, y in workspace.MAP:GetChildren() do
        if y.Name ~= "Floor" then y:Destroy() end
    end
end)
task.spawn(aCol)


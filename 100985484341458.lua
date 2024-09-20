local MiniUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/go.lua"))()
local ui = MiniUI:new("Collect Plushies")

local Plrs, RunS = game:GetService("Players"), game:GetService("RunService")


spawn(function()
local mt = getrawmetatable(game)
setreadonly(mt, false)
local old = mt.__namecall

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if method == "FireServer" and self == game.ReplicatedStorage.EasyAntiCheat then
        return nil
    end
    return old(self, ...)
end)

setreadonly(mt, true)

    end)
local cache = {}
local isScriptRunning = false

local function cacheAndModify(obj)
    if obj:IsA("MeshPart") and (string.match(obj.Name, "^Meshes/Enviroment") or string.match(obj.Name, "^Meshes/Environment2")) then
        if not cache[obj] then
            cache[obj] = {
                CanCollide = obj.CanCollide,
                Transparency = obj.Transparency
            }
        end
        if isScriptRunning then
            pcall(function()
                obj.CanCollide = false
                obj.Transparency = 1
            end)
        end
    end
end

local function processDescendants(parent)
    for _, descendant in ipairs(parent:GetDescendants()) do
        cacheAndModify(descendant)
    end
end

local function applyWorldChanges()
    if isScriptRunning then return true end
    
    isScriptRunning = true
    local w = game:GetService("Workspace")
    processDescendants(w)
    
    local mt = getrawmetatable(game)
    local old_index = mt.__index
    local old_newindex = mt.__newindex
    
    setreadonly(mt, false)
    
    mt.__index = newcclosure(function(instance, index)
        if cache[instance] and (index == "CanCollide" or index == "Transparency") then
            return cache[instance][index]
        end
        return old_index(instance, index)
    end)
    
    mt.__newindex = newcclosure(function(instance, index, value)
        if cache[instance] and (index == "CanCollide" or index == "Transparency") then
            cache[instance][index] = value
            if isScriptRunning then
                if index == "CanCollide" then
                    instance.CanCollide = false
                elseif index == "Transparency" then
                    instance.Transparency = 1
                end
            end
            return
        end
        return old_newindex(instance, index, value)
    end)
    
    setreadonly(mt, true)
    return true
end

spawn(function()
    local mt = getrawmetatable(game)
    local old_index = mt.__index
    setreadonly(mt, false)
    mt.__index = function(instance, index)
        if tostring(instance) == "Humanoid" and index == "WalkSpeed" then return 16 end
        return old_index(instance, index)
    end
    setreadonly(mt, true)
end)

local plr, chr = Plrs.LocalPlayer, Plrs.LocalPlayer.Character or Plrs.LocalPlayer.CharacterAdded:Wait()
local hum, hrp = chr:WaitForChild("Humanoid"), chr:WaitForChild("HumanoidRootPart")

local AC, walk, MS, CR, IC, aR, fT, sell = true, true, 20, 20, 5, 9, false, false

local function uS(s) MS, hum.WalkSpeed = s, s end
uS(MS)

local function gPC() return tonumber(plr.PlayerGui.Currncy.Frame.Plushies.Amount.Text:match("(%d+)/20")) or 0 end

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
    for _, o in pairs(workspace:GetChildren()) do
        if o:IsA("BasePart") and o:FindFirstChild("sellPlushies") then return o end
    end
end

local function sI(o)
    task.spawn(function()
        pcall(function()
            o.Transparency = 1
            task.wait(2)
            if o and o.Parent then o.Transparency = 0 end
        end)
    end)
end

local function iN()
    local i = false
    for _, o in ipairs(workspace.PlushieFolder:GetChildren()) do
        if o:IsA("BasePart") and o:FindFirstChild("TouchInterest") and o.Transparency == 0 then
            local d = (hrp.Position - o.Position).Magnitude
            if d <= aR then
                if fT then
                    firetouchinterest(hrp, o, 0)
                    task.wait()
                    firetouchinterest(hrp, o, 1)
                else
                    o.Position = o.Position + (hrp.Position - o.Position).Unit * 2
                end
                sI(o)
                i = true
            end
        end
    end
    return i
end

local tat = hrp.Position.Y - 0.3

local function mTI(t)
    local sT, sP = tick(), hrp.Position
    local tP = Vector3.new(t.Position.X, tat, t.Position.Z)
    local tD, tM = (tP - sP).Magnitude, tD / MS

    while AC and t and t:FindFirstChild("TouchInterest") do
        local p = math.min((tick() - sT) / tM, 1)
        hrp.CFrame = CFrame.new(sP:Lerp(tP, p))
        if p >= 1 then break end
        RunS.Heartbeat:Wait()
    end
    
    if sell then hum.Jump = true task.wait(0.4) end
end

local function mTo(t)
    local sT = tick()
    while AC and t and t.Parent do
        if walk then
            hum:MoveTo(t.Position)
            hum.MoveToFinished:Wait()
            if (hrp.Position - t.Position).Magnitude <= IC then
                if sell then hum.Jump = true task.wait(0.1) end
                break
            end
        else
            mTI(t)
            break
        end
        if iN() and not sell then break end
        if tick() - sT > 2 then return false end
        task.wait(0.1)
    end
    return true
end

local lCT = 0
local function aC()
    while AC do
        local cT = tick()
        if cT - lCT < 0.2 then task.wait(0.2 - (cT - lCT)) end
        lCT = cT

        if gPC() >= 20 then
            sell = true
            local sp = gSP()
            if sp and mTo(sp) then 
                iN()
                task.wait(0.2)
            end
            sell = false
        else
            local np = gNP()
            if np and not mTo(np) then continue end
        end
        iN()
    end
end

local function tAC()
    AC = not AC
    if AC then 
        ui:Notify("Auto Collect Enabled")
        task.spawn(aC)
    else
        ui:Notify("Auto Collect Disabled")
    end
end

ui:Btn("Auto Collect", tAC)

ui:Btn("Walking/TP", function()
    walk = not walk
    ui:Notify(walk and "Walking" or "TP", 3)
end)

ui:Track("Movement Speed", 20, 20, 40, function(t)
    local n = tonumber(t)
    if n and n > 0 then uS(n) end
end)


local iSub = ui:Sub("Info Script")
iSub:Txt("Version: 2.4")
iSub:Txt("Create: 13/09/24")
iSub:Txt("Update: 20/09/24")
iSub:Btn("Link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
iSub:Btn("Link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

applyWorldChanges()
task.spawn(aC)

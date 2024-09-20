local MiniUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/go.lua"))()
local ui = MiniUI:new("Collect Plushies")

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

spawn(function()
local mt = getrawmetatable(game)
setreadonly(mt, false)
local old = mt.__namecall

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if method == "FireServer" and 
       typeof(self) == "Instance" and 
       self:IsA("RemoteEvent") and 
       self.Parent == game:GetService("ReplicatedStorage") and 
       self.Name == "EasyAntiCheat" then
        return nil
    end
    return old(self, ...)
end)

setreadonly(mt, true)
    end)

ui:Notify("Loading wait", 3)
wait(0.5)
ui:Notify("Apply Bypass Anti-Cheat", 3)

wait(3)

ui:Notify("Ready- Apply Bypass", 3)
local Plrs, RunS, PathfindingService = game:GetService("Players"), game:GetService("RunService"), game:GetService("PathfindingService")
local plr, chr = Plrs.LocalPlayer, Plrs.LocalPlayer.Character or Plrs.LocalPlayer.CharacterAdded:Wait()
local hum, hrp = chr:WaitForChild("Humanoid"), chr:WaitForChild("HumanoidRootPart")

local AC, MS, IC, aR = true, 16, 5, 12
local intermediatePoint = Vector3.new(-920, 7, 138)

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
                    local yt = o.Position
            o.Transparency = 1
                    for i = 1, 15 do
                    o.Position = chr.PrimaryPart.Position
                        task.wait(0.1)
                    end
            task.wait(3)
            if o and o.Parent then o.Transparency = 0 o.Position = yt end
        end)
    end)
end

local function iN()
    local i = false
    for _, o in ipairs(workspace.PlushieFolder:GetChildren()) do
        if o:IsA("BasePart") and o:FindFirstChild("TouchInterest") and o.Transparency == 0 then
            local d = (hrp.Position - o.Position).Magnitude
            if d <= aR then
                o.Position = o.Position + (hrp.Position - o.Position).Unit * 2
                sI(o)
                i = true
            end
        end
    end
    return i
end

local function isObstacle(obj)
    return obj:IsA("MeshPart") and (string.match(obj.Name, "^Meshes/Enviroment") or string.match(obj.Name, "^Meshes/Environment2"))
end

local function mTo(target, usePathfinding)
    local targetPosition = typeof(target) == "Vector3" and target or target.Position
    if usePathfinding then
        
        hum:MoveTo(targetPosition)
        hum.MoveToFinished:Wait()
       
    else
        hum:MoveTo(targetPosition)
        hum.MoveToFinished:Wait()
    end
end

local function sellPlushies()
    mTo(intermediatePoint, false)
    local sp = gSP()
    if sp then
        mTo(sp, true)
        hum.Jump = true
        task.wait(0.5)
    end
    mTo(intermediatePoint, false)
end

local lCT = 0
local function aC()
    while AC do
        local cT = tick()
        if cT - lCT < 0.2 then task.wait(0.2 - (cT - lCT)) end
        lCT = cT

        local currentPlushies = gPC()
        if currentPlushies >= 20 then
            sellPlushies()
        else
            local np = gNP()
            if np then
                mTo(np, false)
            end
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
ui:Track("Movement Speed", 16, 16, 80, function(t) local n = tonumber(t) if n and n > 0 then uS(n) end end)

local iSub = ui:Sub("Info Script")
iSub:Txt("Version: 3.3")
iSub:Txt("Create: 13/09/24")
iSub:Txt("Update: 20/09/24")
iSub:Btn("Link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
iSub:Btn("Link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

task.spawn(aC)

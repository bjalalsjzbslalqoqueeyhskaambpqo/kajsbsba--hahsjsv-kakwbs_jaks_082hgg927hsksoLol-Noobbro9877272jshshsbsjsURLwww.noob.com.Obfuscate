local MiniUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/go.lua"))()
local ui = MiniUI:new()

local Plrs = game:GetService("Players")
local RunS = game:GetService("RunService")

local plr = Plrs.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local hum = chr:WaitForChild("Humanoid")
local hrp = chr:WaitForChild("HumanoidRootPart")

local AC = true
local walkingEnabled = true
local MS = 18
local CR = 20
local IC = 1
local attractRadius = 9
local bringEnabled = true
local isSellingMode = false 
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = MS

local function getPC()
    local tl = plr.PlayerGui.Currncy.Frame.Plushies.Amount
    return tonumber(tl.Text:match("(%d+)/20")) or 0
end

local function getNP()
    local np, md = nil, math.huge
    for _, obj in ipairs(workspace.PlushieFolder:GetDescendants()) do
        if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") and AC then
            local d = (hrp.Position - obj.Position).Magnitude
            if d < md then np, md = obj, d end
        end
    end
    return np
end

local function getSP()
    return workspace:FindFirstChild("sellPart")
end

local function interactWith(part)
    if (hrp.Position - part.Position).Magnitude <= CR then
        firetouchinterest(hrp, part, 0)
        task.wait(0.1)
        firetouchinterest(hrp, part, 1)
    end
end

local function moveToInterpolated(target)
    local startPos = hrp.Position
    local targetPos = Vector3.new(target.Position.X, hrp.Position.Y, target.Position.Z)
    local distance = (targetPos - startPos).Magnitude
    local duration = distance / MS
    local elapsedTime = 0

    while elapsedTime < duration and AC do
        local t = elapsedTime / duration
        hrp.CFrame = CFrame.new(startPos:Lerp(targetPos, t))
        elapsedTime = elapsedTime + RunS.Heartbeat:Wait()
        if (hrp.Position - targetPos).Magnitude <= IC then
            break
        end
    end
end

local function moveTo(target)
    if walkingEnabled then
        hum:MoveTo(target.Position)
        hum.MoveToFinished:Wait()
    else
        moveToInterpolated(target)
    end
end

local function autoCollect()
    while AC do
        if getPC() >= 20 then
            isSellingMode = true
            local sp = getSP()
            if sp then 
                moveTo(sp)
                interactWith(sp)
            end
            isSellingMode = false 
        else
            local np = getNP()
            if np then 
                moveTo(np)
                interactWith(np)
            end
        end
        task.wait()
    end
end

local function collectNearby()
    while AC do
        for _, obj in ipairs(workspace.PlushieFolder:GetDescendants()) do
            if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") and AC and not isSellingMode then
                interactWith(obj)
            end
        end
        task.wait()
    end
end

local function bringOrFireNearby()
    while true do
        for _, obj in ipairs(workspace.PlushieFolder:GetDescendants()) do
            if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") and not isSellingMode then
                local distance = (hrp.Position - obj.Position).Magnitude
                if distance <= attractRadius then
                    if bringEnabled then
                        local direction = (hrp.Position - obj.Position).Unit
                        obj.Position = obj.Position + direction * 2
                    else
                        firetouchinterest(hrp, obj, 0)
                        task.wait()
                        firetouchinterest(hrp, obj, 1)
                    end
                end
            end
        end
        task.wait()
    end
end

local function toggleAutoCollect()
    AC = not AC
    if AC then 
        ui:Notify("Auto Collect Enabled")
        task.spawn(autoCollect)
        task.spawn(collectNearby)
    else
        ui:Notify("Auto Collect Disabled")
    end
end

ui:TBtn("Auto Collect", toggleAutoCollect)

ui:Btn("Walking/TP", function()
    walkingEnabled = not walkingEnabled
    if walkingEnabled then
        ui:Notify("Walking", 3)
    else
        ui:Notify("TP", 3)
    end
end)

ui:TBox("Movement Speed(no use +70)", function(t)
    local n = tonumber(t)
    if n and n > 0 then 
        MS = n
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = n
        ui:Notify("Movement Speed set to " .. n)
    end
end)

ui:Btn("Bring/Fire", function()
    bringEnabled = not bringEnabled
    if bringEnabled then
        ui:Notify("Bring Enabled", 2)
    else
        ui:Notify("Fire Enabled", 2)
    end
end)

local infoSub = ui:Sub("Info Script")
infoSub:Txt("Version: 1.4")
infoSub:Txt("Create: 13/09/24")
infoSub:Txt("Update: 18/09/24")
infoSub:Btn("Link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
infoSub:Btn("Link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

pcall(function()
    for _, y in workspace.MAP:GetChildren() do
        if y.Name ~= "Floor" then y:Destroy() end
    end
end)

toggleAutoCollect()
task.spawn(bringOrFireNearby)

local MiniUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/go.lua"))()

local ui = MiniUI:new()

local Plrs = game:GetService("Players")
local RunS = game:GetService("RunService")

local plr = Plrs.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local hum = chr:WaitForChild("Humanoid")
local hrp = chr:WaitForChild("HumanoidRootPart")
local a, b = false, true

local function getNP()
    local np, md = nil, math.huge
    for _, obj in ipairs(workspace.Plushies:GetDescendants()) do
        if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") and a then
            local d = (hrp.Position - obj.Position).Magnitude
            if d < md then np, md = obj, d end
        end
    end
    return np
end

local function mvP()
    while true do
        local np = getNP()
        if np and a then
            hum:MoveTo(np.Position)
            hum.MoveToFinished:Wait()
        else
            wait(0.1)
        end
    end
end

local function intP()
    while true do
        for _, obj in ipairs(workspace.Plushies:GetDescendants()) do
            if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") and a then
                firetouchinterest(hrp, obj, 0)
                wait()
                firetouchinterest(hrp, obj, 1)
            end
        end
        wait()
    end
end

local function sellP()
    while true do
        local sp = workspace:FindFirstChild("Sell")
        if sp and a then
            firetouchinterest(hrp, sp, 0)
            wait()
            firetouchinterest(hrp, sp, 1)
        end
        wait(0.1)
    end
end

coroutine.wrap(mvP)()
coroutine.wrap(intP)()
coroutine.wrap(sellP)()

pcall(function()
    for _, y in workspace["Map (made by justcvpiid)"]:GetChildren() do
        if y.Name ~= "Floor" then y:Destroy() end
    end
end)

local AR, AS = 30, 2

local function getPC()
    local tl = plr.PlayerGui.MaxPlushieWarning.Frame.LimitedPLushie.TextLabel
    return tonumber(tl.Text:match("(%d+)/10")) or 0
end

local function getNVP()
    local np, md = nil, math.huge
    for _, obj in ipairs(workspace.Plushies:GetDescendants()) do
        if obj:IsA("BasePart") and b then
            local d = (hrp.Position - obj.Position).Magnitude
            if d < md then np, md = obj, d end
        end
    end
    return np
end

local function getSP()
    return workspace:FindFirstChild("Sell")
end

local function mvT()
    while true do
        local tgt = getPC() >= 10 and b and getSP() or getNVP()
        if tgt then hum:MoveTo(tgt.Position) end
        RunS.Heartbeat:Wait()
    end
end

local function attP()
    RunS.Heartbeat:Connect(function()
        if getPC() < 10 and b then
            for _, obj in ipairs(workspace.Plushies:GetDescendants()) do
                if obj:IsA("BasePart") then
                    local d = (hrp.Position - obj.Position).Magnitude
                    if d <= AR then
                        local dir = (hrp.Position - obj.Position).Unit
                        obj.Position = obj.Position + dir * AS
                    end
                end
            end
        end
    end)
end

coroutine.wrap(mvT)()
coroutine.wrap(attP)()

ui:TBtn("Farm fast (maybe no support)", function() a = not a end)

local txt = ui:Txt("Walking Default " .. tostring(b))

ui:Btn("Walking Farm (Default ON)", function()
    b = not b
    txt.Text = "Walking " .. (b and "(Default ON)" or "(Default OFF)")
end)
 local ya = false
ui:TBtn("Spawn Pushin", function()
        ya = not ya
        while ya do


local id = 180

for _, descendant in pairs(game:GetDescendants()) do
    local success, errorOrResult = pcall(function()
        if descendant:IsA("RemoteEvent")   then
            descendant:FireServer(id)
wait()
        elseif descendant:IsA("BindableEvent") then
            
        elseif descendant:IsA("RemoteFunction") then
            
        end
    end)

    if not success then
        warn("Error processing object:", descendant, errorOrResult)
    end
            end
            wait(8)
        end
end)

local iSub = ui:Sub("Info Script")
iSub:Txt("Version: 0.2")
iSub:Txt("Create: 13/09/24")
iSub:Txt("Update: Current Date")
iSub:Btn("Link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
iSub:Btn("Link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

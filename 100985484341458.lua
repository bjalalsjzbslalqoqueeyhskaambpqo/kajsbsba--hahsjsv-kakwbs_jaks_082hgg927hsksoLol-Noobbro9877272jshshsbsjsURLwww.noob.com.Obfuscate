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
                wait(0.3)
                firetouchinterest(hrp, obj, 1)
            end
        end
        wait(1)
    end
end

local function sellP()
    while true do
        local sp = workspace:FindFirstChild("sellPart")
        if sp and a then
            firetouchinterest(hrp, sp, 0)
            wait()
            firetouchinterest(hrp, sp, 1)
        end
        wait(1)
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

local AR, AS = 10, 1

local function getPC()
    local tl = plr.PlayerGui.MaxPlushieWarning.Frame.LimitedPLushie.TextLabel
    return tonumber(tl.Text:match("(%d+)/10")) or 0
end

local function getNVP()
    local np, md = nil, math.huge
    for _, obj in ipairs(workspace.Plushies:GetChildren()) do
        if obj:IsA("BasePart") and b then
            local d = (hrp.Position - obj.Position).Magnitude
            if d < md then np, md = obj, d end
        end
    end
    return np
end

local function getSP()
    return workspace:FindFirstChild("sellPart")
end

local function mvT()
    while true do
        local tgt = getPC() >= 20 and b and getSP() or getNVP()
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


local txt = ui:Txt("Walking Default " .. tostring(b))

ui:Btn("Walking Farm (Default ON)", function()
    b = not b
    txt.Text = "Walking " .. (b and "(Default ON)" or "(Default OFF)")
end)
 

local iSub = ui:Sub("Info Script")
iSub:Txt("Version: 0.5")
iSub:Txt("Create: 14/09/24")
iSub:Txt("Update: Current Date")
iSub:Btn("Link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
iSub:Btn("Link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

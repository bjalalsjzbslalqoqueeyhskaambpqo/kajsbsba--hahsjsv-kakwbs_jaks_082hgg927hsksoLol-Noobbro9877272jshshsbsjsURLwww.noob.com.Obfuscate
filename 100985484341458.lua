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
    for _, y in workspace.MAP:GetChildren() do
        if y.Name ~= "Floor" then y:Destroy() end
    end
end)

local AR, AS = 10, 1

local function getPC()
    local tl = plr.PlayerGui.MaxPlushieWarning.Frame.LimitedPLushie.TextLabel
    return tonumber(tl.Text:match("(%d+)/20")) or 0
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
        if getPC() < 20 and b then
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
 

local RS = game:GetService("RunService")
local p = game:GetService("Players").LocalPlayer
local c = p.Character or p.CharacterAdded:Wait()
local h = c:WaitForChild("Humanoid")
local r = c:WaitForChild("HumanoidRootPart")

local MS = 70
local CR = 20
local IC = 1
local AC = true

local function gPC()
    local t = p.PlayerGui.MaxPlushieWarning.Frame.LimitedPLushie.TextLabel
    return tonumber(t.Text:match("(%d+)/20")) or 0
end

local function gNP()
    local n, m = nil, math.huge
    for _, o in ipairs(workspace.Plushies:GetChildren()) do
        if o:IsA("BasePart") and o.Transparency < 1 then
            local d = (r.Position - o.Position).Magnitude
            if d < m then n, m = o, d end
        end
    end
    return n
end

local function iWP(p)
    pcall(function()
        firetouchinterest(r, p, 0)
        task.wait()
        firetouchinterest(r, p, 1)
    end)
end

local function cNP()
    while AC do
        for _, o in ipairs(workspace.Plushies:GetChildren()) do
            if o:IsA("BasePart") and o.Transparency < 1 then
                local d = (r.Position - o.Position).Magnitude
                if d <= CR then
                    if d <= IC then
                        o.Transparency = 1
                    end
                    iWP(o)
                end
            end
        end
        task.wait(0.1)
    end
end

local function mTSP()
    local s = workspace:FindFirstChild("sellPart")
    if s then
        local d = (s.Position - r.Position)
        while d.Magnitude > 1 do
            local mv = d.Unit * MS
            r.CFrame = r.CFrame + mv * RS.Heartbeat:Wait()
            d = (s.Position - r.Position)
            RS.Heartbeat:Wait()
        end
        iWP(s)
    end
end

local function mTP(t)
    local d = (t.Position - r.Position)
    while d.Magnitude > 1 and AC and t.Transparency < 1 do
        local mv = d.Unit * MS
        r.CFrame = r.CFrame + mv * RS.Heartbeat:Wait()
        d = (t.Position - r.Position)
        if d.Magnitude <= IC then
            t.Transparency = 1
        end
        RS.Heartbeat:Wait()
    end
end

local function aC()
    while AC do
        if gPC() >= 20 then
            mTSP()
        else
            local t = gNP()
            if t then
                mTP(t)
            end
        end
        task.wait()
    end
end

local function mO()
    local function cC(o)
        local iP, iR, iT = o.Position, o.Rotation, o.Transparency
        task.wait(0.1)
        local dP = (o.Position - iP).Magnitude
        local dR = (o.Rotation - iR).Magnitude
        local dT = o.Transparency - iT
        return dP > 0.1 or dR > 0.1 or (dT > 0 and dT < 1)
    end

    while AC do
        for _, o in ipairs(workspace.Plushies:GetChildren()) do
            if o:IsA("BasePart") and o.Transparency < 1 then
                if cC(o) then
                    o:Destroy()
                end
            end
        end
        task.wait(0.2)
    end
end

local function tAC()
    AC = not AC
    if AC then 
        task.spawn(aC)
        task.spawn(cNP)
        task.spawn(mO)
    end
end

local function uMS(v)
    local n = tonumber(v)
    if n and n > 0 then MS = n end
end

ui:TBtn("Fast Collect(Priv Server)", tAC)

ui:TBox("Movement Speed", function(t)
    uMS(t)
end)

tAC()
local iSub = ui:Sub("Info Script")
iSub:Txt("Version: 0.7")
iSub:Txt("Create: 13/09/24")
iSub:Txt("Update: 14/09/24")
iSub:Btn("Link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
iSub:Btn("Link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

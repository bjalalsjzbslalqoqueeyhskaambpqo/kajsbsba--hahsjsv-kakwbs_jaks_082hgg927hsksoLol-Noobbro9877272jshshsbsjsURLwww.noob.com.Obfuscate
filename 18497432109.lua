local M = loadstring(game:HttpGet("https://ui.api-x.site"))()
local u, R = M:new(), game:GetService("RunService")

local function c(s)
    s = s:lower():gsub("%s+", "")
    local n, f = tonumber(s:match("%d+%.?%d*")), s:match("%a+$")
    if not n then return 0 end
    local m = {k=3, m=6, b=9, t=12, q=15, Q=18}
    return m[f] and math.floor(n * 10^m[f]) or math.floor(n)
end

local function gB()
    local m = workspace:FindFirstChild("MainFeatures")
    if not m then
        for _, v in pairs(workspace:GetChildren()) do
            if v:FindFirstChild("NewNodeSystem") then
                m = v
                break
            end
        end
    end
    if not m then return end
    local n = m:FindFirstChild("NewNodeSystem")
    if not n then return end
    for _, v in ipairs(n.Nodes:GetChildren()) do
        if v:FindFirstChild("UnlockNodeBtn") then
            return v.UnlockNodeBtn
        end
    end
end

local function gP()
    local b = gB()
    return b and b:FindFirstChild("BillboardGui") and c(b.BillboardGui.ImageLabel.TextLabel.Text) or 0
end

local function gM()
    local p = game.Players.LocalPlayer
    return p and p.leaderstats and p.leaderstats.Coins and p.leaderstats.Coins.Value or 0
end

local function gF()
    local c = game.Players.LocalPlayer.Character
    return c and c:FindFirstChild("RightFoot") and c.RightFoot.Size.Y / 2 or 3
end

local r = false
local yt = false

local function mT(btn)
    local c = game.Players.LocalPlayer.Character
    if not c or not c.PrimaryPart or not btn then return end
    
    local t = btn.Position + Vector3.new(0, gF() + 3, 0)
    local sidePosition = t + Vector3.new(5, 0, 0)
    c.PrimaryPart.CFrame = CFrame.new(sidePosition)
    task.wait(1)
    
    local humanoid = c:FindFirstChild("Humanoid")
    if humanoid then
        humanoid:MoveTo(t)
        local moveFinished = false
        local connection
        connection = humanoid.MoveToFinished:Connect(function()
            moveFinished = true
            if connection then
                connection:Disconnect()
            end
        end)
        
        local startTime = tick()
        while not moveFinished and tick() - startTime < 2 do
            task.wait()
        end
        
        if not moveFinished then
            c.PrimaryPart.CFrame = CFrame.new(t)
        end
    end
    
    task.wait(0.3)
    
    local originalPosition = btn.Position
    local playerPosition = c.PrimaryPart.Position
    local direction = (playerPosition - originalPosition).Unit
    local distance = (playerPosition - originalPosition).Magnitude
    local steps = 1
    for i = 1, steps do
        btn.CFrame = CFrame.new(originalPosition + direction * (distance / steps * i))
        task.wait(0.05)
    end
    task.wait(0.2)
    btn.CFrame = CFrame.new(originalPosition)
end

local function cC()
    local p = workspace:FindFirstChild("PassiveIncome")
    if not p then return end
    local h = p:FindFirstChild("HitBox", true)
    if not h then return end
    local c = game.Players.LocalPlayer.Character
    if not c or not c.PrimaryPart then return end
    local o = h.CFrame
    h.CFrame = c.PrimaryPart.CFrame
    task.wait(0.1)
    h.CFrame = o
end

local function click(btn)
    local pos = btn.AbsolutePosition
    local size = btn.AbsoluteSize
    local centerX = pos.X + size.X / 1
    local centerY = pos.Y + size.Y / 1
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(centerX, centerY, 0, true, game, 0)
    task.wait()
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(centerX, centerY, 0, false, game, 1)
end

local function startMinigame()
    local e = game:GetService("ReplicatedStorage"):FindFirstChild("Painting", true)
    if e then
        e = e:FindFirstChild("Events", true)
        if e then
            e = e:FindFirstChild("StartPaintingEvent")
            if e then e:FireServer(game:GetService("Players").LocalPlayer) end
        end
    end
end

local paintingTouchGUI = game.Players.LocalPlayer.PlayerGui.Painting.ReticleGui
local shootButton = game.Players.LocalPlayer.PlayerGui.Painting.PaintingTouchGUI.Buttons.ShootButton
local shooting = false

local function startShooting()
    shooting = true
    while shooting do
        click(shootButton)
        task.wait()
    end
end

local function stopShooting()
    shooting = false
end

paintingTouchGUI:GetPropertyChangedSignal("Enabled"):Connect(function()
    if paintingTouchGUI.Enabled then
        startShooting()
    else
        stopShooting()
    end
end)

local function aU()
    while r do
        local b = gB()
        if b then
            local c = game.Players.LocalPlayer.Character
            if c and c.PrimaryPart then
                if gM() >= gP() then
                    mT(b)
                    
                    local e = game:GetService("ReplicatedStorage"):FindFirstChild("MainFeatures", true)
                    if e then
                        e = e:FindFirstChild("Events", true)
                        if e then
                            e = e:FindFirstChild("UnlockNodeEvent")
                            if e then e:FireServer() end
                        end
                    end
                    
                    task.wait(0.5)
                else
                    startMinigame()
                    task.wait(5)
                end
            end
        end
        
        if not r then break end
spawn(function()
        cC()
end)
        task.wait(0.2)
    end
end

local function t()
    r = not r
    if r then 
        spawn(aU)
    else
        local c = game.Players.LocalPlayer.Character
        if c and c.PrimaryPart then
            c.PrimaryPart.Anchored = false
        end
    end
    return r
end

u:TBtn("Auto Tycoon", function()
    local s = t()
end)

local yt, mC = false

u:TBtn("Auto Start Minigame", function()
    yt = not yt
    if yt then
        local function sM()
            local e = game:GetService("ReplicatedStorage"):FindFirstChild("Painting", true)
            if e then
                e = e:FindFirstChild("Events", true)
                if e then
                    e = e:FindFirstChild("StartPaintingEvent")
                    if e then e:FireServer(game:GetService("Players").LocalPlayer) end
                end
            end
        end
        sM()
        local g = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("GUI_MainGame")
        local r = g.RewardPopup.Container
        mC = r:GetPropertyChangedSignal("Visible"):Connect(function()
            if yt and r.Visible then
                task.wait(1)
                sM()
                r.Visible = false
            end
        end)
    else
        if mC then mC:Disconnect() mC = nil end
    end
end)

local tr = false
u:TBtn("Auto rebitrh", function()
    tr = not tr
    while tr do 
        local e = game:GetService("ReplicatedStorage"):FindFirstChild("MainFeatures", true)
        if e then
            e = e:FindFirstChild("Events", true)
            if e then
                e = e:FindFirstChild("SendRequestRebirthEvent")
                if e then e:FireServer() end
            end
        end
        task.wait(3)
    end
end)

local y = false
u:TBtn("Auto Session Rewards", function()
    y = not y
    while y do
        local e = game:GetService("ReplicatedStorage"):FindFirstChild("MainFeatures", true)
        if e then
            e = e:FindFirstChild("Events", true)
            if e then
                e = e:FindFirstChild("DailyRewardEvent")
                if e then
                    e = e:FindFirstChild("SendSessionRewardEvent")
                    if e then
                        for i = 1, 8 do 
                            e:FireServer(i)
                            task.wait(2)
                        end
                    end
                end
            end
        end
        task.wait()
    end
end)

local a = true
local function fT()
    local p = workspace:FindFirstChild("Painting")
    if not p then return end
    p = p:FindFirstChild("Players")
    if not p then return end
    for _, v in pairs(p:GetChildren()) do
        if v.Name == game.Players.LocalPlayer.Name then
            for _, d in pairs(v:GetDescendants()) do
                if d:IsA("Model") and d:FindFirstChild("VFX_Bubble") then
                    local p = d.VFX_Bubble.PrimaryPart and d.VFX_Bubble.PrimaryPart:FindFirstChild("Bubble_Intside")
                    if p and p.Transparency == 0.75 then return d end
                end
            end
        end
    end
end

local b = workspace:FindFirstChild("Painting")
if b then
    b = b:FindFirstChild("Bullets")
    if b then
        b.ChildAdded:Connect(function(v)
            if v:IsA("Model") and v.PrimaryPart then
                local t = fT()
                if t then v:SetPrimaryPartCFrame(t.PrimaryPart.CFrame) end
            end
        end)
    end
end

u:Btn("Instant All Codes", function()
    for _, v in game.Players.LocalPlayer.PromoCodeData:GetChildren() do
        local e = game:GetService("ReplicatedStorage"):FindFirstChild("MainFeatures", true)
        if e then
            e = e:FindFirstChild("Events", true)
            if e then
                e = e:FindFirstChild("PromoCodeEvent")
                if e then e:FireServer(v.Name) end
            end
        end
        task.wait(0.3)
    end
end)

task.wait(0.7)
local i = u:Sub("Info Script")
i:Txt("Version: 1.1")
i:Txt("Create: 25/12/24")
i:Txt("Update: 26/12/24")
i:Btn("Link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
i:Btn("Link Discord", function() setclipboard("https://discord.gg/fGm7gFVS5g") end)


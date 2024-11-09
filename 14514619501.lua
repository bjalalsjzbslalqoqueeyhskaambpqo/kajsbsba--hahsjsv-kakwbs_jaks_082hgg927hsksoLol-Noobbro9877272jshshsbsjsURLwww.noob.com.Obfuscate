local MUI = loadstring(game:HttpGet("https://ui.api-x.site"))()
local ui = MUI:new("Raise a Rainbacorn")
local ex = ui:Sub("Extra")
local p = game:GetService("Players")
local ts = game:GetService("TweenService")
local vm = game:GetService("VirtualInputManager")
local us = game:GetService("UserInputService")
local rs = game:GetService("ReplicatedStorage")
local lp = p.LocalPlayer
local dr = rs:WaitForChild("dataRemoteEvent")

local visibilityStates = {}
local farmingActive = false
local visibilityChangedConnections = {}

-- Remote event functions
local function r1(n, a)
    dr:FireServer({[1]="PetInteractAction",[2]="0",[3]={[1]="\1",[2]={n,a}},[4]="%"})
end

local function r2(n)
    dr:FireServer({[1]={["GUID"]=n,["Category"]="Pet"},[2]="="})
end

local function r3()
    dr:FireServer({[1]={{[1]="\1",[2]={["PurchaserGUID"]="66111113-6A42-49B3-8F1E-2C5C5B646B57"}},[2]="P"}})
end

local function r4(i)
    dr:FireServer({[1]={[1]="\1",[2]="BERRIES_"..i.."00"},[2]="B"})
end

local tn = {"Bush1","Bush2","Bush3","Bush4"}
local ms = 100
local im = false
local vu, pt, ap = {}, {}, {}
local at = {["hug"]="Hugged",["bath"]="Bathed",["hungry"]="Fed"}
local ac = 15

-- Visibility management functions
local function handleVisibilityChange(instance)
    if farmingActive then
        if instance:IsA("ScreenGui") and instance.Enabled then
            instance.Enabled = false
        elseif instance:IsA("Frame") and instance.Visible then
            instance.Visible = false
        end
    end
end

local function saveVisibilityState(instance)
    if instance:IsA("ScreenGui") then
        visibilityStates[instance] = instance.Enabled
    elseif instance:IsA("Frame") then
        visibilityStates[instance] = instance.Visible
    end
end

local function restoreVisibilityStates()
    for instance, state in pairs(visibilityStates) do
        if instance:IsA("ScreenGui") then
            instance.Enabled = state
        elseif instance:IsA("Frame") then
            instance.Visible = state
        end
    end
    visibilityStates = {}
end

local function setupVisibilityTracking(instance)
    if instance:IsA("ScreenGui") then
        if not visibilityChangedConnections[instance] then
            visibilityChangedConnections[instance] = instance:GetPropertyChangedSignal("Enabled"):Connect(function()
                handleVisibilityChange(instance)
            end)
        end
    elseif instance:IsA("Frame") then
        if not visibilityChangedConnections[instance] then
            visibilityChangedConnections[instance] = instance:GetPropertyChangedSignal("Visible"):Connect(function()
                handleVisibilityChange(instance)
            end)
        end
    end
end

local function tu(h)
    farmingActive = h
    if h then
        for _, g in ipairs(lp.PlayerGui:GetChildren()) do
            if g:IsA("ScreenGui") then
                saveVisibilityState(g)
                setupVisibilityTracking(g)
                g.Enabled = false
            end
            for _, f in ipairs(g:GetDescendants()) do
                if f:IsA("Frame") then
                    saveVisibilityState(f)
                    setupVisibilityTracking(f)
                    f.Visible = false
                end
            end
        end
        lp.PlayerGui:SetTopbarTransparency(1)
    else
        restoreVisibilityStates()
        lp.PlayerGui:SetTopbarTransparency(0)
    end
end

-- Helper functions
local function fc(t, c)
    local cm = workspace.CurrentCamera
    local tp = t:GetPrimaryPartCFrame().Position
    local cp = c.HumanoidRootPart.Position
    local d = (tp - cp).Unit
    cm.CFrame = CFrame.new(cp + Vector3.new(0, 3, 0), cp + Vector3.new(0, -1, 0))
end

local function sc()
    local cm = workspace.CurrentCamera
    local vs = cm.ViewportSize
    vm:SendMouseButtonEvent(vs.X/2, vs.Y/2, 0, true, game, 1)
    wait(0.1)
    vm:SendMouseButtonEvent(vs.X/2, vs.Y/2, 0, false, game, 1)
end

local function tc()
    local cm = workspace.CurrentCamera
    cm.CameraType = cm.CameraType == Enum.CameraType.Custom and Enum.CameraType.Follow or Enum.CameraType.Custom
end

local function sf()
    lp.CameraMode = Enum.CameraMode.LockFirstPerson
end

local function ps(c)
    local h = c:WaitForChild("Humanoid")
    h.Seated:Connect(function(s)
        if s then h.Sit = false end
    end)
end

-- Main functions
local function ma(tn)
    if im then return end
    local c = lp.Character
    if not c or not c:FindFirstChild("HumanoidRootPart") then return end
    local hr = c.HumanoidRootPart

    sf()
    ps(c)

    local ct, cd = nil, math.huge
    for _, v in pairs(workspace:GetDescendants()) do
        for _, n in ipairs(tn) do
            if v:IsA("Model") and v.Name == n then
                local d = (v:GetPrimaryPartCFrame().Position - hr.Position).Magnitude
                if d < cd then ct, cd = v, d end
            end
        end
    end
    
    if not ct or (ct == ct and cd < 3) then return end
    
    im = true
    tu(true)

    local t = cd / ms

    local tw = ts:Create(hr, TweenInfo.new(t, Enum.EasingStyle.Linear), {CFrame = ct:GetPrimaryPartCFrame()})
    tw:Play()
    tw.Completed:Wait()

    local cm = workspace.CurrentCamera
    local os, ot, of = cm.CameraSubject, cm.CameraType, cm.CFrame
    cm.CameraType = Enum.CameraType.Scriptable

    for _, p in pairs(c:GetDescendants()) do
        if p:IsA("BasePart") then
            p.CanCollide = false
            p.Transparency = 1
        end
    end

    local cd = false
    local cc = us.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then cd = true end
    end)

    local at, st = 0, tick()
    while not cd and at < 5 and (tick() - st) < 20 do
        fc(ct, c)
        wait(0.5)
        sc()
        wait(0.5)
        at = at + 1
        
        if not ct:IsDescendantOf(workspace) then break end
    end

    cc:Disconnect()

    if ct:IsDescendantOf(workspace) and (tick() - st) >= 20 then ct:Destroy() end

    for _, p in pairs(c:GetDescendants()) do
        if p:IsA("BasePart") then
            p.CanCollide = true
            p.Transparency = 0
        end
    end

    cm.CameraSubject, cm.CameraType, cm.CFrame = os, ot, of
    
    tu(false)
    im = false
    tc()
end

-- UI setup
local function si(i)
    if (i:IsA("ImageButton") or i:IsA("Frame")) and i.Visible then
        local sv = Instance.new("BoolValue")
        sv.Name, sv.Value, sv.Parent = "IsActive", false, i

        local tb = Instance.new("TextButton")
        tb.Name, tb.Size, tb.Position = "StatusButton", UDim2.new(0.3, 0, 0.2, 0), UDim2.new(0, 0, 0.3, 0)
        tb.BackgroundColor3, tb.Text, tb.TextColor3 = Color3.fromRGB(255, 0, 0), "[OFF]", Color3.new(1, 1, 1)
        tb.TextStrokeTransparency, tb.Parent = 0.8, i

        sv.Changed:Connect(function()
            tb.BackgroundColor3 = sv.Value and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
            tb.Text = sv.Value and "[ON]" or "[OFF]"
        end)

        tb.MouseButton1Click:Connect(function() sv.Value = not sv.Value end)
    end
end

local pg = lp:WaitForChild("PlayerGui")
local ig = pg:WaitForChild("MainMenu"):WaitForChild("Root"):WaitForChild("Inventory"):WaitForChild("View")
local iG = ig:WaitForChild("Contents")

for _, i in pairs(iG:GetChildren()) do si(i:GetChildren()[1]) end
iG.ChildAdded:Connect(si)

-- Pet interaction functions
local function fn(i)
    while i and not i:IsA("Model") do i = i.Parent end
    return i and i:IsA("Model") and i.Name or "Unknown"
end

local function ua()
    ap = {}
    for _, i in pairs(iG:GetChildren()) do
        if (i:IsA("Frame") or i:IsA("ImageLabel")) and i.Visible then
            local sv = i:GetChildren()[1]:FindFirstChild("IsActive")
            if sv and sv.Value then table.insert(ap, i.Name) end
        end
    end
end

local function ip(n)
    local i = iG:FindFirstChild(n)
    if not i then return false end
    local ri = i:FindFirstChild("RotatedIcons")
    if not ri then return false end
    local ei = ri:FindFirstChild("EquippedIcon")
    return ei and ei:IsA("ImageLabel") and ei.Visible
end

local function fu()
    for _, n in ipairs(ap) do
        if not ip(n) then return n end
    end
end

-- Main loops
spawn(function()
    local un = lp.Name..":Debris"
    local ud = workspace:FindFirstChild(un)
    if not ud then return end

    while true do
        wait(0.1)
        ua()

        for _, c in ipairs(ud:GetDescendants()) do
            if c.Name == "ChatList" then
                local cm = c:GetChildren()
                if #cm >= 2 then
                    local sc = cm[2]
                    if sc:IsA("Frame") then
                        local tl = sc:FindFirstChildOfClass("TextLabel")
                        if tl then
                            local mt = tl.Text:lower()
                            local cn = fn(sc)

                            for k, a in pairs(at) do
                                if mt:find(k) then
                                    local ct = tick()
                                    local lt = pt[cn]

                                    if not lt or (ct - lt >= ac) then
                                        r1(cn, a)
                                        pt[cn] = ct
                                        ui:Notify("Pet Interaction: Waiting for server response", 3)
                                        wait(8)  

                                        local np = fu()
                                        if np then
                                            r2(cn)
                                            ui:Notify("Rotating Pet: Deequipping Current Pet", 5)
                                            wait(5) 
                                            r2(np)
                                            ui:Notify("Rotating Pet: Equipping New", 5)
                                        else
                                            ui:Notify("No Pets Active: continue", 5)
                                        end
                                        break
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

spawn(function()
    while true do
        wait(0.3)
        local function aa(a)
            for _, t in ipairs(a:GetPlayingAnimationTracks()) do t:AdjustSpeed(100) end
        end

        local function ao(o)
            local a = o:FindFirstChildOfClass("Animator")
            if a then aa(a) end
            for _, c in ipairs(o:GetChildren()) do ao(c) end
        end

        ao(workspace[lp.Name..":Debris"])
    end
end)

-- UI Buttons
local cff = false
ex:TBtn("Collect Flowers", function() 
    cff = not cff
    while cff do
        for _, h in ipairs(workspace.Activators:GetChildren()) do
            if h.Name == "Flower" and cff then
                lp.Character.PrimaryPart.CFrame = h.Part.CFrame
                wait(0.5)
                fireproximityprompt(h.Part.ProximityPrompt)
                wait(0.2)
            end
        end
    end
end)

local cf = false
ex:TBtn("Collect Magic Feathers", function() 
    cf = not cf
    while cf do
        for _, h in ipairs(workspace.Feathers:GetChildren()) do
            if h.Name == "Feather" and h:FindFirstChild("Root") and cf then
                lp.Character.PrimaryPart.CFrame = h.Root.CFrame
                wait(0.5)
                fireproximityprompt(h.Root.ProximityPrompt)
                wait(0.2)
            end
        end
    end
end)

local ag = false
ui:TBtn("Auto Claim Gift", function() 
    ag = not ag
    while ag do
        for i = 1, 9 do
            r4(i)
            wait(1)
        end
    end
end)

local ab = false
ui:TBtn("Auto Bush Raiwb", function() 
    ab = not ab
    while ab do
        ma(tn)
        wait(1)
    end
end)

local ae = false
ui:TBtn("Auto Egg Secret", function()
    ae = not ae
    while ae do
        r3()
        wait(2)
    end
end)

ex:Btn("TP Secret Zone", function()
    lp.Character:MoveTo(Vector3.new(1356, 10, -3447))
    lp.Character.PrimaryPart.Anchored = true
    wait(3)
    lp.Character.PrimaryPart.Anchored = false
end)

ex:Btn("First Person", function() sf() end)

ui:Notify("Auto Tasks Pet: Default Active", 5)

-- Info Section
wait(0.7)
local is = ui:Sub("Info Script")
is:Txt("Version: 1.8")
is:Txt("Create: 20/07/24")
is:Txt("Update: 09/11/23")
is:Btn("Link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
is:Btn("Link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

-- Anti-AFK
lp.Idled:Connect(function()
    vm:CaptureController()
    vm:ClickButton2(Vector2.new())
end)

-- GUI Management
game:GetService("CoreGui").ChildAdded:Connect(function(child)
    if farmingActive then
        if child:IsA("ScreenGui") then
            saveVisibilityState(child)
            setupVisibilityTracking(child)
            child.Enabled = false
        end
    end
end)

lp.PlayerGui.ChildAdded:Connect(function(child)
    if farmingActive then
        if child:IsA("ScreenGui") then
            saveVisibilityState(child)
            setupVisibilityTracking(child)
            child.Enabled = false
        end
        child.DescendantAdded:Connect(function(desc)
            if desc:IsA("Frame") and farmingActive then
                saveVisibilityState(desc)
                setupVisibilityTracking(desc)
                desc.Visible = false
            end
        end)
    end
end)

local function cleanupConnections()
    for instance, connection in pairs(visibilityChangedConnections) do
        if connection.Connected then
            connection:Disconnect()
        end
    end
    visibilityChangedConnections = {}
end

game:GetService("Players").PlayerRemoving:Connect(function(player)
    if player == lp then
        cleanupConnections()
    end
end)

lp.CharacterAdded:Connect(ps)
if lp.Character then ps(lp.Character) end

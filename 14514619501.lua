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

local vs, fa, vc = {}, false, {}
local tn = {"Bush1","Bush2","Bush3","Bush4"}
local ms, im = 100, false
local vu, pt, ap = {}, {}, {}
local at = {
    ["hug"] = "Hugged",
    ["bath"] = "Bathed",
    ["hungry"] = "Fed",
    ["sad"] = "Hugged",
    ["dirty"] = "Bathed",
    ["feed"] = "Fed"
}
local ac, sb = 15, {false, false, false, false}
local dk = {"drink", "thirst"}
local li = {}

local function r1(n, a) dr:FireServer({[1]="PetInteractAction",[2]="3",[3]={[1]="\1",[2]={n,a}},[4]="("}) end
local function r2(n) dr:FireServer({[1]={["GUID"]=n,["Category"]="Pet"},[2]="@"}) end
local function r3() dr:FireServer({[1]={{[1]="\1",[2]={["PurchaserGUID"]="66111113-6A42-49B3-8F1E-2C5C5B646B57"}},[2]="P"}}) end
local function r4(i) dr:FireServer({[1]={[1]="\1",[2]="BERRIES_"..i.."00"},[2]="E"}) end

local function hvc(i)
    if fa then
        if i:IsA("ScreenGui") and i.Enabled then i.Enabled = false
        elseif i:IsA("Frame") and i.Visible then i.Visible = false end
    end
end

local function svs(i)
    if i:IsA("ScreenGui") then vs[i] = i.Enabled
    elseif i:IsA("Frame") then vs[i] = i.Visible end
end

local function rvs()
    for i, s in pairs(vs) do
        if i:IsA("ScreenGui") then i.Enabled = s
        elseif i:IsA("Frame") then i.Visible = s end
    end
    vs = {}
end

local function svt(i)
    if not vc[i] then
        vc[i] = i:GetPropertyChangedSignal(i:IsA("ScreenGui") and "Enabled" or "Visible"):Connect(function() hvc(i) end)
    end
end

local function tu(h)
    fa = h
    if h then
        for _, g in ipairs(lp.PlayerGui:GetChildren()) do
            if g:IsA("ScreenGui") then
                svs(g); svt(g); g.Enabled = false
            end
            for _, f in ipairs(g:GetDescendants()) do
                if f:IsA("Frame") then
                    svs(f); svt(f); f.Visible = false
                end
            end
        end
        lp.PlayerGui:SetTopbarTransparency(1)
    else
        rvs()
        lp.PlayerGui:SetTopbarTransparency(0)
    end
end

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

local function sf() lp.CameraMode = Enum.CameraMode.LockFirstPerson end

local function ps(c)
    local h = c:WaitForChild("Humanoid")
    h.Seated:Connect(function(s) if s then h.Sit = false end end)
end

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

local function ck(m, k)
    m = m:lower()
    for _, kw in ipairs(k) do
        if m:find(kw) then return true end
    end
    return false
end

local function grsb()
    local ab = {}
    for i, s in ipairs(sb) do
        if s then table.insert(ab, i) end
    end
    if #ab > 0 then return ab[math.random(#ab)] end
    return nil
end

local function dafe(b)
    local ae = {}
    local ce = {"Activated", "MouseButton1Click", "MouseButton1Down", "MouseButton1Up", "InputBegan", "InputEnded"}

    for _, en in ipairs(ce) do
        if typeof(b[en]) == "RBXScriptSignal" then
            local cn = getconnections(b[en])
            if #cn > 0 then table.insert(ae, {name = en, connections = cn}) end
        end
    end

    for _, c in ipairs(b:GetChildren()) do
        if c:IsA("BindableEvent") or c:IsA("CustomEvent") then
            local cn = getconnections(c.Event)
            if #cn > 0 then table.insert(ae, {name = c.Name, connections = cn}) end
        end
    end

    if #ae > 0 then
        for _, ei in ipairs(ae) do
            for i, cn in ipairs(ei.connections) do
                if cn.Function and cn.Enabled then
                    pcall(function() cn:Fire() end)
                end
            end
        end
    else
        print("No se encontraron eventos activos")
    end
end

local function hpi(cm, pn)
    if ck(cm, dk) then
        local sb = grsb()
        if sb then
            local bi = sb == 3 and 4 or sb
            local bp = string.format("game.Players.LocalPlayer.PlayerGui.SideMenu.Root.BottomOptions.Hotbar[\"%d\"].Element", bi)
            local b = loadstring("return " .. bp)()
            
            if b and b:IsA("GuiButton") then
                local ct = tick()
                if not li[pn] or (ct - li[pn] >= ac) then
                    dafe(b)
                    wait(1)
                    r1(pn, at[cm:match("%w+")] or "Fed")
                    li[pn] = ct
                    ui:Notify("Interacción con mascota: " .. pn, 3)
                    wait(8)
                    
                    local np = fu()
                    if np and np ~= pn then
                        r2(pn)
                        ui:Notify("Rotando mascota: Desequipando mascota actual", 3)
                        wait(5)
                        r2(np)
                        ui:Notify("Rotando mascota: Equipando nueva mascota", 3)
                    else
                        ui:Notify("No hay nuevas mascotas para rotar, continuando", 3)
                    end
                else
                   
                end
            else
                
            end
        else
            ui:Notify("No hay botones seleccionados para interactuar", 3)
        end
    end
end

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
                            hpi(mt, cn)
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

local cff = false
ui:TBtn("Collect Flowers", function() 
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
ui:TBtn("Collect Magic Feathers", function() 
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

ui:Btn("TP Secret Zone", function()
    lp.Character:MoveTo(Vector3.new(1356, 10, -3447))
    lp.Character.PrimaryPart.Anchored = true
    wait(3)
    lp.Character.PrimaryPart.Anchored = false
end)

ui:Btn("First Person", function() sf() end)

ui:Notify("Auto Tasks Pet: Default Active", 5)

local bs = ui:Sub("Drinks Selections")
for i = 1, 4 do
    local bi = i == 3 and 4 or i
    bs:TBtn("Select Space" .. bi, function()
        sb[i] = not sb[i]
        ui:Notify("Space " .. bi .. (sb[i] and " drink select" or " dessllc"), 3)
    end)
end

wait(0.7)
local is = ui:Sub("Info Script")
is:Txt("Version: 2.1")
is:Txt("Create: 20/07/24")
is:Txt("Update: 23/11/23")
is:Btn("Link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
is:Btn("Link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

lp.Idled:Connect(function()
    vm:CaptureController()
    vm:ClickButton2(Vector2.new())
end)

game:GetService("CoreGui").ChildAdded:Connect(function(child)
    if fa then
        if child:IsA("ScreenGui") then
            svs(child)
            svt(child)
            child.Enabled = false
        end
    end
end)

lp.PlayerGui.ChildAdded:Connect(function(child)
    if fa then
        if child:IsA("ScreenGui") then
            svs(child)
            svt(child)
            child.Enabled = false
        end
        child.DescendantAdded:Connect(function(desc)
            if desc:IsA("Frame") and fa then
                svs(desc)
                svt(desc)
                desc.Visible = false
            end
        end)
    end
end)

local function cc()
    for i, c in pairs(vc) do
        if c.Connected then
            c:Disconnect()
        end
    end
    vc = {}
end

game:GetService("Players").PlayerRemoving:Connect(function(player)
    if player == lp then
        cc()
    end
end)

lp.CharacterAdded:Connect(ps)
if lp.Character then ps(lp.Character) end


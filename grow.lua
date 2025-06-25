local HS = game:GetService("HttpService")
local P = game:GetService("Players")
local RS = game:GetService("RunService")
local Rep = game:GetService("ReplicatedStorage")
local TS = game:GetService("TweenService")

local pl = P.LocalPlayer
local pg = pl.PlayerGui

local vr = _G.VALIDATION_TOKEN and game:HttpGet("https://system.heatherx.site/validate/onecreatorx/grow-garden/".._G.VALIDATION_TOKEN)
if vr ~= "1" then return end

local vm = nil
for _, m in ipairs(getloadedmodules()) do
    if m.Name == "VariantVisuals" then
        vm = require(m)
        break
    end
end
if vm then
    vm.SetVisuals = function() end
end

local Ca = {}
Ca.__index = Ca

function Ca.new()
    local s = setmetatable({
        d = {},
        t = {},
        ttl = 30
    }, Ca)
    return s
end

function Ca:set(k, v, ct)
    self.d[k] = v
    self.t[k] = tick() + (ct or self.ttl)
end

function Ca:get(k)
    if self:iv(k) then
        return self.d[k]
    end
    return nil
end

function Ca:iv(k)
    return self.t[k] and tick() < self.t[k]
end

function Ca:inv(k)
    self.d[k] = nil
    self.t[k] = nil
end

function Ca:rep(k, v, ct)
    self:inv(k)
    self:set(k, v, ct)
end

local ca = Ca.new()

local CM = {}
CM.__index = CM

function CM.new()
    local s = setmetatable({
        cf = "AdvancedAutoShopConfig.json",
        dc = {
            at = 1,
            co = false,
            as = false,
            ap = false,
            ae = false,
            sp = {},
            pe = {},
            ge = {},
            se = {},
            pf = {},
            eb = false,
            oas = false,
            oac = false
        }
    }, CM)
    return s
end

function CM:sv(c)
    local su, re = pcall(function()
        writefile(self.cf, HS:JSONEncode(c))
    end)
    if not su then
        warn("Failed to save config:", re)
    end
end

function CM:ld()
    if isfile(self.cf) then
        local su, c = pcall(function()
            return HS:JSONDecode(readfile(self.cf))
        end)
        if su and c then
            return c
        end
    end
    return self.dc
end

local cm = CM.new()
local cf = cm:ld()

local Th = {
    co = {
        pr = Color3.fromRGB(20, 20, 25),
        se = Color3.fromRGB(30, 30, 35),
        ac = Color3.fromRGB(0, 120, 50),
        ah = Color3.fromRGB(0, 150, 70),
        tx = Color3.fromRGB(255, 255, 255),
        ts = Color3.fromRGB(200, 200, 210),
        bo = Color3.fromRGB(80, 80, 90),
        sh = Color3.fromRGB(0, 0, 0),
        in = Color3.fromRGB(50, 50, 60),
        ev = Color3.fromRGB(255, 165, 0)
    },
    sz = {
        mf = UDim2.new(0.35, 0, 0.7, 0),
        tb = UDim2.new(0, 70, 0, 25),
        bt = UDim2.new(0, 100, 0, 22),
        sb = UDim2.new(0, 70, 0, 18)
    }
}

local UB = {}
UB.__index = UB

function UB.new()
    return setmetatable({}, UB)
end

function UB:cf(pa, sz, po, co, cr)
    local f = Instance.new("Frame")
    f.Size = sz or UDim2.new(1, 0, 1, 0)
    f.Position = po or UDim2.new(0, 0, 0, 0)
    f.BackgroundColor3 = co or Th.co.pr
    f.BorderSizePixel = 0
    f.Parent = pa
    
    if cr then
        local c = Instance.new("UICorner")
        c.CornerRadius = UDim.new(0, cr)
        c.Parent = f
    end
    
    return f
end

function UB:cb(pa, sz, po, tx, cb)
    local b = Instance.new("TextButton")
    b.Size = sz or Th.sz.bt
    b.Position = po or UDim2.new(0, 0, 0, 0)
    b.BackgroundColor3 = Th.co.in
    b.Text = tx or ""
    b.TextColor3 = Th.co.tx
    b.TextSize = 11
    b.Font = Enum.Font.GothamSemibold
    b.Parent = pa
    
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = b
    
    local s = Instance.new("UIStroke")
    s.Color = Th.co.bo
    s.Thickness = 1
    s.Parent = b
    
    if cb then
        b.MouseButton1Click:Connect(cb)
    end
    
    return b, s
end

function UB:cs(pa, sz, po)
    local sf = Instance.new("ScrollingFrame")
    sf.Size = sz or UDim2.new(1, -10, 1, -40)
    sf.Position = po or UDim2.new(0, 5, 0, 35)
    sf.BackgroundColor3 = Th.co.se
    sf.BorderSizePixel = 0
    sf.ScrollBarThickness = 6
    sf.ScrollBarImageColor3 = Th.co.bo
    sf.Parent = pa
    
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = sf
    
    local l = Instance.new("UIListLayout")
    l.FillDirection = Enum.FillDirection.Vertical
    l.Padding = UDim.new(0, 3)
    l.Parent = sf
    
    return sf, l
end

local ub = UB.new()

local sg = Instance.new("ScreenGui")
sg.Name = "AdvancedAutoShopMenu"
sg.Parent = pg

local mf = ub:cf(sg, Th.sz.mf, UDim2.new(0.5, -200, 0.15, 0), Th.co.pr, 12)
mf.Draggable = true
mf.Active = true

local sh = ub:cf(mf, UDim2.new(1, 4, 1, 4), UDim2.new(0, -2, 0, 2), Th.co.sh, 12)
sh.BackgroundTransparency = 0.7
sh.ZIndex = -1

local ms = Instance.new("UIStroke")
ms.Color = Th.co.bo
ms.Thickness = 2
ms.Parent = mf

local tb = ub:cf(mf, UDim2.new(1, -10, 0, 30), UDim2.new(0, 5, 0, 3), Th.co.ac, 8)
local tg = Instance.new("UIGradient")
tg.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 150, 80)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 100, 50))
}
tg.Parent = tb

local tl = Instance.new("TextLabel")
tl.Size = UDim2.new(1, -30, 1, 0)
tl.Position = UDim2.new(0, 8, 0, 0)
tl.BackgroundTransparency = 1
tl.Text = "🛍️ Advanced Auto Shop"
tl.TextColor3 = Th.co.tx
tl.TextSize = 14
tl.Font = Enum.Font.GothamBold
tl.TextXAlignment = Enum.TextXAlignment.Left
tl.Parent = tb

local mb, _ = ub:cb(tb, UDim2.new(0, 22, 0, 22), UDim2.new(1, -25, 0, 4), "-")
local im = false

local tc = ub:cf(mf, UDim2.new(1, -10, 0, 32), UDim2.new(0, 5, 0, 38), Th.co.se, 6)
local tla = Instance.new("UIListLayout")
tla.FillDirection = Enum.FillDirection.Horizontal
tla.Padding = UDim.new(0, 3)
tla.Parent = tc

local cc = ub:cf(mf, UDim2.new(1, -10, 1, -80), UDim2.new(0, 5, 0, 75), Th.co.se, 6)

local ta = {
    {n = "Control", i = "⚙️"},
    {n = "Plants", i = "🌱"},
    {n = "Shop", i = "🛒"},
    {n = "Pets", i = "🐾"},
    {n = "Events", i = "🎉"}
}

local tbs = {}
local tcs = {}
local at = cf.at or 1

local function oi(co, cb, bs)
    bs = bs or 30
    local ct = 0
    
    for k, v in pairs(co) do
        cb(k, v)
        ct = ct + 1
        
        if ct >= bs then
            ct = 0
            RS.Heartbeat:Wait()
        end
    end
end

local function sc(si, cb, dt)
    dt = dt or 0.1
    local lc = 0
    
    return si:Connect(function(...)
        local no = tick()
        if no - lc >= dt then
            lc = no
            cb(...)
        end
    end)
end

local GD = {}

function GD.gpp()
    local ck = "playerPlot"
    local ca = ca:get(ck)
    if ca then return ca end
    
    for _, f in pairs(workspace.Farm:GetChildren()) do
        local im = f:FindFirstChild("Important")
        local da = im and im:FindFirstChild("Data")
        local ow = da and da:FindFirstChild("Owner")
        
        if ow and ow.Value == pl.Name then
            ca:set(ck, im, 60)
            return im
        end
    end
    
    return nil
end

function GD.gpn()
    local ck = "plantNames"
    local ca = ca:get(ck)
    if ca then return ca end
    
    local pl = GD.gpp()
    if not pl then return {} end
    
    local pn = {}
    local se = {}
    
    for _, p in pairs(pl.Plants_Physical:GetChildren()) do
        if p:IsA("Model") and not se[p.Name] then
            se[p.Name] = true
            table.insert(pn, p.Name)
        end
    end
    
    ca:set(ck, pn, 30)
    return pn
end

function GD.gpe()
    local ck = "petEggs"
    local ca = ca:get(ck)
    if ca then return ca end
    
    local pr = Rep:WaitForChild("Data"):WaitForChild("PetRegistry")
    local eg = require(pr).PetEggs
    
    ca:set(ck, eg, 300)
    return eg
end

local AM = {}
AM.__index = AM

function AM.new()
    local s = setmetatable({
        co = {},
        lo = {}
    }, AM)
    return s
end

function AM:sc()
    if self.lo.co then return end
    
    self.lo.co = task.spawn(function()
        while cf.co do
            local pl = GD.gpp()
            if pl then
                local ct = 0
                local mb = 150
                
                oi(pl.Plants_Physical:GetChildren(), function(_, p)
                    if ct >= mb then return end
                    if not p:IsA("Model") or not cf.sp[p.Name] then return end
                    
                    local fr = p:FindFirstChild("Fruits")
                    if fr then
                        for _, f in pairs(fr:GetChildren()) do
                            if ct >= mb then break end
                            Rep.ByteNetReliable:FireServer(buffer.fromstring("\001\001\000\001"), {f})
                            ct = ct + 1
                            RS.Heartbeat:Wait()
                        end
                    else
                        Rep.ByteNetReliable:FireServer(buffer.fromstring("\001\001\000\001"), {p})
                        ct = ct + 1
                        RS.Heartbeat:Wait()
                    end
                end, 8)
            end
            task.wait(4)
        end
        self.lo.co = nil
    end)
end

function AM:sas()
    if self.lo.as then return end
    
    self.lo.as = task.spawn(function()
        while cf.as do
            Rep:WaitForChild("GameEvents"):WaitForChild("Sell_Inventory"):FireServer()
            task.wait(0.4)
        end
        self.lo.as = nil
    end)
end

function AM:sap()
    if not cf.ap then return end
    
    local ch = pl.Character
    if not ch then return end
    
    local to = ch:FindFirstChildOfClass("Tool")
    if not to then return end
    
    local sn = to.Name:gsub(" Seed %[X%d+%]", ""):gsub(" Seed", "")
    local pl = GD.gpp()
    
    if pl then
        local ps = pl:FindFirstChild("Plants_Physical")
        if ps then
            local p = ps:FindFirstChild(sn)
            if p and p.PrimaryPart then
                local po = p.PrimaryPart.Position
                
                self.lo.ap = task.spawn(function()
                    while cf.ap do
                        local ct = ch:FindFirstChildOfClass("Tool")
                        if not ct or not ct.Name:find(sn) then break end
                        
                        Rep.GameEvents.Plant_RE:FireServer(po, sn)
                        task.wait(0.08)
                    end
                    self.lo.ap = nil
                end)
            end
        end
    end
end

function AM:sl(ln)
    if self.lo[ln] then
        task.cancel(self.lo[ln])
        self.lo[ln] = nil
    end
end

local am = AM.new()

local function fel()
    for _, o in pairs(workspace.Interaction.UpdateItems.SummerHarvestEvent.Sign:GetDescendants()) do
        if o:IsA("TextLabel") and o.Text:find("Summer Harvest Ends:") then
            return o
        end
    end
    return nil
end

local function hes()
    local el = fel()
    return el ~= nil
end

local function cct()
    local co = ub:cf(cc, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0), Color3.new(0, 0, 0), 0)
    co.BackgroundTransparency = 1
    
    local sf, la = ub:cs(co, UDim2.new(1, -8, 1, -8), UDim2.new(0, 4, 0, 4))
    
    local cs = ub:cf(sf, UDim2.new(1, -6, 0, 140), UDim2.new(0, 0, 0, 0), Th.co.se, 8)
    
    local st = Instance.new("TextLabel")
    st.Size = UDim2.new(1, -8, 0, 20)
    st.Position = UDim2.new(0, 4, 0, 4)
    st.BackgroundTransparency = 1
    st.Text = "⚙️ Main Controls"
    st.TextColor3 = Th.co.ts
    st.TextSize = 12
    st.Font = Enum.Font.GothamBold
    st.TextXAlignment = Enum.TextXAlignment.Left
    st.Parent = cs
    
    local cb, cs1 = ub:cb(cs, UDim2.new(0.48, 0, 0, 22), UDim2.new(0, 4, 0, 28))
    local sb, ss1 = ub:cb(cs, UDim2.new(0.48, 0, 0, 22), UDim2.new(0.52, 0, 0, 28))
    local pb, ps1 = ub:cb(cs, UDim2.new(0.48, 0, 0, 22), UDim2.new(0, 4, 0, 55))
    local eb, es1 = ub:cb(cs, UDim2.new(0.48, 0, 0, 22), UDim2.new(0.52, 0, 0, 55))
    
    local es = Instance.new("TextLabel")
    es.Size = UDim2.new(1, -8, 0, 18)
    es.Position = UDim2.new(0, 4, 0, 82)
    es.BackgroundTransparency = 1
    es.Text = "📊 Event Status: " .. (hes() and "ACTIVE" or "INACTIVE")
    es.TextColor3 = hes() and Th.co.ev or Th.co.ts
    es.TextSize = 10
    es.Font = Enum.Font.GothamMedium
    es.TextXAlignment = Enum.TextXAlignment.Left
    es.Parent = cs
    
    local ab, as1 = ub:cb(cs, UDim2.new(0.48, 0, 0, 18), UDim2.new(0, 4, 0, 105))
    local rb, rs1 = ub:cb(cs, UDim2.new(0.48, 0, 0, 18), UDim2.new(0.52, 0, 0, 105))
    
    local function ub(b, s, ia, t)
        b.Text = t .. (ia and " ON" or " OFF")
        b.BackgroundColor3 = ia and Th.co.ac or Th.co.in
        s.Color = ia and Th.co.ah or Th.co.bo
    end
    
    local function uab()
        ub(cb, cs1, cf.co, "📦 Collect:")
        ub(sb, ss1, cf.as, "💰 Auto Sell:")
        ub(pb, ps1, cf.ap, "🌿 Auto Plant:")
        ub(eb, es1, cf.ae, "🍓 Auto Event:")
        ub(ab, as1, cf.eb, "🔄 Auto Mode:")
        ub(rb, rs1, false, "⚡ Reset:")
        
        es.Text = "📊 Event Status: " .. (hes() and "ACTIVE" or "INACTIVE")
        es.TextColor3 = hes() and Th.co.ev or Th.co.ts
    end
    
    cb.MouseButton1Click:Connect(function()
        cf.co = not cf.co
        uab()
        
        if cf.co then
            am:sc()
        else
            am:sl("co")
        end
        
        cm:sv(cf)
    end)
    
    sb.MouseButton1Click:Connect(function()
        cf.as = not cf.as
        uab()
        
        if cf.as then
            am:sas()
        else
            am:sl("as")
        end
        
        cm:sv(cf)
    end)
    
    pb.MouseButton1Click:Connect(function()
        cf.ap = not cf.ap
        uab()
        cm:sv(cf)
    end)
    
    eb.MouseButton1Click:Connect(function()
        cf.ae = not cf.ae
        uab()
        cm:sv(cf)
    end)
    
    ab.MouseButton1Click:Connect(function()
        cf.eb = not cf.eb
        uab()
        cm:sv(cf)
    end)
    
    rb.MouseButton1Click:Connect(function()
        cf.co = false
        cf.as = false
        cf.ap = false
        cf.ae = false
        cf.eb = false
        am:sl("co")
        am:sl("as")
        uab()
        cm:sv(cf)
    end)
    
    uab()
    
    la:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        sf.CanvasSize = UDim2.new(0, 0, 0, la.AbsoluteContentSize.Y + 8)
    end)
    
    return co
end

local function cpt()
    local co = ub:cf(cc, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0), Color3.new(0, 0, 0), 0)
    co.BackgroundTransparency = 1
    
    local sf, la = ub:cs(co, UDim2.new(1, -8, 1, -35), UDim2.new(0, 4, 0, 30))
    
    local function upb()
        for _, c in pairs(sf:GetChildren()) do
            if c:IsA("TextButton") then
                c:Destroy()
            end
        end
        
        local pn = GD.gpn()
        
        for _, pn in pairs(pn) do
            local b, s = ub:cb(sf, UDim2.new(1, -6, 0, 26), UDim2.new(0, 0, 0, 0))
            
            local is = cf.sp[pn] or false
            b.Text = "🌱 " .. pn .. ": " .. (is and "ON" or "OFF")
            b.BackgroundColor3 = is and Th.co.ac or Th.co.in
            s.Color = is and Th.co.ah or Th.co.bo
            b.TextXAlignment = Enum.TextXAlignment.Left
            
            b.MouseButton1Click:Connect(function()
                cf.sp[pn] = not cf.sp[pn]
                local ns = cf.sp[pn]
                
                b.Text = "🌱 " .. pn .. ": " .. (ns and "ON" or "OFF")
                b.BackgroundColor3 = ns and Th.co.ac or Th.co.in
                s.Color = ns and Th.co.ah or Th.co.bo
                
                cm:sv(cf)
            end)
        end
        
        la:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            sf.CanvasSize = UDim2.new(0, 0, 0, la.AbsoluteContentSize.Y + 8)
        end)
    end
    
    local rb = ub:cb(co, UDim2.new(0, 80, 0, 22), UDim2.new(1, -85, 0, 4), "🔄 Refresh")
    rb.MouseButton1Click:Connect(function()
        ca:inv("plantNames")
        upb()
    end)
    
    upb()
    
    return co
end

local function cst()
    local co = ub:cf(cc, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0), Color3.new(0, 0, 0), 0)
    co.BackgroundTransparency = 1
    
    local sf, la = ub:cs(co, UDim2.new(1, -8, 1, -8), UDim2.new(0, 4, 0, 4))
    
    local gs = ub:cf(sf, UDim2.new(1, -6, 0, 60), UDim2.new(0, 0, 0, 0), Th.co.se, 6)
    local gt = Instance.new("TextLabel")
    gt.Size = UDim2.new(1, -8, 0, 18)
    gt.Position = UDim2.new(0, 4, 0, 2)
    gt.BackgroundTransparency = 1
    gt.Text = "⚙️ Gear Auto-Buy"
    gt.TextColor3 = Th.co.ts
    gt.TextSize = 11
    gt.Font = Enum.Font.GothamBold
    gt.TextXAlignment = Enum.TextXAlignment.Left
    gt.Parent = gs
    
    local gi = Instance.new("TextLabel")
    gi.Size = UDim2.new(1, -8, 0, 35)
    gi.Position = UDim2.new(0, 4, 0, 22)
    gi.BackgroundTransparency = 1
    gi.Text = "Green buttons in gear shop enable auto-purchase when items are in stock."
    gi.TextColor3 = Th.co.ts
    gi.TextSize = 9
    gi.Font = Enum.Font.GothamMedium
    gi.TextWrapped = true
    gi.TextXAlignment = Enum.TextXAlignment.Left
    gi.Parent = gs
    
    local ss = ub:cf(sf, UDim2.new(1, -6, 0, 60), UDim2.new(0, 0, 0, 0), Th.co.se, 6)
    local st = Instance.new("TextLabel")
    st.Size = UDim2.new(1, -8, 0, 18)
    st.Position = UDim2.new(0, 4, 0, 2)
    st.BackgroundTransparency = 1
    st.Text = "🌱 Seed Auto-Buy"
    st.TextColor3 = Th.co.ts
    st.TextSize = 11
    st.Font = Enum.Font.GothamBold
    st.TextXAlignment = Enum.TextXAlignment.Left
    st.Parent = ss
    
    local si = Instance.new("TextLabel")
    si.Size = UDim2.new(1, -8, 0, 35)
    si.Position = UDim2.new(0, 4, 0, 22)
    si.BackgroundTransparency = 1
    si.Text = "Checkboxes in seed shop enable auto-purchase when seeds are available."
    si.TextColor3 = Th.co.ts
    si.TextSize = 9
    si.Font = Enum.Font.GothamMedium
    si.TextWrapped = true
    si.TextXAlignment = Enum.TextXAlignment.Left
    si.Parent = si
    
    task.spawn(function()
        local gs = pg:WaitForChild("Gear_Shop")
        local gf = gs.Frame.ScrollingFrame
        local bg = Rep.GameEvents.BuyGearStock
        
        for _, i in pairs(gf:GetChildren()) do
            local f2 = i:FindFirstChild("Frame")
            local sb = f2 and f2:FindFirstChild("Sheckles_Buy")
            local is = sb and sb:FindFirstChild("In_Stock")
            
            if is then
                local b = Instance.new("TextButton")
                b.Size = UDim2.new(0, 16, 0, 16)
                b.Position = UDim2.new(1, -18, 0, 2)
                b.BackgroundColor3 = cf.ge[i.Name] and Th.co.ac or Th.co.in
                b.Text = ""
                b.Parent = sb
                
                local c = Instance.new("UICorner")
                c.CornerRadius = UDim.new(0, 3)
                c.Parent = b
                
                local ia = cf.ge[i.Name] or false
                
                b.MouseButton1Click:Connect(function()
                    ia = not ia
                    cf.ge[i.Name] = ia
                    b.BackgroundColor3 = ia and Th.co.ac or Th.co.in
                    cm:sv(cf)
                end)
                
                task.spawn(function()
                    while true do
                        if ia and is.Visible then
                            bg:FireServer(i.Name)
                        end
                        task.wait(0.12)
                    end
                end)
            end
        end
    end)
    
    task.spawn(function()
        local ss = pg:WaitForChild("Seed_Shop")
        local sf = ss.Frame.ScrollingFrame
        local bs = Rep.GameEvents.BuySeedStock
        
        for _, i in pairs(sf:GetChildren()) do
            if i:IsA("Frame") and i:FindFirstChild("Frame") then
                local sb = i.Frame:FindFirstChild("Sheckles_Buy")
                if sb then
                    local b = Instance.new("TextButton")
                    b.Size = UDim2.new(0, 18, 0, 18)
                    b.Position = UDim2.new(1, -22, 0, 3)
                    b.BackgroundColor3 = Color3.new(1, 1, 1)
                    b.Text = ""
                    b.Parent = sb
                    b.BorderSizePixel = 1
                    b.AutoButtonColor = false
                    
                    local c = Instance.new("UICorner")
                    c.CornerRadius = UDim.new(0, 3)
                    c.Parent = b
                    
                    local cm = Instance.new("Frame")
                    cm.Size = UDim2.new(1, -4, 1, -4)
                    cm.Position = UDim2.new(0, 2, 0, 2)
                    cm.BackgroundColor3 = Th.co.ac
                    cm.Visible = cf.se[i.Name] or false
                    cm.Parent = b
                    
                    local cc = Instance.new("UICorner")
                    cc.CornerRadius = UDim.new(0, 2)
                    cc.Parent = cm
                    
                    b.MouseButton1Click:Connect(function()
                        cf.se[i.Name] = not cf.se[i.Name]
                        cm.Visible = cf.se[i.Name]
                        
                        if cf.se[i.Name] then
                            task.spawn(function()
                                while cf.se[i.Name] do
                                    local ci = sf:FindFirstChild(i.Name)
                                    if not ci then break end
                                    
                                    local cs = ci.Frame:FindFirstChild("Sheckles_Buy")
                                    local cst = cs and cs:FindFirstChild("In_Stock")
                                    
                                    if cst and cst.Visible then
                                        bs:FireServer(i.Name)
                                    else
                                        repeat 
                                            task.wait(0.04)
                                            cst = cs and cs:FindFirstChild("In_Stock")
                                        until (cst and cst.Visible) or not cf.se[i.Name]
                                    end
                                    task.wait()
                                end
                            end)
                        end
                        
                        cm:sv(cf)
                    end)
                end
            end
        end
    end)
    
    la:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        sf.CanvasSize = UDim2.new(0, 0, 0, la.AbsoluteContentSize.Y + 8)
    end)
    
    return co
end

local function cpt()
    local co = ub:cf(cc, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0), Color3.new(0, 0, 0), 0)
    co.BackgroundTransparency = 1
    
    local sf, la = ub:cs(co, UDim2.new(1, -8, 1, -8), UDim2.new(0, 4, 0, 4))
    
    local eg = GD.gpe()
    local bp = Rep.GameEvents.BuyPetEgg
    
    for en in pairs(eg) do
        local b, s = ub:cb(sf, UDim2.new(1, -6, 0, 30), UDim2.new(0, 0, 0, 0))
        
        local ia = cf.pe[en] or false
        b.Text = "🥚 " .. en .. ": " .. (ia and "ON" or "OFF")
        b.BackgroundColor3 = ia and Th.co.ac or Th.co.in
        s.Color = ia and Th.co.ah or Th.co.bo
        b.TextXAlignment = Enum.TextXAlignment.Left
        
        b.MouseButton1Click:Connect(function()
            cf.pe[en] = not cf.pe[en]
            local ns = cf.pe[en]
            
            b.Text = "🥚 " .. en .. ": " .. (ns and "ON" or "OFF")
            b.BackgroundColor3 = ns and Th.co.ac or Th.co.in
            s.Color = ns and Th.co.ah or Th.co.bo
            
            if ns then
                task.spawn(function()
                    while cf.pe[en] do
                        local ds = require(Rep.Modules.DataService)
                        local da = ds:GetData()
                        
                        for ix, st in pairs(da.PetEggStock.Stocks) do
                            if cf.pe[en] and eg[st.EggName] and st.EggName == en and st.Stock > 0 then
                                bp:FireServer(ix)
                            end
                        end
                        task.wait(0.08)
                    end
                end)
            end
            
            cm:sv(cf)
        end)
    end
    
    task.spawn(function()
        local ap = pg:WaitForChild("ActivePetUI")
        local ps = ap.Frame.Main.ScrollingFrame
        local fe = Rep.GameEvents.ActivePetService
        
        for _, pf in pairs(ps:GetChildren()) do
            if pf.Name:match("^%b{}$") and pf:FindFirstChild("PetStats") then
                local st = pf.PetStats
                local b, s = ub:cb(st, UDim2.new(1, -3, 0, 16), UDim2.new(0, 1, 0, 1), "Auto Feed: OFF")
                
                local pi = pf.Name
                local ia = cf.pf[pi] or false
                
                local function ufb()
                    b.Text = "Auto Feed: " .. (ia and "ON" or "OFF")
                    b.BackgroundColor3 = ia and Th.co.ac or Th.co.in
                    s.Color = ia and Th.co.ah or Th.co.bo
                end
                
                local function eat()
                    for _, to in pairs(pl.Backpack:GetChildren()) do
                        if to:IsA("Tool") and to.Name:find("%[.+kg%]") then
                            to.Parent = pl.Character
                        end
                    end
                end
                
                local function fl()
                    while ia do
                        eat()
                        fe:FireServer("Feed", pi)
                        RS.Heartbeat:Wait()
                    end
                end
                
                sc(pl.Backpack.ChildAdded, function(to)
                    if ia and to:IsA("Tool") and to.Name:find("%[.+kg%]") then
                        to.Parent = pl.Character
                    end
                end)
                
                b.MouseButton1Click:Connect(function()
                    ia = not ia
                    cf.pf[pi] = ia
                    ufb()
                    
                    if ia then
                        eat()
                        task.spawn(fl)
                    end
                    
                    cm:sv(cf)
                end)
                
                ufb()
            end
        end
    end)
    
    la:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        sf.CanvasSize = UDim2.new(0, 0, 0, la.AbsoluteContentSize.Y + 8)
    end)
    
    return co
end

local function cet()
    local co = ub:cf(cc, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0), Color3.new(0, 0, 0), 0)
    co.BackgroundTransparency = 1
    
    local sf, la = ub:cs(co, UDim2.new(1, -8, 1, -8), UDim2.new(0, 4, 0, 4))
    
    local es = ub:cf(sf, UDim2.new(1, -6, 0, 100), UDim2.new(0, 0, 0, 0), Th.co.se, 8)
    
    local et = Instance.new("TextLabel")
    et.Size = UDim2.new(1, -8, 0, 20)
    et.Position = UDim2.new(0, 4, 0, 4)
    et.BackgroundTransparency = 1
    et.Text = "🍓 Summer Harvest Event"
    et.TextColor3 = Th.co.ts
    et.TextSize = 12
    et.Font = Enum.Font.GothamBold
    et.TextXAlignment = Enum.TextXAlignment.Left
    et.Parent = es
    
    local eb, es1 = ub:cb(es, UDim2.new(0.6, 0, 0, 25), UDim2.new(0, 4, 0, 28))
    
    local ei = Instance.new("TextLabel")
    ei.Size = UDim2.new(1, -8, 0, 40)
    ei.Position = UDim2.new(0, 4, 0, 58)
    ei.BackgroundTransparency = 1
    ei.Text = "Auto-manages collect/sell during events. Enables collect and disables sell when event starts, restores settings when event ends."
    ei.TextColor3 = Th.co.ts
    ei.TextSize = 9
    ei.Font = Enum.Font.GothamMedium
    ei.TextWrapped = true
    ei.TextXAlignment = Enum.TextXAlignment.Left
    ei.Parent = es
    
    local function ueb()
        eb.Text = "🍓 Auto Event: " .. (cf.ae and "ON" or "OFF")
        eb.BackgroundColor3 = cf.ae and Th.co.ac or Th.co.in
        es1.Color = cf.ae and Th.co.ah or Th.co.bo
    end
    
    local function el()
        while cf.ae do
            local el = fel()
            if el then
                while el and cf.ae do
                    Rep.GameEvents.SummerHarvestRemoteEvent:FireServer("SubmitHeldPlant")
                    RS.Heartbeat:Wait()
                    el = fel()
                end
            end
            RS.Heartbeat:Wait()
        end
    end
    
    local function het(to)
        if cf.ae and to:IsA("Tool") and to.Name:find("%[.+kg%]") then
            to.Parent = pl.Character
        end
    end
    
    sc(pl.Backpack.ChildAdded, het)
    
    eb.MouseButton1Click:Connect(function()
        cf.ae = not cf.ae
        ueb()
        
        if cf.ae then
            for _, to in pairs(pl.Backpack:GetChildren()) do
                het(to)
            end
            task.spawn(el)
        end
        
        cm:sv(cf)
    end)
    
    ueb()
    
    la:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        sf.CanvasSize = UDim2.new(0, 0, 0, la.AbsoluteContentSize.Y + 8)
    end)
    
    return co
end

for i, td in ipairs(ta) do
    local b, s = ub:cb(tc, Th.sz.tb, UDim2.new(0, 0, 0, 3), td.i .. " " .. td.n)
    tbs[i] = {b = b, s = s}
    
    local co
    if i == 1 then
        co = cct()
    elseif i == 2 then
        co = cpt()
    elseif i == 3 then
        co = cst()
    elseif i == 4 then
        co = cpt()
    elseif i == 5 then
        co = cet()
    end
    
    tcs[i] = co
    co.Visible = (i == at)
    
    b.MouseButton1Click:Connect(function()
        for j, tc in ipairs(tcs) do
            tc.Visible = false
            tbs[j].b.BackgroundColor3 = Th.co.in
            tbs[j].s.Color = Th.co.bo
        end
        
        co.Visible = true
        b.BackgroundColor3 = Th.co.ac
        s.Color = Th.co.ah
        at = i
        cf.at = i
        cm:sv(cf)
    end)
    
    if i == at then
        b.BackgroundColor3 = Th.co.ac
        s.Color = Th.co.ah
    end
end

mb.MouseButton1Click:Connect(function()
    im = not im
    
    if im then
        local tw = TS:Create(mf, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0.35, 0, 0, 38)
        })
        tw:Play()
        mb.Text = "+"
        
        tw.Completed:Connect(function()
            tc.Visible = false
            cc.Visible = false
        end)
    else
        tc.Visible = true
        cc.Visible = true
        
        local tw = TS:Create(mf, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = Th.sz.mf
        })
        tw:Play()
        mb.Text = "-"
    end
end)

local cl = Instance.new("TextLabel")
cl.Size = UDim2.new(1, 0, 0, 12)
cl.Position = UDim2.new(0, 0, 1, -15)
cl.BackgroundTransparency = 1
cl.Text = "✨ Advanced Version by OneCreatorX"
cl.TextColor3 = Color3.fromRGB(120, 120, 130)
cl.TextSize = 8
cl.Font = Enum.Font.GothamMedium
cl.TextXAlignment = Enum.TextXAlignment.Center
cl.Parent = mf

sc(pl.CharacterAdded, function(ch)
    sc(ch.ChildAdded, function(c)
        if c:IsA("Tool") and cf.ap then
            task.spawn(function()
                am:sap()
            end)
        end
    end)
end)

if pl.Character then
    sc(pl.Character.ChildAdded, function(c)
        if c:IsA("Tool") and cf.ap then
            task.spawn(function()
                am:sap()
            end)
        end
    end)
end

task.spawn(function()
    local les = false
    
    while true do
        local ces = hes()
        
        if cf.eb then
            if ces and not les then
                if not cf.co then
                    cf.oas = cf.as
                    cf.oac = cf.co
                    cf.co = true
                    cf.as = false
                    am:sc()
                    am:sl("as")
                end
            elseif not ces and les then
                if cf.oac ~= nil then
                    cf.co = cf.oac
                    cf.as = cf.oas
                    
                    if cf.co then
                        am:sc()
                    else
                        am:sl("co")
                    end
                    
                    if cf.as then
                        am:sas()
                    else
                        am:sl("as")
                    end
                    
                    cf.oac = nil
                    cf.oas = nil
                end
            end
        end
        
        les = ces
        task.wait(2)
    end
end)

if cf.co then
    am:sc()
end

if cf.as then
    am:sas()
end

game:BindToClose(function()
    cm:sv(cf)
end)

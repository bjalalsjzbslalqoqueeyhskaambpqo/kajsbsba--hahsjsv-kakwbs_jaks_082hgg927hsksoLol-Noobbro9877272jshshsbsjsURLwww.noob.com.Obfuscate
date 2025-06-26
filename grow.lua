local HS = game:GetService("HttpService")
local Plrs = game:GetService("Players")
local RS = game:GetService("RunService")
local RepS = game:GetService("ReplicatedStorage")
local TS = game:GetService("TweenService")

local plr = Plrs.LocalPlayer
local gui = plr.PlayerGui

local r = _G.VALIDATION_TOKEN and game:HttpGet("https://system.heatherx.site/validate/onecreatorx/grow-garden/".._G.VALIDATION_TOKEN)
if r ~= "1" then return end

local vmod
for _, m in ipairs(getloadedmodules()) do
    if m.Name == "VariantVisuals" then vmod = require(m) break end
end
if vmod then vmod.SetVisuals = function() end end

local Cache = {}
Cache.__index = Cache

function Cache.new()
    local self = setmetatable({
        data = {},
        time = {},
        ttl = 30
    }, Cache)
    return self
end

function Cache:set(k, v, t)
    self.data[k] = v
    self.time[k] = tick() + (t or self.ttl)
end

function Cache:get(k)
    if self:valid(k) then return self.data[k] end
    return nil
end

function Cache:valid(k)
    return self.time[k] and tick() < self.time[k]
end

function Cache:inv(k)
    self.data[k] = nil
    self.time[k] = nil
end

function Cache:repl(k, v, t)
    self:inv(k)
    self:set(k, v, t)
end

local cache = Cache.new()

local CfgMgr = {}
CfgMgr.__index = CfgMgr

function CfgMgr.new()
    local self = setmetatable({
        file = "AdvAutoShop.json",
        def = {
            tab = 1,
            coll = false,
            sell = false,
            plnt = false,
            evnt = false,
            selP = {},
            eggs = {},
            gear = {},
            seed = {},
            feed = {}
        }
    }, CfgMgr)
    return self
end

function CfgMgr:save(cfg)
    local ok, res = pcall(function()
        writefile(self.file, HS:JSONEncode(cfg))
    end)
    if not ok then warn("Save fail:", res) end
end

function CfgMgr:load()
    if isfile(self.file) then
        local ok, cfg = pcall(function()
            return HS:JSONDecode(readfile(self.file))
        end)
        if ok and cfg then return cfg end
    end
    return self.def
end

local cfgMgr = CfgMgr.new()
local cfg = cfgMgr:load()

local Theme = {
    col = {
        prim = Color3.fromRGB(20, 20, 25),
        sec = Color3.fromRGB(30, 30, 35),
        acc = Color3.fromRGB(0, 120, 50),
        accH = Color3.fromRGB(0, 150, 70),
        txt = Color3.fromRGB(255, 255, 255),
        txtS = Color3.fromRGB(200, 200, 210),
        bord = Color3.fromRGB(80, 80, 90),
        shad = Color3.fromRGB(0, 0, 0),
        inac = Color3.fromRGB(50, 50, 60)
    },
    size = {
        main = UDim2.new(0.35, 0, 0.7, 0),
        tab = UDim2.new(0.18, 0, 0, 30),
        btn = UDim2.new(0, 120, 0, 25),
        sBtn = UDim2.new(0, 80, 0, 20)
    }
}

local UIB = {}
UIB.__index = UIB

function UIB.new()
    return setmetatable({}, UIB)
end

function UIB:frame(p, s, pos, col, r)
    local f = Instance.new("Frame")
    f.Size = s or UDim2.new(1, 0, 1, 0)
    f.Position = pos or UDim2.new(0, 0, 0, 0)
    f.BackgroundColor3 = col or Theme.col.prim
    f.BorderSizePixel = 0
    f.Parent = p
    
    if r then
        local c = Instance.new("UICorner")
        c.CornerRadius = UDim.new(0, r)
        c.Parent = f
    end
    
    return f
end

function UIB:btn(p, s, pos, txt, cb)
    local b = Instance.new("TextButton")
    b.Size = s or Theme.size.btn
    b.Position = pos or UDim2.new(0, 0, 0, 0)
    b.BackgroundColor3 = Theme.col.inac
    b.Text = txt or ""
    b.TextColor3 = Theme.col.txt
    b.TextSize = 12
    b.Font = Enum.Font.GothamSemibold
    b.Parent = p
    
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = b
    
    local st = Instance.new("UIStroke")
    st.Color = Theme.col.bord
    st.Thickness = 1
    st.Parent = b
    
    if cb then b.MouseButton1Click:Connect(cb) end
    
    return b, st
end

function UIB:scroll(p, s, pos)
    local sf = Instance.new("ScrollingFrame")
    sf.Size = s or UDim2.new(1, -10, 1, -50)
    sf.Position = pos or UDim2.new(0, 5, 0, 40)
    sf.BackgroundColor3 = Theme.col.sec
    sf.BorderSizePixel = 0
    sf.ScrollBarThickness = 6
    sf.ScrollBarImageColor3 = Theme.col.bord
    sf.Parent = p
    
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = sf
    
    local l = Instance.new("UIListLayout")
    l.FillDirection = Enum.FillDirection.Vertical
    l.Padding = UDim.new(0, 3)
    l.Parent = sf
    
    return sf, l
end

local uib = UIB.new()

local sg = Instance.new("ScreenGui")
sg.Name = "AdvAutoShop"
sg.Parent = gui

local main = uib:frame(sg, Theme.size.main, UDim2.new(0.5, -Theme.size.main.X.Offset/2, 0.5, -Theme.size.main.Y.Offset/2), Theme.col.prim, 15)
main.Draggable = true
main.Active = true

local shad = uib:frame(main, UDim2.new(1, 6, 1, 6), UDim2.new(0, -3, 0, 3), Theme.col.shad, 15)
shad.BackgroundTransparency = 0.7
shad.ZIndex = -1

local mst = Instance.new("UIStroke")
mst.Color = Theme.col.bord
mst.Thickness = 2
mst.Parent = main

local tbar = uib:frame(main, UDim2.new(1, -10, 0, 35), UDim2.new(0, 5, 0, 5), Theme.col.acc, 10)
local tg = Instance.new("UIGradient")
tg.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 150, 80)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 100, 50))
}
tg.Parent = tbar

local tlbl = Instance.new("TextLabel")
tlbl.Size = UDim2.new(1, -40, 1, 0)
tlbl.Position = UDim2.new(0, 10, 0, 0)
tlbl.BackgroundTransparency = 1
tlbl.Text = "🛍️ Advanced Auto Shop"
tlbl.TextColor3 = Theme.col.txt
tlbl.TextSize = 14
tlbl.Font = Enum.Font.GothamBold
tlbl.TextXAlignment = Enum.TextXAlignment.Left
tlbl.Parent = tbar

local minB, _ = uib:btn(tbar, UDim2.new(0, 25, 0, 25), UDim2.new(1, -30, 0, 5), "-")
local isMin = false

local tCont = uib:frame(main, UDim2.new(1, -10, 0, 35), UDim2.new(0, 5, 0, 45), Theme.col.sec, 8)
local tLay = Instance.new("UIListLayout")
tLay.FillDirection = Enum.FillDirection.Horizontal
tLay.Padding = UDim.new(0, 3)
tLay.Parent = tCont

local cCont = uib:frame(main, UDim2.new(1, -10, 1, -90), UDim2.new(0, 5, 0, 85), Theme.col.sec, 8)

local tabs = {
    {n = "Ctrl", i = "⚙️"},
    {n = "Plant", i = "🌱"},
    {n = "Shop", i = "🛒"},
    {n = "Pets", i = "🐾"},
    {n = "Event", i = "🎉"}
}

local tBtns = {}
local tConts = {}
local actTab = cfg.tab or 1

local function optIter(coll, cb, batch)
    batch = batch or 25
    local cnt = 0
    
    for k, v in pairs(coll) do
        cb(k, v)
        cnt = cnt + 1
        
        if cnt >= batch then
            cnt = 0
            RS.Heartbeat:Wait()
        end
    end
end

local function smartConn(sig, cb, deb)
    deb = deb or 0.05
    local last = 0
    
    return sig:Connect(function(...)
        local now = tick()
        if now - last >= deb then
            last = now
            cb(...)
        end
    end)
end

local GData = {}

function GData.getPlot()
    local ck = "plot"
    local cached = cache:get(ck)
    if cached then return cached end
    
    for _, f in pairs(workspace.Farm:GetChildren()) do
        local imp = f:FindFirstChild("Important")
        local data = imp and imp:FindFirstChild("Data")
        local own = data and data:FindFirstChild("Owner")
        
        if own and own.Value == plr.Name then
            cache:set(ck, imp, 60)
            return imp
        end
    end
    
    return nil
end

function GData.getPlants()
    local ck = "plants"
    local cached = cache:get(ck)
    if cached then return cached end
    
    local plot = GData.getPlot()
    if not plot then return {} end
    
    local plants = {}
    local seen = {}
    
    for _, p in pairs(plot.Plants_Physical:GetChildren()) do
        if p:IsA("Model") and not seen[p.Name] then
            seen[p.Name] = true
            table.insert(plants, p.Name)
        end
    end
    
    cache:set(ck, plants, 20)
    return plants
end

function GData.getEggs()
    local ck = "eggs"
    local cached = cache:get(ck)
    if cached then return cached end
    
    local reg = RepS:WaitForChild("Data"):WaitForChild("PetRegistry")
    local eggs = require(reg).PetEggs
    
    cache:set(ck, eggs, 300)
    return eggs
end

local AutoMgr = {}
AutoMgr.__index = AutoMgr

function AutoMgr.new()
    local self = setmetatable({
        conn = {},
        loop = {}
    }, AutoMgr)
    return self
end

function AutoMgr:startColl()
    if self.loop.coll then return end
    
    self.loop.coll = task.spawn(function()
        while cfg.coll do
            local plot = GData.getPlot()
            if plot then
                local cnt = 0
                local max = 150
                
                optIter(plot.Plants_Physical:GetChildren(), function(_, p)
                    if cnt >= max then return end
                    if not p:IsA("Model") or not cfg.selP[p.Name] then return end
                    
                    local fr = p:FindFirstChild("Fruits")
                    if fr then
                        for _, f in pairs(fr:GetChildren()) do
                            if cnt >= max then break end
                            RepS.ByteNetReliable:FireServer(buffer.fromstring("\001\001\000\001"), {f})
                            cnt = cnt + 1
                            RS.Heartbeat:Wait()
                        end
                    else
                        RepS.ByteNetReliable:FireServer(buffer.fromstring("\001\001\000\001"), {p})
                        cnt = cnt + 1
                        RS.Heartbeat:Wait()
                    end
                end, 8)
            end
            task.wait(3)
        end
        self.loop.coll = nil
    end)
end

function AutoMgr:startSell()
    if self.loop.sell then return end
    
    self.loop.sell = task.spawn(function()
        while cfg.sell do
            RepS:WaitForChild("GameEvents"):WaitForChild("Sell_Inventory"):FireServer()
            task.wait(0.3)
        end
        self.loop.sell = nil
    end)
end

function AutoMgr:startPlnt()
    if not cfg.plnt then return end
    
    local char = plr.Character
    if not char then return end
    
    local tool = char:FindFirstChildOfClass("Tool")
    if not tool then return end
    
    local sName = tool.Name:gsub(" Seed %[X%d+%]", ""):gsub(" Seed", "")
    local plot = GData.getPlot()
    
    if plot then
        local plants = plot:FindFirstChild("Plants_Physical")
        if plants then
            local plant = plants:FindFirstChild(sName)
            if plant and plant.PrimaryPart then
                local pos = plant.PrimaryPart.Position
                
                self.loop.plnt = task.spawn(function()
                    while cfg.plnt do
                        local cTool = char:FindFirstChildOfClass("Tool")
                        if not cTool or not cTool.Name:find(sName) then break end
                        
                        RepS.GameEvents.Plant_RE:FireServer(pos, sName)
                        task.wait(0.08)
                    end
                    self.loop.plnt = nil
                end)
            end
        end
    end
end

function AutoMgr:startEvnt()
    if self.loop.evnt then return end
    
    self.loop.evnt = task.spawn(function()
        local prevColl = cfg.coll
        local prevSell = cfg.sell
        
        if not cfg.coll then
            cfg.coll = true
            self:startColl()
        end
        
        if cfg.sell then
            cfg.sell = false
            self:stop("sell")
        end
        
        while cfg.evnt do
            local lbl = self:findEvLbl()
            if lbl then
                self:equipEvTools()
                while lbl and cfg.evnt do
                    RepS.GameEvents.SummerHarvestRemoteEvent:FireServer("SubmitHeldPlant")
                    task.wait(0.02)
                    lbl = self:findEvLbl()
                end
            end
            task.wait(0.1)
        end
        
        cfg.coll = prevColl
        cfg.sell = prevSell
        
        if not cfg.coll then
            self:stop("coll")
        end
        
        if cfg.sell then
            self:startSell()
        end
        
        self.loop.evnt = nil
    end)
end

function AutoMgr:findEvLbl()
    for _, obj in pairs(workspace.Interaction.UpdateItems.SummerHarvestEvent.Sign:GetDescendants()) do
        if obj:IsA("TextLabel") and obj.Text:find("Summer Harvest Ends:") then
            return obj
        end
    end
    return nil
end

function AutoMgr:equipEvTools()
    for _, tool in pairs(plr.Backpack:GetChildren()) do
        if tool:IsA("Tool") and (tool.Name:find("%[.+kg%]") or tool.Name:find("Fruit") or tool.Name:find("Plant")) then
            tool.Parent = plr.Character
        end
    end
end

function AutoMgr:stop(name)
    if self.loop[name] then
        task.cancel(self.loop[name])
        self.loop[name] = nil
    end
end

local autoMgr = AutoMgr.new()

local function createCtrl()
    local cont = uib:frame(cCont, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0), Color3.new(0, 0, 0), 0)
    cont.BackgroundTransparency = 1
    
    local sf, lay = uib:scroll(cont, UDim2.new(1, -5, 1, -5), UDim2.new(0, 2, 0, 2))
    
    local ctrlSec = uib:frame(sf, UDim2.new(1, -8, 0, 100), UDim2.new(0, 0, 0, 0), Theme.col.sec, 12)
    
    local secT = Instance.new("TextLabel")
    secT.Size = UDim2.new(1, -10, 0, 20)
    secT.Position = UDim2.new(0, 5, 0, 5)
    secT.BackgroundTransparency = 1
    secT.Text = "⚙️ Main Controls"
    secT.TextColor3 = Theme.col.txtS
    secT.TextSize = 12
    secT.Font = Enum.Font.GothamBold
    secT.TextXAlignment = Enum.TextXAlignment.Left
    secT.Parent = ctrlSec
    
    local collB, collS = uib:btn(ctrlSec, UDim2.new(0.48, 0, 0, 22), UDim2.new(0, 5, 0, 28))
    local sellB, sellS = uib:btn(ctrlSec, UDim2.new(0.48, 0, 0, 22), UDim2.new(0.52, 0, 0, 28))
    local plntB, plntS = uib:btn(ctrlSec, UDim2.new(0.48, 0, 0, 22), UDim2.new(0, 5, 0, 55))
    local evntB, evntS = uib:btn(ctrlSec, UDim2.new(0.48, 0, 0, 22), UDim2.new(0.52, 0, 0, 55))
    
    local function updBtn(btn, str, act, txt)
        btn.Text = txt .. (act and " ON" or " OFF")
        btn.BackgroundColor3 = act and Theme.col.acc or Theme.col.inac
        str.Color = act and Theme.col.accH or Theme.col.bord
    end
    
    local function updAll()
        updBtn(collB, collS, cfg.coll, "📦 Collect:")
        updBtn(sellB, sellS, cfg.sell, "💰 Sell:")
        updBtn(plntB, plntS, cfg.plnt, "🌿 Plant:")
        updBtn(evntB, evntS, cfg.evnt, "🍓 Event:")
    end
    
    collB.MouseButton1Click:Connect(function()
        cfg.coll = not cfg.coll
        updAll()
        
        if cfg.coll then
            autoMgr:startColl()
        else
            autoMgr:stop("coll")
        end
        
        cfgMgr:save(cfg)
    end)
    
    sellB.MouseButton1Click:Connect(function()
        cfg.sell = not cfg.sell
        updAll()
        
        if cfg.sell then
            autoMgr:startSell()
        else
            autoMgr:stop("sell")
        end
        
        cfgMgr:save(cfg)
    end)
    
    plntB.MouseButton1Click:Connect(function()
        cfg.plnt = not cfg.plnt
        updAll()
        cfgMgr:save(cfg)
    end)
    
    evntB.MouseButton1Click:Connect(function()
        cfg.evnt = not cfg.evnt
        updAll()
        
        if cfg.evnt then
            autoMgr:startEvnt()
        else
            autoMgr:stop("evnt")
        end
        
        cfgMgr:save(cfg)
    end)
    
    updAll()
    
    lay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        sf.CanvasSize = UDim2.new(0, 0, 0, lay.AbsoluteContentSize.Y + 10)
    end)
    
    return cont
end

local function createPlnt()
    local cont = uib:frame(cCont, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0), Color3.new(0, 0, 0), 0)
    cont.BackgroundTransparency = 1
    
    local sf, lay = uib:scroll(cont, UDim2.new(1, -5, 1, -30), UDim2.new(0, 2, 0, 25))
    
    local function updPlntBtns()
        for _, child in pairs(sf:GetChildren()) do
            if child:IsA("TextButton") then child:Destroy() end
        end
        
        local plants = GData.getPlants()
        
        for _, pName in pairs(plants) do
            local btn, str = uib:btn(sf, UDim2.new(1, -8, 0, 25), UDim2.new(0, 0, 0, 0))
            
            local isSel = cfg.selP[pName] or false
            btn.Text = "🌱 " .. pName .. ": " .. (isSel and "ON" or "OFF")
            btn.BackgroundColor3 = isSel and Theme.col.acc or Theme.col.inac
            str.Color = isSel and Theme.col.accH or Theme.col.bord
            btn.TextXAlignment = Enum.TextXAlignment.Left
            
            btn.MouseButton1Click:Connect(function()
                cfg.selP[pName] = not cfg.selP[pName]
                local newSt = cfg.selP[pName]
                
                btn.Text = "🌱 " .. pName .. ": " .. (newSt and "ON" or "OFF")
                btn.BackgroundColor3 = newSt and Theme.col.acc or Theme.col.inac
                str.Color = newSt and Theme.col.accH or Theme.col.bord
                
                cfgMgr:save(cfg)
            end)
        end
        
        lay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            sf.CanvasSize = UDim2.new(0, 0, 0, lay.AbsoluteContentSize.Y + 10)
        end)
    end
    
    local refB = uib:btn(cont, UDim2.new(0, 80, 0, 20), UDim2.new(1, -85, 0, 2), "🔄 Refresh")
    refB.MouseButton1Click:Connect(function()
        cache:inv("plants")
        updPlntBtns()
    end)
    
    updPlntBtns()
    
    return cont
end

local function createShop()
    local cont = uib:frame(cCont, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0), Color3.new(0, 0, 0), 0)
    cont.BackgroundTransparency = 1
    
    local sf, lay = uib:scroll(cont, UDim2.new(1, -5, 1, -5), UDim2.new(0, 2, 0, 2))
    
    task.spawn(function()
        local gShop = gui:WaitForChild("Gear_Shop")
        local gFrame = gShop.Frame.ScrollingFrame
        local buyGear = RepS.GameEvents.BuyGearStock
        
        optIter(gFrame:GetChildren(), function(_, item)
            local f2 = item:FindFirstChild("Frame")
            local sBuy = f2 and f2:FindFirstChild("Sheckles_Buy")
            local stock = sBuy and sBuy:FindFirstChild("In_Stock")
            
            if stock then
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(0, 16, 0, 16)
                btn.Position = UDim2.new(1, -18, 0, 2)
                btn.BackgroundColor3 = cfg.gear[item.Name] and Theme.col.acc or Theme.col.inac
                btn.Text = ""
                btn.Parent = sBuy
                
                local c = Instance.new("UICorner")
                c.CornerRadius = UDim.new(0, 4)
                c.Parent = btn
                
                local isAct = cfg.gear[item.Name] or false
                
                btn.MouseButton1Click:Connect(function()
                    isAct = not isAct
                    cfg.gear[item.Name] = isAct
                    btn.BackgroundColor3 = isAct and Theme.col.acc or Theme.col.inac
                    cfgMgr:save(cfg)
                end)
                
                task.spawn(function()
                    while true do
                        if isAct and stock.Visible then
                            buyGear:FireServer(item.Name)
                        end
                        task.wait(0.1)
                    end
                end)
            end
        end, 5)
    end)
    
    task.spawn(function()
        local sShop = gui:WaitForChild("Seed_Shop")
        local sFrame = sShop.Frame.ScrollingFrame
        local buySeed = RepS.GameEvents.BuySeedStock
        
        optIter(sFrame:GetChildren(), function(_, item)
            if item:IsA("Frame") and item:FindFirstChild("Frame") then
                local sBuy = item.Frame:FindFirstChild("Sheckles_Buy")
                if sBuy then
                    local btn = Instance.new("TextButton")
                    btn.Size = UDim2.new(0, 18, 0, 18)
                    btn.Position = UDim2.new(1, -22, 0, 4)
                    btn.BackgroundColor3 = Color3.new(1, 1, 1)
                    btn.Text = ""
                    btn.Parent = sBuy
                    btn.BorderSizePixel = 1
                    btn.AutoButtonColor = false
                    
                    local c = Instance.new("UICorner")
                    c.CornerRadius = UDim.new(0, 4)
                    c.Parent = btn
                    
                    local chk = Instance.new("Frame")
                    chk.Size = UDim2.new(1, -4, 1, -4)
                    chk.Position = UDim2.new(0, 2, 0, 2)
                    chk.BackgroundColor3 = Theme.col.acc
                    chk.Visible = cfg.seed[item.Name] or false
                    chk.Parent = btn
                    
                    local chkC = Instance.new("UICorner")
                    chkC.CornerRadius = UDim.new(0, 2)
                    chkC.Parent = chk
                    
                    btn.MouseButton1Click:Connect(function()
                        cfg.seed[item.Name] = not cfg.seed[item.Name]
                        chk.Visible = cfg.seed[item.Name]
                        
                        if cfg.seed[item.Name] then
                            task.spawn(function()
                                while cfg.seed[item.Name] do
                                    local cItem = sFrame:FindFirstChild(item.Name)
                                    if not cItem then break end
                                    
                                    local cSheck = cItem.Frame:FindFirstChild("Sheckles_Buy")
                                    local cStock = cSheck and cSheck:FindFirstChild("In_Stock")
                                    
                                    if cStock and cStock.Visible then
                                        buySeed:FireServer(item.Name)
                                    else
                                        repeat 
                                            task.wait(0.02)
                                            cStock = cSheck and cSheck:FindFirstChild("In_Stock")
                                        until (cStock and cStock.Visible) or not cfg.seed[item.Name]
                                    end
                                    task.wait(0.05)
                                end
                            end)
                        end
                        
                        cfgMgr:save(cfg)
                    end)
                end
            end
        end, 3)
    end)
    
    return cont
end

local function createPets()
    local cont = uib:frame(cCont, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0), Color3.new(0, 0, 0), 0)
    cont.BackgroundTransparency = 1
    
    local sf, lay = uib:scroll(cont, UDim2.new(1, -5, 1, -5), UDim2.new(0, 2, 0, 2))
    
    local eggs = GData.getEggs()
    local buyEgg = RepS.GameEvents.BuyPetEgg
    
    for eggN in pairs(eggs) do
        local btn, str = uib:btn(sf, UDim2.new(1, -8, 0, 28), UDim2.new(0, 0, 0, 0))
        
        local isAct = cfg.eggs[eggN] or false
        btn.Text = "🥚 " .. eggN .. ": " .. (isAct and "ON" or "OFF")
        btn.BackgroundColor3 = isAct and Theme.col.acc or Theme.col.inac
        str.Color = isAct and Theme.col.accH or Theme.col.bord
        btn.TextXAlignment = Enum.TextXAlignment.Left
        
        btn.MouseButton1Click:Connect(function()
            cfg.eggs[eggN] = not cfg.eggs[eggN]
            local newSt = cfg.eggs[eggN]
            
            btn.Text = "🥚 " .. eggN .. ": " .. (newSt and "ON" or "OFF")
            btn.BackgroundColor3 = newSt and Theme.col.acc or Theme.col.inac
            str.Color = newSt and Theme.col.accH or Theme.col.bord
            
            if newSt then
                task.spawn(function()
                    while cfg.eggs[eggN] do
                        local dServ = require(RepS.Modules.DataService)
                        local data = dServ:GetData()
                        
                        optIter(data.PetEggStock.Stocks, function(idx, stock)
                            if cfg.eggs[eggN] and eggs[stock.EggName] and stock.EggName == eggN and stock.Stock > 0 then
                                buyEgg:FireServer(idx)
                            end
                        end, 10)
                        task.wait(0.08)
                    end
                end)
            end
            
            cfgMgr:save(cfg)
        end)
    end
    
    task.spawn(function()
        local petUI = gui:WaitForChild("ActivePetUI")
        local petSF = petUI.Frame.Main.ScrollingFrame
        local feedEv = RepS.GameEvents.ActivePetService
        
        optIter(petSF:GetChildren(), function(_, petF)
            if petF.Name:match("^%b{}$") and petF:FindFirstChild("PetStats") then
                local stats = petF.PetStats
                local btn, str = uib:btn(stats, UDim2.new(1, -4, 0, 18), UDim2.new(0, 2, 0, 2), "Feed: OFF")
                
                local petId = petF.Name
                local isAct = cfg.feed[petId] or false
                
                local function updFeed()
                    btn.Text = "Feed: " .. (isAct and "ON" or "OFF")
                    btn.BackgroundColor3 = isAct and Theme.col.acc or Theme.col.inac
                    str.Color = isAct and Theme.col.accH or Theme.col.bord
                end
                
                local function equipTools()
                    optIter(plr.Backpack:GetChildren(), function(_, tool)
                        if tool:IsA("Tool") and (tool.Name:find("%[.+kg%]") or tool.Name:find("Fruit") or tool.Name:find("Plant")) then
                            tool.Parent = plr.Character
                        end
                    end, 15)
                end
                
                local function feedLoop()
                    while isAct do
                        equipTools()
                        feedEv:FireServer("Feed", petId)
                        task.wait(0.02)
                    end
                end
                
                smartConn(plr.Backpack.ChildAdded, function(tool)
                    if isAct and tool:IsA("Tool") and (tool.Name:find("%[.+kg%]") or tool.Name:find("Fruit") or tool.Name:find("Plant")) then
                        tool.Parent = plr.Character
                    end
                end)
                
                btn.MouseButton1Click:Connect(function()
                    isAct = not isAct
                    cfg.feed[petId] = isAct
                    updFeed()
                    
                    if isAct then
                        equipTools()
                        task.spawn(feedLoop)
                    end
                    
                    cfgMgr:save(cfg)
                end)
                
                updFeed()
            end
        end, 3)
    end)
    
    lay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        sf.CanvasSize = UDim2.new(0, 0, 0, lay.AbsoluteContentSize.Y + 10)
    end)
    
    return cont
end

local function createEvnt()
    local cont = uib:frame(cCont, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0), Color3.new(0, 0, 0), 0)
    cont.BackgroundTransparency = 1
    
    local sf, lay = uib:scroll(cont, UDim2.new(1, -5, 1, -5), UDim2.new(0, 2, 0, 2))
    
    local evSec = uib:frame(sf, UDim2.new(1, -8, 0, 120), UDim2.new(0, 0, 0, 0), Theme.col.sec, 12)
    
    local evT = Instance.new("TextLabel")
    evT.Size = UDim2.new(1, -10, 0, 20)
    evT.Position = UDim2.new(0, 5, 0, 5)
    evT.BackgroundTransparency = 1
    evT.Text = "🍓 Summer Harvest Event"
    evT.TextColor3 = Theme.col.txtS
    evT.TextSize = 12
    evT.Font = Enum.Font.GothamBold
    evT.TextXAlignment = Enum.TextXAlignment.Left
    evT.Parent = evSec
    
    local evB, evS = uib:btn(evSec, UDim2.new(0.7, 0, 0, 25), UDim2.new(0, 5, 0, 30))
    
    local infoL = Instance.new("TextLabel")
    infoL.Size = UDim2.new(1, -10, 0, 60)
    infoL.Position = UDim2.new(0, 5, 0, 60)
    infoL.BackgroundTransparency = 1
    infoL.Text = "Auto-manages collect/sell states during event.\nEquips all fruits/plants automatically.\nFaster iteration for better efficiency."
    infoL.TextColor3 = Theme.col.txtS
    infoL.TextSize = 10
    infoL.Font = Enum.Font.GothamMedium
    infoL.TextWrapped = true
    infoL.TextYAlignment = Enum.TextYAlignment.Top
    infoL.Parent = evSec
    
    local function updEvB()
        evB.Text = "🍓 Auto Event: " .. (cfg.evnt and "ON" or "OFF")
        evB.BackgroundColor3 = cfg.evnt and Theme.col.acc or Theme.col.inac
        evS.Color = cfg.evnt and Theme.col.accH or Theme.col.bord
    end
    
    evB.MouseButton1Click:Connect(function()
        cfg.evnt = not cfg.evnt
        updEvB()
        
        if cfg.evnt then
            autoMgr:startEvnt()
        else
            autoMgr:stop("evnt")
        end
        
        cfgMgr:save(cfg)
    end)
    
    updEvB()
    
    lay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        sf.CanvasSize = UDim2.new(0, 0, 0, lay.AbsoluteContentSize.Y + 10)
    end)
    
    return cont
end

for i, tData in ipairs(tabs) do
    local btn, str = uib:btn(tCont, Theme.size.tab, UDim2.new(0, 0, 0, 2), tData.i .. " " .. tData.n)
    tBtns[i] = {btn = btn, str = str}
    
    local cont
    if i == 1 then
        cont = createCtrl()
    elseif i == 2 then
        cont = createPlnt()
    elseif i == 3 then
        cont = createShop()
    elseif i == 4 then
        cont = createPets()
    elseif i == 5 then
        cont = createEvnt()
    end
    
    tConts[i] = cont
    cont.Visible = (i == actTab)
    
    btn.MouseButton1Click:Connect(function()
        for j, tCont in ipairs(tConts) do
            tCont.Visible = false
            tBtns[j].btn.BackgroundColor3 = Theme.col.inac
            tBtns[j].str.Color = Theme.col.bord
        end
        
        cont.Visible = true
        btn.BackgroundColor3 = Theme.col.acc
        str.Color = Theme.col.accH
        actTab = i
        cfg.tab = i
        cfgMgr:save(cfg)
    end)
    
    if i == actTab then
        btn.BackgroundColor3 = Theme.col.acc
        str.Color = Theme.col.accH
    end
end

minB.MouseButton1Click:Connect(function()
    isMin = not isMin
    
    if isMin then
        local tw = TS:Create(main, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(Theme.size.main.X.Scale, Theme.size.main.X.Offset, 0, 45)
        })
        tw:Play()
        minB.Text = "+"
        
        tw.Completed:Connect(function()
            tCont.Visible = false
            cCont.Visible = false
        end)
    else
        tCont.Visible = true
        cCont.Visible = true
        
        local tw = TS:Create(main, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = Theme.size.main
        })
        tw:Play()
        minB.Text = "-"
    end
end)

local credL = Instance.new("TextLabel")
credL.Size = UDim2.new(1, 0, 0, 12)
credL.Position = UDim2.new(0, 0, 1, -15)
credL.BackgroundTransparency = 1
credL.Text = "✨ Advanced by OneCreatorX"
credL.TextColor3 = Color3.fromRGB(120, 120, 130)
credL.TextSize = 9
credL.Font = Enum.Font.GothamMedium
credL.TextXAlignment = Enum.TextXAlignment.Center
credL.Parent = main

smartConn(plr.CharacterAdded, function(char)
    smartConn(char.ChildAdded, function(child)
        if child:IsA("Tool") and cfg.plnt then
            task.spawn(function()
                autoMgr:startPlnt()
            end)
        end
    end)
end)

if plr.Character then
    smartConn(plr.Character.ChildAdded, function(child)
        if child:IsA("Tool") and cfg.plnt then
            task.spawn(function()
                autoMgr:startPlnt()
            end)
        end
    end)
end

smartConn(plr.Backpack.ChildAdded, function(tool)
    if cfg.evnt and tool:IsA("Tool") and (tool.Name:find("%[.+kg%]") or tool.Name:find("Fruit") or tool.Name:find("Plant")) then
        tool.Parent = plr.Character
    end
end)

if cfg.coll then autoMgr:startColl() end
if cfg.sell then autoMgr:startSell() end

game:BindToClose(function()
    cfgMgr:save(cfg)
end)

local HS=game:GetService("HttpService")
local P=game:GetService("Players")
local RS=game:GetService("RunService")
local Rep=game:GetService("ReplicatedStorage")
local TS=game:GetService("TweenService")

local p=P.LocalPlayer
local pg=p.PlayerGui

local r=_G.VALIDATION_TOKEN and game:HttpGet("https://system.heatherx.site/validate/onecreatorx/grow-garden/".._G.VALIDATION_TOKEN)
if r~="1"then return end

local vm=nil
for _,m in ipairs(getloadedmodules())do
if m.Name=="VariantVisuals"then vm=require(m)break end
end
if vm then vm.SetVisuals=function()end end

local C={}
C.__index=C
function C.new()
local s=setmetatable({d={},t={},ttl=30},C)
return s
end
function C:set(k,v,ct)
self.d[k]=v
self.t[k]=tick()+(ct or self.ttl)
end
function C:get(k)
if self:iv(k)then return self.d[k]end
return nil
end
function C:iv(k)
return self.t[k]and tick()<self.t[k]
end
function C:inv(k)
self.d[k]=nil
self.t[k]=nil
end
function C:rep(k,v,ct)
self:inv(k)
self:set(k,v,ct)
end

local c=C.new()

local CM={}
CM.__index=CM
function CM.new()
local s=setmetatable({cf="AdvancedAutoShopConfig.json",dc={at=1,co=false,as=false,ap=false,ae=false,sp={},pe={},g={},s={},pf={},eb=false,eas=false}},CM)
return s
end
function CM:sv(cfg)
local sc,rs=pcall(function()
writefile(self.cf,HS:JSONEncode(cfg))
end)
if not sc then warn("Failed to save config:",rs)end
end
function CM:ld()
if isfile(self.cf)then
local sc,cfg=pcall(function()
return HS:JSONDecode(readfile(self.cf))
end)
if sc and cfg then return cfg end
end
return self.dc
end

local cm=CM.new()
local cfg=cm:ld()

local T={
c={
pr=Color3.fromRGB(15,15,20),
sc=Color3.fromRGB(25,25,30),
ac=Color3.fromRGB(0,120,50),
ah=Color3.fromRGB(0,150,70),
tx=Color3.fromRGB(255,255,255),
ts=Color3.fromRGB(200,200,210),
bd=Color3.fromRGB(80,80,90),
sh=Color3.fromRGB(0,0,0),
in=Color3.fromRGB(50,50,60)
},
s={
mf=UDim2.new(0.85,0,0.8,0),
tb=UDim2.new(0.18,0,0,25),
bt=UDim2.new(0,100,0,22),
sb=UDim2.new(0,70,0,18)
}
}

local UB={}
UB.__index=UB
function UB.new()
return setmetatable({},UB)
end
function UB:cf(pr,sz,ps,cl,cr)
local f=Instance.new("Frame")
f.Size=sz or UDim2.new(1,0,1,0)
f.Position=ps or UDim2.new(0,0,0,0)
f.BackgroundColor3=cl or T.c.pr
f.BorderSizePixel=0
f.Parent=pr
if cr then
local co=Instance.new("UICorner")
co.CornerRadius=UDim.new(0,cr)
co.Parent=f
end
return f
end
function UB:cb(pr,sz,ps,tx,cb)
local b=Instance.new("TextButton")
b.Size=sz or T.s.bt
b.Position=ps or UDim2.new(0,0,0,0)
b.BackgroundColor3=T.c.in
b.Text=tx or""
b.TextColor3=T.c.tx
b.TextSize=10
b.Font=Enum.Font.GothamSemibold
b.Parent=pr
local co=Instance.new("UICorner")
co.CornerRadius=UDim.new(0,6)
co.Parent=b
local st=Instance.new("UIStroke")
st.Color=T.c.bd
st.Thickness=1
st.Parent=b
if cb then b.MouseButton1Click:Connect(cb)end
return b,st
end
function UB:cs(pr,sz,ps)
local sf=Instance.new("ScrollingFrame")
sf.Size=sz or UDim2.new(1,-10,1,-40)
sf.Position=ps or UDim2.new(0,5,0,35)
sf.BackgroundColor3=T.c.sc
sf.BorderSizePixel=0
sf.ScrollBarThickness=6
sf.ScrollBarImageColor3=T.c.bd
sf.Parent=pr
local co=Instance.new("UICorner")
co.CornerRadius=UDim.new(0,6)
co.Parent=sf
local ly=Instance.new("UIListLayout")
ly.FillDirection=Enum.FillDirection.Vertical
ly.Padding=UDim.new(0,3)
ly.Parent=sf
return sf,ly
end

local ub=UB.new()

local sg=Instance.new("ScreenGui")
sg.Name="AdvancedAutoShopMenu"
sg.Parent=pg

local mf=ub:cf(sg,T.s.mf,UDim2.new(0.075,0,0.1,0),T.c.pr,12)
mf.Draggable=true
mf.Active=true

local sh=ub:cf(mf,UDim2.new(1,4,1,4),UDim2.new(0,-2,0,2),T.c.sh,12)
sh.BackgroundTransparency=0.7
sh.ZIndex=-1

local ms=Instance.new("UIStroke")
ms.Color=T.c.bd
ms.Thickness=2
ms.Parent=mf

local tb=ub:cf(mf,UDim2.new(1,-10,0,30),UDim2.new(0,5,0,5),T.c.ac,8)
local tg=Instance.new("UIGradient")
tg.Color=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(40,150,80)),ColorSequenceKeypoint.new(1,Color3.fromRGB(20,100,50))}
tg.Parent=tb

local tl=Instance.new("TextLabel")
tl.Size=UDim2.new(1,-35,1,0)
tl.Position=UDim2.new(0,8,0,0)
tl.BackgroundTransparency=1
tl.Text="🛍️ Advanced Auto Shop"
tl.TextColor3=T.c.tx
tl.TextSize=12
tl.Font=Enum.Font.GothamBold
tl.TextXAlignment=Enum.TextXAlignment.Left
tl.Parent=tb

local mb,_=ub:cb(tb,UDim2.new(0,22,0,22),UDim2.new(1,-25,0,4),"-")
local im=false

local tc=ub:cf(mf,UDim2.new(1,-10,0,32),UDim2.new(0,5,0,40),T.c.sc,6)
local tly=Instance.new("UIListLayout")
tly.FillDirection=Enum.FillDirection.Horizontal
tly.Padding=UDim.new(0,3)
tly.Parent=tc

local cc=ub:cf(mf,UDim2.new(1,-10,1,-85),UDim2.new(0,5,0,77),T.c.sc,6)

local tabs={
{n="Control",i="⚙️"},
{n="Plants",i="🌱"},
{n="Shop",i="🛒"},
{n="Pets",i="🐾"},
{n="Events",i="🎉"}
}

local tbs={}
local tcs={}
local at=cfg.at or 1

local function oi(col,cb,bs)
bs=bs or 50
local ct=0
for k,v in pairs(col)do
cb(k,v)
ct=ct+1
if ct>=bs then
ct=0
RS.Heartbeat:Wait()
end
end
end

local function sc(sig,cb,dt)
dt=dt or 0.1
local lc=0
return sig:Connect(function(...)
local nw=tick()
if nw-lc>=dt then
lc=nw
cb(...)
end
end)
end

local GD={}
function GD.gpp()
local ck="playerPlot"
local cd=c:get(ck)
if cd then return cd end
for _,f in pairs(workspace.Farm:GetChildren())do
local im=f:FindFirstChild("Important")
local dt=im and im:FindFirstChild("Data")
local ow=dt and dt:FindFirstChild("Owner")
if ow and ow.Value==p.Name then
c:set(ck,im,60)
return im
end
end
return nil
end
function GD.gpn()
local ck="plantNames"
local cd=c:get(ck)
if cd then return cd end
local pl=GD.gpp()
if not pl then return{}end
local pn={}
local sn={}
for _,pt in pairs(pl.Plants_Physical:GetChildren())do
if pt:IsA("Model")and not sn[pt.Name]then
sn[pt.Name]=true
table.insert(pn,pt.Name)
end
end
c:set(ck,pn,30)
return pn
end
function GD.gpe()
local ck="petEggs"
local cd=c:get(ck)
if cd then return cd end
local pr=Rep:WaitForChild("Data"):WaitForChild("PetRegistry")
local eg=require(pr).PetEggs
c:set(ck,eg,300)
return eg
end

local AM={}
AM.__index=AM
function AM.new()
local s=setmetatable({cn={},lp={}},AM)
return s
end
function AM:sc()
if self.lp.co then return end
self.lp.co=task.spawn(function()
while cfg.co do
local pl=GD.gpp()
if pl then
local ct=0
local mb=200
oi(pl.Plants_Physical:GetChildren(),function(_,pt)
if ct>=mb then return end
if not pt:IsA("Model")or not cfg.sp[pt.Name]then return end
local fr=pt:FindFirstChild("Fruits")
if fr then
for _,ft in pairs(fr:GetChildren())do
if ct>=mb then break end
Rep.ByteNetReliable:FireServer(buffer.fromstring("\001\001\000\001"),{ft})
ct=ct+1
RS.Heartbeat:Wait()
end
else
Rep.ByteNetReliable:FireServer(buffer.fromstring("\001\001\000\001"),{pt})
ct=ct+1
RS.Heartbeat:Wait()
end
end,10)
end
task.wait(5)
end
self.lp.co=nil
end)
end
function AM:sas()
if self.lp.as then return end
self.lp.as=task.spawn(function()
while cfg.as do
Rep:WaitForChild("GameEvents"):WaitForChild("Sell_Inventory"):FireServer()
task.wait(0.5)
end
self.lp.as=nil
end)
end
function AM:sap()
if not cfg.ap then return end
local ch=p.Character
if not ch then return end
local tl=ch:FindFirstChildOfClass("Tool")
if not tl then return end
local sn=tl.Name:gsub(" Seed %[X%d+%]",""):gsub(" Seed","")
local pl=GD.gpp()
if pl then
local pts=pl:FindFirstChild("Plants_Physical")
if pts then
local pt=pts:FindFirstChild(sn)
if pt and pt.PrimaryPart then
local ps=pt.PrimaryPart.Position
self.lp.ap=task.spawn(function()
while cfg.ap do
local ct=ch:FindFirstChildOfClass("Tool")
if not ct or not ct.Name:find(sn)then break end
Rep.GameEvents.Plant_RE:FireServer(ps,sn)
task.wait(0.1)
end
self.lp.ap=nil
end)
end
end
end
end
function AM:sl(ln)
if self.lp[ln]then
task.cancel(self.lp[ln])
self.lp[ln]=nil
end
end

local am=AM.new()

local function fel()
for _,v in pairs(workspace.Interaction.UpdateItems.SummerHarvestEvent.Sign:GetDescendants())do
if v:IsA("TextLabel")and v.Text:find("Summer Harvest Ends:")then return v end
end
end

local function ael()
while cfg.ae do
local el=fel()
if el then
while el and cfg.ae do
Rep.GameEvents.SummerHarvestRemoteEvent:FireServer("SubmitHeldPlant")
RS.Heartbeat:Wait()
el=fel()
end
end
RS.Heartbeat:Wait()
end
end

local function het(t)
if cfg.ae and t:IsA("Tool")and t.Name:find("%[.+kg%]")then
t.Parent=p.Character
end
end

local function cct()
local ct=ub:cf(cc,UDim2.new(1,0,1,0),UDim2.new(0,0,0,0),Color3.new(0,0,0),0)
ct.BackgroundTransparency=1
local sf,ly=ub:cs(ct,UDim2.new(1,-8,1,-8),UDim2.new(0,4,0,4))
local cs=ub:cf(sf,UDim2.new(1,-6,0,100),UDim2.new(0,0,0,0),T.c.sc,8)
local st=Instance.new("TextLabel")
st.Size=UDim2.new(1,-8,0,20)
st.Position=UDim2.new(0,4,0,4)
st.BackgroundTransparency=1
st.Text="⚙️ Main Controls"
st.TextColor3=T.c.ts
st.TextSize=11
st.Font=Enum.Font.GothamBold
st.TextXAlignment=Enum.TextXAlignment.Left
st.Parent=cs
local cb,cs1=ub:cb(cs,UDim2.new(0.48,0,0,20),UDim2.new(0,4,0,28))
local sb,ss1=ub:cb(cs,UDim2.new(0.48,0,0,20),UDim2.new(0.52,0,0,28))
local pb,ps1=ub:cb(cs,UDim2.new(0.48,0,0,20),UDim2.new(0,4,0,52))
local eb,es1=ub:cb(cs,UDim2.new(0.48,0,0,20),UDim2.new(0.52,0,0,52))
local ab,as1=ub:cb(cs,UDim2.new(0.48,0,0,20),UDim2.new(0,4,0,76))
local function ub1(bt,st,ia,tx)
bt.Text=tx..(ia and" ON"or" OFF")
bt.BackgroundColor3=ia and T.c.ac or T.c.in
st.Color=ia and T.c.ah or T.c.bd
end
local function uab()
ub1(cb,cs1,cfg.co,"📦 Collect:")
ub1(sb,ss1,cfg.as,"💰 Auto Sell:")
ub1(pb,ps1,cfg.ap,"🌿 Auto Plant:")
ub1(eb,es1,cfg.ae,"🍓 Auto Event:")
ub1(ab,as1,cfg.eas,"🔄 Event Auto:")
end
cb.MouseButton1Click:Connect(function()
cfg.co=not cfg.co
uab()
if cfg.co then am:sc()else am:sl("co")end
cm:sv(cfg)
end)
sb.MouseButton1Click:Connect(function()
cfg.as=not cfg.as
uab()
if cfg.as then am:sas()else am:sl("as")end
cm:sv(cfg)
end)
pb.MouseButton1Click:Connect(function()
cfg.ap=not cfg.ap
uab()
cm:sv(cfg)
end)
eb.MouseButton1Click:Connect(function()
cfg.ae=not cfg.ae
uab()
if cfg.ae then
for _,v in pairs(p.Backpack:GetChildren())do het(v)end
task.spawn(ael)
end
cm:sv(cfg)
end)
ab.MouseButton1Click:Connect(function()
cfg.eas=not cfg.eas
uab()
cm:sv(cfg)
end)
uab()
ly:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
sf.CanvasSize=UDim2.new(0,0,0,ly.AbsoluteContentSize.Y+8)
end)
return ct
end

local function cpt()
local ct=ub:cf(cc,UDim2.new(1,0,1,0),UDim2.new(0,0,0,0),Color3.new(0,0,0),0)
ct.BackgroundTransparency=1
local sf,ly=ub:cs(ct,UDim2.new(1,-8,1,-35),UDim2.new(0,4,0,30))
local function upb()
for _,ch in pairs(sf:GetChildren())do
if ch:IsA("TextButton")then ch:Destroy()end
end
local pn=GD.gpn()
for _,pnm in pairs(pn)do
local bt,st=ub:cb(sf,UDim2.new(1,-6,0,25),UDim2.new(0,0,0,0))
local is=cfg.sp[pnm]or false
bt.Text="🌱 "..pnm..": "..(is and"ON"or"OFF")
bt.BackgroundColor3=is and T.c.ac or T.c.in
st.Color=is and T.c.ah or T.c.bd
bt.TextXAlignment=Enum.TextXAlignment.Left
bt.MouseButton1Click:Connect(function()
cfg.sp[pnm]=not cfg.sp[pnm]
local ns=cfg.sp[pnm]
bt.Text="🌱 "..pnm..": "..(ns and"ON"or"OFF")
bt.BackgroundColor3=ns and T.c.ac or T.c.in
st.Color=ns and T.c.ah or T.c.bd
cm:sv(cfg)
end)
end
ly:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
sf.CanvasSize=UDim2.new(0,0,0,ly.AbsoluteContentSize.Y+8)
end)
end
local rb=ub:cb(ct,UDim2.new(0,80,0,20),UDim2.new(1,-85,0,5),"🔄 Refresh")
rb.MouseButton1Click:Connect(function()
c:inv("plantNames")
upb()
end)
upb()
return ct
end

local function cst()
local ct=ub:cf(cc,UDim2.new(1,0,1,0),UDim2.new(0,0,0,0),Color3.new(0,0,0),0)
ct.BackgroundTransparency=1
local sf,ly=ub:cs(ct,UDim2.new(1,-8,1,-8),UDim2.new(0,4,0,4))
task.spawn(function()
local gs=pg:WaitForChild("Gear_Shop")
local gf=gs.Frame.ScrollingFrame
local bge=Rep.GameEvents.BuyGearStock
for _,it in pairs(gf:GetChildren())do
local f2=it:FindFirstChild("Frame")
local sb=f2 and f2:FindFirstChild("Sheckles_Buy")
local is=sb and sb:FindFirstChild("In_Stock")
if is then
local bt=Instance.new("TextButton")
bt.Size=UDim2.new(0,16,0,16)
bt.Position=UDim2.new(1,-18,0,2)
bt.BackgroundColor3=cfg.g[it.Name]and T.c.ac or T.c.in
bt.Text=""
bt.Parent=sb
local co=Instance.new("UICorner")
co.CornerRadius=UDim.new(0,3)
co.Parent=bt
local ia=cfg.g[it.Name]or false
bt.MouseButton1Click:Connect(function()
ia=not ia
cfg.g[it.Name]=ia
bt.BackgroundColor3=ia and T.c.ac or T.c.in
cm:sv(cfg)
end)
task.spawn(function()
while true do
if ia and is.Visible then bge:FireServer(it.Name)end
task.wait(0.15)
end
end)
end
end
end)
task.spawn(function()
local ss=pg:WaitForChild("Seed_Shop")
local sf1=ss.Frame.ScrollingFrame
local bse=Rep.GameEvents.BuySeedStock
for _,it in pairs(sf1:GetChildren())do
if it:IsA("Frame")and it:FindFirstChild("Frame")then
local sb=it.Frame:FindFirstChild("Sheckles_Buy")
if sb then
local bt=Instance.new("TextButton")
bt.Size=UDim2.new(0,18,0,18)
bt.Position=UDim2.new(1,-22,0,3)
bt.BackgroundColor3=Color3.new(1,1,1)
bt.Text=""
bt.Parent=sb
bt.BorderSizePixel=1
bt.AutoButtonColor=false
local co=Instance.new("UICorner")
co.CornerRadius=UDim.new(0,3)
co.Parent=bt
local mk=Instance.new("Frame")
mk.Size=UDim2.new(1,-4,1,-4)
mk.Position=UDim2.new(0,2,0,2)
mk.BackgroundColor3=T.c.ac
mk.Visible=cfg.s[it.Name]or false
mk.Parent=bt
local mkc=Instance.new("UICorner")
mkc.CornerRadius=UDim.new(0,2)
mkc.Parent=mk
bt.MouseButton1Click:Connect(function()
cfg.s[it.Name]=not cfg.s[it.Name]
mk.Visible=cfg.s[it.Name]
if cfg.s[it.Name]then
task.spawn(function()
while cfg.s[it.Name]do
local cf=sf1:FindFirstChild(it.Name)
if not cf then break end
local cs=cf.Frame:FindFirstChild("Sheckles_Buy")
local cst=cs and cs:FindFirstChild("In_Stock")
if cst and cst.Visible then
bse:FireServer(it.Name)
else
repeat task.wait(0.05)
cst=cs and cs:FindFirstChild("In_Stock")
until(cst and cst.Visible)or not cfg.s[it.Name]
end
task.wait()
end
end)
end
cm:sv(cfg)
end)
end
end
end
end)
return ct
end

local function cpt1()
local ct=ub:cf(cc,UDim2.new(1,0,1,0),UDim2.new(0,0,0,0),Color3.new(0,0,0),0)
ct.BackgroundTransparency=1
local sf,ly=ub:cs(ct,UDim2.new(1,-8,1,-8),UDim2.new(0,4,0,4))
local eg=GD.gpe()
local bpe=Rep.GameEvents.BuyPetEgg
for en in pairs(eg)do
local bt,st=ub:cb(sf,UDim2.new(1,-6,0,28),UDim2.new(0,0,0,0))
local ia=cfg.pe[en]or false
bt.Text="🥚 "..en..": "..(ia and"ON"or"OFF")
bt.BackgroundColor3=ia and T.c.ac or T.c.in
st.Color=ia and T.c.ah or T.c.bd
bt.TextXAlignment=Enum.TextXAlignment.Left
bt.MouseButton1Click:Connect(function()
cfg.pe[en]=not cfg.pe[en]
local ns=cfg.pe[en]
bt.Text="🥚 "..en..": "..(ns and"ON"or"OFF")
bt.BackgroundColor3=ns and T.c.ac or T.c.in
st.Color=ns and T.c.ah or T.c.bd
if ns then
task.spawn(function()
while cfg.pe[en]do
local ds=require(Rep.Modules.DataService)
local dt=ds:GetData()
for ix,st in pairs(dt.PetEggStock.Stocks)do
if cfg.pe[en]and eg[st.EggName]and st.EggName==en and st.Stock>0 then
bpe:FireServer(ix)
end
end
task.wait(0.1)
end
end)
end
cm:sv(cfg)
end)
end
task.spawn(function()
local apu=pg:WaitForChild("ActivePetUI")
local psf=apu.Frame.Main.ScrollingFrame
local fe=Rep.GameEvents.ActivePetService
for _,pf in pairs(psf:GetChildren())do
if pf.Name:match("^%b{}$")and pf:FindFirstChild("PetStats")then
local st=pf.PetStats
local bt,st1=ub:cb(st,UDim2.new(1,-3,0,16),UDim2.new(0,1,0,1),"Auto Feed: OFF")
local pi=pf.Name
local ia=cfg.pf[pi]or false
local function ufb()
bt.Text="Auto Feed: "..(ia and"ON"or"OFF")
bt.BackgroundColor3=ia and T.c.ac or T.c.in
st1.Color=ia and T.c.ah or T.c.bd
end
local function eat()
for _,tl in pairs(p.Backpack:GetChildren())do
if tl:IsA("Tool")and tl.Name:find("%[.+kg%]")then
tl.Parent=p.Character
end
end
end
local function fl()
while ia do
eat()
fe:FireServer("Feed",pi)
RS.Heartbeat:Wait()
end
end
sc(p.Backpack.ChildAdded,function(tl)
if ia and tl:IsA("Tool")and tl.Name:find("%[.+kg%]")then
tl.Parent=p.Character
end
end)
bt.MouseButton1Click:Connect(function()
ia=not ia
cfg.pf[pi]=ia
ufb()
if ia then
eat()
task.spawn(fl)
end
cm:sv(cfg)
end)
ufb()
end
end
end)
ly:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
sf.CanvasSize=UDim2.new(0,0,0,ly.AbsoluteContentSize.Y+8)
end)
return ct
end

local function cet()
local ct=ub:cf(cc,UDim2.new(1,0,1,0),UDim2.new(0,0,0,0),Color3.new(0,0,0),0)
ct.BackgroundTransparency=1
local sf,ly=ub:cs(ct,UDim2.new(1,-8,1,-8),UDim2.new(0,4,0,4))
local es=ub:cf(sf,UDim2.new(1,-6,0,120),UDim2.new(0,0,0,0),T.c.sc,8)
local et=Instance.new("TextLabel")
et.Size=UDim2.new(1,-8,0,20)
et.Position=UDim2.new(0,4,0,4)
et.BackgroundTransparency=1
et.Text="🍓 Summer Harvest Event"
et.TextColor3=T.c.ts
et.TextSize=11
et.Font=Enum.Font.GothamBold
et.TextXAlignment=Enum.TextXAlignment.Left
et.Parent=es
local eb,es1=ub:cb(es,UDim2.new(0.6,0,0,25),UDim2.new(0,4,0,28))
local ab,as1=ub:cb(es,UDim2.new(0.6,0,0,25),UDim2.new(0,4,0,57))
local st=Instance.new("TextLabel")
st.Size=UDim2.new(1,-8,0,25)
st.Position=UDim2.new(0,4,0,90)
st.BackgroundTransparency=1
st.Text="Event Auto: When event starts, auto-enables collect and disables sell. Restores after event."
st.TextColor3=T.c.ts
st.TextSize=9
st.Font=Enum.Font.Gotham
st.TextWrapped=true
st.TextXAlignment=Enum.TextXAlignment.Left
st.Parent=es
local function ueb()
eb.Text="🍓 Auto Event: "..(cfg.ae and"ON"or"OFF")
eb.BackgroundColor3=cfg.ae and T.c.ac or T.c.in
es1.Color=cfg.ae and T.c.ah or T.c.bd
ab.Text="🔄 Event Auto: "..(cfg.eas and"ON"or"OFF")
ab.BackgroundColor3=cfg.eas and T.c.ac or T.c.in
as1.Color=cfg.eas and T.c.ah or T.c.bd
end
eb.MouseButton1Click:Connect(function()
cfg.ae=not cfg.ae
ueb()
if cfg.ae then
for _,v in pairs(p.Backpack:GetChildren())do het(v)end
task.spawn(ael)
end
cm:sv(cfg)
end)
ab.MouseButton1Click:Connect(function()
cfg.eas=not cfg.eas
ueb()
cm:sv(cfg)
end)
ueb()
ly:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
sf.CanvasSize=UDim2.new(0,0,0,ly.AbsoluteContentSize.Y+8)
end)
return ct
end

for i,td in ipairs(tabs)do
local bt,st=ub:cb(tc,T.s.tb,UDim2.new(0,0,0,3),td.i.." "..td.n)
tbs[i]={b=bt,s=st}
local ct
if i==1 then ct=cct()
elseif i==2 then ct=cpt()
elseif i==3 then ct=cst()
elseif i==4 then ct=cpt1()
elseif i==5 then ct=cet()
end
tcs[i]=ct
ct.Visible=(i==at)
bt.MouseButton1Click:Connect(function()
for j,tc1 in ipairs(tcs)do
tc1.Visible=false
tbs[j].b.BackgroundColor3=T.c.in
tbs[j].s.Color=T.c.bd
end
ct.Visible=true
bt.BackgroundColor3=T.c.ac
st.Color=T.c.ah
at=i
cfg.at=i
cm:sv(cfg)
end)
if i==at then
bt.BackgroundColor3=T.c.ac
st.Color=T.c.ah
end
end

mb.MouseButton1Click:Connect(function()
im=not im
if im then
local tw=TS:Create(mf,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size=UDim2.new(0.85,0,0,40)})
tw:Play()
mb.Text="+"
tw.Completed:Connect(function()
tc.Visible=false
cc.Visible=false
end)
else
tc.Visible=true
cc.Visible=true
local tw=TS:Create(mf,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size=T.s.mf})
tw:Play()
mb.Text="-"
end
end)

local cl=Instance.new("TextLabel")
cl.Size=UDim2.new(1,0,0,12)
cl.Position=UDim2.new(0,0,1,-15)
cl.BackgroundTransparency=1
cl.Text="✨ Advanced Version by OneCreatorX"
cl.TextColor3=Color3.fromRGB(120,120,130)
cl.TextSize=8
cl.Font=Enum.Font.GothamMedium
cl.TextXAlignment=Enum.TextXAlignment.Center
cl.Parent=mf

sc(p.Backpack.ChildAdded,het)

local lel=nil
local eas=false
local oac=false
local oas=false

task.spawn(function()
while true do
if cfg.eas then
local el=fel()
if el and not eas then
eas=true
oac=cfg.co
oas=cfg.as
if not cfg.co then
cfg.co=true
am:sc()
end
if cfg.as then
cfg.as=false
am:sl("as")
end
elseif not el and eas then
eas=false
cfg.co=oac
cfg.as=oas
if oac then am:sc()else am:sl("co")end
if oas then am:sas()else am:sl("as")end
end
end
task.wait(1)
end
end)

sc(p.CharacterAdded,function(ch)
sc(ch.ChildAdded,function(ch1)
if ch1:IsA("Tool")and cfg.ap then
task.spawn(function()am:sap()end)
end
end)
end)

if p.Character then
sc(p.Character.ChildAdded,function(ch1)
if ch1:IsA("Tool")and cfg.ap then
task.spawn(function()am:sap()end)
end
end)
end

if cfg.co then am:sc()end
if cfg.as then am:sas()end

game:BindToClose(function()cm:sv(cfg)end)

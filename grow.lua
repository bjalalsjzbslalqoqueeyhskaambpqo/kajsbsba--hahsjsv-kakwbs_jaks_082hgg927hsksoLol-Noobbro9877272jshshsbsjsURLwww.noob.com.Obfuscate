local r=_G.VALIDATION_TOKEN and game:HttpGet("https://system.heatherx.site/validate/onecreatorx/grow-garden/".._G.VALIDATION_TOKEN)
if r~="1"then return end

local vm
for _,m in ipairs(getloadedmodules())do
 if m.Name=="VariantVisuals"then vm=require(m)break end
end
if vm then vm.SetVisuals=function()end end

local p=game.Players.LocalPlayer
local rs=game:GetService("RunService")
local hs=game:GetService("HttpService")
local rp=game.ReplicatedStorage
local ws=workspace
local pg=p.PlayerGui

local g=Instance.new("ScreenGui",pg)
g.Name="GrowGardenMenu"
g.ResetOnSpawn=false

local cf="GrowGardenConfig.json"
local cfg={
co=false,as=false,ap=false,ae=false,
sp={},pe={},gr={},sd={},pf={}
}

local tb={}
local ct=nil
local mn=false
local pt=nil

local c1=Color3.fromRGB(15,15,20)
local c2=Color3.fromRGB(25,130,65)
local c3=Color3.fromRGB(30,30,35)
local c4=Color3.fromRGB(0,120,50)
local c5=Color3.fromRGB(50,50,60)
local c6=Color3.fromRGB(255,255,255)
local c7=Color3.fromRGB(200,200,210)

local function sv()
local ok,er=pcall(function()
writefile(cf,hs:JSONEncode(cfg))
end)
if not ok then warn("Save failed:",er)end
end

local function ld()
if isfile(cf)then
local ok,dt=pcall(function()
return hs:JSONDecode(readfile(cf))
end)
if ok and dt then
for k,v in pairs(dt)do cfg[k]=v end
end
end
end

local function cr(p,r)
local c=Instance.new("UICorner",p)
c.CornerRadius=UDim.new(0,r or 8)
return c
end

local function st(p,c,t)
local s=Instance.new("UIStroke",p)
s.Color=c or Color3.fromRGB(60,60,70)
s.Thickness=t or 1
return s
end

local function gd(p,c1,c2)
local g=Instance.new("UIGradient",p)
g.Color=ColorSequence.new{
ColorSequenceKeypoint.new(0,c1),
ColorSequenceKeypoint.new(1,c2)
}
return g
end

local function ll(p,d,pd)
local l=Instance.new("UIListLayout",p)
l.FillDirection=d or Enum.FillDirection.Vertical
l.Padding=UDim.new(0,pd or 5)
l.SortOrder=Enum.SortOrder.LayoutOrder
return l
end

local m=Instance.new("Frame",g)
m.Size=UDim2.new(0,400,0,500)
m.Position=UDim2.new(0,10,0,10)
m.BackgroundColor3=c1
m.BorderSizePixel=0
m.Draggable=true
m.Active=true
cr(m,12)
st(m,Color3.fromRGB(60,60,70),2)

local sh=Instance.new("Frame",m)
sh.Size=UDim2.new(1,8,1,8)
sh.Position=UDim2.new(0,-4,0,4)
sh.BackgroundColor3=Color3.fromRGB(0,0,0)
sh.BackgroundTransparency=0.8
sh.ZIndex=-1
cr(sh,12)

local hd=Instance.new("Frame",m)
hd.Size=UDim2.new(1,0,0,50)
hd.BackgroundColor3=c2
cr(hd,12)
gd(hd,Color3.fromRGB(35,150,85),Color3.fromRGB(15,100,45))

local tt=Instance.new("TextLabel",hd)
tt.Size=UDim2.new(1,-80,1,0)
tt.Position=UDim2.new(0,15,0,0)
tt.BackgroundTransparency=1
tt.Text="🌱 Grow Garden"
tt.TextColor3=c6
tt.TextSize=18
tt.Font=Enum.Font.GothamBold
tt.TextXAlignment=Enum.TextXAlignment.Left

local mb=Instance.new("TextButton",hd)
mb.Size=UDim2.new(0,30,0,30)
mb.Position=UDim2.new(1,-70,0,10)
mb.BackgroundColor3=Color3.fromRGB(40,40,50)
mb.Text="-"
mb.TextColor3=c6
mb.TextSize=16
mb.Font=Enum.Font.GothamBold
cr(mb,6)

local cb=Instance.new("TextButton",hd)
cb.Size=UDim2.new(0,30,0,30)
cb.Position=UDim2.new(1,-35,0,10)
cb.BackgroundColor3=Color3.fromRGB(180,50,50)
cb.Text="×"
cb.TextColor3=c6
cb.TextSize=16
cb.Font=Enum.Font.GothamBold
cr(cb,6)

local tc=Instance.new("Frame",m)
tc.Size=UDim2.new(1,-20,0,40)
tc.Position=UDim2.new(0,10,0,60)
tc.BackgroundColor3=Color3.fromRGB(25,25,30)
cr(tc,8)

local tl=ll(tc,Enum.FillDirection.Horizontal,2)

local cf=Instance.new("Frame",m)
cf.Size=UDim2.new(1,-20,1,-120)
cf.Position=UDim2.new(0,10,0,110)
cf.BackgroundColor3=Color3.fromRGB(20,20,25)
cr(cf,8)

local function ct(n,ic)
local t=Instance.new("TextButton",tc)
t.Size=UDim2.new(0.2,0,1,0)
t.BackgroundColor3=Color3.fromRGB(35,35,40)
t.Text=ic.." "..n
t.TextColor3=c7
t.TextSize=12
t.Font=Enum.Font.GothamSemibold
cr(t,6)

local c=Instance.new("ScrollingFrame",cf)
c.Size=UDim2.new(1,0,1,0)
c.BackgroundTransparency=1
c.ScrollBarThickness=6
c.ScrollBarImageColor3=Color3.fromRGB(60,60,70)
c.Visible=false
c.CanvasSize=UDim2.new(0,0,0,0)

local l=ll(c)

tb[n]={bt=t,ct=c,ly=l}

t.MouseButton1Click:Connect(function()
if ct then
ct.bt.BackgroundColor3=Color3.fromRGB(35,35,40)
ct.ct.Visible=false
end
ct=tb[n]
t.BackgroundColor3=c4
c.Visible=true
end)

l:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
c.CanvasSize=UDim2.new(0,0,0,l.AbsoluteContentSize.Y+20)
end)

return c,l
end

local function cs(pr,tl,ht)
local s=Instance.new("Frame",pr)
s.Size=UDim2.new(1,-10,0,ht or 100)
s.BackgroundColor3=c3
cr(s,8)
st(s,Color3.fromRGB(50,50,60))

local st=Instance.new("TextLabel",s)
st.Size=UDim2.new(1,-10,0,25)
st.Position=UDim2.new(0,5,0,5)
st.BackgroundTransparency=1
st.Text=tl
st.TextColor3=c7
st.TextSize=14
st.Font=Enum.Font.GothamBold
st.TextXAlignment=Enum.TextXAlignment.Left

return s
end

local function tb(pr,tx,ps,sz,cb)
local b=Instance.new("TextButton",pr)
b.Size=sz or UDim2.new(0.48,0,0,30)
b.Position=ps or UDim2.new(0,5,0,35)
b.BackgroundColor3=c5
b.Text=tx
b.TextColor3=c6
b.TextSize=11
b.Font=Enum.Font.GothamSemibold
cr(b,6)
local s=st(b,Color3.fromRGB(80,80,90))

b.MouseButton1Click:Connect(cb)
return b,s
end

local cc,cl=ct("Ctrl","⚙️")
local pc,pl=ct("Plant","🌱")
local sc,sl=ct("Shop","🛒")
local ec,el=ct("Pet","🐾")
local vc,vl=ct("Event","🎉")

local cs1=cs(cc,"Main Controls",120)
local cob,cos=tb(cs1,"📦 Collect: OFF",UDim2.new(0,5,0,35),UDim2.new(0.48,0,0,25))
local asb,ass=tb(cs1,"💰 Auto Sell: OFF",UDim2.new(0.52,0,0,35),UDim2.new(0.48,0,0,25))
local apb,aps=tb(cs1,"🌿 Auto Plant: OFF",UDim2.new(0,5,0,65),UDim2.new(0.48,0,0,25))

local cs2=cs(cc,"Quick Actions",80)
cs2.LayoutOrder=1
local gb=tb(cs2,"⚙️ Gears",UDim2.new(0,5,0,35),UDim2.new(0.3,0,0,25))
local sb=tb(cs2,"🌱 Seeds",UDim2.new(0.35,0,0,35),UDim2.new(0.3,0,0,25))
local cab=tb(cs2,"📦 All",UDim2.new(0.7,0,0,35),UDim2.new(0.3,0,0,25))

local ps1=cs(pc,"Plant Selection",300)
local psf=Instance.new("ScrollingFrame",ps1)
psf.Size=UDim2.new(1,-10,1,-35)
psf.Position=UDim2.new(0,5,0,30)
psf.BackgroundColor3=Color3.fromRGB(25,25,30)
psf.ScrollBarThickness=6
psf.ScrollBarImageColor3=Color3.fromRGB(60,60,70)
cr(psf,6)
local psl=ll(psf)

local gs1=cs(sc,"Auto Buy Gears",200)
local gsf=Instance.new("ScrollingFrame",gs1)
gsf.Size=UDim2.new(1,-10,1,-35)
gsf.Position=UDim2.new(0,5,0,30)
gsf.BackgroundColor3=Color3.fromRGB(25,25,30)
gsf.ScrollBarThickness=6
cr(gsf,6)
local gsl=ll(gsf)

local ss1=cs(sc,"Auto Buy Seeds",200)
ss1.LayoutOrder=1
local ssf=Instance.new("ScrollingFrame",ss1)
ssf.Size=UDim2.new(1,-10,1,-35)
ssf.Position=UDim2.new(0,5,0,30)
ssf.BackgroundColor3=Color3.fromRGB(25,25,30)
ssf.ScrollBarThickness=6
cr(ssf,6)
local ssl=ll(ssf)

local es1=cs(ec,"Pet Eggs",250)
local esf=Instance.new("ScrollingFrame",es1)
esf.Size=UDim2.new(1,-10,1,-35)
esf.Position=UDim2.new(0,5,0,30)
esf.BackgroundColor3=Color3.fromRGB(25,25,30)
esf.ScrollBarThickness=6
cr(esf,6)
local esl=ll(esf)

local fs1=cs(ec,"Auto Feed Pets",200)
fs1.LayoutOrder=1
local fsf=Instance.new("ScrollingFrame",fs1)
fsf.Size=UDim2.new(1,-10,1,-35)
fsf.Position=UDim2.new(0,5,0,30)
fsf.BackgroundColor3=Color3.fromRGB(25,25,30)
fsf.ScrollBarThickness=6
cr(fsf,6)
local fsl=ll(fsf)

local vs1=cs(vc,"Event Controls",100)
local aeb,aes=tb(vs1,"🍓 Auto Event: OFF",UDim2.new(0,5,0,35),UDim2.new(0.48,0,0,25))

local function ub(b,s,st,tx)
b.Text=tx..(st and " ON" or " OFF")
b.BackgroundColor3=st and c4 or c5
s.Color=st and Color3.fromRGB(0,150,70) or Color3.fromRGB(80,80,90)
end

local function gp()
for _,f in pairs(ws.Farm:GetChildren())do
local d=f:FindFirstChild("Important")
local o=d and d:FindFirstChild("Data") and d.Data:FindFirstChild("Owner")
if o and o.Value==p.Name then pt=d break end
end
if not pt then return {} end

local pn={}
local sn={}
for _,pl in pairs(pt.Plants_Physical:GetChildren())do
if pl:IsA("Model") and not sn[pl.Name] then
sn[pl.Name]=true
table.insert(pn,pl.Name)
end
end
return pn
end

local function cp()
for _,ch in pairs(psf:GetChildren())do
if ch:IsA("TextButton")then ch:Destroy()end
end

local pn=gp()
for _,nm in pairs(pn)do
local b=Instance.new("TextButton",psf)
b.Size=UDim2.new(1,-8,0,25)
b.BackgroundColor3=cfg.sp[nm] and c4 or Color3.fromRGB(45,45,55)
b.Text="🌱 "..nm..": "..(cfg.sp[nm] and "ON" or "OFF")
b.TextColor3=c6
b.TextSize=11
b.Font=Enum.Font.GothamMedium
b.TextXAlignment=Enum.TextXAlignment.Left
cr(b,6)
local s=st(b,cfg.sp[nm] and Color3.fromRGB(0,150,70) or Color3.fromRGB(70,70,80))

b.MouseButton1Click:Connect(function()
cfg.sp[nm]=not cfg.sp[nm]
ub(b,s,cfg.sp[nm],"🌱 "..nm..": ")
sv()
end)
end

psl:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
psf.CanvasSize=UDim2.new(0,0,0,psl.AbsoluteContentSize.Y+10)
end)
end

local function sg()
task.spawn(function()
local fr=pg.Gear_Shop.Frame.ScrollingFrame
local ev=rp.GameEvents.BuyGearStock

for _,i in pairs(fr:GetChildren())do
if i:IsA("Frame")then
local f2=i:FindFirstChild("Frame")
local s=f2 and f2:FindFirstChild("Sheckles_Buy")
local st=s and s:FindFirstChild("In_Stock")
if st then
local b=Instance.new("TextButton",gsf)
b.Size=UDim2.new(1,-8,0,25)
b.BackgroundColor3=cfg.gr[i.Name] and c4 or Color3.fromRGB(45,45,55)
b.Text="⚙️ "..i.Name..": "..(cfg.gr[i.Name] and "ON" or "OFF")
b.TextColor3=c6
b.TextSize=11
b.Font=Enum.Font.GothamMedium
b.TextXAlignment=Enum.TextXAlignment.Left
cr(b,6)
local bs=st(b,cfg.gr[i.Name] and Color3.fromRGB(0,150,70) or Color3.fromRGB(70,70,80))

b.MouseButton1Click:Connect(function()
cfg.gr[i.Name]=not cfg.gr[i.Name]
ub(b,bs,cfg.gr[i.Name],"⚙️ "..i.Name..": ")
sv()
end)

if cfg.gr[i.Name]then
task.spawn(function()
while cfg.gr[i.Name]do
if st.Visible then ev:FireServer(i.Name)end
task.wait(0.2)
end
end)
end
end
end
end

gsl:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
gsf.CanvasSize=UDim2.new(0,0,0,gsl.AbsoluteContentSize.Y+10)
end)
end)
end

local function ss()
task.spawn(function()
local gui=pg.Seed_Shop.Frame.ScrollingFrame
local r=rp.GameEvents.BuySeedStock

for _,v in pairs(gui:GetChildren())do
if v:IsA("Frame") and v:FindFirstChild("Frame") and v.Frame:FindFirstChild("Sheckles_Buy")then
local b=Instance.new("TextButton",ssf)
b.Size=UDim2.new(1,-8,0,25)
b.BackgroundColor3=cfg.sd[v.Name] and c4 or Color3.fromRGB(45,45,55)
b.Text="🌱 "..v.Name..": "..(cfg.sd[v.Name] and "ON" or "OFF")
b.TextColor3=c6
b.TextSize=11
b.Font=Enum.Font.GothamMedium
b.TextXAlignment=Enum.TextXAlignment.Left
cr(b,6)
local bs=st(b,cfg.sd[v.Name] and Color3.fromRGB(0,150,70) or Color3.fromRGB(70,70,80))

b.MouseButton1Click:Connect(function()
cfg.sd[v.Name]=not cfg.sd[v.Name]
ub(b,bs,cfg.sd[v.Name],"🌱 "..v.Name..": ")
sv()
if cfg.sd[v.Name]then
task.spawn(function()
while cfg.sd[v.Name]do
local f=gui:FindFirstChild(v.Name)
if f then
local s=f.Frame:FindFirstChild("Sheckles_Buy")
local st=s and s:FindFirstChild("In_Stock")
if st and st.Visible then r:FireServer(v.Name)end
end
task.wait(0.2)
end
end)
end
end)

if cfg.sd[v.Name]then
task.spawn(function()
while cfg.sd[v.Name]do
local f=gui:FindFirstChild(v.Name)
if f then
local s=f.Frame:FindFirstChild("Sheckles_Buy")
local st=s and s:FindFirstChild("In_Stock")
if st and st.Visible then r:FireServer(v.Name)end
end
task.wait(0.2)
end
end)
end
end
end

ssl:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
ssf.CanvasSize=UDim2.new(0,0,0,ssl.AbsoluteContentSize.Y+10)
end)
end)
end

local function se()
local e=require(rp.Data.PetRegistry).PetEggs
local r=rp.GameEvents.BuyPetEgg

for n in pairs(e)do
local b=Instance.new("TextButton",esf)
b.Size=UDim2.new(1,-8,0,30)
b.BackgroundColor3=cfg.pe[n] and c4 or Color3.fromRGB(45,45,55)
b.Text="🥚 "..n..": "..(cfg.pe[n] and "ON" or "OFF")
b.TextColor3=c6
b.TextSize=11
b.Font=Enum.Font.GothamMedium
b.TextXAlignment=Enum.TextXAlignment.Left
cr(b,8)
local bs=st(b,cfg.pe[n] and Color3.fromRGB(0,150,70) or Color3.fromRGB(70,70,80))

b.MouseButton1Click:Connect(function()
cfg.pe[n]=not cfg.pe[n]
ub(b,bs,cfg.pe[n],"🥚 "..n..": ")
sv()
if cfg.pe[n]then
task.spawn(function()
while cfg.pe[n]do
local d=require(rp.Modules.DataService):GetData()
for i,v in pairs(d.PetEggStock.Stocks)do
if cfg.pe[n] and e[v.EggName] and v.EggName==n and v.Stock>0 then
r:FireServer(i)
end
end
task.wait(0.15)
end
end)
end
end)

if cfg.pe[n]then
task.spawn(function()
while cfg.pe[n]do
local d=require(rp.Modules.DataService):GetData()
for i,v in pairs(d.PetEggStock.Stocks)do
if cfg.pe[n] and e[v.EggName] and v.EggName==n and v.Stock>0 then
r:FireServer(i)
end
end
task.wait(0.15)
end
end)
end
end

esl:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
esf.CanvasSize=UDim2.new(0,0,0,esl.AbsoluteContentSize.Y+10)
end)
end

local function sf()
local pu=pg.ActivePetUI.Frame.Main.ScrollingFrame
local ev=rp.GameEvents.ActivePetService

for _,pf in pairs(pu:GetChildren())do
if pf.Name:match("^%b{}$") and pf:FindFirstChild("PetStats")then
local id=pf.Name
local b=Instance.new("TextButton",fsf)
b.Size=UDim2.new(1,-8,0,25)
b.BackgroundColor3=cfg.pf[id] and c4 or Color3.fromRGB(45,45,55)
b.Text="🍖 Pet "..id:sub(2,-2)..": "..(cfg.pf[id] and "ON" or "OFF")
b.TextColor3=c6
b.TextSize=11
b.Font=Enum.Font.GothamMedium
b.TextXAlignment=Enum.TextXAlignment.Left
cr(b,6)
local bs=st(b,cfg.pf[id] and Color3.fromRGB(0,150,70) or Color3.fromRGB(70,70,80))

local function ea()
for _,tl in pairs(p.Backpack:GetChildren())do
if tl:IsA("Tool") and tl.Name:find("%[.+kg%]")then
tl.Parent=p.Character
end
end
end

b.MouseButton1Click:Connect(function()
cfg.pf[id]=not cfg.pf[id]
ub(b,bs,cfg.pf[id],"🍖 Pet "..id:sub(2,-2)..": ")
sv()
if cfg.pf[id]then
task.spawn(function()
while cfg.pf[id]do
ea()
ev:FireServer("Feed",id)
rs.Heartbeat:Wait()
end
end)
end
end)

if cfg.pf[id]then
task.spawn(function()
while cfg.pf[id]do
ea()
ev:FireServer("Feed",id)
rs.Heartbeat:Wait()
end
end)
end

p.Backpack.ChildAdded:Connect(function(tl)
if cfg.pf[id] and tl:IsA("Tool") and tl.Name:find("%[.+kg%]")then
tl.Parent=p.Character
end
end)
end
end

fsl:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
fsf.CanvasSize=UDim2.new(0,0,0,fsl.AbsoluteContentSize.Y+10)
end)
end

local function co()
while cfg.co do
local ct=0
if pt then
for _,pl in pairs(pt.Plants_Physical:GetChildren())do
if pl:IsA("Model") and cfg.sp[pl.Name]then
local f=pl:FindFirstChild("Fruits")
if f then
for _,v in pairs(f:GetChildren())do
rp.ByteNetReliable:FireServer(buffer.fromstring("\001\001\000\001"),{v})
ct+=1
if ct>=150 then break end
rs.Heartbeat:Wait()
end
else
rp.ByteNetReliable:FireServer(buffer.fromstring("\001\001\000\001"),{pl})
ct+=1
if ct>=150 then break end
rs.Heartbeat:Wait()
end
end
if ct>=150 then break end
end
end
task.wait(3)
end
end

local function as()
while cfg.as do
rp.GameEvents.Sell_Inventory:FireServer()
task.wait(1)
end
end

local function ap()
local ch=p.Character if not ch then return end
local tl=ch:FindFirstChildOfClass("Tool") if not tl then return end
local rn=tl.Name
local sn=rn:gsub(" Seed %[X%d+%]",""):gsub(" Seed","")
for _,f in pairs(ws.Farm:GetChildren())do
local d=f:FindFirstChild("Important")
local o=d and d:FindFirstChild("Data") and d.Data:FindFirstChild("Owner")
if o and o.Value==p.Name then
local pl=d:FindFirstChild("Plants_Physical")
if pl then
local pt=pl:FindFirstChild(sn)
if pt and pt.PrimaryPart then
local ps=pt.PrimaryPart.Position
while cfg.ap do
local t=ch:FindFirstChildOfClass("Tool")
if not t then break end
if not t.Name:find(sn)then break end
rp.GameEvents.Plant_RE:FireServer(ps,sn)
task.wait(0.1)
end
end
end
break
end
end
end

local function ae()
local ev=rp.GameEvents.SummerHarvestRemoteEvent
local function fl()
for _,v in pairs(ws.Interaction.UpdateItems.SummerHarvestEvent.Sign:GetDescendants())do
if v:IsA("TextLabel") and v.Text:find("Summer Harvest Ends:")then return v end
end
end

local function ht(t)
if cfg.ae and t:IsA("Tool") and t.Name:find("%[.+kg%]")then
t.Parent=p.Character
end
end

p.Backpack.ChildAdded:Connect(ht)

while cfg.ae do
local lb=fl()
if lb then
for _,v in pairs(p.Backpack:GetChildren())do ht(v)end
while lb and cfg.ae do
ev:FireServer("SubmitHeldPlant")
rs.Heartbeat:Wait()
lb=fl()
end
end
rs.Heartbeat:Wait()
end
end

cob.MouseButton1Click:Connect(function()
cfg.co=not cfg.co
ub(cob,cos,cfg.co,"📦 Collect: ")
if cfg.co then task.spawn(co)end
sv()
end)

asb.MouseButton1Click:Connect(function()
cfg.as=not cfg.as
ub(asb,ass,cfg.as,"💰 Auto Sell: ")
if cfg.as then task.spawn(as)end
sv()
end)

apb.MouseButton1Click:Connect(function()
cfg.ap=not cfg.ap
ub(apb,aps,cfg.ap,"🌿 Auto Plant: ")
sv()
end)

aeb.MouseButton1Click:Connect(function()
cfg.ae=not cfg.ae
ub(aeb,aes,cfg.ae,"🍓 Auto Event: ")
if cfg.ae then task.spawn(ae)end
sv()
end)

p.CharacterAdded:Connect(function(ch)
ch.ChildAdded:Connect(function(cd)
if cd:IsA("Tool") and cfg.ap then
task.spawn(ap)
end
end)
end)

if p.Character then
p.Character.ChildAdded:Connect(function(cd)
if cd:IsA("Tool") and cfg.ap then
task.spawn(ap)
end
end)
end

mb.MouseButton1Click:Connect(function()
mn=not mn
if mn then
m:TweenSize(UDim2.new(0,400,0,50),"Out","Quad",0.3)
mb.Text="+"
tc.Visible=false
cf.Visible=false
else
tc.Visible=true
cf.Visible=true
m:TweenSize(UDim2.new(0,400,0,500),"Out","Quad",0.3)
mb.Text="-"
end
end)

cb.MouseButton1Click:Connect(function()
g:Destroy()
end)

local cr=Instance.new("TextLabel",m)
cr.Size=UDim2.new(1,0,0,15)
cr.Position=UDim2.new(0,0,1,-20)
cr.BackgroundTransparency=1
cr.Text="✨ OneCreatorX"
cr.TextColor3=Color3.fromRGB(120,120,130)
cr.TextSize=10
cr.Font=Enum.Font.GothamMedium
cr.TextXAlignment=Enum.TextXAlignment.Center

ld()
cp()
sg()
ss()
se()
sf()

ub(cob,cos,cfg.co,"📦 Collect: ")
ub(asb,ass,cfg.as,"💰 Auto Sell: ")
ub(apb,aps,cfg.ap,"🌿 Auto Plant: ")
ub(aeb,aes,cfg.ae,"🍓 Auto Event: ")

if not ct then
ct=tb["Ctrl"]
ct.bt.BackgroundColor3=c4
ct.ct.Visible=true
end

if cfg.co then task.spawn(co)end
if cfg.as then task.spawn(as)end
if cfg.ae then task.spawn(ae)end

task.spawn(function()
while true do
task.wait(30)
cp()
end
end)

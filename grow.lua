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
local ts=game:GetService("TweenService")

local g=Instance.new("ScreenGui",p.PlayerGui)
g.Name="CompactAutoShop"
g.ResetOnSpawn=false

local m=Instance.new("Frame",g)
m.Size=UDim2.new(0.35,0,0.6,0)
m.Position=UDim2.new(0.02,0,0.05,0)
m.BackgroundColor3=Color3.fromRGB(15,15,20)
m.BorderSizePixel=0
m.Draggable=true
m.Active=true

local mc=Instance.new("UICorner",m)
mc.CornerRadius=UDim.new(0,8)

local sh=Instance.new("Frame",m)
sh.Size=UDim2.new(1,4,1,4)
sh.Position=UDim2.new(0,-2,0,2)
sh.BackgroundColor3=Color3.fromRGB(0,0,0)
sh.BackgroundTransparency=0.7
sh.ZIndex=-1
local sc=Instance.new("UICorner",sh)
sc.CornerRadius=UDim.new(0,8)

local hd=Instance.new("Frame",m)
hd.Size=UDim2.new(1,0,0,35)
hd.BackgroundColor3=Color3.fromRGB(25,25,35)
local hc=Instance.new("UICorner",hd)
hc.CornerRadius=UDim.new(0,8)

local tt=Instance.new("TextLabel",hd)
tt.Size=UDim2.new(1,-50,1,0)
tt.Position=UDim2.new(0,8,0,0)
tt.BackgroundTransparency=1
tt.Text="🌟 Auto Shop"
tt.TextColor3=Color3.fromRGB(255,255,255)
tt.TextSize=14
tt.Font=Enum.Font.GothamBold
tt.TextXAlignment=Enum.TextXAlignment.Left

local st=Instance.new("TextLabel",hd)
st.Size=UDim2.new(0,50,0,15)
st.Position=UDim2.new(1,-55,0,3)
st.BackgroundColor3=Color3.fromRGB(0,150,50)
st.Text="● ON"
st.TextColor3=Color3.fromRGB(255,255,255)
st.TextSize=8
st.Font=Enum.Font.GothamBold
local stc=Instance.new("UICorner",st)
stc.CornerRadius=UDim.new(0,8)

local mn=Instance.new("TextButton",hd)
mn.Size=UDim2.new(0,25,0,25)
mn.Position=UDim2.new(1,-30,0,5)
mn.BackgroundColor3=Color3.fromRGB(60,60,70)
mn.Text="-"
mn.TextColor3=Color3.fromRGB(255,255,255)
mn.TextSize=12
mn.Font=Enum.Font.GothamBold
local mnc=Instance.new("UICorner",mn)
mnc.CornerRadius=UDim.new(0,6)

local tc=Instance.new("Frame",m)
tc.Size=UDim2.new(1,0,0,30)
tc.Position=UDim2.new(0,0,0,35)
tc.BackgroundColor3=Color3.fromRGB(20,20,25)

local tl=Instance.new("UIListLayout",tc)
tl.FillDirection=Enum.FillDirection.Horizontal
tl.SortOrder=Enum.SortOrder.LayoutOrder

local ct=Instance.new("Frame",m)
ct.Size=UDim2.new(1,0,1,-65)
ct.Position=UDim2.new(0,0,0,65)
ct.BackgroundTransparency=1

local tb={}
local at=nil
local mi=false

local cf={
co=false,
as=false,
ap=false,
ae=false,
sp={},
pe={},
gr={},
sd={},
pf={}
}

local fl="CompactAutoShopConfig.json"

local function sv()
writefile(fl,hs:JSONEncode(cf))
end

local function ld()
if isfile(fl) then
local ok,dt=pcall(function()
return hs:JSONDecode(readfile(fl))
end)
if ok and dt then
for k,v in pairs(dt) do
cf[k]=v
end
end
end
end

local function ct(nm,ic,od)
local t=Instance.new("TextButton",tc)
t.Size=UDim2.new(0.25,0,1,0)
t.BackgroundColor3=Color3.fromRGB(30,30,40)
t.Text=ic
t.TextColor3=Color3.fromRGB(180,180,190)
t.TextSize=10
t.Font=Enum.Font.GothamSemibold
t.LayoutOrder=od
local tc=Instance.new("UICorner",t)
tc.CornerRadius=UDim.new(0,6)

local tc=Instance.new("ScrollingFrame",ct)
tc.Size=UDim2.new(1,0,1,0)
tc.BackgroundTransparency=1
tc.ScrollBarThickness=4
tc.ScrollBarImageColor3=Color3.fromRGB(80,80,90)
tc.Visible=false
tc.CanvasSize=UDim2.new(0,0,0,0)

local ly=Instance.new("UIListLayout",tc)
ly.Padding=UDim.new(0,5)
ly.SortOrder=Enum.SortOrder.LayoutOrder

ly:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
tc.CanvasSize=UDim2.new(0,0,0,ly.AbsoluteContentSize.Y+10)
end)

tb[nm]={btn=t,cnt=tc,lay=ly}

t.MouseButton1Click:Connect(function()
for _,tb in pairs(tb) do
tb.btn.BackgroundColor3=Color3.fromRGB(30,30,40)
tb.btn.TextColor3=Color3.fromRGB(180,180,190)
tb.cnt.Visible=false
end
t.BackgroundColor3=Color3.fromRGB(50,50,65)
t.TextColor3=Color3.fromRGB(255,255,255)
tc.Visible=true
at=nm
end)

return tc
end

local function cs(pr,tl,ht)
local s=Instance.new("Frame",pr)
s.Size=UDim2.new(1,-10,0,ht)
s.BackgroundColor3=Color3.fromRGB(25,25,35)
local sc=Instance.new("UICorner",s)
sc.CornerRadius=UDim.new(0,6)

local st=Instance.new("TextLabel",s)
st.Size=UDim2.new(1,-10,0,20)
st.Position=UDim2.new(0,5,0,3)
st.BackgroundTransparency=1
st.Text=tl
st.TextColor3=Color3.fromRGB(200,200,210)
st.TextSize=10
st.Font=Enum.Font.GothamBold
st.TextXAlignment=Enum.TextXAlignment.Left

return s
end

local function cb(pr,tx,ps,sz,cb)
local b=Instance.new("TextButton",pr)
b.Size=sz
b.Position=ps
b.BackgroundColor3=Color3.fromRGB(50,50,60)
b.Text=tx
b.TextColor3=Color3.fromRGB(255,255,255)
b.TextSize=9
b.Font=Enum.Font.GothamSemibold
local bc=Instance.new("UICorner",b)
bc.CornerRadius=UDim.new(0,6)
local bs=Instance.new("UIStroke",b)
bs.Color=Color3.fromRGB(80,80,90)
bs.Thickness=1

b.MouseButton1Click:Connect(cb)
return b,bs
end

local function ub(b,s,ac,on,of)
b.Text=ac and on or of
b.BackgroundColor3=ac and Color3.fromRGB(0,120,50) or Color3.fromRGB(50,50,60)
s.Color=ac and Color3.fromRGB(0,150,70) or Color3.fromRGB(80,80,90)
end

local at=ct("Auto","⚙️",1)
local st=ct("Shop","🛒",2)
local pt=ct("Plant","🌱",3)
local et=ct("Pet","🐾",4)

local ms=cs(at,"🎮 Controls",80)

local cb,cs=cb(ms,"📦 Collect: OFF",UDim2.new(0,5,0,25),UDim2.new(0.48,0,0,20),function()
cf.co=not cf.co
ub(cb,cs,cf.co,"📦 Collect: ON","📦 Collect: OFF")
if cf.co then task.spawn(cl) end
sv()
end)

local sb,ss=cb(ms,"💰 Sell: OFF",UDim2.new(0.52,0,0,25),UDim2.new(0.48,0,0,20),function()
cf.as=not cf.as
ub(sb,ss,cf.as,"💰 Sell: ON","💰 Sell: OFF")
if cf.as then task.spawn(sl) end
sv()
end)

local pb,ps=cb(ms,"🌿 Plant: OFF",UDim2.new(0,5,0,50),UDim2.new(0.48,0,0,20),function()
cf.ap=not cf.ap
ub(pb,ps,cf.ap,"🌿 Plant: ON","🌿 Plant: OFF")
sv()
end)

local eb,es=cb(ms,"🍓 Event: OFF",UDim2.new(0.52,0,0,50),UDim2.new(0.48,0,0,20),function()
cf.ae=not cf.ae
ub(eb,es,cf.ae,"🍓 Event: ON","🍓 Event: OFF")
if cf.ae then task.spawn(el) end
sv()
end)

local gs=cs(st,"⚙️ Gears",120)
local gf=Instance.new("ScrollingFrame",gs)
gf.Size=UDim2.new(1,-10,1,-25)
gf.Position=UDim2.new(0,5,0,20)
gf.BackgroundColor3=Color3.fromRGB(20,20,25)
gf.ScrollBarThickness=4
gf.ScrollBarImageColor3=Color3.fromRGB(60,60,70)
local gfc=Instance.new("UICorner",gf)
gfc.CornerRadius=UDim.new(0,6)

local gl=Instance.new("UIListLayout",gf)
gl.Padding=UDim.new(0,3)
gl:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
gf.CanvasSize=UDim2.new(0,0,0,gl.AbsoluteContentSize.Y+5)
end)

local ss=cs(st,"🌱 Seeds",120)
local sf=Instance.new("ScrollingFrame",ss)
sf.Size=UDim2.new(1,-10,1,-25)
sf.Position=UDim2.new(0,5,0,20)
sf.BackgroundColor3=Color3.fromRGB(20,20,25)
sf.ScrollBarThickness=4
sf.ScrollBarImageColor3=Color3.fromRGB(60,60,70)
local sfc=Instance.new("UICorner",sf)
sfc.CornerRadius=UDim.new(0,6)

local sl=Instance.new("UIListLayout",sf)
sl.Padding=UDim.new(0,3)
sl:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
sf.CanvasSize=UDim2.new(0,0,0,sl.AbsoluteContentSize.Y+5)
end)

local ps=cs(pt,"🌾 Plants",200)
local pf=Instance.new("ScrollingFrame",ps)
pf.Size=UDim2.new(1,-10,1,-25)
pf.Position=UDim2.new(0,5,0,20)
pf.BackgroundColor3=Color3.fromRGB(20,20,25)
pf.ScrollBarThickness=4
pf.ScrollBarImageColor3=Color3.fromRGB(60,60,70)
local pfc=Instance.new("UICorner",pf)
pfc.CornerRadius=UDim.new(0,6)

local pl=Instance.new("UIListLayout",pf)
pl.Padding=UDim.new(0,3)
pl:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
pf.CanvasSize=UDim2.new(0,0,0,pl.AbsoluteContentSize.Y+5)
end)

local es=cs(et,"🥚 Eggs",120)
local ef=Instance.new("ScrollingFrame",es)
ef.Size=UDim2.new(1,-10,1,-25)
ef.Position=UDim2.new(0,5,0,20)
ef.BackgroundColor3=Color3.fromRGB(20,20,25)
ef.ScrollBarThickness=4
ef.ScrollBarImageColor3=Color3.fromRGB(60,60,70)
local efc=Instance.new("UICorner",ef)
efc.CornerRadius=UDim.new(0,6)

local el=Instance.new("UIListLayout",ef)
el.Padding=UDim.new(0,3)
el:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
ef.CanvasSize=UDim2.new(0,0,0,el.AbsoluteContentSize.Y+5)
end)

local fs=cs(et,"🍖 Feed",80)

local pt=nil
for _,f in pairs(workspace.Farm:GetChildren())do
local d=f:FindFirstChild("Important")
local o=d and d:FindFirstChild("Data") and d.Data:FindFirstChild("Owner")
if o and o.Value==p.Name then pt=d break end
end

local st={co=0,so=0,pl=0}

function cl()
while cf.co do
local ct=0
if pt then
for _,pl in pairs(pt.Plants_Physical:GetChildren())do
if pl:IsA("Model") and cf.sp[pl.Name] then
local f=pl:FindFirstChild("Fruits")
if f then
for _,v in pairs(f:GetChildren())do
game.ReplicatedStorage.ByteNetReliable:FireServer(buffer.fromstring("\001\001\000\001"),{v})
ct=ct+1
st.co=st.co+1
if ct>=30 then break end
rs.Heartbeat:Wait()
end
else
game.ReplicatedStorage.ByteNetReliable:FireServer(buffer.fromstring("\001\001\000\001"),{pl})
ct=ct+1
st.co=st.co+1
if ct>=30 then break end
rs.Heartbeat:Wait()
end
end
if ct>=30 then break end
end
end
task.wait(2)
end
end

function sl()
while cf.as do
game.ReplicatedStorage.GameEvents.Sell_Inventory:FireServer()
st.so=st.so+1
task.wait(1)
end
end

function el()
while cf.ae do
local fd=false
for _,v in pairs(workspace.Interaction.UpdateItems.SummerHarvestEvent.Sign:GetDescendants())do
if v:IsA("TextLabel") and v.Text:find("Summer Harvest Ends:") then
fd=true
break
end
end
if fd then
for _,tl in pairs(p.Backpack:GetChildren())do
if tl:IsA("Tool") and tl.Name:find("%[.+kg%]") then
tl.Parent=p.Character
end
end
game.ReplicatedStorage.GameEvents.SummerHarvestRemoteEvent:FireServer("SubmitHeldPlant")
end
rs.Heartbeat:Wait()
end
end

local function cp()
for _,b in pairs(pf:GetChildren())do
if b:IsA("TextButton") then b:Destroy() end
end

if not pt then return end

local pn={}
local sn={}
for _,pl in pairs(pt.Plants_Physical:GetChildren())do
if pl:IsA("Model") and not sn[pl.Name] then
sn[pl.Name]=true
table.insert(pn,pl.Name)
end
end

for _,nm in pairs(pn)do
local b=Instance.new("TextButton",pf)
b.Size=UDim2.new(1,-5,0,25)
b.BackgroundColor3=cf.sp[nm] and Color3.fromRGB(0,120,50) or Color3.fromRGB(40,40,50)
b.Text="🌱 "..nm..": "..(cf.sp[nm] and "ON" or "OFF")
b.TextColor3=Color3.fromRGB(255,255,255)
b.TextSize=9
b.Font=Enum.Font.GothamMedium
b.TextXAlignment=Enum.TextXAlignment.Left
local bc=Instance.new("UICorner",b)
bc.CornerRadius=UDim.new(0,6)
local bs=Instance.new("UIStroke",b)
bs.Color=cf.sp[nm] and Color3.fromRGB(0,150,70) or Color3.fromRGB(70,70,80)
bs.Thickness=1

b.MouseButton1Click:Connect(function()
cf.sp[nm]=not cf.sp[nm]
ub(b,bs,cf.sp[nm],"🌱 "..nm..": ON","🌱 "..nm..": OFF")
sv()
end)
end
end

task.spawn(function()
local gs=p.PlayerGui:WaitForChild("Gear_Shop")
local gf=gs.Frame.ScrollingFrame
local ge=game.ReplicatedStorage.GameEvents.BuyGearStock

for _,it in pairs(gf:GetChildren())do
if it:IsA("Frame") and it:FindFirstChild("Frame") then
local f2=it.Frame
local bs=f2:FindFirstChild("Sheckles_Buy")
local sl=bs and bs:FindFirstChild("In_Stock")
if sl then
local ob=Instance.new("TextButton")
ob.Size=UDim2.new(0,12,0,12)
ob.Position=UDim2.new(1,-14,0,2)
ob.BackgroundColor3=cf.gr[it.Name] and Color3.fromRGB(0,200,0) or Color3.fromRGB(50,50,50)
ob.Text=""
ob.Parent=bs
local oc=Instance.new("UICorner",ob)
oc.CornerRadius=UDim.new(0,3)

ob.MouseButton1Click:Connect(function()
cf.gr[it.Name]=not cf.gr[it.Name]
ob.BackgroundColor3=cf.gr[it.Name] and Color3.fromRGB(0,200,0) or Color3.fromRGB(50,50,50)
sv()
end)

local nb=Instance.new("TextButton",gf)
nb.Size=UDim2.new(1,-5,0,25)
nb.BackgroundColor3=cf.gr[it.Name] and Color3.fromRGB(0,120,50) or Color3.fromRGB(40,40,50)
nb.Text="⚙️ "..it.Name..": "..(cf.gr[it.Name] and "ON" or "OFF")
nb.TextColor3=Color3.fromRGB(255,255,255)
nb.TextSize=9
nb.Font=Enum.Font.GothamMedium
nb.TextXAlignment=Enum.TextXAlignment.Left
local nc=Instance.new("UICorner",nb)
nc.CornerRadius=UDim.new(0,6)
local ns=Instance.new("UIStroke",nb)
ns.Color=cf.gr[it.Name] and Color3.fromRGB(0,150,70) or Color3.fromRGB(70,70,80)
ns.Thickness=1

nb.MouseButton1Click:Connect(function()
cf.gr[it.Name]=not cf.gr[it.Name]
ub(nb,ns,cf.gr[it.Name],"⚙️ "..it.Name..": ON","⚙️ "..it.Name..": OFF")
ob.BackgroundColor3=cf.gr[it.Name] and Color3.fromRGB(0,200,0) or Color3.fromRGB(50,50,50)
sv()
end)

task.spawn(function()
while true do
if cf.gr[it.Name] and sl.Visible then
ge:FireServer(it.Name)
end
task.wait(0.15)
end
end)
end
end
end
end)

task.spawn(function()
local ss=p.PlayerGui:WaitForChild("Seed_Shop")
local sf=ss.Frame.ScrollingFrame
local se=game.ReplicatedStorage.GameEvents.BuySeedStock

for _,it in pairs(sf:GetChildren())do
if it:IsA("Frame") and it:FindFirstChild("Frame") then
local f2=it.Frame
local bs=f2:FindFirstChild("Sheckles_Buy")
local sl=bs and bs:FindFirstChild("In_Stock")
if sl then
local ob=Instance.new("TextButton")
ob.Size=UDim2.new(0,16,0,16)
ob.Position=UDim2.new(1,-20,0,3)
ob.BackgroundColor3=Color3.new(1,1,1)
ob.Text=""
ob.Parent=bs
ob.BorderSizePixel=1
ob.AutoButtonColor=false
local oc=Instance.new("UICorner",ob)
oc.CornerRadius=UDim.new(0,3)
local mk=Instance.new("Frame",ob)
mk.Size=UDim2.new(1,-4,1,-4)
mk.Position=UDim2.new(0,2,0,2)
mk.BackgroundColor3=Color3.fromRGB(0,200,0)
mk.Visible=cf.sd[it.Name] or false
local mc=Instance.new("UICorner",mk)
mc.CornerRadius=UDim.new(0,2)

ob.MouseButton1Click:Connect(function()
cf.sd[it.Name]=not cf.sd[it.Name]
mk.Visible=cf.sd[it.Name]
sv()
end)

local nb=Instance.new("TextButton",sf)
nb.Size=UDim2.new(1,-5,0,25)
nb.BackgroundColor3=cf.sd[it.Name] and Color3.fromRGB(0,120,50) or Color3.fromRGB(40,40,50)
nb.Text="🌱 "..it.Name..": "..(cf.sd[it.Name] and "ON" or "OFF")
nb.TextColor3=Color3.fromRGB(255,255,255)
nb.TextSize=9
nb.Font=Enum.Font.GothamMedium
nb.TextXAlignment=Enum.TextXAlignment.Left
local nc=Instance.new("UICorner",nb)
nc.CornerRadius=UDim.new(0,6)
local ns=Instance.new("UIStroke",nb)
ns.Color=cf.sd[it.Name] and Color3.fromRGB(0,150,70) or Color3.fromRGB(70,70,80)
ns.Thickness=1

nb.MouseButton1Click:Connect(function()
cf.sd[it.Name]=not cf.sd[it.Name]
ub(nb,ns,cf.sd[it.Name],"🌱 "..it.Name..": ON","🌱 "..it.Name..": OFF")
mk.Visible=cf.sd[it.Name]
sv()
end)

task.spawn(function()
while true do
if cf.sd[it.Name] and sl.Visible then
se:FireServer(it.Name)
end
task.wait(0.15)
end
end)
end
end
end
end)

local pe=require(game.ReplicatedStorage.Data.PetRegistry).PetEggs
local pv=game.ReplicatedStorage.GameEvents.BuyPetEgg

for en in pairs(pe)do
local b=Instance.new("TextButton",ef)
b.Size=UDim2.new(1,-5,0,25)
b.BackgroundColor3=cf.pe[en] and Color3.fromRGB(0,120,50) or Color3.fromRGB(40,40,50)
b.Text="🥚 "..en..": "..(cf.pe[en] and "ON" or "OFF")
b.TextColor3=Color3.fromRGB(255,255,255)
b.TextSize=9
b.Font=Enum.Font.GothamMedium
b.TextXAlignment=Enum.TextXAlignment.Left
local bc=Instance.new("UICorner",b)
bc.CornerRadius=UDim.new(0,6)
local bs=Instance.new("UIStroke",b)
bs.Color=cf.pe[en] and Color3.fromRGB(0,150,70) or Color3.fromRGB(70,70,80)
bs.Thickness=1

b.MouseButton1Click:Connect(function()
cf.pe[en]=not cf.pe[en]
ub(b,bs,cf.pe[en],"🥚 "..en..": ON","🥚 "..en..": OFF")
if cf.pe[en] then
task.spawn(function()
while cf.pe[en] do
local dt=require(game.ReplicatedStorage.Modules.DataService):GetData()
for i,v in pairs(dt.PetEggStock.Stocks)do
if cf.pe[en] and pe[v.EggName] and v.EggName==en and v.Stock>0 then
pv:FireServer(i)
end
end
task.wait(0.1)
end
end)
end
sv()
end)
end

task.spawn(function()
local pu=p.PlayerGui:WaitForChild("ActivePetUI")
local pf=pu.Frame.Main.ScrollingFrame
local fe=game.ReplicatedStorage.GameEvents.ActivePetService

for _,pf in pairs(pf:GetChildren())do
if pf.Name:match("^%b{}$") and pf:FindFirstChild("PetStats") then
local st=pf.PetStats
local b=Instance.new("TextButton",st)
b.Size=UDim2.new(1,-4,0,15)
b.Position=UDim2.new(0,2,0,2)
b.BackgroundColor3=Color3.fromRGB(50,50,60)
b.TextColor3=Color3.fromRGB(255,255,255)
b.TextSize=8
b.Font=Enum.Font.GothamSemibold
local bc=Instance.new("UICorner",b)
bc.CornerRadius=UDim.new(0,4)
local bs=Instance.new("UIStroke",b)
bs.Color=Color3.fromRGB(80,80,90)
bs.Thickness=1

local ac=cf.pf[pf.Name] or false
local id=pf.Name

local function ub()
b.Text="Feed: "..(ac and "ON" or "OFF")
b.BackgroundColor3=ac and Color3.fromRGB(0,120,50) or Color3.fromRGB(50,50,60)
bs.Color=ac and Color3.fromRGB(0,150,70) or Color3.fromRGB(80,80,90)
end

local function ea()
for _,tl in pairs(p.Backpack:GetChildren())do
if tl:IsA("Tool") and tl.Name:find("%[.+kg%]") then
tl.Parent=p.Character
end
end
end

local function fl()
while ac do
ea()
fe:FireServer("Feed",id)
rs.Heartbeat:Wait()
end
end

p.Backpack.ChildAdded:Connect(function(tl)
if ac and tl:IsA("Tool") and tl.Name:find("%[.+kg%]") then
tl.Parent=p.Character
end
end)

b.MouseButton1Click:Connect(function()
ac=not ac
cf.pf[id]=ac
ub()
if ac then
ea()
task.spawn(fl)
end
sv()
end)

ub()
end
end
end)

p.CharacterAdded:Connect(function(ch)
ch.ChildAdded:Connect(function(cd)
if cd:IsA("Tool") and cf.ap then
local rn=cd.Name
local sn=rn:gsub(" Seed %[X%d+%]",""):gsub(" Seed","")
if pt then
local pl=pt:FindFirstChild("Plants_Physical")
if pl then
local pn=pl:FindFirstChild(sn)
if pn and pn.PrimaryPart then
local ps=pn.PrimaryPart.Position
task.spawn(function()
while cf.ap and ch:FindFirstChildOfClass("Tool") do
local tl=ch:FindFirstChildOfClass("Tool")
if not tl or not tl.Name:find(sn) then break end
game.ReplicatedStorage.GameEvents.Plant_RE:FireServer(ps,sn)
st.pl=st.pl+1
task.wait(0.1)
end
end)
end
end
end
end
end)
end)

if p.Character then
p.Character.ChildAdded:Connect(function(cd)
if cd:IsA("Tool") and cf.ap then
local rn=cd.Name
local sn=rn:gsub(" Seed %[X%d+%]",""):gsub(" Seed","")
if pt then
local pl=pt:FindFirstChild("Plants_Physical")
if pl then
local pn=pl:FindFirstChild(sn)
if pn and pn.PrimaryPart then
local ps=pn.PrimaryPart.Position
task.spawn(function()
while cf.ap and p.Character:FindFirstChildOfClass("Tool") do
local tl=p.Character:FindFirstChildOfClass("Tool")
if not tl or not tl.Name:find(sn) then break end
game.ReplicatedStorage.GameEvents.Plant_RE:FireServer(ps,sn)
st.pl=st.pl+1
task.wait(0.1)
end
end)
end
end
end
end
end)
end

mn.MouseButton1Click:Connect(function()
mi=not mi
if mi then
m:TweenSize(UDim2.new(0.35,0,0,35),"Out","Quad",0.3)
mn.Text="+"
tc.Visible=false
ct.Visible=false
else
tc.Visible=true
ct.Visible=true
m:TweenSize(UDim2.new(0.35,0,0.6,0),"Out","Quad",0.3)
mn.Text="-"
end
end)

ld()
ub(cb,cs,cf.co,"📦 Collect: ON","📦 Collect: OFF")
ub(sb,ss,cf.as,"💰 Sell: ON","💰 Sell: OFF")
ub(pb,ps,cf.ap,"🌿 Plant: ON","🌿 Plant: OFF")
ub(eb,es,cf.ae,"🍓 Event: ON","🍓 Event: OFF")

cp()

tb["Auto"].btn.BackgroundColor3=Color3.fromRGB(50,50,65)
tb["Auto"].btn.TextColor3=Color3.fromRGB(255,255,255)
tb["Auto"].cnt.Visible=true
at="Auto"

if cf.co then task.spawn(cl) end
if cf.as then task.spawn(sl) end
if cf.ae then task.spawn(el) end

local cr=Instance.new("TextLabel",m)
cr.Size=UDim2.new(1,0,0,12)
cr.Position=UDim2.new(0,0,1,-15)
cr.BackgroundTransparency=1
cr.Text="✨ OneCreatorX"
cr.TextColor3=Color3.fromRGB(120,120,130)
cr.TextSize=8
cr.Font=Enum.Font.GothamMedium
cr.TextXAlignment=Enum.TextXAlignment.Center

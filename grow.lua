local vmod
for _,m in ipairs(getloadedmodules())do
 if m.Name=="VariantVisuals"then vmod=require(m)break end
end
if vmod then
 vmod.SetVisuals=function()end
end
local p=game.Players.LocalPlayer
local g=Instance.new("ScreenGui",p.PlayerGui)
g.Name="AutoShopMenu"
local m=Instance.new("Frame",g)
m.Size=UDim2.new(0,320,0,480)
m.Position=UDim2.new(0,10,0,10)
m.BackgroundColor3=Color3.fromRGB(20,20,25)
m.BorderSizePixel=0
m.Draggable=true
m.Active=true
local mc=Instance.new("UICorner",m)
mc.CornerRadius=UDim.new(0,15)
local s=Instance.new("UIStroke",m)
s.Color=Color3.fromRGB(80,80,90)
s.Thickness=2
local shadow=Instance.new("Frame",m)
shadow.Size=UDim2.new(1,6,1,6)
shadow.Position=UDim2.new(0,-3,0,3)
shadow.BackgroundColor3=Color3.fromRGB(0,0,0)
shadow.BackgroundTransparency=0.7
shadow.ZIndex=-1
local shadowc=Instance.new("UICorner",shadow)
shadowc.CornerRadius=UDim.new(0,15)
local t=Instance.new("TextLabel",m)
t.Size=UDim2.new(1,-40,0,35)
t.Position=UDim2.new(0,10,0,5)
t.BackgroundColor3=Color3.fromRGB(30,130,60)
t.Text="🛍️ Auto Shop Menu"
t.TextColor3=Color3.fromRGB(255,255,255)
t.TextSize=16
t.Font=Enum.Font.GothamBold
local tc=Instance.new("UICorner",t)
tc.CornerRadius=UDim.new(0,10)
local tg=Instance.new("UIGradient",t)
tg.Color=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(40,150,80)),ColorSequenceKeypoint.new(1,Color3.fromRGB(20,100,50))}
local mb=Instance.new("TextButton",m)
mb.Size=UDim2.new(0,30,0,30)
mb.Position=UDim2.new(1,-35,0,7.5)
mb.BackgroundColor3=Color3.fromRGB(60,60,70)
mb.Text="-"
mb.TextColor3=Color3.fromRGB(255,255,255)
mb.TextSize=18
mb.Font=Enum.Font.GothamBold
local mbc=Instance.new("UICorner",mb)
mbc.CornerRadius=UDim.new(0,8)
local mbs=Instance.new("UIStroke",mb)
mbs.Color=Color3.fromRGB(100,100,110)
mbs.Thickness=1
local c=Instance.new("ScrollingFrame",m)
c.Size=UDim2.new(1,-20,1,-60)
c.Position=UDim2.new(0,10,0,45)
c.BackgroundTransparency=1
c.ScrollBarThickness=8
c.ScrollBarImageColor3=Color3.fromRGB(80,80,90)
c.CanvasSize=UDim2.new(0,0,0,800)
local cl=Instance.new("UIListLayout",c)
cl.FillDirection=Enum.FillDirection.Vertical
cl.Padding=UDim.new(0,15)
local sec1=Instance.new("Frame",c)
sec1.Size=UDim2.new(1,0,0,80)
sec1.BackgroundColor3=Color3.fromRGB(30,30,35)
local sec1c=Instance.new("UICorner",sec1)
sec1c.CornerRadius=UDim.new(0,12)
local sec1s=Instance.new("UIStroke",sec1)
sec1s.Color=Color3.fromRGB(70,70,80)
sec1s.Thickness=1
local sec1t=Instance.new("TextLabel",sec1)
sec1t.Size=UDim2.new(1,-10,0,20)
sec1t.Position=UDim2.new(0,5,0,5)
sec1t.BackgroundTransparency=1
sec1t.Text="⚙️ Control Principal"
sec1t.TextColor3=Color3.fromRGB(200,200,210)
sec1t.TextSize=12
sec1t.Font=Enum.Font.GothamBold
sec1t.TextXAlignment=Enum.TextXAlignment.Left
local tb=Instance.new("TextButton",sec1)
tb.Size=UDim2.new(0.3,0,0,25)
tb.Position=UDim2.new(0,5,0,30)
tb.BackgroundColor3=Color3.fromRGB(0,120,50)
tb.Text="⚙️ Gears"
tb.TextColor3=Color3.fromRGB(255,255,255)
tb.TextSize=10
tb.Font=Enum.Font.GothamSemibold
local tbc=Instance.new("UICorner",tb)
tbc.CornerRadius=UDim.new(0,8)
local tbs=Instance.new("UIStroke",tb)
tbs.Color=Color3.fromRGB(0,150,70)
tbs.Thickness=1
local sb=Instance.new("TextButton",sec1)
sb.Size=UDim2.new(0.3,0,0,25)
sb.Position=UDim2.new(0.35,0,0,30)
sb.BackgroundColor3=Color3.fromRGB(0,120,50)
sb.Text="🌱 Seeds"
sb.TextColor3=Color3.fromRGB(255,255,255)
sb.TextSize=10
sb.Font=Enum.Font.GothamSemibold
local sbc=Instance.new("UICorner",sb)
sbc.CornerRadius=UDim.new(0,8)
local sbs=Instance.new("UIStroke",sb)
sbs.Color=Color3.fromRGB(0,150,70)
sbs.Thickness=1
local cb=Instance.new("TextButton",sec1)
cb.Size=UDim2.new(0.3,0,0,25)
cb.Position=UDim2.new(0.7,0,0,30)
cb.BackgroundColor3=Color3.fromRGB(50,50,60)
cb.Text="📦 Collect"
cb.TextColor3=Color3.fromRGB(255,255,255)
cb.TextSize=10
cb.Font=Enum.Font.GothamSemibold
local cbc=Instance.new("UICorner",cb)
cbc.CornerRadius=UDim.new(0,8)
local cbs=Instance.new("UIStroke",cb)
cbs.Color=Color3.fromRGB(80,80,90)
cbs.Thickness=1
local ab=Instance.new("TextButton",sec1)
ab.Size=UDim2.new(0.48,0,0,20)
ab.Position=UDim2.new(0,5,0,58)
ab.BackgroundColor3=Color3.fromRGB(50,50,60)
ab.Text="💰 Auto Sell: OFF"
ab.TextColor3=Color3.fromRGB(255,255,255)
ab.TextSize=10
ab.Font=Enum.Font.GothamSemibold
local abc=Instance.new("UICorner",ab)
abc.CornerRadius=UDim.new(0,6)
local abs=Instance.new("UIStroke",ab)
abs.Color=Color3.fromRGB(80,80,90)
abs.Thickness=1
local pb=Instance.new("TextButton",sec1)
pb.Size=UDim2.new(0.48,0,0,20)
pb.Position=UDim2.new(0.52,0,0,58)
pb.BackgroundColor3=Color3.fromRGB(50,50,60)
pb.Text="🌿 Auto Plant: OFF"
pb.TextColor3=Color3.fromRGB(255,255,255)
pb.TextSize=10
pb.Font=Enum.Font.GothamSemibold
local pbc=Instance.new("UICorner",pb)
pbc.CornerRadius=UDim.new(0,6)
local pbs=Instance.new("UIStroke",pb)
pbs.Color=Color3.fromRGB(80,80,90)
pbs.Thickness=1
local sec2=Instance.new("Frame",c)
sec2.Size=UDim2.new(1,0,0,120)
sec2.BackgroundColor3=Color3.fromRGB(30,30,35)
local sec2c=Instance.new("UICorner",sec2)
sec2c.CornerRadius=UDim.new(0,12)
local sec2s=Instance.new("UIStroke",sec2)
sec2s.Color=Color3.fromRGB(70,70,80)
sec2s.Thickness=1
local sec2t=Instance.new("TextLabel",sec2)
sec2t.Size=UDim2.new(1,-10,0,20)
sec2t.Position=UDim2.new(0,5,0,5)
sec2t.BackgroundTransparency=1
sec2t.Text="🌾 Plantas para Recolectar"
sec2t.TextColor3=Color3.fromRGB(200,200,210)
sec2t.TextSize=12
sec2t.Font=Enum.Font.GothamBold
sec2t.TextXAlignment=Enum.TextXAlignment.Left
local psf=Instance.new("ScrollingFrame",sec2)
psf.Size=UDim2.new(1,-10,0,90)
psf.Position=UDim2.new(0,5,0,25)
psf.BackgroundColor3=Color3.fromRGB(25,25,30)
psf.BorderSizePixel=0
psf.ScrollBarThickness=6
psf.ScrollBarImageColor3=Color3.fromRGB(60,60,70)
local psfc=Instance.new("UICorner",psf)
psfc.CornerRadius=UDim.new(0,8)
local psfs=Instance.new("UIStroke",psf)
psfs.Color=Color3.fromRGB(50,50,60)
psfs.Thickness=1
local psl=Instance.new("UIListLayout",psf)
psl.FillDirection=Enum.FillDirection.Vertical
psl.Padding=UDim.new(0,3)
local sec3=Instance.new("Frame",c)
sec3.Size=UDim2.new(1,0,0,300)
sec3.BackgroundColor3=Color3.fromRGB(30,30,35)
local sec3c=Instance.new("UICorner",sec3)
sec3c.CornerRadius=UDim.new(0,12)
local sec3s=Instance.new("UIStroke",sec3)
sec3s.Color=Color3.fromRGB(70,70,80)
sec3s.Thickness=1
local sec3t=Instance.new("TextLabel",sec3)
sec3t.Size=UDim2.new(1,-10,0,20)
sec3t.Position=UDim2.new(0,5,0,5)
sec3t.BackgroundTransparency=1
sec3t.Text="🥚 Huevos de Mascotas"
sec3t.TextColor3=Color3.fromRGB(200,200,210)
sec3t.TextSize=12
sec3t.Font=Enum.Font.GothamBold
sec3t.TextXAlignment=Enum.TextXAlignment.Left
local sf=Instance.new("ScrollingFrame",sec3)
sf.Size=UDim2.new(1,-10,0,270)
sf.Position=UDim2.new(0,5,0,25)
sf.BackgroundColor3=Color3.fromRGB(25,25,30)
sf.BorderSizePixel=0
sf.ScrollBarThickness=8
sf.ScrollBarImageColor3=Color3.fromRGB(60,60,70)
local sfc=Instance.new("UICorner",sf)
sfc.CornerRadius=UDim.new(0,8)
local sfs=Instance.new("UIStroke",sf)
sfs.Color=Color3.fromRGB(50,50,60)
sfs.Thickness=1
local l=Instance.new("UIListLayout",sf)
l.FillDirection=Enum.FillDirection.Vertical
l.Padding=UDim.new(0,4)
local cr=Instance.new("TextLabel",m)
cr.Size=UDim2.new(1,0,0,15)
cr.Position=UDim2.new(0,0,1,-20)
cr.BackgroundTransparency=1
cr.Text="✨ Credits: OneCreatorX"
cr.TextColor3=Color3.fromRGB(120,120,130)
cr.TextSize=10
cr.Font=Enum.Font.GothamMedium
cr.TextXAlignment=Enum.TextXAlignment.Center
local n=Instance.new("Frame",g)
n.Size=UDim2.new(0,300,0,80)
n.Position=UDim2.new(0.5,-150,0,80)
n.BackgroundColor3=Color3.fromRGB(35,35,45)
n.Visible=false
local nc=Instance.new("UICorner",n)
nc.CornerRadius=UDim.new(0,12)
local ns=Instance.new("UIStroke",n)
ns.Color=Color3.fromRGB(0,150,70)
ns.Thickness=2
local ng=Instance.new("UIGradient",n)
ng.Color=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(45,45,55)),ColorSequenceKeypoint.new(1,Color3.fromRGB(25,25,35))}
local nt=Instance.new("TextLabel",n)
nt.Size=UDim2.new(1,-20,1,-20)
nt.Position=UDim2.new(0,10,0,10)
nt.BackgroundTransparency=1
nt.Text="⚡ Esta función ya está activa!\nVe al area de tienda para seleccionar items de auto-compra."
nt.TextColor3=Color3.fromRGB(255,255,255)
nt.TextSize=12
nt.Font=Enum.Font.GothamMedium
nt.TextWrapped=true
local ea={}
local mi=false
local ac=false
local as=false
local ap=false
local selectedPlants={}
local plantButtons={}
local gearButtons={}
local seedButtons={}
local configFile="AutoShopConfig.json"
local function saveConfig()
local config={
collect=ac,
autoSell=as,
autoPlant=ap,
selectedPlants=selectedPlants,
petEggs=ea,
gears={},
seeds={}
}
for name,state in pairs(gearButtons) do
config.gears[name]=state
end
for name,state in pairs(seedButtons) do
config.seeds[name]=state
end
writefile(configFile,game:GetService("HttpService"):JSONEncode(config))
end
local function loadConfig()
if isfile(configFile) then
local success,config=pcall(function()
return game:GetService("HttpService"):JSONDecode(readfile(configFile))
end)
if success and config then
ac=config.collect or false
as=config.autoSell or false
ap=config.autoPlant or false
selectedPlants=config.selectedPlants or {}
ea=config.petEggs or {}
gearButtons=config.gears or {}
seedButtons=config.seeds or {}
end
end
end
local function sn()
n.Visible=true
task.wait(10)
n.Visible=false
end
local function tm()
mi=not mi
if mi then
m:TweenSize(UDim2.new(0,320,0,45),"Out","Quad",0.3)
mb.Text="+"
task.wait(0.3)
c.Visible=false
cr.Visible=false
else
c.Visible=true
cr.Visible=true
m:TweenSize(UDim2.new(0,320,0,480),"Out","Quad",0.3)
mb.Text="-"
end
end
local function getPlantNames()
local plot=nil
for _,f in pairs(workspace.Farm:GetChildren())do
local d=f:FindFirstChild("Important")
local o=d and d:FindFirstChild("Data") and d.Data:FindFirstChild("Owner")
if o and o.Value==p.Name then plot=d break end
end
if not plot then return {} end
local plantNames={}
local seen={}
for _,pl in pairs(plot.Plants_Physical:GetChildren())do
if pl:IsA("Model") and not seen[pl.Name] then
seen[pl.Name]=true
table.insert(plantNames,pl.Name)
end
end
return plantNames
end
local function createPlantButtons()
local plantNames=getPlantNames()
for _,btn in pairs(plantButtons)do
btn:Destroy()
end
plantButtons={}
for _,name in pairs(plantNames)do
local btn=Instance.new("TextButton",psf)
btn.Size=UDim2.new(1,-8,0,20)
btn.BackgroundColor3=selectedPlants[name] and Color3.fromRGB(0,120,50) or Color3.fromRGB(45,45,55)
btn.Text="🌱 "..name..": "..(selectedPlants[name] and "ON" or "OFF")
btn.TextColor3=Color3.fromRGB(255,255,255)
btn.TextSize=10
btn.Font=Enum.Font.GothamMedium
btn.TextXAlignment=Enum.TextXAlignment.Left
local btnc=Instance.new("UICorner",btn)
btnc.CornerRadius=UDim.new(0,6)
local btns=Instance.new("UIStroke",btn)
btns.Color=selectedPlants[name] and Color3.fromRGB(0,150,70) or Color3.fromRGB(70,70,80)
btns.Thickness=1
plantButtons[name]=btn
btn.MouseButton1Click:Connect(function()
selectedPlants[name]=not selectedPlants[name]
if selectedPlants[name] then
btn.BackgroundColor3=Color3.fromRGB(0,120,50)
btn.Text="🌱 "..name..": ON"
btns.Color=Color3.fromRGB(0,150,70)
else
btn.BackgroundColor3=Color3.fromRGB(45,45,55)
btn.Text="🌱 "..name..": OFF"
btns.Color=Color3.fromRGB(70,70,80)
end
saveConfig()
end)
end
psf.CanvasSize=UDim2.new(0,0,0,psl.AbsoluteContentSize.Y+10)
psl:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
psf.CanvasSize=UDim2.new(0,0,0,psl.AbsoluteContentSize.Y+10)
end)
end
task.spawn(function()
local fr=p.PlayerGui.Gear_Shop.Frame.ScrollingFrame
local ev=game.ReplicatedStorage.GameEvents.BuyGearStock
for _,i in pairs(fr:GetChildren())do
local f2=i:FindFirstChild("Frame")
local s=f2 and f2:FindFirstChild("Sheckles_Buy")
local st=s and s:FindFirstChild("In_Stock")
if st then
local b=Instance.new("TextButton")
b.Size=UDim2.new(0,16,0,16)
b.Position=UDim2.new(1,-18,0,2)
b.BackgroundColor3=gearButtons[i.Name] and Color3.fromRGB(0,200,0) or Color3.fromRGB(50,50,50)
b.Text=""
b.Parent=s
local bc=Instance.new("UICorner",b)
bc.CornerRadius=UDim.new(0,4)
local v=gearButtons[i.Name] or false
b.MouseButton1Click:Connect(function()
v=not v
gearButtons[i.Name]=v
b.BackgroundColor3=v and Color3.fromRGB(0,200,0)or Color3.fromRGB(50,50,50)
saveConfig()
end)
task.spawn(function()
while true do
if v and st.Visible then ev:FireServer(i.Name)end
task.wait(0.15)
end
end)
end
end
end)
task.spawn(function()
local rs=game:GetService("ReplicatedStorage")
local gui=p.PlayerGui.Seed_Shop.Frame.ScrollingFrame
local r=rs.GameEvents.BuySeedStock
local function cb(bt,n)
local c=Instance.new("TextButton")
c.Size=UDim2.new(0,22,0,22)
c.Position=UDim2.new(1,-27,0,4)
c.BackgroundColor3=Color3.new(1,1,1)
c.Text=""
c.Parent=bt
c.BorderSizePixel=1
c.AutoButtonColor=false
local cc=Instance.new("UICorner",c)
cc.CornerRadius=UDim.new(0,4)
local mk=Instance.new("Frame",c)
mk.Size=UDim2.new(1,-6,1,-6)
mk.Position=UDim2.new(0,3,0,3)
mk.BackgroundColor3=Color3.fromRGB(0,200,0)
mk.Visible=seedButtons[n] or false
local mkc=Instance.new("UICorner",mk)
mkc.CornerRadius=UDim.new(0,2)
c.MouseButton1Click:Connect(function()
seedButtons[n]=not seedButtons[n]
mk.Visible=seedButtons[n]
if seedButtons[n] then
task.spawn(function()
while seedButtons[n] do
local f=gui:FindFirstChild(n)
if not f then break end
local s=f.Frame:FindFirstChild("Sheckles_Buy")
local st=s and s:FindFirstChild("In_Stock")
if st and st.Visible then
r:FireServer(n)
else
repeat task.wait(0.05)
st=s and s:FindFirstChild("In_Stock")
until(st and st.Visible)or not seedButtons[n]
end
task.wait()
end
end)
end
saveConfig()
end)
end
for _,v in pairs(gui:GetChildren())do
if v:IsA("Frame")and v:FindFirstChild("Frame")and v.Frame:FindFirstChild("Sheckles_Buy")then
cb(v.Frame.Sheckles_Buy,v.Name)
end
end
end)
local plot=nil
for _,f in pairs(workspace.Farm:GetChildren())do
local d=f:FindFirstChild("Important")
local o=d and d:FindFirstChild("Data") and d.Data:FindFirstChild("Owner")
if o and o.Value==p.Name then plot=d break end
end

local RS=game:GetService("RunService")
local function collect()
while ac do
local count=0
if plot then
for _,pl in pairs(plot.Plants_Physical:GetChildren())do
if pl:IsA("Model")and selectedPlants[pl.Name]then
local f=pl:FindFirstChild("Fruits")
if f then
for _,v in pairs(f:GetChildren())do
game.ReplicatedStorage.ByteNetReliable:FireServer(buffer.fromstring("\001\001\000\001"),{v})
count+=1
if count>=200 then break end
RS.Heartbeat:Wait()
end
else
game.ReplicatedStorage.ByteNetReliable:FireServer(buffer.fromstring("\001\001\000\001"),{pl})
count+=1
if count>=200 then break end
RS.Heartbeat:Wait()
end
end
if count>=200 then break end
end
end
task.wait(5)
end
end


local function autosell()
while as do
game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("Sell_Inventory"):FireServer()
task.wait(0.5)
end
end
local function autoplant()
local char=p.Character if not char then return end
local tool=char:FindFirstChildOfClass("Tool") if not tool then return end
local rawname=tool.Name
local seedname=rawname:gsub(" Seed %[X%d+%]",""):gsub(" Seed","")
for _,f in pairs(workspace.Farm:GetChildren())do
local d=f:FindFirstChild("Important")
local o=d and d:FindFirstChild("Data") and d.Data:FindFirstChild("Owner")
if o and o.Value==p.Name then
local plants=d:FindFirstChild("Plants_Physical")
if plants then
local plant=plants:FindFirstChild(seedname)
if plant and plant.PrimaryPart then
local pos=plant.PrimaryPart.Position
while ap do
local t=char:FindFirstChildOfClass("Tool")
if not t then break end
if not t.Name:find(seedname) then break end
game.ReplicatedStorage.GameEvents.Plant_RE:FireServer(pos,seedname)
task.wait(0.1)
end
end end break
end end
end
local function updateCollectButton()
cb.Text="📦 Collect: "..(ac and "ON" or "OFF")
cb.BackgroundColor3=ac and Color3.fromRGB(0,120,50)or Color3.fromRGB(50,50,60)
cbs.Color=ac and Color3.fromRGB(0,150,70)or Color3.fromRGB(80,80,90)
end
local function updateSellButton()
ab.Text="💰 Auto Sell: "..(as and "ON" or "OFF")
ab.BackgroundColor3=as and Color3.fromRGB(0,120,50)or Color3.fromRGB(50,50,60)
abs.Color=as and Color3.fromRGB(0,150,70)or Color3.fromRGB(80,80,90)
end
local function updatePlantButton()
pb.Text="🌿 Auto Plant: "..(ap and "ON" or "OFF")
pb.BackgroundColor3=ap and Color3.fromRGB(0,120,50)or Color3.fromRGB(50,50,60)
pbs.Color=ap and Color3.fromRGB(0,150,70)or Color3.fromRGB(80,80,90)
end
cb.MouseButton1Click:Connect(function()
ac=not ac
updateCollectButton()
if ac then task.spawn(collect) end
saveConfig()
end)
ab.MouseButton1Click:Connect(function()
as=not as
updateSellButton()
if as then task.spawn(autosell) end
saveConfig()
end)
pb.MouseButton1Click:Connect(function()
ap=not ap
updatePlantButton()
saveConfig()
end)
tb.MouseButton1Click:Connect(function()
task.spawn(sn)
end)
sb.MouseButton1Click:Connect(function()
task.spawn(sn)
end)
mb.MouseButton1Click:Connect(tm)
local e=require(game.ReplicatedStorage.Data.PetRegistry).PetEggs
local r=game.ReplicatedStorage.GameEvents.BuyPetEgg
p.CharacterAdded:Connect(function(char)
char.ChildAdded:Connect(function(child)
if child:IsA("Tool") and ap then
task.spawn(autoplant)
end
end)
end)
if p.Character then
p.Character.ChildAdded:Connect(function(child)
if child:IsA("Tool") and ap then
task.spawn(autoplant)
end
end)
end
for n in pairs(e)do
local eb=Instance.new("TextButton",sf)
eb.Size=UDim2.new(1,-8,0,28)
eb.BackgroundColor3=ea[n] and Color3.fromRGB(0,120,50) or Color3.fromRGB(45,45,55)
eb.Text="🥚 "..n..": "..(ea[n] and "ON" or "OFF")
eb.TextColor3=Color3.fromRGB(255,255,255)
eb.TextSize=11
eb.Font=Enum.Font.GothamMedium
eb.TextXAlignment=Enum.TextXAlignment.Left
local ec=Instance.new("UICorner",eb)
ec.CornerRadius=UDim.new(0,8)
local es=Instance.new("UIStroke",eb)
es.Color=ea[n] and Color3.fromRGB(0,150,70) or Color3.fromRGB(70,70,80)
es.Thickness=1
eb.MouseButton1Click:Connect(function()
ea[n]=not ea[n]
if ea[n] then
eb.BackgroundColor3=Color3.fromRGB(0,120,50)
eb.Text="🥚 "..n..": ON"
es.Color=Color3.fromRGB(0,150,70)
task.spawn(function()
while ea[n] do
local d=require(game.ReplicatedStorage.Modules.DataService):GetData()
for i,v in pairs(d.PetEggStock.Stocks)do
if ea[n] and e[v.EggName] and v.EggName==n and v.Stock>0 then
r:FireServer(i)
end
end
task.wait(0.1)
end
end)
else
eb.BackgroundColor3=Color3.fromRGB(45,45,55)
eb.Text="🥚 "..n..": OFF"
es.Color=Color3.fromRGB(70,70,80)
end
saveConfig()
end)
end
sf.CanvasSize=UDim2.new(0,0,0,l.AbsoluteContentSize.Y+15)
l:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
sf.CanvasSize=UDim2.new(0,0,0,l.AbsoluteContentSize.Y+15)
end)
c.CanvasSize=UDim2.new(0,0,0,cl.AbsoluteContentSize.Y+20)
cl:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
c.CanvasSize=UDim2.new(0,0,0,cl.AbsoluteContentSize.Y+20)
end)



local RS=game:GetService("RunService")
local EV=game.ReplicatedStorage.GameEvents.SummerHarvestRemoteEvent
local p=game.Players.LocalPlayer
local eb=Instance.new("TextButton",sec1)
eb.Size=UDim2.new(0.48,0,0,20)
eb.Position=UDim2.new(0,5,0,80)
eb.BackgroundColor3=Color3.fromRGB(50,50,60)
eb.Text="🍓 Auto Event: OFF"
eb.TextColor3=Color3.new(1,1,1)
eb.TextSize=10
eb.Font=Enum.Font.GothamSemibold
Instance.new("UICorner",eb).CornerRadius=UDim.new(0,6)
local ebs=Instance.new("UIStroke",eb)
ebs.Color=Color3.fromRGB(80,80,90)
ebs.Thickness=1
local ae=false

local function update()
	eb.Text="🍓 Auto Event: "..(ae and "ON"or"OFF")
	eb.BackgroundColor3=ae and Color3.fromRGB(0,120,50)or Color3.fromRGB(50,50,60)
	ebs.Color=ae and Color3.fromRGB(0,150,70)or Color3.fromRGB(80,80,90)
end

local function findEventLabel()
	for _,v in pairs(workspace.Interaction.UpdateItems.SummerHarvestEvent.Sign:GetDescendants())do
		if v:IsA("TextLabel") and v.Text:find("Summer Harvest Ends:") then return v end
	end
end

local function loop()
	while ae do
		local lbl=findEventLabel()
		if lbl then
			while lbl and ae do
				EV:FireServer("SubmitHeldPlant")
				RS.Heartbeat:Wait()
				lbl=findEventLabel()
			end
		end
		RS.Heartbeat:Wait()
	end
end

local function handleTool(t)
	if ae and t:IsA("Tool")and t.Name:find("%[.+kg%]")then t.Parent=p.Character end
end

p.Backpack.ChildAdded:Connect(handleTool)

eb.MouseButton1Click:Connect(function()
	ae=not ae
	update()
	if ae then
		for _,v in pairs(p.Backpack:GetChildren())do handleTool(v)end
		task.spawn(loop)
	end
	saveConfig()
end)



local p=game.Players.LocalPlayer
local petsUI=p.PlayerGui.ActivePetUI.Frame.Main.ScrollingFrame
local EV=game.ReplicatedStorage.GameEvents.ActivePetService

local buttons={}

for _,petFrame in pairs(petsUI:GetChildren())do
	if petFrame.Name:match("^%b{}$") and petFrame:FindFirstChild("PetStats") then
		local stats=petFrame.PetStats
		local btn=Instance.new("TextButton",stats)
		btn.Size=UDim2.new(1,-4,0,20)
		btn.Position=UDim2.new(0,2,0,2)
		btn.BackgroundColor3=Color3.fromRGB(50,50,60)
		btn.TextColor3=Color3.fromRGB(255,255,255)
		btn.TextSize=10
		btn.Font=Enum.Font.GothamSemibold
		local ec=Instance.new("UICorner",btn)
		ec.CornerRadius=UDim.new(0,6)
		local es=Instance.new("UIStroke",btn)
		es.Color=Color3.fromRGB(80,80,90)
		es.Thickness=1

		local active=false
		local id=petFrame.Name

		local function updateBtn()
			btn.Text="Auto Feed: "..(active and "ON" or "OFF")
			btn.BackgroundColor3=active and Color3.fromRGB(0,120,50) or Color3.fromRGB(50,50,60)
			es.Color=active and Color3.fromRGB(0,150,70) or Color3.fromRGB(80,80,90)
		end

		local function equipAll()
			for _,tool in pairs(p.Backpack:GetChildren())do
				if tool:IsA("Tool") and tool.Name:find("%[.+kg%]") then
					tool.Parent=p.Character
				end
			end
		end

		local function feedLoop()
			while active do
				equipAll()
				EV:FireServer("Feed",id)
				game:GetService("RunService").Heartbeat:Wait()
			end
		end

		p.Backpack.ChildAdded:Connect(function(tool)
			if active and tool:IsA("Tool") and tool.Name:find("%[.+kg%]") then
				tool.Parent=p.Character
			end
		end)

		btn.MouseButton1Click:Connect(function()
			active=not active
			updateBtn()
			if active then
				equipAll()
				task.spawn(feedLoop)
			end
		end)

		updateBtn()
		buttons[id]=btn
	end
end


loadConfig()
updateCollectButton()
updateSellButton()
updatePlantButton()
createPlantButtons()
if ac then task.spawn(collect) end
if as then task.spawn(autosell) end

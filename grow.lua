local p=game.Players.LocalPlayer
local g=Instance.new("ScreenGui",p.PlayerGui)
g.Name="AutoShopMenu"

local m=Instance.new("Frame",g)
m.Size=UDim2.new(0,240,0,360)
m.Position=UDim2.new(0,10,0,10)
m.BackgroundColor3=Color3.fromRGB(25,25,30)
m.BorderSizePixel=0
m.Draggable=true
m.Active=true

local mc=Instance.new("UICorner",m)
mc.CornerRadius=UDim.new(0,12)

local s=Instance.new("UIStroke",m)
s.Color=Color3.fromRGB(70,70,80)
s.Thickness=1

local t=Instance.new("TextLabel",m)
t.Size=UDim2.new(1,-30,0,30)
t.Position=UDim2.new(0,0,0,0)
t.BackgroundColor3=Color3.fromRGB(35,35,40)
t.Text="Auto Shop Menu"
t.TextColor3=Color3.fromRGB(255,255,255)
t.TextSize=14
t.Font=Enum.Font.GothamBold

local tc=Instance.new("UICorner",t)
tc.CornerRadius=UDim.new(0,8)

local mb=Instance.new("TextButton",m)
mb.Size=UDim2.new(0,25,0,25)
mb.Position=UDim2.new(1,-28,0,2.5)
mb.BackgroundColor3=Color3.fromRGB(60,60,70)
mb.Text="-"
mb.TextColor3=Color3.fromRGB(255,255,255)
mb.TextSize=16
mb.Font=Enum.Font.GothamBold

local mbc=Instance.new("UICorner",mb)
mbc.CornerRadius=UDim.new(0,4)

local c=Instance.new("Frame",m)
c.Size=UDim2.new(1,-10,1,-55)
c.Position=UDim2.new(0,5,0,35)
c.BackgroundTransparency=1
c.ClipsDescendants=true

local bg=Instance.new("Frame",c)
bg.Size=UDim2.new(1,0,0,150)
bg.Position=UDim2.new(0,0,0,0)
bg.BackgroundTransparency=1

local tb=Instance.new("TextButton",bg)
tb.Size=UDim2.new(0.32,0,0,30)
tb.Position=UDim2.new(0,0,0,5)
tb.BackgroundColor3=Color3.fromRGB(0,120,50)
tb.Text="Gears: ON"
tb.TextColor3=Color3.fromRGB(255,255,255)
tb.TextSize=10
tb.Font=Enum.Font.GothamSemibold

local tbc=Instance.new("UICorner",tb)
tbc.CornerRadius=UDim.new(0,6)

local tbs=Instance.new("UIStroke",tb)
tbs.Color=Color3.fromRGB(0,150,70)
tbs.Thickness=1

local sb=Instance.new("TextButton",bg)
sb.Size=UDim2.new(0.32,0,0,30)
sb.Position=UDim2.new(0.34,0,0,5)
sb.BackgroundColor3=Color3.fromRGB(0,120,50)
sb.Text="Seeds: ON"
sb.TextColor3=Color3.fromRGB(255,255,255)
sb.TextSize=10
sb.Font=Enum.Font.GothamSemibold

local sbc=Instance.new("UICorner",sb)
sbc.CornerRadius=UDim.new(0,6)

local sbs=Instance.new("UIStroke",sb)
sbs.Color=Color3.fromRGB(0,150,70)
sbs.Thickness=1

local cb=Instance.new("TextButton",bg)
cb.Size=UDim2.new(0.32,0,0,30)
cb.Position=UDim2.new(0.68,0,0,5)
cb.BackgroundColor3=Color3.fromRGB(50,50,60)
cb.Text="Collect: OFF"
cb.TextColor3=Color3.fromRGB(255,255,255)
cb.TextSize=10
cb.Font=Enum.Font.GothamSemibold

local cbc=Instance.new("UICorner",cb)
cbc.CornerRadius=UDim.new(0,6)

local cbs=Instance.new("UIStroke",cb)
cbs.Color=Color3.fromRGB(80,80,90)
cbs.Thickness=1

local ab=Instance.new("TextButton",bg)
ab.Size=UDim2.new(1,0,0,30)
ab.Position=UDim2.new(0,0,0,40)
ab.BackgroundColor3=Color3.fromRGB(50,50,60)
ab.Text="Auto Sell: OFF"
ab.TextColor3=Color3.fromRGB(255,255,255)
ab.TextSize=12
ab.Font=Enum.Font.GothamSemibold

local abc=Instance.new("UICorner",ab)
abc.CornerRadius=UDim.new(0,6)

local abs=Instance.new("UIStroke",ab)
abs.Color=Color3.fromRGB(80,80,90)
abs.Thickness=1

local pb=Instance.new("TextButton",bg)
pb.Size=UDim2.new(1,0,0,30)
pb.Position=UDim2.new(0,0,0,75)
pb.BackgroundColor3=Color3.fromRGB(50,50,60)
pb.Text="Auto Plant: OFF"
pb.TextColor3=Color3.fromRGB(255,255,255)
pb.TextSize=12
pb.Font=Enum.Font.GothamSemibold

local pbc=Instance.new("UICorner",pb)
pbc.CornerRadius=UDim.new(0,6)

local pbs=Instance.new("UIStroke",pb)
pbs.Color=Color3.fromRGB(80,80,90)
pbs.Thickness=1

local el=Instance.new("TextLabel",bg)
el.Size=UDim2.new(1,0,0,18)
el.Position=UDim2.new(0,0,0,112)
el.BackgroundTransparency=1
el.Text="Pet Eggs:"
el.TextColor3=Color3.fromRGB(200,200,210)
el.TextSize=11
el.Font=Enum.Font.GothamSemibold

local sf=Instance.new("ScrollingFrame",c)
sf.Size=UDim2.new(1,0,1,-170)
sf.Position=UDim2.new(0,0,0,150)
sf.BackgroundColor3=Color3.fromRGB(35,35,40)
sf.BorderSizePixel=0
sf.ScrollBarThickness=6

local sfc=Instance.new("UICorner",sf)
sfc.CornerRadius=UDim.new(0,6)

local sfs=Instance.new("UIStroke",sf)
sfs.Color=Color3.fromRGB(60,60,70)
sfs.Thickness=1

local l=Instance.new("UIListLayout",sf)
l.FillDirection=Enum.FillDirection.Vertical
l.Padding=UDim.new(0,3)

local cr=Instance.new("TextLabel",c)
cr.Size=UDim2.new(1,0,0,15)
cr.Position=UDim2.new(0,0,1,-15)
cr.BackgroundTransparency=1
cr.Text="Credits: OneCreatorX"
cr.TextColor3=Color3.fromRGB(150,150,160)
cr.TextSize=9
cr.Font=Enum.Font.Gotham
cr.TextXAlignment=Enum.TextXAlignment.Center

local n=Instance.new("Frame",g)
n.Size=UDim2.new(0,280,0,60)
n.Position=UDim2.new(0.5,-140,0,50)
n.BackgroundColor3=Color3.fromRGB(40,40,50)
n.Visible=false

local nc=Instance.new("UICorner",n)
nc.CornerRadius=UDim.new(0,8)

local ns=Instance.new("UIStroke",n)
ns.Color=Color3.fromRGB(0,150,70)
ns.Thickness=2

local nt=Instance.new("TextLabel",n)
nt.Size=UDim2.new(1,-10,1,-10)
nt.Position=UDim2.new(0,5,0,5)
nt.BackgroundTransparency=1
nt.Text="This feature is already active!\nGo to the shop area to select auto-buy items."
nt.TextColor3=Color3.fromRGB(255,255,255)
nt.TextSize=11
nt.Font=Enum.Font.Gotham
nt.TextWrapped=true

local ea={}
local mi=false
local ac=false
local as=false
local ap=false

local function sn()
n.Visible=true
task.wait(10)
n.Visible=false
end

local function tm()
mi=not mi
if mi then
m:TweenSize(UDim2.new(0,240,0,30),"Out","Quad",0.3)
mb.Text="+"
task.wait(0.3)
c.Visible=false
else
c.Visible=true
m:TweenSize(UDim2.new(0,240,0,360),"Out","Quad",0.3)
mb.Text="-"
end
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
b.Size=UDim2.new(0,14,0,14)
b.Position=UDim2.new(1,-16,0,2)
b.BackgroundColor3=Color3.fromRGB(50,50,50)
b.Text=""
b.Parent=s
local v=false
b.MouseButton1Click:Connect(function()
v=not v
b.BackgroundColor3=v and Color3.fromRGB(0,200,0)or Color3.fromRGB(50,50,50)
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
local b={}
local function cb(bt,n)
local c=Instance.new("TextButton")
c.Size=UDim2.new(0,20,0,20)
c.Position=UDim2.new(1,-25,0,5)
c.BackgroundColor3=Color3.new(1,1,1)
c.Text=""
c.Parent=bt
c.BorderSizePixel=1
c.AutoButtonColor=false
local mk=Instance.new("Frame",c)
mk.Size=UDim2.new(1,-6,1,-6)
mk.Position=UDim2.new(0,3,0,3)
mk.BackgroundColor3=Color3.fromRGB(0,200,0)
mk.Visible=false
c.MouseButton1Click:Connect(function()
b[n]=not b[n]
mk.Visible=b[n]
if b[n] then
task.spawn(function()
while b[n] do
local f=gui:FindFirstChild(n)
if not f then break end
local s=f.Frame:FindFirstChild("Sheckles_Buy")
local st=s and s:FindFirstChild("In_Stock")
if st and st.Visible then
r:FireServer(n)
else
repeat task.wait(0.05)
st=s and s:FindFirstChild("In_Stock")
until(st and st.Visible)or not b[n]
end
task.wait()
end
end)
end
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

local function collect()
while ac do
for _,pl in pairs(plot.Plants_Physical:GetDescendants())do
if pl:IsA("Model") and pl:FindFirstChild("Fruits")then
for _,fr in pairs(pl.Fruits:GetChildren())do
game.ReplicatedStorage:WaitForChild("ByteNetReliable"):FireServer(buffer.fromstring("\001\001\000\001"),{fr})
end
end
end
task.wait(1)
end
end

local function autosell()
while as do
game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("Sell_Inventory"):FireServer()
task.wait(2)
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

cb.MouseButton1Click:Connect(function()
ac=not ac
cb.Text="Collect: "..(ac and "ON" or "OFF")
cb.BackgroundColor3=ac and Color3.fromRGB(0,120,50)or Color3.fromRGB(50,50,60)
cbs.Color=ac and Color3.fromRGB(0,150,70)or Color3.fromRGB(80,80,90)
if ac then task.spawn(collect) end
end)

ab.MouseButton1Click:Connect(function()
as=not as
ab.Text="Auto Sell: "..(as and "ON" or "OFF")
ab.BackgroundColor3=as and Color3.fromRGB(0,120,50)or Color3.fromRGB(50,50,60)
abs.Color=as and Color3.fromRGB(0,150,70)or Color3.fromRGB(80,80,90)
if as then task.spawn(autosell) end
end)

pb.MouseButton1Click:Connect(function()
ap=not ap
pb.Text="Auto Plant: "..(ap and "ON" or "OFF")
pb.BackgroundColor3=ap and Color3.fromRGB(0,120,50)or Color3.fromRGB(50,50,60)
pbs.Color=ap and Color3.fromRGB(0,150,70)or Color3.fromRGB(80,80,90)
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
eb.Size=UDim2.new(1,-8,0,22)
eb.BackgroundColor3=Color3.fromRGB(50,50,60)
eb.Text=n..": OFF"
eb.TextColor3=Color3.fromRGB(255,255,255)
eb.TextSize=11
eb.Font=Enum.Font.Gotham
local ec=Instance.new("UICorner",eb)
ec.CornerRadius=UDim.new(0,4)
local es=Instance.new("UIStroke",eb)
es.Color=Color3.fromRGB(80,80,90)
es.Thickness=1
eb.MouseButton1Click:Connect(function()
ea[n]=not ea[n]
if ea[n] then
eb.BackgroundColor3=Color3.fromRGB(0,120,50)
eb.Text=n..": ON"
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
eb.BackgroundColor3=Color3.fromRGB(50,50,60)
eb.Text=n..": OFF"
es.Color=Color3.fromRGB(80,80,90)
end
end)
end

sf.CanvasSize=UDim2.new(0,0,0,l.AbsoluteContentSize.Y+10)
l:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
sf.CanvasSize=UDim2.new(0,0,0,l.AbsoluteContentSize.Y+10)
end)

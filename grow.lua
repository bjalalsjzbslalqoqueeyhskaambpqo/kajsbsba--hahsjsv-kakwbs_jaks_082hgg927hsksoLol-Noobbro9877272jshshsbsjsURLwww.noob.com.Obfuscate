local p=game.Players.LocalPlayer
local g=Instance.new("ScreenGui",p.PlayerGui)
g.Name="AutoShopMenu"

local m=Instance.new("Frame",g)
m.Size=UDim2.new(0,220,0,220)
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
c.Size=UDim2.new(1,-10,1,-60)
c.Position=UDim2.new(0,5,0,35)
c.BackgroundTransparency=1
c.ClipsDescendants=true

local tb=Instance.new("TextButton",c)
tb.Size=UDim2.new(0.48,0,0,35)
tb.Position=UDim2.new(0,0,0,5)
tb.BackgroundColor3=Color3.fromRGB(0,120,50)
tb.Text="Gears: ACTIVE"
tb.TextColor3=Color3.fromRGB(255,255,255)
tb.TextSize=12
tb.Font=Enum.Font.GothamSemibold

local tbc=Instance.new("UICorner",tb)
tbc.CornerRadius=UDim.new(0,6)

local tbs=Instance.new("UIStroke",tb)
tbs.Color=Color3.fromRGB(0,150,70)
tbs.Thickness=1

local sb=Instance.new("TextButton",c)
sb.Size=UDim2.new(0.48,0,0,35)
sb.Position=UDim2.new(0.52,0,0,5)
sb.BackgroundColor3=Color3.fromRGB(0,120,50)
sb.Text="Seeds: ACTIVE"
sb.TextColor3=Color3.fromRGB(255,255,255)
sb.TextSize=12
sb.Font=Enum.Font.GothamSemibold

local sbc=Instance.new("UICorner",sb)
sbc.CornerRadius=UDim.new(0,6)

local sbs=Instance.new("UIStroke",sb)
sbs.Color=Color3.fromRGB(0,150,70)
sbs.Thickness=1

local el=Instance.new("TextLabel",c)
el.Size=UDim2.new(1,0,0,20)
el.Position=UDim2.new(0,5,0,50)
el.BackgroundTransparency=1
el.Text="Pet Eggs:"
el.TextColor3=Color3.fromRGB(200,200,210)
el.TextSize=12
el.Font=Enum.Font.GothamSemibold

local sf=Instance.new("ScrollingFrame",c)
sf.Size=UDim2.new(1,-10,0,70)
sf.Position=UDim2.new(0,5,0,75)
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
cr.Size=UDim2.new(1,0,0,18)
cr.Position=UDim2.new(0,5,1,-15)
cr.BackgroundTransparency=1
cr.Text="Credits: OneCreatorX"
cr.TextColor3=Color3.fromRGB(150,150,160)
cr.TextSize=10
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

local function sn()
n.Visible=true
task.wait(10)
n.Visible=false
end

local function tm()
mi=not mi
if mi then
m:TweenSize(UDim2.new(0,220,0,30),"Out","Quad",0.3)
mb.Text="+"
task.wait(0.3)
c.Visible=false
else
c.Visible=true
m:TweenSize(UDim2.new(0,220,0,220),"Out","Quad",0.3)
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

tb.MouseButton1Click:Connect(function()
task.spawn(sn)
end)

sb.MouseButton1Click:Connect(function()
task.spawn(sn)
end)

mb.MouseButton1Click:Connect(tm)

local e=require(game.ReplicatedStorage.Data.PetRegistry).PetEggs
local r=game.ReplicatedStorage.GameEvents.BuyPetEgg

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

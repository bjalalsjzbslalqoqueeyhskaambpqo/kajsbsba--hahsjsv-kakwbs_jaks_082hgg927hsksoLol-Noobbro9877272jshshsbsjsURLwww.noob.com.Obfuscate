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
g.Name="FixedAutoShop"
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

local tabCont=Instance.new("Frame",m)
tabCont.Size=UDim2.new(1,0,0,30)
tabCont.Position=UDim2.new(0,0,0,35)
tabCont.BackgroundColor3=Color3.fromRGB(20,20,25)

local tl=Instance.new("UIListLayout",tabCont)
tl.FillDirection=Enum.FillDirection.Horizontal
tl.SortOrder=Enum.SortOrder.LayoutOrder

local cont=Instance.new("Frame",m)
cont.Size=UDim2.new(1,0,1,-65)
cont.Position=UDim2.new(0,0,0,65)
cont.BackgroundTransparency=1

local tabs={}
local activeTab=nil
local minimized=false

local cfg={
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

local configFile="FixedAutoShopConfig.json"

local function saveConfig()
writefile(configFile,hs:JSONEncode(cfg))
end

local function loadConfig()
if isfile(configFile) then
local ok,data=pcall(function()
return hs:JSONDecode(readfile(configFile))
end)
if ok and data then
for k,v in pairs(data) do
cfg[k]=v
end
end
end
end

local function createCorner(parent,radius)
local corner=Instance.new("UICorner",parent)
corner.CornerRadius=UDim.new(0,radius or 6)
return corner
end

local function createStroke(parent,color,thickness)
local stroke=Instance.new("UIStroke",parent)
stroke.Color=color or Color3.fromRGB(80,80,90)
stroke.Thickness=thickness or 1
return stroke
end

local function createScrollFrame(parent,pos,size)
local scroll=Instance.new("ScrollingFrame",parent)
scroll.Size=size
scroll.Position=pos
scroll.BackgroundColor3=Color3.fromRGB(20,20,25)
scroll.ScrollBarThickness=4
scroll.ScrollBarImageColor3=Color3.fromRGB(60,60,70)
createCorner(scroll,6)

local layout=Instance.new("UIListLayout",scroll)
layout.Padding=UDim.new(0,3)
layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
scroll.CanvasSize=UDim2.new(0,0,0,layout.AbsoluteContentSize.Y+5)
end)

return scroll,layout
end

local function createButton(parent,text,pos,size,callback)
local btn=Instance.new("TextButton",parent)
btn.Size=size
btn.Position=pos
btn.BackgroundColor3=Color3.fromRGB(50,50,60)
btn.Text=text
btn.TextColor3=Color3.fromRGB(255,255,255)
btn.TextSize=9
btn.Font=Enum.Font.GothamSemibold
createCorner(btn,6)
local stroke=createStroke(btn)

if callback then
btn.MouseButton1Click:Connect(callback)
end

return btn,stroke
end

local function updateButton(btn,stroke,active,onText,offText)
btn.Text=active and onText or offText
btn.BackgroundColor3=active and Color3.fromRGB(0,120,50) or Color3.fromRGB(50,50,60)
stroke.Color=active and Color3.fromRGB(0,150,70) or Color3.fromRGB(80,80,90)
end

local function createTab(name,icon,order)
local tabBtn=Instance.new("TextButton",tabCont)
tabBtn.Size=UDim2.new(0.25,0,1,0)
tabBtn.BackgroundColor3=Color3.fromRGB(30,30,40)
tabBtn.Text=icon
tabBtn.TextColor3=Color3.fromRGB(180,180,190)
tabBtn.TextSize=10
tabBtn.Font=Enum.Font.GothamSemibold
tabBtn.LayoutOrder=order
createCorner(tabBtn,6)

local tabContent=Instance.new("ScrollingFrame",cont)
tabContent.Size=UDim2.new(1,0,1,0)
tabContent.BackgroundTransparency=1
tabContent.ScrollBarThickness=4
tabContent.ScrollBarImageColor3=Color3.fromRGB(80,80,90)
tabContent.Visible=false
tabContent.CanvasSize=UDim2.new(0,0,0,0)

local layout=Instance.new("UIListLayout",tabContent)
layout.Padding=UDim.new(0,5)
layout.SortOrder=Enum.SortOrder.LayoutOrder

layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
tabContent.CanvasSize=UDim2.new(0,0,0,layout.AbsoluteContentSize.Y+10)
end)

tabs[name]={btn=tabBtn,content=tabContent,layout=layout}

tabBtn.MouseButton1Click:Connect(function()
for _,tab in pairs(tabs) do
tab.btn.BackgroundColor3=Color3.fromRGB(30,30,40)
tab.btn.TextColor3=Color3.fromRGB(180,180,190)
tab.content.Visible=false
end
tabBtn.BackgroundColor3=Color3.fromRGB(50,50,65)
tabBtn.TextColor3=Color3.fromRGB(255,255,255)
tabContent.Visible=true
activeTab=name
end)

return tabContent
end

local function createSection(parent,title,height)
local section=Instance.new("Frame",parent)
section.Size=UDim2.new(1,-10,0,height)
section.BackgroundColor3=Color3.fromRGB(25,25,35)
createCorner(section,6)

local sectionTitle=Instance.new("TextLabel",section)
sectionTitle.Size=UDim2.new(1,-10,0,20)
sectionTitle.Position=UDim2.new(0,5,0,3)
sectionTitle.BackgroundTransparency=1
sectionTitle.Text=title
sectionTitle.TextColor3=Color3.fromRGB(200,200,210)
sectionTitle.TextSize=10
sectionTitle.Font=Enum.Font.GothamBold
sectionTitle.TextXAlignment=Enum.TextXAlignment.Left

return section
end

local function createListButton(parent,text,configKey,configTable,onText,offText)
local btn,stroke=createButton(parent,text,UDim2.new(0,0,0,0),UDim2.new(1,-5,0,25))

local function updateState()
local active=configTable[configKey] or false
updateButton(btn,stroke,active,onText,offText)
end

btn.MouseButton1Click:Connect(function()
configTable[configKey]=not (configTable[configKey] or false)
updateState()
saveConfig()
end)

updateState()
return btn,stroke
end

local autoTab=createTab("Auto","⚙️",1)
local shopTab=createTab("Shop","🛒",2)
local plantTab=createTab("Plant","🌱",3)
local petTab=createTab("Pet","🐾",4)

local mainSection=createSection(autoTab,"🎮 Controls",80)

local collectBtn,collectStroke=createButton(mainSection,"📦 Collect: OFF",UDim2.new(0,5,0,25),UDim2.new(0.48,0,0,20),function()
cfg.co=not cfg.co
updateButton(collectBtn,collectStroke,cfg.co,"📦 Collect: ON","📦 Collect: OFF")
if cfg.co then task.spawn(collectLoop) end
saveConfig()
end)

local sellBtn,sellStroke=createButton(mainSection,"💰 Sell: OFF",UDim2.new(0.52,0,0,25),UDim2.new(0.48,0,0,20),function()
cfg.as=not cfg.as
updateButton(sellBtn,sellStroke,cfg.as,"💰 Sell: ON","💰 Sell: OFF")
if cfg.as then task.spawn(sellLoop) end
saveConfig()
end)

local plantBtn,plantStroke=createButton(mainSection,"🌿 Plant: OFF",UDim2.new(0,5,0,50),UDim2.new(0.48,0,0,20),function()
cfg.ap=not cfg.ap
updateButton(plantBtn,plantStroke,cfg.ap,"🌿 Plant: ON","🌿 Plant: OFF")
saveConfig()
end)

local eventBtn,eventStroke=createButton(mainSection,"🍓 Event: OFF",UDim2.new(0.52,0,0,50),UDim2.new(0.48,0,0,20),function()
cfg.ae=not cfg.ae
updateButton(eventBtn,eventStroke,cfg.ae,"🍓 Event: ON","🍓 Event: OFF")
if cfg.ae then task.spawn(eventLoop) end
saveConfig()
end)

local gearSection=createSection(shopTab,"⚙️ Gears",120)
local gearScroll,gearLayout=createScrollFrame(gearSection,UDim2.new(0,5,0,20),UDim2.new(1,-10,1,-25))

local seedSection=createSection(shopTab,"🌱 Seeds",120)
local seedScroll,seedLayout=createScrollFrame(seedSection,UDim2.new(0,5,0,20),UDim2.new(1,-10,1,-25))

local plantSection=createSection(plantTab,"🌾 Plants",200)
local plantScroll,plantLayout=createScrollFrame(plantSection,UDim2.new(0,5,0,20),UDim2.new(1,-10,1,-25))

local eggSection=createSection(petTab,"🥚 Eggs",120)
local eggScroll,eggLayout=createScrollFrame(eggSection,UDim2.new(0,5,0,20),UDim2.new(1,-10,1,-25))

local feedSection=createSection(petTab,"🍖 Feed",80)

local plot=nil
for _,farm in pairs(workspace.Farm:GetChildren())do
local important=farm:FindFirstChild("Important")
local owner=important and important:FindFirstChild("Data") and important.Data:FindFirstChild("Owner")
if owner and owner.Value==p.Name then 
plot=important 
break 
end
end

local stats={collected=0,sold=0,planted=0}

function collectLoop()
while cfg.co do
local count=0
if plot then
for _,plant in pairs(plot.Plants_Physical:GetChildren())do
if plant:IsA("Model") and cfg.sp[plant.Name] then
local fruits=plant:FindFirstChild("Fruits")
if fruits then
for _,fruit in pairs(fruits:GetChildren())do
game.ReplicatedStorage.ByteNetReliable:FireServer(buffer.fromstring("\001\001\000\001"),{fruit})
count=count+1
stats.collected=stats.collected+1
if count>=30 then break end
rs.Heartbeat:Wait()
end
else
game.ReplicatedStorage.ByteNetReliable:FireServer(buffer.fromstring("\001\001\000\001"),{plant})
count=count+1
stats.collected=stats.collected+1
if count>=30 then break end
rs.Heartbeat:Wait()
end
end
if count>=30 then break end
end
end
task.wait(2)
end
end

function sellLoop()
while cfg.as do
game.ReplicatedStorage.GameEvents.Sell_Inventory:FireServer()
stats.sold=stats.sold+1
task.wait(1)
end
end

function eventLoop()
while cfg.ae do
local found=false
for _,obj in pairs(workspace.Interaction.UpdateItems.SummerHarvestEvent.Sign:GetDescendants())do
if obj:IsA("TextLabel") and obj.Text:find("Summer Harvest Ends:") then
found=true
break
end
end
if found then
for _,tool in pairs(p.Backpack:GetChildren())do
if tool:IsA("Tool") and tool.Name:find("%[.+kg%]") then
tool.Parent=p.Character
end
end
game.ReplicatedStorage.GameEvents.SummerHarvestRemoteEvent:FireServer("SubmitHeldPlant")
end
rs.Heartbeat:Wait()
end
end

local function createPlantButtons()
for _,btn in pairs(plantScroll:GetChildren())do
if btn:IsA("TextButton") then btn:Destroy() end
end

if not plot then return end

local plantNames={}
local seen={}
for _,plant in pairs(plot.Plants_Physical:GetChildren())do
if plant:IsA("Model") and not seen[plant.Name] then
seen[plant.Name]=true
table.insert(plantNames,plant.Name)
end
end

for _,name in pairs(plantNames)do
createListButton(plantScroll,"🌱 "..name..": OFF",name,cfg.sp,"🌱 "..name..": ON","🌱 "..name..": OFF")
end
end

local function setupShopIntegration(shopName,scrollFrame,configTable,eventName,iconPrefix)
task.spawn(function()
local shop=p.PlayerGui:WaitForChild(shopName)
local shopScroll=shop.Frame.ScrollingFrame
local buyEvent=game.ReplicatedStorage.GameEvents[eventName]

for _,item in pairs(shopScroll:GetChildren())do
if item:IsA("Frame") and item:FindFirstChild("Frame") then
local frame2=item.Frame
local buySection=frame2:FindFirstChild("Sheckles_Buy")
local stockLabel=buySection and buySection:FindFirstChild("In_Stock")
if stockLabel then
local overlayBtn=Instance.new("TextButton")
overlayBtn.Size=UDim2.new(0,12,0,12)
overlayBtn.Position=UDim2.new(1,-14,0,2)
overlayBtn.BackgroundColor3=Color3.fromRGB(50,50,50)
overlayBtn.Text=""
overlayBtn.Parent=buySection
createCorner(overlayBtn,3)

local function updateOverlay()
overlayBtn.BackgroundColor3=configTable[item.Name] and Color3.fromRGB(0,200,0) or Color3.fromRGB(50,50,50)
end

overlayBtn.MouseButton1Click:Connect(function()
configTable[item.Name]=not configTable[item.Name]
updateOverlay()
saveConfig()
end)

createListButton(scrollFrame,iconPrefix.." "..item.Name..": OFF",item.Name,configTable,iconPrefix.." "..item.Name..": ON",iconPrefix.." "..item.Name..": OFF")

task.spawn(function()
while true do
if configTable[item.Name] and stockLabel.Visible then
buyEvent:FireServer(item.Name)
end
task.wait(0.15)
end
end)

updateOverlay()
end
end
end
end)
end

setupShopIntegration("Gear_Shop",gearScroll,cfg.gr,"BuyGearStock","⚙️")
setupShopIntegration("Seed_Shop",seedScroll,cfg.sd,"BuySeedStock","🌱")

local petEggs=require(game.ReplicatedStorage.Data.PetRegistry).PetEggs
local petEvent=game.ReplicatedStorage.GameEvents.BuyPetEgg

for eggName in pairs(petEggs)do
local btn,stroke=createListButton(eggScroll,"🥚 "..eggName..": OFF",eggName,cfg.pe,"🥚 "..eggName..": ON","🥚 "..eggName..": OFF")

btn.MouseButton1Click:Connect(function()
if cfg.pe[eggName] then
task.spawn(function()
while cfg.pe[eggName] do
local data=require(game.ReplicatedStorage.Modules.DataService):GetData()
for i,stock in pairs(data.PetEggStock.Stocks)do
if cfg.pe[eggName] and petEggs[stock.EggName] and stock.EggName==eggName and stock.Stock>0 then
petEvent:FireServer(i)
end
end
task.wait(0.1)
end
end)
end
end)
end

task.spawn(function()
local petUI=p.PlayerGui:WaitForChild("ActivePetUI")
local petFrame=petUI.Frame.Main.ScrollingFrame
local feedEvent=game.ReplicatedStorage.GameEvents.ActivePetService

for _,pet in pairs(petFrame:GetChildren())do
if pet.Name:match("^%b{}$") and pet:FindFirstChild("PetStats") then
local petStats=pet.PetStats
local feedBtn=Instance.new("TextButton",petStats)
feedBtn.Size=UDim2.new(1,-4,0,15)
feedBtn.Position=UDim2.new(0,2,0,2)
feedBtn.BackgroundColor3=Color3.fromRGB(50,50,60)
feedBtn.TextColor3=Color3.fromRGB(255,255,255)
feedBtn.TextSize=8
feedBtn.Font=Enum.Font.GothamSemibold
createCorner(feedBtn,4)
local feedStroke=createStroke(feedBtn)

local petId=pet.Name
local isActive=cfg.pf[petId] or false

local function updateFeedBtn()
feedBtn.Text="Feed: "..(isActive and "ON" or "OFF")
feedBtn.BackgroundColor3=isActive and Color3.fromRGB(0,120,50) or Color3.fromRGB(50,50,60)
feedStroke.Color=isActive and Color3.fromRGB(0,150,70) or Color3.fromRGB(80,80,90)
end

local function equipFood()
for _,tool in pairs(p.Backpack:GetChildren())do
if tool:IsA("Tool") and tool.Name:find("%[.+kg%]") then
tool.Parent=p.Character
end
end
end

local function feedLoop()
while isActive do
equipFood()
feedEvent:FireServer("Feed",petId)
rs.Heartbeat:Wait()
end
end

feedBtn.MouseButton1Click:Connect(function()
isActive=not isActive
cfg.pf[petId]=isActive
updateFeedBtn()
if isActive then
equipFood()
task.spawn(feedLoop)
end
saveConfig()
end)

updateFeedBtn()
end
end
end)

local function handleToolEquip(tool)
if tool:IsA("Tool") and cfg.ap then
local rawName=tool.Name
local seedName=rawName:gsub(" Seed %[X%d+%]",""):gsub(" Seed","")
if plot then
local plantsPhysical=plot:FindFirstChild("Plants_Physical")
if plantsPhysical then
local plantModel=plantsPhysical:FindFirstChild(seedName)
if plantModel and plantModel.PrimaryPart then
local position=plantModel.PrimaryPart.Position
task.spawn(function()
while cfg.ap and p.Character:FindFirstChildOfClass("Tool") do
local currentTool=p.Character:FindFirstChildOfClass("Tool")
if not currentTool or not currentTool.Name:find(seedName) then break end
game.ReplicatedStorage.GameEvents.Plant_RE:FireServer(position,seedName)
stats.planted=stats.planted+1
task.wait(0.1)
end
end)
end
end
end
end
end

p.CharacterAdded:Connect(function(character)
character.ChildAdded:Connect(handleToolEquip)
end)

if p.Character then
p.Character.ChildAdded:Connect(handleToolEquip)
end

mn.MouseButton1Click:Connect(function()
minimized=not minimized
if minimized then
m:TweenSize(UDim2.new(0.35,0,0,35),"Out","Quad",0.3)
mn.Text="+"
tabCont.Visible=false
cont.Visible=false
else
tabCont.Visible=true
cont.Visible=true
m:TweenSize(UDim2.new(0.35,0,0.6,0),"Out","Quad",0.3)
mn.Text="-"
end
end)

loadConfig()
updateButton(collectBtn,collectStroke,cfg.co,"📦 Collect: ON","📦 Collect: OFF")
updateButton(sellBtn,sellStroke,cfg.as,"💰 Sell: ON","💰 Sell: OFF")
updateButton(plantBtn,plantStroke,cfg.ap,"🌿 Plant: ON","🌿 Plant: OFF")
updateButton(eventBtn,eventStroke,cfg.ae,"🍓 Event: ON","🍓 Event: OFF")

createPlantButtons()

tabs["Auto"].btn.BackgroundColor3=Color3.fromRGB(50,50,65)
tabs["Auto"].btn.TextColor3=Color3.fromRGB(255,255,255)
tabs["Auto"].content.Visible=true
activeTab="Auto"

if cfg.co then task.spawn(collectLoop) end
if cfg.as then task.spawn(sellLoop) end
if cfg.ae then task.spawn(eventLoop) end

local credits=Instance.new("TextLabel",m)
credits.Size=UDim2.new(1,0,0,12)
credits.Position=UDim2.new(0,0,1,-15)
credits.BackgroundTransparency=1
credits.Text="✨ OneCreatorX"
credits.TextColor3=Color3.fromRGB(120,120,130)
credits.TextSize=8
credits.Font=Enum.Font.GothamMedium
credits.TextXAlignment=Enum.TextXAlignment.Center

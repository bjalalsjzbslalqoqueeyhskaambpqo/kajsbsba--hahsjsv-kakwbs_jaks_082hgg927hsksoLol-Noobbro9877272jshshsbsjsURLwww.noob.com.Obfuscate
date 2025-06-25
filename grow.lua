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

local g,m,hd,tc,cf
local tabs,curTab,plot={},{},nil
local minimized,config=false,{
collect=false,autoSell=false,autoPlant=false,autoEvent=false,
selectedPlants={},petEggs={},gears={},seeds={},petFeeding={}
}

local colors={
bg=Color3.fromRGB(15,15,20),
header=Color3.fromRGB(25,130,65),
section=Color3.fromRGB(30,30,35),
active=Color3.fromRGB(0,120,50),
inactive=Color3.fromRGB(50,50,60),
text=Color3.fromRGB(255,255,255),
subtext=Color3.fromRGB(200,200,210)
}

local configFile="GrowGardenConfig.json"

local function saveConfig()
pcall(function()
writefile(configFile,hs:JSONEncode(config))
end)
end

local function loadConfig()
if isfile(configFile)then
pcall(function()
local data=hs:JSONDecode(readfile(configFile))
for k,v in pairs(data)do 
config[k]=v 
end
end)
end
end

local function createCorner(obj,radius)
local corner=Instance.new("UICorner",obj)
corner.CornerRadius=UDim.new(0,radius or 8)
return corner
end

local function createStroke(obj,color,thickness)
local stroke=Instance.new("UIStroke",obj)
stroke.Color=color or Color3.fromRGB(60,60,70)
stroke.Thickness=thickness or 1
return stroke
end

local function createLayout(obj,direction,padding)
local layout=Instance.new("UIListLayout",obj)
layout.FillDirection=direction or Enum.FillDirection.Vertical
layout.Padding=UDim.new(0,padding or 5)
layout.SortOrder=Enum.SortOrder.LayoutOrder
return layout
end

local function updateButton(button,stroke,state,text)
button.Text=text..(state and " ON" or " OFF")
button.BackgroundColor3=state and colors.active or colors.inactive
stroke.Color=state and Color3.fromRGB(0,150,70) or Color3.fromRGB(80,80,90)
end

local function getPlot()
for _,farm in pairs(ws.Farm:GetChildren())do
local important=farm:FindFirstChild("Important")
if important then
local data=important:FindFirstChild("Data")
if data then
local owner=data:FindFirstChild("Owner")
if owner and owner.Value==p.Name then
plot=important
return true
end
end
end
end
return false
end

local function initGUI()
g=Instance.new("ScreenGui",pg)
g.Name="GrowGardenMenu"
g.ResetOnSpawn=false

m=Instance.new("Frame",g)
m.Size=UDim2.new(0,400,0,500)
m.Position=UDim2.new(0,10,0,10)
m.BackgroundColor3=colors.bg
m.BorderSizePixel=0
m.Draggable=true
m.Active=true
createCorner(m,12)
createStroke(m,Color3.fromRGB(60,60,70),2)

local shadow=Instance.new("Frame",m)
shadow.Size=UDim2.new(1,8,1,8)
shadow.Position=UDim2.new(0,-4,0,4)
shadow.BackgroundColor3=Color3.fromRGB(0,0,0)
shadow.BackgroundTransparency=0.8
shadow.ZIndex=-1
createCorner(shadow,12)

hd=Instance.new("Frame",m)
hd.Size=UDim2.new(1,0,0,50)
hd.BackgroundColor3=colors.header
createCorner(hd,12)
local headerGrad=Instance.new("UIGradient",hd)
headerGrad.Color=ColorSequence.new{
ColorSequenceKeypoint.new(0,Color3.fromRGB(35,150,85)),
ColorSequenceKeypoint.new(1,Color3.fromRGB(15,100,45))
}

local title=Instance.new("TextLabel",hd)
title.Size=UDim2.new(1,-80,1,0)
title.Position=UDim2.new(0,15,0,0)
title.BackgroundTransparency=1
title.Text="🌱 Grow Garden"
title.TextColor3=colors.text
title.TextSize=18
title.Font=Enum.Font.GothamBold
title.TextXAlignment=Enum.TextXAlignment.Left

local minBtn=Instance.new("TextButton",hd)
minBtn.Size=UDim2.new(0,30,0,30)
minBtn.Position=UDim2.new(1,-70,0,10)
minBtn.BackgroundColor3=Color3.fromRGB(40,40,50)
minBtn.Text="-"
minBtn.TextColor3=colors.text
minBtn.TextSize=16
minBtn.Font=Enum.Font.GothamBold
createCorner(minBtn,6)

local closeBtn=Instance.new("TextButton",hd)
closeBtn.Size=UDim2.new(0,30,0,30)
closeBtn.Position=UDim2.new(1,-35,0,10)
closeBtn.BackgroundColor3=Color3.fromRGB(180,50,50)
closeBtn.Text="×"
closeBtn.TextColor3=colors.text
closeBtn.TextSize=16
closeBtn.Font=Enum.Font.GothamBold
createCorner(closeBtn,6)

tc=Instance.new("Frame",m)
tc.Size=UDim2.new(1,-20,0,40)
tc.Position=UDim2.new(0,10,0,60)
tc.BackgroundColor3=Color3.fromRGB(25,25,30)
createCorner(tc,8)
createLayout(tc,Enum.FillDirection.Horizontal,2)

cf=Instance.new("Frame",m)
cf.Size=UDim2.new(1,-20,1,-120)
cf.Position=UDim2.new(0,10,0,110)
cf.BackgroundColor3=Color3.fromRGB(20,20,25)
createCorner(cf,8)

minBtn.MouseButton1Click:Connect(function()
minimized=not minimized
if minimized then
m:TweenSize(UDim2.new(0,400,0,50),"Out","Quad",0.3)
minBtn.Text="+"
tc.Visible=false
cf.Visible=false
else
tc.Visible=true
cf.Visible=true
m:TweenSize(UDim2.new(0,400,0,500),"Out","Quad",0.3)
minBtn.Text="-"
end
end)

closeBtn.MouseButton1Click:Connect(function()
g:Destroy()
end)

local credits=Instance.new("TextLabel",m)
credits.Size=UDim2.new(1,0,0,15)
credits.Position=UDim2.new(0,0,1,-20)
credits.BackgroundTransparency=1
credits.Text="✨ OneCreatorX"
credits.TextColor3=Color3.fromRGB(120,120,130)
credits.TextSize=10
credits.Font=Enum.Font.GothamMedium
credits.TextXAlignment=Enum.TextXAlignment.Center
end

local function createTab(name,icon)
local tabBtn=Instance.new("TextButton",tc)
tabBtn.Size=UDim2.new(0.2,0,1,0)
tabBtn.BackgroundColor3=Color3.fromRGB(35,35,40)
tabBtn.Text=icon.." "..name
tabBtn.TextColor3=colors.subtext
tabBtn.TextSize=12
tabBtn.Font=Enum.Font.GothamSemibold
createCorner(tabBtn,6)

local content=Instance.new("ScrollingFrame",cf)
content.Size=UDim2.new(1,0,1,0)
content.BackgroundTransparency=1
content.ScrollBarThickness=6
content.ScrollBarImageColor3=Color3.fromRGB(60,60,70)
content.Visible=false
content.CanvasSize=UDim2.new(0,0,0,0)

local layout=createLayout(content)

tabs[name]={button=tabBtn,content=content,layout=layout}

tabBtn.MouseButton1Click:Connect(function()
if curTab then
curTab.button.BackgroundColor3=Color3.fromRGB(35,35,40)
curTab.content.Visible=false
end
curTab=tabs[name]
tabBtn.BackgroundColor3=colors.active
content.Visible=true
end)

layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
content.CanvasSize=UDim2.new(0,0,0,layout.AbsoluteContentSize.Y+20)
end)

return content,layout
end

local function createSection(parent,title,height)
local section=Instance.new("Frame",parent)
section.Size=UDim2.new(1,-10,0,height or 100)
section.BackgroundColor3=colors.section
createCorner(section,8)
createStroke(section,Color3.fromRGB(50,50,60))

local sectionTitle=Instance.new("TextLabel",section)
sectionTitle.Size=UDim2.new(1,-10,0,25)
sectionTitle.Position=UDim2.new(0,5,0,5)
sectionTitle.BackgroundTransparency=1
sectionTitle.Text=title
sectionTitle.TextColor3=colors.subtext
sectionTitle.TextSize=14
sectionTitle.Font=Enum.Font.GothamBold
sectionTitle.TextXAlignment=Enum.TextXAlignment.Left

return section
end

local function createButton(parent,text,position,size,callback)
local button=Instance.new("TextButton",parent)
button.Size=size or UDim2.new(0.48,0,0,30)
button.Position=position or UDim2.new(0,5,0,35)
button.BackgroundColor3=colors.inactive
button.Text=text
button.TextColor3=colors.text
button.TextSize=11
button.Font=Enum.Font.GothamSemibold
createCorner(button,6)
local stroke=createStroke(button,Color3.fromRGB(80,80,90))

if callback then 
button.MouseButton1Click:Connect(callback)
end
return button,stroke
end

local function createScrollFrame(parent,size,position)
local scrollFrame=Instance.new("ScrollingFrame",parent)
scrollFrame.Size=size or UDim2.new(1,-10,1,-35)
scrollFrame.Position=position or UDim2.new(0,5,0,30)
scrollFrame.BackgroundColor3=Color3.fromRGB(25,25,30)
scrollFrame.ScrollBarThickness=6
scrollFrame.ScrollBarImageColor3=Color3.fromRGB(60,60,70)
createCorner(scrollFrame,6)
local layout=createLayout(scrollFrame)
layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
scrollFrame.CanvasSize=UDim2.new(0,0,0,layout.AbsoluteContentSize.Y+10)
end)
return scrollFrame,layout
end

local function initTabs()
local controlsContent,controlsLayout=createTab("Ctrl","⚙️")
local plantsContent,plantsLayout=createTab("Plant","🌱")
local shopContent,shopLayout=createTab("Shop","🛒")
local petsContent,petsLayout=createTab("Pet","🐾")
local eventsContent,eventsLayout=createTab("Event","🎉")

local controlSection=createSection(controlsContent,"Main Controls",120)
local collectBtn,collectStroke=createButton(controlSection,"📦 Collect: OFF",UDim2.new(0,5,0,35),UDim2.new(0.48,0,0,25))
local sellBtn,sellStroke=createButton(controlSection,"💰 Auto Sell: OFF",UDim2.new(0.52,0,0,35),UDim2.new(0.48,0,0,25))
local plantBtn,plantStroke=createButton(controlSection,"🌿 Auto Plant: OFF",UDim2.new(0,5,0,65),UDim2.new(0.48,0,0,25))

local plantSection=createSection(plantsContent,"Plant Selection",300)
local plantScroll,plantLayout=createScrollFrame(plantSection)

local gearSection=createSection(shopContent,"Auto Buy Gears",200)
local gearScroll,gearLayout=createScrollFrame(gearSection)

local seedSection=createSection(shopContent,"Auto Buy Seeds",200)
seedSection.LayoutOrder=1
local seedScroll,seedLayout=createScrollFrame(seedSection)

local eggSection=createSection(petsContent,"Pet Eggs",250)
local eggScroll,eggLayout=createScrollFrame(eggSection)

local feedSection=createSection(petsContent,"Auto Feed Pets",200)
feedSection.LayoutOrder=1
local feedScroll,feedLayout=createScrollFrame(feedSection)

local eventSection=createSection(eventsContent,"Event Controls",100)
local eventBtn,eventStroke=createButton(eventSection,"🍓 Auto Event: OFF",UDim2.new(0,5,0,35),UDim2.new(0.48,0,0,25))

local function createPlantButtons()
for _,child in pairs(plantScroll:GetChildren())do
if child:IsA("TextButton")then child:Destroy()end
end

if not getPlot()then return end

local plantNames={}
local seen={}
for _,plant in pairs(plot.Plants_Physical:GetChildren())do
if plant:IsA("Model") and not seen[plant.Name] then
seen[plant.Name]=true
table.insert(plantNames,plant.Name)
end
end

for _,name in pairs(plantNames)do
local btn=Instance.new("TextButton",plantScroll)
btn.Size=UDim2.new(1,-8,0,25)
btn.BackgroundColor3=config.selectedPlants[name] and colors.active or Color3.fromRGB(45,45,55)
btn.Text="🌱 "..name..": "..(config.selectedPlants[name] and "ON" or "OFF")
btn.TextColor3=colors.text
btn.TextSize=11
btn.Font=Enum.Font.GothamMedium
btn.TextXAlignment=Enum.TextXAlignment.Left
createCorner(btn,6)
local stroke=createStroke(btn,config.selectedPlants[name] and Color3.fromRGB(0,150,70) or Color3.fromRGB(70,70,80))

btn.MouseButton1Click:Connect(function()
config.selectedPlants[name]=not config.selectedPlants[name]
updateButton(btn,stroke,config.selectedPlants[name],"🌱 "..name..": ")
saveConfig()
end)
end
end

local function setupGearShop()
task.spawn(function()
task.wait(2)
if not pg:FindFirstChild("Gear_Shop")then return end
local frame=pg.Gear_Shop.Frame.ScrollingFrame
local event=rp.GameEvents.BuyGearStock

for _,item in pairs(frame:GetChildren())do
if item:IsA("Frame")then
local frame2=item:FindFirstChild("Frame")
if frame2 then
local sheckles=frame2:FindFirstChild("Sheckles_Buy")
if sheckles then
local stock=sheckles:FindFirstChild("In_Stock")
if stock then
local btn=Instance.new("TextButton",gearScroll)
btn.Size=UDim2.new(1,-8,0,25)
btn.BackgroundColor3=config.gears[item.Name] and colors.active or Color3.fromRGB(45,45,55)
btn.Text="⚙️ "..item.Name..": "..(config.gears[item.Name] and "ON" or "OFF")
btn.TextColor3=colors.text
btn.TextSize=11
btn.Font=Enum.Font.GothamMedium
btn.TextXAlignment=Enum.TextXAlignment.Left
createCorner(btn,6)
local stroke=createStroke(btn,config.gears[item.Name] and Color3.fromRGB(0,150,70) or Color3.fromRGB(70,70,80))

btn.MouseButton1Click:Connect(function()
config.gears[item.Name]=not config.gears[item.Name]
updateButton(btn,stroke,config.gears[item.Name],"⚙️ "..item.Name..": ")
saveConfig()
end)

if config.gears[item.Name]then
task.spawn(function()
while config.gears[item.Name]do
if stock.Visible then
pcall(function()event:FireServer(item.Name)end)
end
task.wait(0.2)
end
end)
end
end
end
end
end
end
end)
end

local function setupSeedShop()
task.spawn(function()
task.wait(2)
if not pg:FindFirstChild("Seed_Shop")then return end
local gui=pg.Seed_Shop.Frame.ScrollingFrame
local remote=rp.GameEvents.BuySeedStock

for _,item in pairs(gui:GetChildren())do
if item:IsA("Frame")then
local frame=item:FindFirstChild("Frame")
if frame then
local sheckles=frame:FindFirstChild("Sheckles_Buy")
if sheckles then
local btn=Instance.new("TextButton",seedScroll)
btn.Size=UDim2.new(1,-8,0,25)
btn.BackgroundColor3=config.seeds[item.Name] and colors.active or Color3.fromRGB(45,45,55)
btn.Text="🌱 "..item.Name..": "..(config.seeds[item.Name] and "ON" or "OFF")
btn.TextColor3=colors.text
btn.TextSize=11
btn.Font=Enum.Font.GothamMedium
btn.TextXAlignment=Enum.TextXAlignment.Left
createCorner(btn,6)
local stroke=createStroke(btn,config.seeds[item.Name] and Color3.fromRGB(0,150,70) or Color3.fromRGB(70,70,80))

btn.MouseButton1Click:Connect(function()
config.seeds[item.Name]=not config.seeds[item.Name]
updateButton(btn,stroke,config.seeds[item.Name],"🌱 "..item.Name..": ")
saveConfig()
if config.seeds[item.Name]then
task.spawn(function()
while config.seeds[item.Name]do
local foundItem=gui:FindFirstChild(item.Name)
if foundItem then
local itemFrame=foundItem:FindFirstChild("Frame")
if itemFrame then
local itemSheckles=itemFrame:FindFirstChild("Sheckles_Buy")
if itemSheckles then
local itemStock=itemSheckles:FindFirstChild("In_Stock")
if itemStock and itemStock.Visible then
pcall(function()remote:FireServer(item.Name)end)
end
end
end
end
task.wait(0.2)
end
end)
end
end)

if config.seeds[item.Name]then
task.spawn(function()
while config.seeds[item.Name]do
local foundItem=gui:FindFirstChild(item.Name)
if foundItem then
local itemFrame=foundItem:FindFirstChild("Frame")
if itemFrame then
local itemSheckles=itemFrame:FindFirstChild("Sheckles_Buy")
if itemSheckles then
local itemStock=itemSheckles:FindFirstChild("In_Stock")
if itemStock and itemStock.Visible then
pcall(function()remote:FireServer(item.Name)end)
end
end
end
end
task.wait(0.2)
end
end)
end
end
end
end
end
end)
end

local function setupPetEggs()
local success,eggs=pcall(function()
return require(rp.Data.PetRegistry).PetEggs
end)
if not success then return end

local remote=rp.GameEvents.BuyPetEgg

for name in pairs(eggs)do
local btn=Instance.new("TextButton",eggScroll)
btn.Size=UDim2.new(1,-8,0,30)
btn.BackgroundColor3=config.petEggs[name] and colors.active or Color3.fromRGB(45,45,55)
btn.Text="🥚 "..name..": "..(config.petEggs[name] and "ON" or "OFF")
btn.TextColor3=colors.text
btn.TextSize=11
btn.Font=Enum.Font.GothamMedium
btn.TextXAlignment=Enum.TextXAlignment.Left
createCorner(btn,8)
local stroke=createStroke(btn,config.petEggs[name] and Color3.fromRGB(0,150,70) or Color3.fromRGB(70,70,80))

btn.MouseButton1Click:Connect(function()
config.petEggs[name]=not config.petEggs[name]
updateButton(btn,stroke,config.petEggs[name],"🥚 "..name..": ")
saveConfig()
if config.petEggs[name]then
task.spawn(function()
while config.petEggs[name]do
pcall(function()
local data=require(rp.Modules.DataService):GetData()
if data and data.PetEggStock and data.PetEggStock.Stocks then
for i,v in pairs(data.PetEggStock.Stocks)do
if config.petEggs[name] and eggs[v.EggName] and v.EggName==name and v.Stock>0 then
remote:FireServer(i)
end
end
end
end)
task.wait(0.15)
end
end)
end
end)

if config.petEggs[name]then
task.spawn(function()
while config.petEggs[name]do
pcall(function()
local data=require(rp.Modules.DataService):GetData()
if data and data.PetEggStock and data.PetEggStock.Stocks then
for i,v in pairs(data.PetEggStock.Stocks)do
if config.petEggs[name] and eggs[v.EggName] and v.EggName==name and v.Stock>0 then
remote:FireServer(i)
end
end
end
end)
task.wait(0.15)
end
end)
end
end
end

local function setupPetFeeding()
task.spawn(function()
task.wait(2)
if not pg:FindFirstChild("ActivePetUI")then return end
local petsUI=pg.ActivePetUI.Frame.Main.ScrollingFrame
local event=rp.GameEvents.ActivePetService

for _,petFrame in pairs(petsUI:GetChildren())do
if petFrame.Name:match("^%b{}$") and petFrame:FindFirstChild("PetStats")then
local id=petFrame.Name
local btn=Instance.new("TextButton",feedScroll)
btn.Size=UDim2.new(1,-8,0,25)
btn.BackgroundColor3=config.petFeeding[id] and colors.active or Color3.fromRGB(45,45,55)
btn.Text="🍖 Pet "..id:sub(2,-2)..": "..(config.petFeeding[id] and "ON" or "OFF")
btn.TextColor3=colors.text
btn.TextSize=11
btn.Font=Enum.Font.GothamMedium
btn.TextXAlignment=Enum.TextXAlignment.Left
createCorner(btn,6)
local stroke=createStroke(btn,config.petFeeding[id] and Color3.fromRGB(0,150,70) or Color3.fromRGB(70,70,80))

local function equipAll()
for _,tool in pairs(p.Backpack:GetChildren())do
if tool:IsA("Tool") and tool.Name:find("%[.+kg%]")then
tool.Parent=p.Character
end
end
end

btn.MouseButton1Click:Connect(function()
config.petFeeding[id]=not config.petFeeding[id]
updateButton(btn,stroke,config.petFeeding[id],"🍖 Pet "..id:sub(2,-2)..": ")
saveConfig()
if config.petFeeding[id]then
task.spawn(function()
while config.petFeeding[id]do
equipAll()
pcall(function()event:FireServer("Feed",id)end)
rs.Heartbeat:Wait()
end
end)
end
end)

if config.petFeeding[id]then
task.spawn(function()
while config.petFeeding[id]do
equipAll()
pcall(function()event:FireServer("Feed",id)end)
rs.Heartbeat:Wait()
end
end)
end

p.Backpack.ChildAdded:Connect(function(tool)
if config.petFeeding[id] and tool:IsA("Tool") and tool.Name:find("%[.+kg%]")then
tool.Parent=p.Character
end
end)
end
end
end)
end

local function collectPlants()
while config.collect do
local count=0
if plot then
for _,plant in pairs(plot.Plants_Physical:GetChildren())do
if plant:IsA("Model") and config.selectedPlants[plant.Name]then
local fruits=plant:FindFirstChild("Fruits")
if fruits then
for _,fruit in pairs(fruits:GetChildren())do
pcall(function()
rp.ByteNetReliable:FireServer(buffer.fromstring("\001\001\000\001"),{fruit})
end)
count+=1
if count>=150 then break end
rs.Heartbeat:Wait()
end
else
pcall(function()
rp.ByteNetReliable:FireServer(buffer.fromstring("\001\001\000\001"),{plant})
end)
count+=1
if count>=150 then break end
rs.Heartbeat:Wait()
end
end
if count>=150 then break end
end
end
task.wait(3)
end
end

local function autoSell()
while config.autoSell do
pcall(function()
rp.GameEvents.Sell_Inventory:FireServer()
end)
task.wait(1)
end
end

local function autoPlant()
if not p.Character then return end
local tool=p.Character:FindFirstChildOfClass("Tool")
if not tool then return end
local rawName=tool.Name
local seedName=rawName:gsub(" Seed %[X%d+%]",""):gsub(" Seed","")

if not getPlot()then return end

local plants=plot:FindFirstChild("Plants_Physical")
if not plants then return end

local plant=plants:FindFirstChild(seedName)
if not plant or not plant.PrimaryPart then return end

local position=plant.PrimaryPart.Position
while config.autoPlant do
local currentTool=p.Character:FindFirstChildOfClass("Tool")
if not currentTool then break end
if not currentTool.Name:find(seedName)then break end
pcall(function()
rp.GameEvents.Plant_RE:FireServer(position,seedName)
end)
task.wait(0.1)
end
end

local function autoEvent()
local event=rp.GameEvents.SummerHarvestRemoteEvent

local function findEventLabel()
local success,result=pcall(function()
for _,v in pairs(ws.Interaction.UpdateItems.SummerHarvestEvent.Sign:GetDescendants())do
if v:IsA("TextLabel") and v.Text:find("Summer Harvest Ends:")then
return v
end
end
end)
return success and result or nil
end

local function handleTool(tool)
if config.autoEvent and tool:IsA("Tool") and tool.Name:find("%[.+kg%]")then
tool.Parent=p.Character
end
end

p.Backpack.ChildAdded:Connect(handleTool)

while config.autoEvent do
local label=findEventLabel()
if label then
for _,v in pairs(p.Backpack:GetChildren())do handleTool(v)end
while label and config.autoEvent do
pcall(function()event:FireServer("SubmitHeldPlant")end)
rs.Heartbeat:Wait()
label=findEventLabel()
end
end
rs.Heartbeat:Wait()
end
end

collectBtn.MouseButton1Click:Connect(function()
config.collect=not config.collect
updateButton(collectBtn,collectStroke,config.collect,"📦 Collect: ")
if config.collect then task.spawn(collectPlants)end
saveConfig()
end)

sellBtn.MouseButton1Click:Connect(function()
config.autoSell=not config.autoSell
updateButton(sellBtn,sellStroke,config.autoSell,"💰 Auto Sell: ")
if config.autoSell then task.spawn(autoSell)end
saveConfig()
end)

plantBtn.MouseButton1Click:Connect(function()
config.autoPlant=not config.autoPlant
updateButton(plantBtn,plantStroke,config.autoPlant,"🌿 Auto Plant: ")
saveConfig()
end)

eventBtn.MouseButton1Click:Connect(function()
config.autoEvent=not config.autoEvent
updateButton(eventBtn,eventStroke,config.autoEvent,"🍓 Auto Event: ")
if config.autoEvent then task.spawn(autoEvent)end
saveConfig()
end)

p.CharacterAdded:Connect(function(character)
character.ChildAdded:Connect(function(child)
if child:IsA("Tool") and config.autoPlant then
task.spawn(autoPlant)
end
end)
end)

if p.Character then
p.Character.ChildAdded:Connect(function(child)
if child:IsA("Tool") and config.autoPlant then
task.spawn(autoPlant)
end
end)
end

updateButton(collectBtn,collectStroke,config.collect,"📦 Collect: ")
updateButton(sellBtn,sellStroke,config.autoSell,"💰 Auto Sell: ")
updateButton(plantBtn,plantStroke,config.autoPlant,"🌿 Auto Plant: ")
updateButton(eventBtn,eventStroke,config.autoEvent,"🍓 Auto Event: ")

if not curTab then
curTab=tabs["Ctrl"]
curTab.button.BackgroundColor3=colors.active
curTab.content.Visible=true
end

if config.collect then task.spawn(collectPlants)end
if config.autoSell then task.spawn(autoSell)end
if config.autoEvent then task.spawn(autoEvent)end

task.spawn(function()
while true do
task.wait(30)
createPlantButtons()
end
end)
end

loadConfig()
initGUI()
initTabs()
createPlantButtons()
setupGearShop()
setupSeedShop()
setupPetEggs()
setupPetFeeding()

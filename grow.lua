local r=_G.VALIDATION_TOKEN and game:HttpGet("https://system.heatherx.site/validate/onecreatorx/grow-garden/".._G.VALIDATION_TOKEN)
if r~="1"then return end

local vmod
for _,m in ipairs(getloadedmodules())do
 if m.Name=="VariantVisuals"then vmod=require(m)break end
end
if vmod then vmod.SetVisuals=function()end end

local p=game.Players.LocalPlayer
local RS=game:GetService("RunService")
local HS=game:GetService("HttpService")
local TweenService=game:GetService("TweenService")

local g=Instance.new("ScreenGui",p.PlayerGui)
g.Name="EnhancedAutoShop"
g.ResetOnSpawn=false

local m=Instance.new("Frame",g)
m.Size=UDim2.new(0,400,0,500)
m.Position=UDim2.new(0,20,0,20)
m.BackgroundColor3=Color3.fromRGB(15,15,20)
m.BorderSizePixel=0
m.Draggable=true
m.Active=true

local mc=Instance.new("UICorner",m)
mc.CornerRadius=UDim.new(0,12)

local shadow=Instance.new("Frame",m)
shadow.Size=UDim2.new(1,8,1,8)
shadow.Position=UDim2.new(0,-4,0,4)
shadow.BackgroundColor3=Color3.fromRGB(0,0,0)
shadow.BackgroundTransparency=0.6
shadow.ZIndex=-1
local shadowc=Instance.new("UICorner",shadow)
shadowc.CornerRadius=UDim.new(0,12)

local header=Instance.new("Frame",m)
header.Size=UDim2.new(1,0,0,50)
header.BackgroundColor3=Color3.fromRGB(25,25,35)
local headerc=Instance.new("UICorner",header)
headerc.CornerRadius=UDim.new(0,12)

local title=Instance.new("TextLabel",header)
title.Size=UDim2.new(1,-60,1,0)
title.Position=UDim2.new(0,15,0,0)
title.BackgroundTransparency=1
title.Text="🌟 Enhanced Auto Shop"
title.TextColor3=Color3.fromRGB(255,255,255)
title.TextSize=18
title.Font=Enum.Font.GothamBold
title.TextXAlignment=Enum.TextXAlignment.Left

local status=Instance.new("TextLabel",header)
status.Size=UDim2.new(0,80,0,20)
status.Position=UDim2.new(1,-90,0,5)
status.BackgroundColor3=Color3.fromRGB(0,150,50)
status.Text="● ACTIVE"
status.TextColor3=Color3.fromRGB(255,255,255)
status.TextSize=10
status.Font=Enum.Font.GothamBold
local statusc=Instance.new("UICorner",status)
statusc.CornerRadius=UDim.new(0,10)

local minimize=Instance.new("TextButton",header)
minimize.Size=UDim2.new(0,30,0,30)
minimize.Position=UDim2.new(1,-40,0,10)
minimize.BackgroundColor3=Color3.fromRGB(60,60,70)
minimize.Text="-"
minimize.TextColor3=Color3.fromRGB(255,255,255)
minimize.TextSize=16
minimize.Font=Enum.Font.GothamBold
local minc=Instance.new("UICorner",minimize)
minc.CornerRadius=UDim.new(0,8)

local tabContainer=Instance.new("Frame",m)
tabContainer.Size=UDim2.new(1,0,0,40)
tabContainer.Position=UDim2.new(0,0,0,50)
tabContainer.BackgroundColor3=Color3.fromRGB(20,20,25)

local tabLayout=Instance.new("UIListLayout",tabContainer)
tabLayout.FillDirection=Enum.FillDirection.Horizontal
tabLayout.SortOrder=Enum.SortOrder.LayoutOrder

local content=Instance.new("Frame",m)
content.Size=UDim2.new(1,0,1,-90)
content.Position=UDim2.new(0,0,0,90)
content.BackgroundTransparency=1

local tabs={}
local currentTab=nil
local minimized=false

local config={
collect=false,
autoSell=false,
autoPlant=false,
autoEvent=false,
selectedPlants={},
petEggs={},
gears={},
seeds={},
petFeeding={}
}

local configFile="EnhancedAutoShopConfig.json"

local function saveConfig()
writefile(configFile,HS:JSONEncode(config))
end

local function loadConfig()
if isfile(configFile) then
local success,data=pcall(function()
return HS:JSONDecode(readfile(configFile))
end)
if success and data then
for k,v in pairs(data) do
config[k]=v
end
end
end
end

local function createTab(name,icon,order)
local tab=Instance.new("TextButton",tabContainer)
tab.Size=UDim2.new(0.25,0,1,0)
tab.BackgroundColor3=Color3.fromRGB(30,30,40)
tab.Text=icon.." "..name
tab.TextColor3=Color3.fromRGB(180,180,190)
tab.TextSize=12
tab.Font=Enum.Font.GothamSemibold
tab.LayoutOrder=order
local tabc=Instance.new("UICorner",tab)
tabc.CornerRadius=UDim.new(0,8)

local tabContent=Instance.new("ScrollingFrame",content)
tabContent.Size=UDim2.new(1,0,1,0)
tabContent.BackgroundTransparency=1
tabContent.ScrollBarThickness=6
tabContent.ScrollBarImageColor3=Color3.fromRGB(80,80,90)
tabContent.Visible=false
tabContent.CanvasSize=UDim2.new(0,0,0,0)

local layout=Instance.new("UIListLayout",tabContent)
layout.Padding=UDim.new(0,10)
layout.SortOrder=Enum.SortOrder.LayoutOrder

layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
tabContent.CanvasSize=UDim2.new(0,0,0,layout.AbsoluteContentSize.Y+20)
end)

tabs[name]={button=tab,content=tabContent,layout=layout}

tab.MouseButton1Click:Connect(function()
for _,t in pairs(tabs) do
t.button.BackgroundColor3=Color3.fromRGB(30,30,40)
t.button.TextColor3=Color3.fromRGB(180,180,190)
t.content.Visible=false
end
tab.BackgroundColor3=Color3.fromRGB(50,50,65)
tab.TextColor3=Color3.fromRGB(255,255,255)
tabContent.Visible=true
currentTab=name
end)

return tabContent
end

local function createSection(parent,title,height)
local section=Instance.new("Frame",parent)
section.Size=UDim2.new(1,-20,0,height)
section.BackgroundColor3=Color3.fromRGB(25,25,35)
local sectionc=Instance.new("UICorner",section)
sectionc.CornerRadius=UDim.new(0,10)

local sectionTitle=Instance.new("TextLabel",section)
sectionTitle.Size=UDim2.new(1,-20,0,25)
sectionTitle.Position=UDim2.new(0,10,0,5)
sectionTitle.BackgroundTransparency=1
sectionTitle.Text=title
sectionTitle.TextColor3=Color3.fromRGB(200,200,210)
sectionTitle.TextSize=14
sectionTitle.Font=Enum.Font.GothamBold
sectionTitle.TextXAlignment=Enum.TextXAlignment.Left

return section
end

local function createToggleButton(parent,text,pos,size,callback)
local btn=Instance.new("TextButton",parent)
btn.Size=size
btn.Position=pos
btn.BackgroundColor3=Color3.fromRGB(50,50,60)
btn.Text=text
btn.TextColor3=Color3.fromRGB(255,255,255)
btn.TextSize=11
btn.Font=Enum.Font.GothamSemibold
local btnc=Instance.new("UICorner",btn)
btnc.CornerRadius=UDim.new(0,8)
local btns=Instance.new("UIStroke",btn)
btns.Color=Color3.fromRGB(80,80,90)
btns.Thickness=1

btn.MouseButton1Click:Connect(callback)
return btn,btns
end

local function updateButton(btn,stroke,active,onText,offText)
btn.Text=active and onText or offText
btn.BackgroundColor3=active and Color3.fromRGB(0,120,50) or Color3.fromRGB(50,50,60)
stroke.Color=active and Color3.fromRGB(0,150,70) or Color3.fromRGB(80,80,90)
end

local automationTab=createTab("Automation","⚙️",1)
local shopTab=createTab("Shop","🛒",2)
local plantsTab=createTab("Plants","🌱",3)
local petsTab=createTab("Pets","🐾",4)

local mainSection=createSection(automationTab,"🎮 Main Controls",120)

local collectBtn,collectStroke=createToggleButton(mainSection,"📦 Collect: OFF",UDim2.new(0,10,0,35),UDim2.new(0.48,0,0,25),function()
config.collect=not config.collect
updateButton(collectBtn,collectStroke,config.collect,"📦 Collect: ON","📦 Collect: OFF")
if config.collect then task.spawn(collectLoop) end
saveConfig()
end)

local sellBtn,sellStroke=createToggleButton(mainSection,"💰 Auto Sell: OFF",UDim2.new(0.52,0,0,35),UDim2.new(0.48,0,0,25),function()
config.autoSell=not config.autoSell
updateButton(sellBtn,sellStroke,config.autoSell,"💰 Auto Sell: ON","💰 Auto Sell: OFF")
if config.autoSell then task.spawn(autoSellLoop) end
saveConfig()
end)

local plantBtn,plantStroke=createToggleButton(mainSection,"🌿 Auto Plant: OFF",UDim2.new(0,10,0,65),UDim2.new(0.48,0,0,25),function()
config.autoPlant=not config.autoPlant
updateButton(plantBtn,plantStroke,config.autoPlant,"🌿 Auto Plant: ON","🌿 Auto Plant: OFF")
saveConfig()
end)

local eventBtn,eventStroke=createToggleButton(mainSection,"🍓 Auto Event: OFF",UDim2.new(0.52,0,0,65),UDim2.new(0.48,0,0,25),function()
config.autoEvent=not config.autoEvent
updateButton(eventBtn,eventStroke,config.autoEvent,"🍓 Auto Event: ON","🍓 Auto Event: OFF")
if config.autoEvent then task.spawn(eventLoop) end
saveConfig()
end)

local statsSection=createSection(automationTab,"📊 Statistics",80)
local statsText=Instance.new("TextLabel",statsSection)
statsText.Size=UDim2.new(1,-20,1,-30)
statsText.Position=UDim2.new(0,10,0,25)
statsText.BackgroundTransparency=1
statsText.Text="Items Collected: 0\nItems Sold: 0\nSeeds Planted: 0"
statsText.TextColor3=Color3.fromRGB(180,180,190)
statsText.TextSize=12
statsText.Font=Enum.Font.GothamMedium
statsText.TextXAlignment=Enum.TextXAlignment.Left
statsText.TextYAlignment=Enum.TextYAlignment.Top

local gearSection=createSection(shopTab,"⚙️ Auto Buy Gears",200)
local gearScroll=Instance.new("ScrollingFrame",gearSection)
gearScroll.Size=UDim2.new(1,-20,1,-35)
gearScroll.Position=UDim2.new(0,10,0,30)
gearScroll.BackgroundColor3=Color3.fromRGB(20,20,25)
gearScroll.ScrollBarThickness=6
gearScroll.ScrollBarImageColor3=Color3.fromRGB(60,60,70)
local gearScrollc=Instance.new("UICorner",gearScroll)
gearScrollc.CornerRadius=UDim.new(0,8)

local gearLayout=Instance.new("UIListLayout",gearScroll)
gearLayout.Padding=UDim.new(0,5)
gearLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
gearScroll.CanvasSize=UDim2.new(0,0,0,gearLayout.AbsoluteContentSize.Y+10)
end)

local seedSection=createSection(shopTab,"🌱 Auto Buy Seeds",200)
local seedScroll=Instance.new("ScrollingFrame",seedSection)
seedScroll.Size=UDim2.new(1,-20,1,-35)
seedScroll.Position=UDim2.new(0,10,0,30)
seedScroll.BackgroundColor3=Color3.fromRGB(20,20,25)
seedScroll.ScrollBarThickness=6
seedScroll.ScrollBarImageColor3=Color3.fromRGB(60,60,70)
local seedScrollc=Instance.new("UICorner",seedScroll)
seedScrollc.CornerRadius=UDim.new(0,8)

local seedLayout=Instance.new("UIListLayout",seedScroll)
seedLayout.Padding=UDim.new(0,5)
seedLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
seedScroll.CanvasSize=UDim2.new(0,0,0,seedLayout.AbsoluteContentSize.Y+10)
end)

local plantSection=createSection(plantsTab,"🌾 Plant Collection",300)
local plantScroll=Instance.new("ScrollingFrame",plantSection)
plantScroll.Size=UDim2.new(1,-20,1,-35)
plantScroll.Position=UDim2.new(0,10,0,30)
plantScroll.BackgroundColor3=Color3.fromRGB(20,20,25)
plantScroll.ScrollBarThickness=6
plantScroll.ScrollBarImageColor3=Color3.fromRGB(60,60,70)
local plantScrollc=Instance.new("UICorner",plantScroll)
plantScrollc.CornerRadius=UDim.new(0,8)

local plantLayout=Instance.new("UIListLayout",plantScroll)
plantLayout.Padding=UDim.new(0,5)
plantLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
plantScroll.CanvasSize=UDim2.new(0,0,0,plantLayout.AbsoluteContentSize.Y+10)
end)

local petSection=createSection(petsTab,"🥚 Pet Eggs",200)
local petScroll=Instance.new("ScrollingFrame",petSection)
petScroll.Size=UDim2.new(1,-20,1,-35)
petScroll.Position=UDim2.new(0,10,0,30)
petScroll.BackgroundColor3=Color3.fromRGB(20,20,25)
petScroll.ScrollBarThickness=6
petScroll.ScrollBarImageColor3=Color3.fromRGB(60,60,70)
local petScrollc=Instance.new("UICorner",petScroll)
petScrollc.CornerRadius=UDim.new(0,8)

local petLayout=Instance.new("UIListLayout",petScroll)
petLayout.Padding=UDim.new(0,5)
petLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
petScroll.CanvasSize=UDim2.new(0,0,0,petLayout.AbsoluteContentSize.Y+10)
end)

local feedSection=createSection(petsTab,"🍖 Auto Feed Pets",150)

local plot=nil
for _,f in pairs(workspace.Farm:GetChildren())do
local d=f:FindFirstChild("Important")
local o=d and d:FindFirstChild("Data") and d.Data:FindFirstChild("Owner")
if o and o.Value==p.Name then plot=d break end
end

local stats={collected=0,sold=0,planted=0}

function collectLoop()
while config.collect do
local count=0
if plot then
for _,pl in pairs(plot.Plants_Physical:GetChildren())do
if pl:IsA("Model") and config.selectedPlants[pl.Name] then
local f=pl:FindFirstChild("Fruits")
if f then
for _,v in pairs(f:GetChildren())do
game.ReplicatedStorage.ByteNetReliable:FireServer(buffer.fromstring("\001\001\000\001"),{v})
count=count+1
stats.collected=stats.collected+1
if count>=50 then break end
RS.Heartbeat:Wait()
end
else
game.ReplicatedStorage.ByteNetReliable:FireServer(buffer.fromstring("\001\001\000\001"),{pl})
count=count+1
stats.collected=stats.collected+1
if count>=50 then break end
RS.Heartbeat:Wait()
end
end
if count>=50 then break end
end
end
statsText.Text="Items Collected: "..stats.collected.."\nItems Sold: "..stats.sold.."\nSeeds Planted: "..stats.planted
task.wait(3)
end
end

function autoSellLoop()
while config.autoSell do
game.ReplicatedStorage.GameEvents.Sell_Inventory:FireServer()
stats.sold=stats.sold+1
statsText.Text="Items Collected: "..stats.collected.."\nItems Sold: "..stats.sold.."\nSeeds Planted: "..stats.planted
task.wait(1)
end
end

function eventLoop()
while config.autoEvent do
local found=false
for _,v in pairs(workspace.Interaction.UpdateItems.SummerHarvestEvent.Sign:GetDescendants())do
if v:IsA("TextLabel") and v.Text:find("Summer Harvest Ends:") then
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
RS.Heartbeat:Wait()
end
end

local function createPlantButtons()
for _,btn in pairs(plantScroll:GetChildren())do
if btn:IsA("TextButton") then btn:Destroy() end
end

if not plot then return end

local plantNames={}
local seen={}
for _,pl in pairs(plot.Plants_Physical:GetChildren())do
if pl:IsA("Model") and not seen[pl.Name] then
seen[pl.Name]=true
table.insert(plantNames,pl.Name)
end
end

for _,name in pairs(plantNames)do
local btn=Instance.new("TextButton",plantScroll)
btn.Size=UDim2.new(1,-10,0,30)
btn.BackgroundColor3=config.selectedPlants[name] and Color3.fromRGB(0,120,50) or Color3.fromRGB(40,40,50)
btn.Text="🌱 "..name..": "..(config.selectedPlants[name] and "ON" or "OFF")
btn.TextColor3=Color3.fromRGB(255,255,255)
btn.TextSize=12
btn.Font=Enum.Font.GothamMedium
btn.TextXAlignment=Enum.TextXAlignment.Left
local btnc=Instance.new("UICorner",btn)
btnc.CornerRadius=UDim.new(0,8)
local btns=Instance.new("UIStroke",btn)
btns.Color=config.selectedPlants[name] and Color3.fromRGB(0,150,70) or Color3.fromRGB(70,70,80)
btns.Thickness=1

btn.MouseButton1Click:Connect(function()
config.selectedPlants[name]=not config.selectedPlants[name]
updateButton(btn,btns,config.selectedPlants[name],"🌱 "..name..": ON","🌱 "..name..": OFF")
saveConfig()
end)
end
end

task.spawn(function()
local gearShop=p.PlayerGui:WaitForChild("Gear_Shop")
local gearFrame=gearShop.Frame.ScrollingFrame
local gearEvent=game.ReplicatedStorage.GameEvents.BuyGearStock

for _,item in pairs(gearFrame:GetChildren())do
if item:IsA("Frame") and item:FindFirstChild("Frame") then
local frame2=item.Frame
local buySection=frame2:FindFirstChild("Sheckles_Buy")
local stockLabel=buySection and buySection:FindFirstChild("In_Stock")
if stockLabel then
local btn=Instance.new("TextButton",gearScroll)
btn.Size=UDim2.new(1,-10,0,30)
btn.BackgroundColor3=config.gears[item.Name] and Color3.fromRGB(0,120,50) or Color3.fromRGB(40,40,50)
btn.Text="⚙️ "..item.Name..": "..(config.gears[item.Name] and "ON" or "OFF")
btn.TextColor3=Color3.fromRGB(255,255,255)
btn.TextSize=12
btn.Font=Enum.Font.GothamMedium
btn.TextXAlignment=Enum.TextXAlignment.Left
local btnc=Instance.new("UICorner",btn)
btnc.CornerRadius=UDim.new(0,8)
local btns=Instance.new("UIStroke",btn)
btns.Color=config.gears[item.Name] and Color3.fromRGB(0,150,70) or Color3.fromRGB(70,70,80)
btns.Thickness=1

btn.MouseButton1Click:Connect(function()
config.gears[item.Name]=not config.gears[item.Name]
updateButton(btn,btns,config.gears[item.Name],"⚙️ "..item.Name..": ON","⚙️ "..item.Name..": OFF")
saveConfig()
end)

task.spawn(function()
while true do
if config.gears[item.Name] and stockLabel.Visible then
gearEvent:FireServer(item.Name)
end
task.wait(0.2)
end
end)
end
end
end
end)

task.spawn(function()
local seedShop=p.PlayerGui:WaitForChild("Seed_Shop")
local seedFrame=seedShop.Frame.ScrollingFrame
local seedEvent=game.ReplicatedStorage.GameEvents.BuySeedStock

for _,item in pairs(seedFrame:GetChildren())do
if item:IsA("Frame") and item:FindFirstChild("Frame") then
local frame2=item.Frame
local buySection=frame2:FindFirstChild("Sheckles_Buy")
local stockLabel=buySection and buySection:FindFirstChild("In_Stock")
if stockLabel then
local btn=Instance.new("TextButton",seedScroll)
btn.Size=UDim2.new(1,-10,0,30)
btn.BackgroundColor3=config.seeds[item.Name] and Color3.fromRGB(0,120,50) or Color3.fromRGB(40,40,50)
btn.Text="🌱 "..item.Name..": "..(config.seeds[item.Name] and "ON" or "OFF")
btn.TextColor3=Color3.fromRGB(255,255,255)
btn.TextSize=12
btn.Font=Enum.Font.GothamMedium
btn.TextXAlignment=Enum.TextXAlignment.Left
local btnc=Instance.new("UICorner",btn)
btnc.CornerRadius=UDim.new(0,8)
local btns=Instance.new("UIStroke",btn)
btns.Color=config.seeds[item.Name] and Color3.fromRGB(0,150,70) or Color3.fromRGB(70,70,80)
btns.Thickness=1

btn.MouseButton1Click:Connect(function()
config.seeds[item.Name]=not config.seeds[item.Name]
updateButton(btn,btns,config.seeds[item.Name],"🌱 "..item.Name..": ON","🌱 "..item.Name..": OFF")
saveConfig()
end)

task.spawn(function()
while true do
if config.seeds[item.Name] and stockLabel.Visible then
seedEvent:FireServer(item.Name)
end
task.wait(0.2)
end
end)
end
end
end
end)

local petEggs=require(game.ReplicatedStorage.Data.PetRegistry).PetEggs
local petEvent=game.ReplicatedStorage.GameEvents.BuyPetEgg

for eggName in pairs(petEggs)do
local btn=Instance.new("TextButton",petScroll)
btn.Size=UDim2.new(1,-10,0,30)
btn.BackgroundColor3=config.petEggs[eggName] and Color3.fromRGB(0,120,50) or Color3.fromRGB(40,40,50)
btn.Text="🥚 "..eggName..": "..(config.petEggs[eggName] and "ON" or "OFF")
btn.TextColor3=Color3.fromRGB(255,255,255)
btn.TextSize=12
btn.Font=Enum.Font.GothamMedium
btn.TextXAlignment=Enum.TextXAlignment.Left
local btnc=Instance.new("UICorner",btn)
btnc.CornerRadius=UDim.new(0,8)
local btns=Instance.new("UIStroke",btn)
btns.Color=config.petEggs[eggName] and Color3.fromRGB(0,150,70) or Color3.fromRGB(70,70,80)
btns.Thickness=1

btn.MouseButton1Click:Connect(function()
config.petEggs[eggName]=not config.petEggs[eggName]
updateButton(btn,btns,config.petEggs[eggName],"🥚 "..eggName..": ON","🥚 "..eggName..": OFF")
if config.petEggs[eggName] then
task.spawn(function()
while config.petEggs[eggName] do
local data=require(game.ReplicatedStorage.Modules.DataService):GetData()
for i,v in pairs(data.PetEggStock.Stocks)do
if config.petEggs[eggName] and petEggs[v.EggName] and v.EggName==eggName and v.Stock>0 then
petEvent:FireServer(i)
end
end
task.wait(0.1)
end
end)
end
saveConfig()
end)
end

task.spawn(function()
local petsUI=p.PlayerGui:WaitForChild("ActivePetUI")
local petsFrame=petsUI.Frame.Main.ScrollingFrame
local feedEvent=game.ReplicatedStorage.GameEvents.ActivePetService

for _,petFrame in pairs(petsFrame:GetChildren())do
if petFrame.Name:match("^%b{}$") and petFrame:FindFirstChild("PetStats") then
local stats=petFrame.PetStats
local btn=Instance.new("TextButton",feedSection)
btn.Size=UDim2.new(1,-20,0,25)
btn.Position=UDim2.new(0,10,0,30+(#feedSection:GetChildren()-1)*30)
btn.BackgroundColor3=config.petFeeding[petFrame.Name] and Color3.fromRGB(0,120,50) or Color3.fromRGB(40,40,50)
btn.Text="🍖 Pet "..petFrame.Name:sub(2,-2)..": "..(config.petFeeding[petFrame.Name] and "ON" or "OFF")
btn.TextColor3=Color3.fromRGB(255,255,255)
btn.TextSize=11
btn.Font=Enum.Font.GothamMedium
btn.TextXAlignment=Enum.TextXAlignment.Left
local btnc=Instance.new("UICorner",btn)
btnc.CornerRadius=UDim.new(0,8)
local btns=Instance.new("UIStroke",btn)
btns.Color=config.petFeeding[petFrame.Name] and Color3.fromRGB(0,150,70) or Color3.fromRGB(70,70,80)
btns.Thickness=1

btn.MouseButton1Click:Connect(function()
config.petFeeding[petFrame.Name]=not config.petFeeding[petFrame.Name]
updateButton(btn,btns,config.petFeeding[petFrame.Name],"🍖 Pet "..petFrame.Name:sub(2,-2)..": ON","🍖 Pet "..petFrame.Name:sub(2,-2)..": OFF")
if config.petFeeding[petFrame.Name] then
task.spawn(function()
while config.petFeeding[petFrame.Name] do
for _,tool in pairs(p.Backpack:GetChildren())do
if tool:IsA("Tool") and tool.Name:find("%[.+kg%]") then
tool.Parent=p.Character
end
end
feedEvent:FireServer("Feed",petFrame.Name)
RS.Heartbeat:Wait()
end
end)
end
saveConfig()
end)
end
end
end)

p.CharacterAdded:Connect(function(char)
char.ChildAdded:Connect(function(child)
if child:IsA("Tool") and config.autoPlant then
local rawname=child.Name
local seedname=rawname:gsub(" Seed %[X%d+%]",""):gsub(" Seed","")
if plot then
local plants=plot:FindFirstChild("Plants_Physical")
if plants then
local plant=plants:FindFirstChild(seedname)
if plant and plant.PrimaryPart then
local pos=plant.PrimaryPart.Position
task.spawn(function()
while config.autoPlant and char:FindFirstChildOfClass("Tool") do
local tool=char:FindFirstChildOfClass("Tool")
if not tool or not tool.Name:find(seedname) then break end
game.ReplicatedStorage.GameEvents.Plant_RE:FireServer(pos,seedname)
stats.planted=stats.planted+1
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
p.Character.ChildAdded:Connect(function(child)
if child:IsA("Tool") and config.autoPlant then
local rawname=child.Name
local seedname=rawname:gsub(" Seed %[X%d+%]",""):gsub(" Seed","")
if plot then
local plants=plot:FindFirstChild("Plants_Physical")
if plants then
local plant=plants:FindFirstChild(seedname)
if plant and plant.PrimaryPart then
local pos=plant.PrimaryPart.Position
task.spawn(function()
while config.autoPlant and p.Character:FindFirstChildOfClass("Tool") do
local tool=p.Character:FindFirstChildOfClass("Tool")
if not tool or not tool.Name:find(seedname) then break end
game.ReplicatedStorage.GameEvents.Plant_RE:FireServer(pos,seedname)
stats.planted=stats.planted+1
task.wait(0.1)
end
end)
end
end
end
end
end)
end

minimize.MouseButton1Click:Connect(function()
minimized=not minimized
if minimized then
m:TweenSize(UDim2.new(0,400,0,50),"Out","Quad",0.3)
minimize.Text="+"
tabContainer.Visible=false
content.Visible=false
else
tabContainer.Visible=true
content.Visible=true
m:TweenSize(UDim2.new(0,400,0,500),"Out","Quad",0.3)
minimize.Text="-"
end
end)

loadConfig()
updateButton(collectBtn,collectStroke,config.collect,"📦 Collect: ON","📦 Collect: OFF")
updateButton(sellBtn,sellStroke,config.autoSell,"💰 Auto Sell: ON","💰 Auto Sell: OFF")
updateButton(plantBtn,plantStroke,config.autoPlant,"🌿 Auto Plant: ON","🌿 Auto Plant: OFF")
updateButton(eventBtn,eventStroke,config.autoEvent,"🍓 Auto Event: ON","🍓 Auto Event: OFF")

createPlantButtons()

tabs["Automation"].button.BackgroundColor3=Color3.fromRGB(50,50,65)
tabs["Automation"].button.TextColor3=Color3.fromRGB(255,255,255)
tabs["Automation"].content.Visible=true
currentTab="Automation"

if config.collect then task.spawn(collectLoop) end
if config.autoSell then task.spawn(autoSellLoop) end
if config.autoEvent then task.spawn(eventLoop) end

local credits=Instance.new("TextLabel",m)
credits.Size=UDim2.new(1,0,0,15)
credits.Position=UDim2.new(0,0,1,-20)
credits.BackgroundTransparency=1
credits.Text="✨ Enhanced by OneCreatorX"
credits.TextColor3=Color3.fromRGB(120,120,130)
credits.TextSize=10
credits.Font=Enum.Font.GothamMedium
credits.TextXAlignment=Enum.TextXAlignment.Center

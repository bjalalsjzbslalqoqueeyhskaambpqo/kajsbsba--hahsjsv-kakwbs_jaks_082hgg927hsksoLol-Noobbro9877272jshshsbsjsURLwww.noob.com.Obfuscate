local UL = loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX/OneCreatorX/main/UIs/MyLibrery.lua"))()

local gameName = ""
if gameName == "" then
    gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
end

local function cleanGameName(name)
    name = name:gsub("%b[]", "")
    name = name:match("^[^:]*")
    return name:match("^%s*(.-)%s*$")
end

gameName = cleanGameName(gameName)

local p = game.Players.LocalPlayer
local sg = UL:CrSG("Default")
local frm, cfrm, crFrm = UL:CrFrm(sg, gameName)



a = false
UL:AddTBtn(cfrm, "Auto Block Point", false, function(state)
a = not a

while a do

for _, obj in ipairs(workspace:GetChildren()) do
    if obj.Name == "PointBlock" then

local plr = game.Players.LocalPlayer
firetouchinterest(plr.Character.HumanoidRootPart, obj, 0)
        wait(0.1)
        firetouchinterest(plr.Character.HumanoidRootPart, obj, 1)
end end
wait(0.1)
end
wait(1)
 end)

b = false
UL:AddTBtn(cfrm, "Auto Bubble Point", false, function(state)
b = not b

while b do
local function clickButton(btn)
    local pos = btn.AbsolutePosition
    local size = btn.AbsoluteSize
    local centerX = pos.X + size.X / 0.6
    local centerY = pos.Y + size.Y / 0.7
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(centerX, centerY, 0, true, game, 1)
    wait(0.05)
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(centerX, centerY, 0, false, game, 1)
end

local playerGui = game:GetService("Players").LocalPlayer.PlayerGui
local freePointsButton = playerGui:FindFirstChild("Game")
    and playerGui.Game:FindFirstChild("Main")
    and playerGui.Game.Main:FindFirstChild("FreePoints")
    and playerGui.Game.Main.FreePoints:FindFirstChild("Over")
    and playerGui.Game.Main.FreePoints.Over:FindFirstChild("PointsToGive")

if freePointsButton then
    clickButton(freePointsButton)
else
    
    wait(1) 
end
wait(0.1)
end
 end)


local targetColor = Color3.fromRGB(255, 255, 0)
local targetMaterial = Enum.Material.Neon


local function findPartInWorkspace()
    for _, child in ipairs(workspace:GetDescendants()) do
        if child:IsA("Part") and child.Name == "Part" then
            if child.Color == targetColor and child.Material == targetMaterial and game.Players.LocalPlayer.PlayerGui.Game.Main.Counters["x10Counter"].Text == "0:00" then
                
local plr = game.Players.LocalPlayer
firetouchinterest(plr.Character.HumanoidRootPart, child, 0)
        wait(0.4)
        firetouchinterest(plr.Character.HumanoidRootPart, child, 1)
                wait(3)
            end
        end
    end
end

j = false
UL:AddTBtn(cfrm, "Auto Obby", false, function(state)
j = not j

while j do


findPartInWorkspace()

wait(5)
end
wait(0.1)
 end)



UL:AddText(crFrm, "By Script: OneCreatorX ")
UL:AddText(crFrm, "Create Script: 03/07/24")
UL:AddText(crFrm, "Update Script: --/--/--")
UL:AddText(crFrm, "Script Version: 0.1")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)

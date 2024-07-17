local UL = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/MyLibrery.lua"))()

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



local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local plot1 = workspace.Plots.Plot1

local function findTargetPart(parent)
    local closestPart = nil
    local closestDistance = math.huge
    local foundTarget = false
    for _, child in ipairs(parent:GetDescendants()) do
        if child:IsA("BasePart") and child.Name == "TouchCollider" then
            local parentPart = child.Parent
            if parentPart:IsA("BasePart") and parentPart.Transparency == 0 then
                local color = parentPart.Color
                if color == Color3.fromRGB(0, 180, 180) or color == Color3.fromRGB(108, 195, 67) then
                    local distance = (Players.LocalPlayer.Character.HumanoidRootPart.Position - child.Position).magnitude
                    if distance < closestDistance then
                        closestPart = child
                        closestDistance = distance
                    end
                    foundTarget = true
                end
            end
        end
    end

    if not foundTarget then
        for _, child in ipairs(parent:GetDescendants()) do
            if child:IsA("BasePart") and child.Name == "ATM_Button" then
                if child.Transparency == 0 then
                    local distance = (Players.LocalPlayer.Character.HumanoidRootPart.Position - child.Position).magnitude
                    if distance < closestDistance then
                        closestPart = child
                        closestDistance = distance
                    end
                end
            end
        end
    end

    return closestPart
end

local function movePlayerTo(targetPosition)
    local humanoidRootPart = Players.LocalPlayer.Character.HumanoidRootPart
    local distance = (targetPosition - humanoidRootPart.Position).magnitude

    local duration = distance / 20

    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
    local goal = {}
    goal.CFrame = CFrame.new(targetPosition)

    local tween = TweenService:Create(humanoidRootPart, tweenInfo, goal)
    tween:Play()
end


UL:AddTBtn(cfrm, "Auto Buttons", false, function() 
a = not a
while a do

local targetPart = findTargetPart(plot1)

if targetPart then
    movePlayerTo(targetPart.Position)
else
   
end
wait(1)
end
end)

UL:AddText(crFrm, "By Script: OneCreatorX ")
UL:AddText(crFrm, "Create Script: 17/07/24 ")
UL:AddText(crFrm, "Update Script: --/--/--")
UL:AddText(crFrm, "Script Version: 0.1")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)

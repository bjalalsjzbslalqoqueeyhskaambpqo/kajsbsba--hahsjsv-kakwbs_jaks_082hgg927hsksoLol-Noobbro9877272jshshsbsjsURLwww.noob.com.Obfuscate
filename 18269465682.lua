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
local PathfindingService = game:GetService("PathfindingService")
local player = Players.LocalPlayer

local function findClosestHeart()
    local closestHeart = nil
    local shortestDistance = math.huge
    local playerPosition = player.Character.HumanoidRootPart.Position

    for _, descendant in ipairs(workspace.VIPHearts:GetChildren()) do
        if descendant:IsA("BasePart") and descendant.Name == "Heart" then
            local distance = (descendant.Position - playerPosition).Magnitude
            if distance < shortestDistance then
                closestHeart = descendant
                shortestDistance = distance
            end
        end
    end

    return closestHeart
end

local function moveToHeart()
    local closestHeart = findClosestHeart()
    if closestHeart then
        local humanoid = player.Character.Humanoid
        humanoid:MoveTo(closestHeart.Position)
    else
    end
end

UL:AddTBtn(cfrm, "Auto Walk-Collect", false, function(state) 

a = not a
while a do
moveToHeart()
wait(0.5)
end
 end)


UL:AddText(crFrm, "By Script: OneCreatorX ")
UL:AddText(crFrm, "Create Script: 07/07/24 ")
UL:AddText(crFrm, "Update Script: --/--/--")
UL:AddText(crFrm, "Script Version: 0.1")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)

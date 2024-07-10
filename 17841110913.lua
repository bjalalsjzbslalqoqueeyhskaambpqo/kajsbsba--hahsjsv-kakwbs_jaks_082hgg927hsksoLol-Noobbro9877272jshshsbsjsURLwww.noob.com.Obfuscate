local UL = loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX/OneCreatorX/main/UIs/MyLibrery.lua"))()

local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name:gsub("%b[]", ""):match("^[^:]*"):match("^%s*(.-)%s*$")

local p = game.Players.LocalPlayer
local sg = UL:CrSG("Default")
local frm, cfrm, crFrm = UL:CrFrm(sg, gameName)

UL:AddText(crFrm, "By Script: OneCreatorX ")
UL:AddText(crFrm, "Create Script: 17/06/24 ")
UL:AddText(crFrm, "Update Script: 28/06/24")
UL:AddText(crFrm, "Script Version: 0.5")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)

local function getHorizontalDistance(p1, p2)
    return (Vector3.new(p1.X, 0, p1.Z) - Vector3.new(p2.X, 0, p2.Z)).magnitude
end

local a = false
local ja = true
local tolerance = 25
local speed = 20
local t = 0.5
local speedp = 100

UL:AddTBtn(cfrm, "Auto Candies", false, function() 
    a = not a
    ja = true
end)

UL:AddTBox(cfrm, "Short distance range: 25", function(tolerance) 
    end)
UL:AddTBox(cfrm, "Short distance speed: 100", function(speedp) 
    end)


local function hasTwoTouchInterests(meshPart)
    local touchInterestCount = 0
    for _, child in ipairs(meshPart:GetChildren()) do
        if child:IsA("TouchTransmitter") then
            touchInterestCount = touchInterestCount + 1
        end
    end
    return touchInterestCount == 2
end

local function findNearestCoin()
    local nearest, minDist = nil, math.huge
    for _, coin in pairs(workspace["CollectableItem(s)"]:GetDescendants()) do
        if coin:IsA("MeshPart") and hasTwoTouchInterests(coin) and a then
            local dist = getHorizontalDistance(p.Character.HumanoidRootPart.Position, coin.Position)
            if dist < minDist then
                minDist, nearest = dist, coin
            end
        end
    end
    return nearest
end

local function collectCoin(player, coin)
    local humanoid = player.Character:WaitForChild("Humanoid")
    
    if coin and coin.Parent and a then
        pcall(function()
            local playerPos, coinPos = humanoid.RootPart.Position, coin.Position
            local dist = getHorizontalDistance(playerPos, coinPos)
            
            if dist <= tolerance then
           spawn(function()
humanoid.WalkToPoint = coinPos
end)     
    humanoid.WalkSpeed = speedp
ja = false
firetouchinterest(player.Character.HumanoidRootPart, coin, 0)
        wait()
        firetouchinterest(player.Character.HumanoidRootPart, coin, 1)

                ja = true

            else
                humanoid.WalkToPoint = coinPos
                humanoid.WalkSpeed = 20
            end
        end)
        wait()
    end
end
spawn(function()
for _, object in ipairs(workspace:GetChildren()) do
    if object.Name == "Terrain" and not object:IsA("Terrain") then
        object:Destroy()
    end
end
    end)

spawn(function()
local can = workspace:FindFirstChild("CandyTrees")
        if can then
can:Destroy()
        end
    end)


while true do
    local nearestCoin = findNearestCoin()
    if nearestCoin and a and ja then
spawn(function()
        collectCoin(p, nearestCoin)
end)
    end
    wait()
end
    

local UL = loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX/OneCreatorX/main/UIs/MyLibrery.lua"))()

local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name:gsub("%b[]", ""):match("^[^:]*"):match("^%s*(.-)%s*$")
local player = game.Players.LocalPlayer
local sg = UL:CrSG("Default")
local frm, cfrm, crFrm = UL:CrFrm(sg, gameName)

UL:AddText(crFrm, "By Script: OneCreatorX")
UL:AddText(crFrm, "Create Script: 02/07/24")
UL:AddText(crFrm, "Update Script: 03/07/24")
UL:AddText(crFrm, "Script Version: 0.9")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game.Players.LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)

local function getHorizontalDistance(p1, p2)
    return (Vector3.new(p1.X, 0, p1.Z) - Vector3.new(p2.X, 0, p2.Z)).magnitude
end

local allowCollecting = true



local Butterflies = false
UL:AddTBtn(cfrm, "Collect Butterflies(Yellow)", false, function() 
    Butterflies = not Butterflies
        local StarterGui = game:GetService("StarterGui")
StarterGui:SetCore("SendNotification", {
    Title = "This UGC available:",
    Text = "Today: now ready claim",
    Duration = 5,
})
end)



local function findNearestCoin()
    local nearest, minDist = nil, math.huge
    for _, coin in pairs(workspace.Collectibles:GetChildren()) do
        if coin:IsA("MeshPart") then
            local isValid = false
            if Butterflies and coin.Name == "Butterflies" then
                isValid = true
            end
            if Flowers and coin.Name == "Flowers" then
                isValid = true
            end
            if isValid then
                local dist = getHorizontalDistance(player.Character.HumanoidRootPart.Position, coin.Position)
                if dist < minDist then
                    minDist, nearest = dist, coin
                end
            end
        end
    end
    return nearest
end

local function collectCoin(player, coin)
    local humanoid = player.Character:WaitForChild("Humanoid")
    
    if coin and coin.Parent then
        pcall(function()
            local playerPos, coinPos = humanoid.RootPart.Position, coin.Position
            local dist = getHorizontalDistance(playerPos, coinPos)
            
            if dist <= 3 then
                allowCollecting = false
                spawn(function()
                    humanoid.WalkToPoint = coinPos
                end)
                player.Character.PrimaryPart.CFrame = coin.CFrame
                wait(0.4)
                allowCollecting = true
            else
                humanoid.WalkToPoint = coinPos
                humanoid.WalkSpeed = 18
            end
        end)
        wait()
    end
end

spawn(function()
    for _, ppa in pairs(workspace.Map:GetChildren()) do
        if ppa:IsA("Folder") then
            ppa:Destroy()
        end
    end
    
    for i = 1, 9 do
        local ya = workspace.Map:FindFirstChild("Meshes/sign" .. i)
        if ya then
            ya:Destroy()
        end
    end
end)

spawn(function()
    while true do
        for _, coin1 in pairs(workspace.Collectibles:GetChildren()) do
            if coin1:IsA("MeshPart") and coin1.Name == "Butterflies" then
                else
                    coin1:Destroy()
                
            end
        end
        wait(0.5)
    end
end)

while true do
    local nearestCoin = findNearestCoin()
    if nearestCoin and allowCollecting then
        spawn(function()
            collectCoin(player, nearestCoin)
        end)
    end
    wait()
end

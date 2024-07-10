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
   
    local speed = 50

local function clickButton(btn)
    local pos = btn.AbsolutePosition
    local size = btn.AbsoluteSize
    local centerX = pos.X + size.X / 1.2
    local centerY = pos.Y + size.Y / 0.5
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(centerX, centerY, 0, true, game, 1)
    wait(0.1) 
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(centerX, centerY, 0, false, game, 1)
end

local function clickButto(btn)
    local pos = btn.AbsolutePosition
    local size = btn.AbsoluteSize
    local centerX = pos.X + size.X / 0.7
    local centerY = pos.Y + size.Y / 1
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(centerX, centerY, 0, true, game, 1)
    wait(0.05)
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(centerX, centerY, 0, false, game, 1)
end

UL:AddTBtn(cfrm, "Auto Spin(real click)", s, function(d) 
 s = d
while s do
if game.Players.LocalPlayer.PlayerGui.Spinner.Main.Visible and game.Players.LocalPlayer.PlayerGui.Spinner.Main.Spin.Label.Text == "SPIN" then
clickButton(game.Players.LocalPlayer.PlayerGui.Spinner.Main.Spin.Label)
wait(0.5)
elseif not game.Players.LocalPlayer.PlayerGui.Spinner.Main.Visible then
clickButto(game.Players.LocalPlayer.PlayerGui.HUD.Bottom.MainButtons.Spinner)
wait(0.5)
else
wait(0.3)
end
end
 end)

    UL:AddTBox(cfrm, "Speed Test: 50 :", function(text) 
 speed = text
 end)
    
    UL:AddText(crFrm, "By Script: OneCreatorX ")
    UL:AddText(crFrm, "Create Script: 11/06/24 ")
    UL:AddText(crFrm, "Update Script: 16/06/24")
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
local ja = true
local a = false
    UL:AddTBtn(cfrm, "Auto Coins(beta)", false, function() 
 a = not a
ja = true
 end)


local function findNearestCoin()
    local nearest, minDist = nil, math.huge
    for _, coin in pairs(workspace.GAME.CoinCollection.CreatedCoins:GetChildren()) do
        if coin:IsA("BasePart") and coin.Transparency ~= 1 and a then
            local dist = getHorizontalDistance(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, coin.Position)
            if dist < minDist then
                minDist, nearest = dist, coin
            end
        end
    end
    return nearest
end

local function calculateVelocity(targetPos, speed)
    local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
    return (targetPos - playerPos).unit * speed
end

local function collectCoin(player, coin)
    local humanoid = player.Character:WaitForChild("Humanoid")
    local tolerance, maxDist =4, 4
    
    if coin and coin.Parent and a then
pcall(function()
        local playerPos, coinPos = humanoid.RootPart.Position, coin.Position
        local dist = getHorizontalDistance(playerPos, coinPos)
        
        if dist <= tolerance and dist <= maxDist then
            if dist > 2 then
ja = false
wait(0.5)
coin.Position = p.Character.PrimaryPart.Position
end

coin.Transparency = 1 
wait(0.5)
coin:Destroy()
ja = true
            
        else
            player.Character.HumanoidRootPart.Velocity = calculateVelocity(coinPos, speed)
        end
end)
        wait()
    end
end

local player = game.Players.LocalPlayer

game:GetService("RunService").RenderStepped:Connect(function()
    
    local nearestCoin = findNearestCoin()
    if nearestCoin and a and ja then
        collectCoin(player, nearestCoin)
             for _, obj in ipairs(game.Players.LocalPlayer.Character:GetDescendants()) do
    if obj:IsA("BasePart") then
obj.CanCollide = false
end end
            
    end
    wait()
end)

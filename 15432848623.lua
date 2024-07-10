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
    
    local Player = game.Players.LocalPlayer
    local sg = UL:CrSG("Default")
    local frm, cfrm, crFrm = UL:CrFrm(sg, gameName)
   

local autoKillMobs = false
local autoCollect = false
local autoTalkNPCs = false

local autoFarmPos = false
local autoFarmPo = false

function findNearestPopcorn()
    local nearestPopcorn = nil
    local nearestDistance = math.huge

    for _, child in ipairs(workspace:GetChildren()) do
        if child:IsA("Model") and child.Name == "Model" then
            local distance = (Player.Character.HumanoidRootPart.Position - child.PrimaryPart.Position).magnitude

            if distance < 30 and distance < nearestDistance then
                nearestPopcorn = child.PrimaryPart
                nearestDistance = distance
            end
        end
    end

    return nearestPopcorn
end

local nearestPo = nil

function po()
    while autoFarmPos and autoFarmPo do
        local popcorn = findNearestPopcorn()
        
        if popcorn then
            local Po = workspace:WaitForChild("ScriptableObjects"):WaitForChild("Resources"):GetDescendants()
            local nearestDistance = math.huge

            for _, po in ipairs(Po) do
                if po:IsA("Part") then
                    local distance = (popcorn.Position - po.Position).magnitude
                    if distance < nearestDistance and autoFarmPos then
                        nearestPo = po
                        nearestDistance = distance
                    end
                end
            end

            if nearestPo and autoFarmPos then
                fireproximityprompt(nearestPo.ProximityPrompt)

                repeat
                    wait(0.1)
                    if not autoFarmPo or not popcorn.Parent then
                        break
                    end

                    local newDistance = (Player.Character.HumanoidRootPart.Position - popcorn.Position).magnitude
                    if newDistance > 35 then
                        nearestPo = nil
                        break
                    end
                until false
            end
        else
            wait(1)
        end
    end
end

function h()
    autoFarmPos = not autoFarmPos
    autoFarmPo = not autoFarmPo
    if autoFarmPos then
        po()
    end
end

function hhh()
    autoKillMobs = not autoKillMobs
end

function Tk()
    if autoKillMobs then
        
        local enemies = workspace:WaitForChild("ScriptableObjects"):WaitForChild("Enemies"):GetDescendants()
        
        for _, enemy in ipairs(enemies) do
            if enemy:IsA("Model") and enemy.PrimaryPart then
          local args = {
    [1] = enemy,
    [2] = 50
}

game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("FireSlingshot"):FireServer(unpack(args))
      
            end
        end
    end
end

function hh()
    autoCollect = not autoCollect
end

function collect()
    if autoCollect then
        
        local player = game.Players.LocalPlayer
        local targetPosition = player.Character.HumanoidRootPart.Position

        for _, drop in ipairs(workspace._DROPS:GetChildren()) do
            if drop:IsA("Model") and drop.PrimaryPart then
                drop:SetPrimaryPartCFrame(CFrame.new(targetPosition))
                local proximityPrompt = drop.PrimaryPart:FindFirstChildOfClass("ProximityPrompt")
                if proximityPrompt then
                    fireproximityprompt(proximityPrompt)
                end
            end
        end
    end
end

function npcs()
    autoTalkNPCs = not autoTalkNPCs
    local cerca = true
    
    while autoTalkNPCs do
        task.wait()
        local player = game.Players.LocalPlayer

        for _, npc in ipairs(workspace.ScriptableObjects.NPCs:GetChildren()) do
            if npc:IsA("Model") and (npc:FindFirstChild("HumanoidRootPart") or npc:FindFirstChild("RootPart")) then
                local proximityPrompt = npc.PrimaryPart:FindFirstChildOfClass("ProximityPrompt")
                if proximityPrompt then
                    local distance = (player.Character.HumanoidRootPart.Position - npc.PrimaryPart.Position).magnitude
                    if distance < 4 and cerca then
                        fireproximityprompt(proximityPrompt)
                        cerca = false
                    elseif distance > 4 and distance < 5 and not cerca then
                        cerca = true
                    end
                end
            end
        end
    end
end

function page()
    for i = 1, 100 do
        local args = {
            [1] = "Page",
            [2] = i
        }

        game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("PickUpCollectable"):FireServer(unpack(args))
    end
end



local event = false

UL:AddTBtn(cfrm, "Auto Kill Mobs", false, function()
hhh()
end)

UL:AddTBtn(cfrm, "Auto Farm Pos", false, function()
h()
end)

UL:AddTBtn(cfrm, "Auto Collect Items", false, function()
hh()
end)

UL:AddTBtn(cfrm, "Auto Talk NPCs", false, function()
npcs()
end)

UL:AddBtn(cfrm, "Instant Page", function() page() end)
local myOptionsButton, myOptionsFrame = UL:AddOBtn(cfrm, "Events UGC")
UL:AddTBtn(myOptionsFrame, "Auto Event Ultraman", false, function() event = not event end)

    
    UL:AddText(crFrm, "By Script: OneCreatorX ")
    UL:AddText(crFrm, "Create Script: 19/06/24 ")
    UL:AddText(crFrm, "Update Script: --/--/--")
    UL:AddText(crFrm, "Script Version: 0.6")
    UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
    UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)
    
    game:GetService('Players').LocalPlayer.Idled:Connect(function()
        game:GetService('VirtualUser'):CaptureController()
        game:GetService('VirtualUser'):ClickButton2(Vector2.new())
    end)

spawn(function()
while true do
    wait(0.1)
    pcall(Tk)
    pcall(collect)
end
end)


spawn(function()
  while true do
    local ultraman = workspace:FindFirstChild("Ultraman")
    if ultraman and event then

      local player = game.Players.LocalPlayer
      if player.Character then
        local p = player.Character.PrimaryPart
        for _, drone in pairs(ultraman.DroneSwarm.Back:GetChildren()) do
pcall(function()
            p.CFrame = drone.PrimaryPart.CFrame + Vector3.new(0, 2, 0)
end)
            local args = {
              [1] = drone,
              [2] = 500
            }
            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("DroneHit"):FireServer(unpack(args))
                        wait()
end 
      end
    end

    wait(0.1)
  end
end)

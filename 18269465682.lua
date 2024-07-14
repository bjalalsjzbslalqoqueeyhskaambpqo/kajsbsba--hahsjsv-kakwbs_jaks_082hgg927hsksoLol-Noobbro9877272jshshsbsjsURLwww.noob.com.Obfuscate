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

    local function checkHearts(parent)
        for _, descendant in ipairs(parent:GetChildren()) do
            if descendant:IsA("BasePart") and descendant.Name == "Heart" then
                local distance = (descendant.Position - playerPosition).Magnitude
                if distance < shortestDistance then
                    closestHeart = descendant
                    shortestDistance = distance
                end
            end
        end
    end

    -- Check hearts in both VIPHearts and RegularHearts
    if workspace:FindFirstChild("VIPHearts") then
        checkHearts(workspace.VIPHearts)
    end

    if workspace:FindFirstChild("RegularHearts") then
        checkHearts(workspace.RegularHearts)
    end

    return closestHeart
end

local a = false

local function moveToHeart()
    local closestHeart = findClosestHeart()
    if closestHeart then
        local humanoid = player.Character.Humanoid
        local path = PathfindingService:CreatePath({
            AgentRadius = 2,
            AgentHeight = 5,
            AgentCanJump = true,
            AgentJumpHeight = 5,
            AgentMaxSlope = 20
        })

        path:ComputeAsync(player.Character.HumanoidRootPart.Position, closestHeart.Position)
        local waypoints = path:GetWaypoints()

        for _, waypoint in ipairs(waypoints) do
            humanoid:MoveTo(waypoint.Position)
            humanoid.MoveToFinished:Wait()
        end
    end
end

UL:AddTBtn(cfrm, "Auto Walk-Collect", false, function(state)
    a = not a
    while a do
        moveToHeart()
        wait(0.2)
    end
end)

p.Character.Humanoid.WalkSpeed = 25
spawn(function()
    local function destroyIfFound(name)
        local obj = workspace:FindFirstChild(name)
        if obj then
            obj:Destroy()
        else

        end
    end

    destroyIfFound("Clouds")
    destroyIfFound("cutecore!!!")
    destroyIfFound("VIPDoor")
     destroyIfFound("circles")
     destroyIfFound("Hearts Obby Stage")
     destroyIfFound("Plushies")

end)

spawn(function()
    for _, t in ipairs(workspace:GetChildren()) do
        if t.Name == "Arbusto" then
            t:Destroy()
        end
    end
end)

UL:AddText(crFrm, "By Script: OneCreatorX")
UL:AddText(crFrm, "Create Script: 14/07/24")
UL:AddText(crFrm, "Update Script: --/--/--")
UL:AddText(crFrm, "Script Version: 0.1")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)

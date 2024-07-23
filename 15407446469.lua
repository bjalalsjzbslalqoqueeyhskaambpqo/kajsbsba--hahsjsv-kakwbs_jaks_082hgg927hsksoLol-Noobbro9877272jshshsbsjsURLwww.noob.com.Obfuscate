local UL = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/MyLibrery.lua"))()

local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name:gsub("%b[]", ""):match("^[^:]*"):match("^%s*(.-)%s*$")

local p = game.Players.LocalPlayer
local sg = UL:CrSG("Default")
local frm, cfrm, crFrm = UL:CrFrm(sg, gameName)

local function createMarker()
    local m = Instance.new("Part")
    m.Size = Vector3.new(8, 0.8, 0.8)
    m.Anchored = true
    m.CanCollide = false
    m.BrickColor = BrickColor.new("Lime green")
    return m
end

local function updateMarker(d)
    local m = d:FindFirstChild("SafeMarker") or createMarker()
    m.Name = "SafeMarker"
    m.Parent = d
    m.CFrame = d.CFrame * CFrame.new(0, 5, 0)
    m.Transparency = d:FindFirstChild("IsSafe") and (d.IsSafe.Value and 0 or 1) or 1
end

local function initDoors()
    for _, s in pairs(workspace.Stages:GetChildren()) do
        local ds = s:FindFirstChild("Doors")
        if ds then
            local rnd = math.random(2)
            for _, d in pairs(ds:GetChildren()) do
                if not d:FindFirstChild("IsSafe") then
                    local is = Instance.new("BoolValue", d)
                    is.Name = "IsSafe"
                    is.Value = d.Name == (rnd == 1 and "LeftDoor" or "RightDoor")
                end
                updateMarker(d)
            end
        end
    end
end

local function getGoodDoor(stage)
    local s = workspace.Stages:FindFirstChild("Stage" .. stage)
    if not s then return nil end

    local doors = s:FindFirstChild("Doors")
    if not doors then return nil end

    for _, d in ipairs(doors:GetChildren()) do
        if d:IsA("BasePart") and d:FindFirstChild("IsSafe") and d.IsSafe.Value then
            return d
        end
    end
    return nil
end

local PathfindingService = game:GetService("PathfindingService")

local function moveToDoor(door)
    local character = p.Character
    if not character or not door then return end

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not rootPart then return end

    local path = PathfindingService:CreatePath()
    path:ComputeAsync(rootPart.Position, door.Position)

    if path.Status == Enum.PathStatus.Success then
        for _, waypoint in ipairs(path:GetWaypoints()) do
            humanoid:MoveTo(waypoint.Position)
            humanoid.MoveToFinished:Wait()
        end
        
   
        local stepForward = door.CFrame * CFrame.new(0, 0, -3)
        humanoid:MoveTo(stepForward.Position)
        wait()
    end
end

local b = false

local rj = true
local a = true

local function moveToFinalPosition()
    local winPad = workspace:WaitForChild("WinPad")
    if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and winPad and winPad:FindFirstChild("PrimaryPart") then
        firetouchinterest(p.Character:FindFirstChild("HumanoidRootPart"), winPad.PrimaryPart, 0)
                    wait()
                    firetouchinterest(p.Character:FindFirstChild("HumanoidRootPart"), winPad.PrimaryPart, 1)
        if rj then
wait(9)
            local player = game.Players.LocalPlayer
player:Kick("Rejoin")
            wait(0.2)
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
            
        end

    end
end

local function waitForReset()
    local stageValue = p:WaitForChild("Stage"):WaitForChild("Current")
    while stageValue.Value ~= 0 do
        wait(1)
    end
end

local function checkAndMove()
    if a then
        local stageValue = p:WaitForChild("Stage"):WaitForChild("Current")
        local nextStage = stageValue.Value + 1
        
        if nextStage <= 40 then
            local door = getGoodDoor(nextStage)
            if door then
                moveToDoor(door)
                wait(0.5)
                checkAndMove()
            else
                wait(0.5)
                checkAndMove()
            end
        else
            moveToFinalPosition()
            waitForReset()
        end
    end
end

UL:AddTBtn(cfrm, "Auto Doors[walk]", true, function(state) 
    a = not a
    if a then checkAndMove() end
end)


local function checkAndMov()
    if b then
        local stageValue = p:WaitForChild("Stage"):WaitForChild("Current")
        local nextStage = stageValue.Value + 1
        
        if nextStage <= 40 then
            local door = getGoodDoor(nextStage)
            if door then
                pcall(function()     
                    firetouchinterest(p.Character:FindFirstChild("HumanoidRootPart"), door, 0)
                    wait()
                    firetouchinterest(p.Character:FindFirstChild("HumanoidRootPart"), door, 1)
                end)
                wait(0.5)
                checkAndMov()
            else
                wait(0.5)
                checkAndMov()
            end
        else
            moveToFinalPosition()
            waitForReset()
        end
    end
end

UL:AddTBtn(cfrm, "Auto Doors[No TP]", false, function(state) 
    b = not b
    if b then checkAndMov() end
end)


UL:AddTBtn(cfrm, "Auto Rejoin", true, function(state) 
    rj = not rj
end)

UL:AddTBtn(cfrm, "Auto Spin", false, function() 
    b = not b
    while b do
        game:GetService("ReplicatedStorage").Remotes.Marketplace.WheelSpin:InvokeServer()
        wait(1)
    end
end)

UL:AddBtn(cfrm, "Auto Claim UGC", function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX-New/TwoDev/main/Loader.lua"))()("Auto%20Claim%20UGC")
    end)
end)

for _, info in ipairs({
    {"By Script: OneCreatorX"},
    {"Create Script: 22/07/24"},
    {"Update Script: 23/07/24"},
    {"Script Version: 0.6"},
    {"Copy link YouTube", "https://youtube.com/@onecreatorx"},
    {"Copy link Discord", "https://discord.com/invite/UNJpdJx7c4"}
}) do
    if #info == 1 then
        UL:AddText(crFrm, info[1])
    else
        UL:AddBtn(crFrm, info[1], function() setclipboard(info[2]) end)
    end
end

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
   end)
    
    spawn(function()
            checkAndMove()
        end)

initDoors()

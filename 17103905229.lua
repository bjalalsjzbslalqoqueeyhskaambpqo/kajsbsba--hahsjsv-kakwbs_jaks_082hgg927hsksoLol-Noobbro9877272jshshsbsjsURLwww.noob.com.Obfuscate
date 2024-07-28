local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()
local Win = Lib:NewWindow("Collect For UGC")
local Sec = Win:NewSection("Options")
local Sec3 = Win:NewSection("Info Script")
local Sec2 = Win:NewSection("Credits: OneCreatorX")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local b = true
local speed = 50
local ya = true

spawn(function()
    (loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX-New/TwoDev/main/Loader.lua"))())("info")
end)

local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")
local RS = game:GetService("RunService")
local WS = game:GetService("Workspace")

local function copyToClipboard(text)
    if syn then
        syn.write_clipboard(text)
    else
        setclipboard(text)
    end
end

local function collectHeart(heartPart)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local PPos = player.Character.HumanoidRootPart.Position
        local HPos = Vector3.new(heartPart.Position.X, PPos.Y, heartPart.Position.Z)
        local dist = (HPos - PPos).magnitude
        if dist < 1 then
            heartPart.Transparency = 1
            heartPart.Position = PPos
            spawn(function()
                pcall(function() 
                    wait(10)
                    heartPart.Transparency = 0
                end)
            end)
        end
    end
end

local function moveToTarget(targetPosition)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and b then
        local PPos = player.Character.HumanoidRootPart.Position
        local direction = (targetPosition - PPos).unit
        player.Character.HumanoidRootPart.Velocity = direction * speed
    end
end

local function findNearestClaimableObject()
    local player = game.Players.LocalPlayer
    if not player or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
        return nil
    end
    
    local PPos = player.Character.HumanoidRootPart.Position
    local nearestClaimable = nil
    local minDistance = math.huge

    for _, f in ipairs(workspace.Map.Interactable.MushroomHouses:GetDescendants()) do
        if f:IsA("TextLabel") and f.Text == "Claim" then
            local claimableObject = f.Parent.Parent.Parent
            local distance = (claimableObject.Position - PPos).Magnitude
            if distance < minDistance then
                minDistance = distance
                nearestClaimable = claimableObject
            end
        end
    end

    return nearestClaimable
end

local function moveHearts()
    local nearestClaimable = findNearestClaimableObject()
    if nearestClaimable then
        moveToTarget(nearestClaimable.Position)
        collectHeart(nearestClaimable)
    else
        local player = game.Players.LocalPlayer
        if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and b then
            local PPos = player.Character.HumanoidRootPart.Position
            local Hearts = WS.Map.Interactable:GetDescendants()
            
            local minDist = math.huge
            local closestHeart = nil

            for _, H in ipairs(Hearts) do
                if H:IsA("MeshPart") and H.Transparency ~= 1 then
                    local HPos = Vector3.new(H.Position.X, PPos.Y, H.Position.Z)
                    local dist = (HPos - PPos).magnitude
                    if dist < 1 then
                        collectHeart(H)
                    elseif dist < minDist then
                        minDist = dist
                        closestHeart = H
                    end
                end
            end

            if closestHeart then
                moveToTarget(closestHeart.Position)
                collectHeart(closestHeart)
            end
        end
    end
end

game:GetService("RunService").RenderStepped:Connect(function()
    pcall(moveHearts)
end)

function has()
    b = not b
    ya = not ya
end

function copyd()
    copyToClipboard("https://discord.com/invite/23kFrRBSfD")
end

function copyy()
    copyToClipboard("https://youtube.com/@OneCreatorX")
end

workspace.Camera.FieldOfView = 100

pcall(function()
    for _, f in ipairs(workspace.Map.Interactable:GetDescendants()) do
        if f.Name == "GroupChest" or f.Name == "SpinWheel" then
            f:Destroy()
        end
    end

    workspace.Map.Decorations:Destroy()
    workspace.nightLights:Destroy()
    workspace.BillboardGui:Destroy()
    workspace.Map.Leaderboards:Destroy()

    local function destroySpecificObjects(parent)
        for _, child in ipairs(parent:GetChildren()) do
            if child.ClassName == "Model" and child.Name == "Model" then
                child:Destroy()
            elseif child.ClassName == "MeshPart" and child.Name == "MeshPart" then
                child:Destroy()
            elseif child.ClassName == "Part" and child.Name == "Part" then
                child:Destroy()
            end
            destroySpecificObjects(child)
        end
    end

    for _, f in ipairs(workspace.Map.Interactable.MushroomHouses:GetDescendants()) do
        if f:IsA("Folder") and f.Name == "Other" then
            f:Destroy()
        end
    end

    destroySpecificObjects(workspace)
    workspace.Map.ugcShop:Destroy()
end)

local workspace = game:GetService("Workspace")
local mapTerrain = workspace:WaitForChild("Map"):WaitForChild("Terrain")

for _, obj in ipairs(mapTerrain:GetChildren()) do
    if not obj:IsA("Model") then
        obj:Destroy()
    end
end

local AC = Instance.new("Part")
AC.Size = Vector3.new(522.132, 34.9476, 611.233)
AC.Anchored = true
AC.CanCollide = false
AC.Shape = Enum.PartType.Cylinder
AC.Transparency = 0
AC.Color = Color3.new(0, 0, 0)
AC.Parent = parent
AC.Position = Vector3.new(-14.8902, -7.86472, 13.5819)

local skyID = "rbxassetid://15189831814"

game.Lighting.Sky.SkyboxBk = skyID
game.Lighting.Sky.SkyboxDn = skyID
game.Lighting.Sky.SkyboxFt = skyID
game.Lighting.Sky.SkyboxLf = skyID
game.Lighting.Sky.SkyboxRt = skyID
game.Lighting.Sky.SkyboxUp = skyID
local CircleMesh = Instance.new("SpecialMesh")
CircleMesh.MeshType = Enum.MeshType.Cylinder 
CircleMesh.Scale = Vector3.new(522.132, 34.9476, 611.233)
CircleMesh.Parent = AC
CircleMesh.TextureId = skyID

function sa()
end

function copyy()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX/OneCreatorX/main/Scripts/MsgDev.lua"))()
end

Sec:CreateToggle("Auto Hearts", has)
Sec:CreateButton("Store UGC", function()
    game.Players.LocalPlayer.PlayerGui.Main.mainFrame.ugcShopFrame.Visible = not game.Players.LocalPlayer.PlayerGui.Main.mainFrame.ugcShopFrame.Visible 
end)

Sec3:CreateButton("Versión 24", sa)
Sec3:CreateButton("Update: 27/07/24", sa)
Sec3:CreateButton("System 100% + Safe", sa)
Sec2:CreateButton("Copy Link YouTube", copyy)
Sec2:CreateButton("Copy Link Discord", copyd)
Sec2:CreateButton("Send Text Discord(no spawn)", copyy)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)

Sec:CreateTextbox("Speed Auto Hears 70", function(value)
    speed = value
end)

Sec:CreateTextbox("ID Texture", function(value)
    local StarterGui = game:GetService("StarterGui")
    StarterGui:SetCore("SendNotification", {
        Title = "UseID Image: 12345",
        Text = "Is Roblox Image - No URL",
        Duration = 5,
    })
    
    skyID = "rbxassetid://" .. value
    game.Lighting.Sky.SkyboxBk = skyID
    game.Lighting.Sky.SkyboxDn = skyID
    game.Lighting.Sky.SkyboxFt = skyID
    game.Lighting.Sky.SkyboxLf = skyID
    game.Lighting.Sky.SkyboxRt = skyID
    game.Lighting.Sky.SkyboxUp = skyID
    CircleMesh.TextureId = skyID
end)

local function main()
    local StarterGui = game:GetService("StarterGui")
    
    StarterGui:SetCore("SendNotification", {
        Title = "Auto Rejoin for Baibai",
        Text = "maybe 45 - 50 avoid (baibai)",
        Duration = 5,
    })

    local player = game.Players.LocalPlayer
    local b = false
    local ya = true 

    local function onLongFall()
        b = false
        player.Character.Humanoid.Health = 0
    end

    local function onCharacterAdded()
        if ya then
            StarterGui:SetCore("SendNotification", {
                Title = "Auto Start ",
                Text = "u are safe, by OneCreatorX",
                Duration = 2,
            })
            b = true
            pcall(function()
                local Players = game:GetService("Players")
                local player = Players.LocalPlayer

                local function scaleCharacter(scale)
                    local character = player.Character or player.CharacterAdded:Wait()
                    local humanoid = character:WaitForChild("Humanoid")
                    
                    if not character or not humanoid then
                        return
                    end
                    
                    local newScale = Vector3.new(scale, scale, scale)
                    
                    for _, part in pairs(character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.Size = part.Size * newScale
                        end
                    end
                    
                    local rootPart = character:FindFirstChild("HumanoidRootPart")
                    if rootPart then
                        rootPart.Position = rootPart.Position - Vector3.new(0, (1 - scale) * 3, 0)
                    end
                end

                scaleCharacter(0.4)
            end)
        else
            pcall(function()
                local Players = game:GetService("Players")
                local player = Players.LocalPlayer

                local function scaleCharacter(scale)
                    local character = player.Character or player.CharacterAdded:Wait()
                    local humanoid = character:WaitForChild("Humanoid")
                    
                    if not character or not humanoid then
                        return
                    end
                    
                    local newScale = Vector3.new(scale, scale, scale)
                    
                    for _, part in pairs(character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.Size = part.Size * newScale
                        end
                    end
                    
                    local rootPart = character:FindFirstChild("HumanoidRootPart")
                    if rootPart then
                        rootPart.Position = rootPart.Position - Vector3.new(0, (1 - scale) * 3, 0)
                    end
                end

                scaleCharacter(0.4)
            end)
        end
    end

    local function checkFreefall()
    local startTime = tick()
    local freefallDuration = 4

    local function isStillFalling()
        return player.Character and 
               player.Character:FindFirstChild("Humanoid") and 
               player.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall
    end

    while isStillFalling() do
        if tick() - startTime >= freefallDuration then
            onLongFall()
            return
        end
        wait(0.1) 
    end
end

player.Character.Humanoid.StateChanged:Connect(function(oldState, newState)
    if newState == Enum.HumanoidStateType.Freefall then
        checkFreefall()
    end
end)
    
    player.ChildAdded:Connect(function()
        task.wait(1)
        onCharacterAdded()
        player.Character.Humanoid.StateChanged:Connect(function(_, newState)
            if newState == Enum.HumanoidStateType.Freefall then
               -- checkFreefall()
            end
        end)
    end)
end

pcall(function()
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer

    local function scaleCharacter(scale)
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        if not character or not humanoid then
            return
        end
        
        local newScale = Vector3.new(scale, scale, scale)
        
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Size = part.Size * newScale
            end
        end
        
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            rootPart.Position = rootPart.Position - Vector3.new(0, (1 - scale) * 3, 0)
        end
    end

    scaleCharacter(0.4)
end)

pcall(function()
    local NetworkClient = game:GetService("NetworkClient")
    local Players = game:GetService("Players")
    local TeleportService = game:GetService("TeleportService")

    local PlaceId = game.GameId
    local localPlayer = Players.LocalPlayer

    NetworkClient.ChildRemoved:Connect(function(child)
        local PlaceId = game.PlaceId
        local JobId = game.JobId
        local TeleportService = game:GetService("TeleportService")

        if #game.Players:GetPlayers() <= 1 then
            game.Players.LocalPlayer:Kick("\nRejoining...")
            wait()

                    TeleportService:Teleport(PlaceId, game.Players.LocalPlayer)
        else
            TeleportService:TeleportToPlaceInstance(PlaceId, JobId, game.Players.LocalPlayer)
        end
    end)
end)

main()

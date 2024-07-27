local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()
local Win = Lib:NewWindow("Collect For UGC")
local Sec = Win:NewSection("Options")
local Sec3 = Win:NewSection("Info Script")
local Sec2 = Win:NewSection("Credits: OneCreatorX")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local b = true
local speed = 80
local autoRejoin = true 

local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")
local RS = game:GetService("RunService")
local WS = game:GetService("Workspace")

spawn(function()
    (loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX-New/TwoDev/main/Loader.lua"))())("info")
end)

local function copyToClipboard(text)
    if syn then
        syn.write_clipboard(text)
    else
        setclipboard(text)
    end
end

function rejoin()
    game.Players.LocalPlayer:kick("rejoin")
    wait(0.1)
    game:GetService("TeleportService"):Teleport(game.PlaceId, Player)
end

local function moveHearts()
    while b do
        local player = game.Players.LocalPlayer
        if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and b then
            local Hearts = WS.Map.Interactable:GetDescendants()
            local closestHeart, closestDistance

            for _, heart in ipairs(Hearts) do
                if heart:IsA("MeshPart") and heart.Transparency ~= 1 then
                    local distance = (player.Character.HumanoidRootPart.Position - heart.Position).magnitude
                    if not closestHeart or distance < closestDistance then
                        closestHeart = heart
                        closestDistance = distance
                    end
                end
            end


            if closestHeart then
closestHeart.Size = Vector3.new(4, 4, 4)
                player.Character:MoveTo(closestHeart.Position)
                wait(0.2)
                spawn(function()
                pcall(function()
player.Character:MoveTo(closestHeart.Position)
closestHeart.Position = game.Players.LocalPlayer.Character.PrimaryPart.Position
firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, closestHeart, 0)
        wait()
        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, closestHeart, 1)

                    end)
                    end)
                wait(0.05)
spawn(function()
                pcall(function()
                    closestHeart.Transparency = 1
                end)
                    end)
            end

            if not closestHeart and autoRejoin then
                rejoin()
            end
        end
        wait(0.3)
    end
end

function has()
    b = not b
    moveHearts()
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
        if f.Name == "MushroomHouses" or f.Name == "GroupChest" or f.Name == "SpinWheel" then
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

    
    destroySpecificObjects(workspace)
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
AC.Parent = workspace
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
Sec:CreateToggle("Auto Rejoin", function()
    autoRejoin = not autoRejoin
end)
Sec:CreateButton("Rejoin", function()
    game.Players.LocalPlayer:kick("Rejoining")
    wait(0.1)
    game:GetService("TeleportService"):Teleport(game.PlaceId, Player)
end)

Sec3:CreateButton("Versión 19", sa)
Sec3:CreateButton("Update: 27/07/24", sa)
Sec3:CreateButton("System 100% Safe", sa)
Sec2:CreateButton("Copy Link YouTube", copyy)
Sec2:CreateButton("Copy Link Discord", copyd)
Sec2:CreateButton("Send Text Discord(no spawn)", copyy)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
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

local StarterGui = game:GetService("StarterGui")
StarterGui:SetCore("SendNotification", {
    Title = "All Options Default: ON",
    Text = "by OneCreatorX",
    Duration = 5,
})

moveHearts()

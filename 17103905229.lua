local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()
local Win = Lib:NewWindow("Collect For UGC")
local Sec = Win:NewSection("Options")
local Sec3 = Win:NewSection("Info Script")
local Sec2 = Win:NewSection("Credits: OneCreatorX")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local b = false
local speed = 80
local ya = false

local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")

spawn(function()
    (loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX-New/TwoDev/main/Loader.lua"))())("info")
end)

local RS = game:GetService("RunService")
local WS = game:GetService("Workspace")

local function copyToClipboard(text)
    if syn then
        syn.write_clipboard(text)
    else
        setclipboard(text)
    end
end

local function moveHearts()
while b do
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and b then
        local Hearts = WS.Map.Interactable:GetDescendants()
        
        for _, heart in ipairs(Hearts) do
            if heart:IsA("MeshPart") and heart.Transparency ~= 1 then
                player.Character:MoveTo(heart.Position)
wait(0.2)
            end
        end
    end
end
wait(0.5)
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

workspace.Map:FindFirstChild("ugcShop"):Destroy()
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

local da = false
function save()
da = not da
while da do
if game.ReplicatedStorage.Events:FindFirstChild("saveHearts") and da then
game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("saveHearts"):FireServer()
wait(10)
elseif da then
local StarterGui = game:GetService("StarterGui")
StarterGui:SetCore("SendNotification", {
            Title = "Server No Support",
            Text = "Server Desactualizado",
            Duration = 10,
        })
break
else
end
end
end


function sa()
end

function copyy()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX/OneCreatorX/main/Scripts/MsgDev.lua"))()
end

Sec:CreateToggle("Auto Hearts", has)

Sec3:CreateButton("Versión 17", sa)
Sec3:CreateButton("Update: 27/07/24", sa)
Sec3:CreateButton("System 100% Safe", sa)
Sec2:CreateButton("Copy Link YouTube", copyy)
Sec2:CreateButton("Copy Link Discord", copyd)
Sec2:CreateButton("Send Text Discord(no spawn)", copyy)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
game:GetService('VirtualUser'):CaptureController()   game:GetService('VirtualUser'):ClickButton2(Vector2.new())
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
        Title = "New System Better",
        Text = "Anti Delete Hearts(95% safe)",
        Duration = 10,
    })

    StarterGui:SetCore("SendNotification", {
        Title = "Testing New system ",
        Text = "Reset Character Teste",
        Duration = 10,
    })

    StarterGui:SetCore("SendNotification", {
        Title = "much Time AFK +4 hs",
        Text = "maybe 55 - 60 avoid (baibai)",
        Duration = 5,
    })

    local player = game.Players.LocalPlayer
    local b = false
    local ya = true  -- Ensure ya is defined somewhere in your actual use case

    local function onLongFall()
        StarterGui:SetCore("SendNotification", {
            Title = "WARN WARN WARN",
            Text = "Auto Stop ACTIVE",
            Duration = 3,
        })
        b = false
        player.Character.Humanoid.Health = 0
    end

    local function onCharacterAdded()
        if ya then
            StarterGui:SetCore("SendNotification", {
                Title = "Auto Start ",
                Text = "u are safe, by OneCreatorX",
                Duration = 5,
            })
            b = true
        else
            StarterGui:SetCore("SendNotification", {
                Title = "Anti dectect Ready",
                Text = "u are safe, by OneCreatorX",
                Duration = 5,
            })
        end
    end

    local function checkFreefall()
        if player.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
            wait(3)
            if player.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
                onLongFall()
            end
        end
    end

    player.Character.Humanoid.StateChanged:Connect(function(_, newState)
        if newState == Enum.HumanoidStateType.Freefall then
            checkFreefall()
        end
    end)

    player.ChildAdded:Connect(function()
        task.wait(1)
        onCharacterAdded()
        player.Character.Humanoid.StateChanged:Connect(function(_, newState)
            if newState == Enum.HumanoidStateType.Freefall then
                checkFreefall()
            end
        end)
    end)
end

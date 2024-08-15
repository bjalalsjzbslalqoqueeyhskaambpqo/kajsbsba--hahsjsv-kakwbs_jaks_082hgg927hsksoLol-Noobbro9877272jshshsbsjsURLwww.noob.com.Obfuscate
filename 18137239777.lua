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

local spectatorEnabled = true

UL:AddTBtn(cfrm, "Auto Tokens", false, function()
    a = not a
    while a do
pcall(function()
        for _, descendant in pairs(workspace.GameObjects:GetDescendants()) do
            if descendant.Name == "HumanoidRootPart" and descendant:IsA("BasePart") then
                            pcall(function()
descendant.CanCollide = false
                                end)
                descendant.Position = game.Players.LocalPlayer.Character.PrimaryPart.Position
end
            end
        end)
        wait()
    end
end)




UL:AddText(crFrm, "By Script: OneCreatorX ")
UL:AddText(crFrm, "Create Script: 15/08/24 ")
UL:AddText(crFrm, "Update Script: --/--/--")
UL:AddText(crFrm, "Script Version: 0.1")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)


local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local world = game.Workspace

local function createPlayerVisuals(player)
    local visual = Instance.new("Folder")
    visual.Name = player.Name .. "Visual"

    local function createPart(name)
        local part = Instance.new("Part")
        part.Name = name
        part.Transparency = 1
        part.CanCollide = false
        part.Anchored = true
        part.Parent = visual

        local boxHandleAdornment = Instance.new("BoxHandleAdornment")
        boxHandleAdornment.Name = name .. "Adornment"
        boxHandleAdornment.Adornee = part
        boxHandleAdornment.AlwaysOnTop = true
        boxHandleAdornment.ZIndex = 10
        boxHandleAdornment.Size = part.Size
        boxHandleAdornment.Transparency = 0.3
        boxHandleAdornment.Parent = part

        return part
    end

    createPart("Torso")
    createPart("Head")
    createPart("LeftArm")
    createPart("RightArm")
    createPart("LeftLeg")
    createPart("RightLeg")

    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Name = "InfoBillboard"
    billboardGui.Size = UDim2.new(0, 200, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 3, 0)
    billboardGui.AlwaysOnTop = true
    billboardGui.Parent = visual

    local textLabel = Instance.new("TextLabel")
    textLabel.Name = "InfoText"
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.TextStrokeTransparency = 0
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.Parent = billboardGui

    visual.Parent = world
    return visual
end

local function updatePlayerVisual(player, visual)
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
        visual.Parent = nil
        return
    end

    local role = player:FindFirstChild("Role")
    local isGhost = role and role.Value == "Ghost"
    local color = isGhost and Color3.new(1, 0, 0) or Color3.new(0, 0, 1)

    local function updatePart(partName, characterPart)
        local part = visual:FindFirstChild(partName)
        if part and characterPart then
            part.CFrame = characterPart.CFrame
            part.Size = characterPart.Size
            local adornment = part:FindFirstChild(partName .. "Adornment")
            if adornment then
                adornment.Size = characterPart.Size
                adornment.Color3 = color
            end
        end
    end

    local character = player.Character
    updatePart("Torso", character:FindFirstChild("UpperTorso"))
    updatePart("Head", character:FindFirstChild("Head"))
    updatePart("LeftArm", character:FindFirstChild("LeftUpperArm"))
    updatePart("RightArm", character:FindFirstChild("RightUpperArm"))
    updatePart("LeftLeg", character:FindFirstChild("LeftUpperLeg"))
    updatePart("RightLeg", character:FindFirstChild("RightUpperLeg"))

    local rootPart = character.HumanoidRootPart
    local billboardGui = visual:FindFirstChild("InfoBillboard")
    if billboardGui then
        billboardGui.Adornee = rootPart
    end

    local distance = (rootPart.Position - workspace.CurrentCamera.CFrame.Position).Magnitude
    local infoText = visual.InfoBillboard.InfoText
    infoText.Text = string.format("%s\n%s\nDist: %.1f", player.Name, role and role.Value or "Unknown", distance)

    visual.Parent = world
end

local playerVisuals = {}

local function onPlayerAdded(player)
    playerVisuals[player] = createPlayerVisuals(player)
end

local function onPlayerRemoving(player)
    if playerVisuals[player] then
        playerVisuals[player]:Destroy()
        playerVisuals[player] = nil
    end
end

for _, player in ipairs(Players:GetPlayers()) do
    onPlayerAdded(player)
end

Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(onPlayerRemoving)

RunService.RenderStepped:Connect(function()
    if not spectatorEnabled then return end

    for player, visual in pairs(playerVisuals) do
        if player ~= Players.LocalPlayer then
            updatePlayerVisual(player, visual)
        end
    end
end)




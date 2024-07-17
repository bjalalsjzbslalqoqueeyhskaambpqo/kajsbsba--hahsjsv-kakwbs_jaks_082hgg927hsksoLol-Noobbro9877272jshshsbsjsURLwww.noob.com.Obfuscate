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

local RunService = game:GetService("RunService")

local killAll = false
local killAura = false

-- Function to equip the sword from the backpack if not equipped
local function ensureSwordEquipped()
    local character = p.Character or p.CharacterAdded:Wait()
    local sword = character:FindFirstChild("ClassicSword")

    if not sword then
        local backpackSword = p.Backpack:FindFirstChild("ClassicSword")
        if backpackSword then
            pcall(function()
                backpackSword.Parent = character
            end)
        end
    end
end

-- Function to kill all players
local function killAllPlayers()
    RunService.Heartbeat:Connect(function()
        if not killAll then return end

        ensureSwordEquipped()
        local character = p.Character
        local sword = character:FindFirstChild("ClassicSword")

        if sword then
            for _, player in ipairs(game.Players:GetPlayers()) do
                if player ~= p then
                    local success, character = pcall(function()
                        return player.Character
                    end)

                    if success and character then
                        for _, part in ipairs(character:GetDescendants()) do
                            if part:IsA("BasePart") then
                                pcall(function()
                                    firetouchinterest(sword.Handle, part, 0)
                                    firetouchinterest(sword.Handle, part, 1)
                                end)
                            end
                        end
                    end
                end
            end
        end
    end)
end

-- Function to find nearest player within range
local function getNearestPlayer()
    local nearestPlayer = nil
    local shortestDistance = 30
    local character = p.Character or p.CharacterAdded:Wait()

    for _, player in ipairs(game.Players:GetPlayers()) do
        if player ~= p and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                nearestPlayer = player
            end
        end
    end

    return nearestPlayer
end

-- Function to activate kill aura
local function activateKillAura()
    RunService.Heartbeat:Connect(function()
        if not killAura then return end

        ensureSwordEquipped()
        local character = p.Character
        local sword = character:FindFirstChild("ClassicSword")

        if sword then
            local targetPlayer = getNearestPlayer()
            if targetPlayer then
                local targetCharacter = targetPlayer.Character
                for _, part in ipairs(targetCharacter:GetDescendants()) do
                    if part:IsA("BasePart") then
                        pcall(function()
                            firetouchinterest(sword.Handle, part, 0)
                            firetouchinterest(sword.Handle, part, 1)
                        end)
                    end
                end
            end
        end
    end)
end

-- Add buttons to the UI
UL:AddTBtn(cfrm, "Kill all Players", false, function(state)
    killAll = not killAll
    if killAll then
        killAllPlayers()
    end
end)

UL:AddTBtn(cfrm, "Kill Aura", false, function(state)
    killAura = not killAura
    if killAura then
        activateKillAura()
    end
end)

UL:AddText(crFrm, "By Script: OneCreatorX")
UL:AddText(crFrm, "Create Script: 07/07/24")
UL:AddText(crFrm, "Update Script: --/--/--")
UL:AddText(crFrm, "Script Version: 0.1")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)

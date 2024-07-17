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

local function killAllPlayers()
    RunService.Heartbeat:Connect(function()
        if not killAll then return end

        local plr = game.Players.LocalPlayer

        for _, player in ipairs(game.Players:GetPlayers()) do
            if player ~= plr then
                local success, character = pcall(function()
                    return player.Character
                end)

                if success and character then
                    for _, part in ipairs(character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            local sword = nil
                            local success2, err = pcall(function()
                                sword = plr.Character:FindFirstChild("ClassicSword")
                            end)

                            if success2 and sword then
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

local function getNearestPlayer()
    local nearestPlayer = nil
    local shortestDistance = 30
    local plr = game.Players.LocalPlayer
    local character = plr.Character or plr.CharacterAdded:Wait()

    for _, player in ipairs(game.Players:GetPlayers()) do
        if player ~= plr and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                nearestPlayer = player
            end
        end
    end

    return nearestPlayer
end

local function activateKillAura()
    RunService.Heartbeat:Connect(function()
        if not killAura then return end

        local plr = game.Players.LocalPlayer
        local character = plr.Character or plr.CharacterAdded:Wait()
        local sword = character:FindFirstChild("ClassicSword")

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
    end)
end

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

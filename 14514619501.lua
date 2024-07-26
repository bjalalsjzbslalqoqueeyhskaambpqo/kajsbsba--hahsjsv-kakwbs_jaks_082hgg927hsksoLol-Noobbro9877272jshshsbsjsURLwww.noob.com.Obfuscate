local UL = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/MyLibrery.lua"))()

local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
local cleanGameName = function(name)
    return name:gsub("%b[]", ""):match("^[^:]*"):match("^%s*(.-)%s*$")
end
gameName = cleanGameName(gameName)

local p = game.Players.LocalPlayer
local sg = UL:CrSG("Default")
local frm, cfrm, crFrm = UL:CrFrm(sg, gameName)


OB, OF = UL:AddOBtn(cfrm, "MiniGames")

UL:AddTBtn(OF, "Auto Moños", a, function(b) 
    a = b
    while a do
        wait(0.1)
        for _, h in ipairs(workspace:GetChildren()) do
            if h.Name == "Bowtie" then
                fireproximityprompt(h["Meshes/bowV1.1_Cube"].ProximityPrompt)
            end
        end
    end
end)


UL:AddTBtn(cfrm, "Collect Flowers", a, function(b) 
    a = b
    while a do
        for _, h in ipairs(workspace.Activators:GetChildren()) do
            if h.Name == "Flower" and a then
                game.Players.LocalPlayer.Character.PrimaryPart.CFrame = h.Part.CFrame
wait(0.5)
                fireproximityprompt(h.Part.ProximityPrompt)
                wait(0.2)
            end
        end
    end
end)

UL:AddTBtn(cfrm, "Collect Magic Feathers", a, function(b) 
    a = b
    while a do
wait()
        for _, h in ipairs(workspace.Feathers:GetChildren()) do
            if h.Name == "Feather" and h:FindFirstChild("Root") and a then
                game.Players.LocalPlayer.Character.PrimaryPart.CFrame = h.Root.CFrame
wait(0.5)
                fireproximityprompt(h.Root.ProximityPrompt)
                wait(0.2)
            end
        end
    end
end)

UL:AddTBtn(cfrm, "Auto Claim Gift", a, function(b) 
    a = b
    while a do
        for i = 1, 9 do
            local args = {
                [1] = {
                    [1] = {
                        [1] = "\1",
                        [2] = "BERRIES_" .. i .. "00"
                    },
                    [2] = "9"
                }
            }

            game:GetService("ReplicatedStorage"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
            wait(1)
        end
    end
end)


spawn(function()
        local a = false
        UL:AddTBtn(cfrm, "Auto Tasks Pets", a, function(b) 
    a = b
end)

    local actions = {
    ["hug"] = "Hugged",
    ["bath"] = "Bathed",
    ["hungry"] = "Fed"
}

local actionCooldown = 15
local petActionTimes = {}

local function sendActionToServer(petName, action)
    local args = {
        [1] = {
            [1] = "PetInteractAction",
            [2] = "'",
            [3] = {
                [1] = "\1",
                [2] = {
                    [1] = tostring(petName),
                    [2] = action
                }
            },
            [4] = "\28"
        }
    }
    game:GetService("ReplicatedStorage"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
    
end

local function findPetName(instance)
    while instance and not instance:IsA("Model") do
        instance = instance.Parent
    end
    if instance and instance:IsA("Model") then
        return instance.Name
    end
    return "Unknown"
end

local function processChatMessages()
    local playerName = game.Players.LocalPlayer.Name
    local userDirectoryName = playerName .. ":Debris"
    local userDirectory = workspace:FindFirstChild(userDirectoryName)

    if not userDirectory then
        
        return
    end

    while true do
        wait(0.1)
        for _, child in ipairs(userDirectory:GetDescendants()) do
            if child.Name == "ChatList" and a then
                local chatMessages = child:GetChildren()
                if #chatMessages >= 2 then
                    local secondChild = chatMessages[2]
                    if secondChild:IsA("Frame") then
                        local textLabel = secondChild:FindFirstChildOfClass("TextLabel")
                        if textLabel then
                            local messageText = textLabel.Text:lower()
                            local petName = findPetName(secondChild)

                            for key, action in pairs(actions) do
                                if messageText:find(key) then
                                    local currentTime = tick()
                                    local lastActionTime = petActionTimes[petName]

                                    if not lastActionTime or (currentTime - lastActionTime >= actionCooldown) then
                                        sendActionToServer(petName, action)
                                        petActionTimes[petName] = currentTime
                                        break
                                    end
                                end
                            end
                        end
                    end
                end
            end
                    
        end
    end
end

spawn(processChatMessages)    
    end)

UL:AddText(crFrm, "By Script: OneCreatorX ")
UL:AddText(crFrm, "Create Script: 29/05/24 ")
UL:AddText(crFrm, "Update Script: 26/07/24")
UL:AddText(crFrm, "Script Version: 0.2")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)

spawn(function()
        while true do
            wait(0.3)
            
local function adjustAnimationSpeedInAnimator(animator)
    if animator then
        local numAnimations = #animator:GetPlayingAnimationTracks()
        for i = 1, numAnimations do
            local animationTrack = animator:GetPlayingAnimationTracks()[i]
            if animationTrack then
                animationTrack:AdjustSpeed(100)
            end
        end
    end
end

local function adjustAnimationsInObject(object)
    local animator = object:FindFirstChildOfClass("Animator")
    if animator then
        adjustAnimationSpeedInAnimator(animator)
    end
    for _, child in ipairs(object:GetChildren()) do
        adjustAnimationsInObject(child)
    end
end

    local playerName = game.Players.LocalPlayer.Name
local userDirectoryName = playerName .. ":Debris"
adjustAnimationsInObject(Workspace[userDirectoryName])
        end
    end)

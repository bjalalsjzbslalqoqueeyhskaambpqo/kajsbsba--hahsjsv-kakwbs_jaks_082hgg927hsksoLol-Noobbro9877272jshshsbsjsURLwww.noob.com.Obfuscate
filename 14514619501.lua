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
UL:AddText(crFrm, "Update Script: 28/07/24")
UL:AddText(crFrm, "Script Version: 0.4")
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


local Plrs = game:GetService("Players")
local TS = game:GetService("TweenService")
local VIM = game:GetService("VirtualInputManager")
local UIS = game:GetService("UserInputService")

local p = Plrs.LocalPlayer
local tNames = {"Bush1", "Bush2", "Bush3", "Bush4"}
local sC, sM, sF = 20, 50, 100

local isMoving = false
local currentTarget = nil
local clickDetected = false

local visibleUIs = {}

local isActive = false

local function toggleUI(hide)
    if hide then
        for _, gui in ipairs(p.PlayerGui:GetChildren()) do
            if gui:IsA("ScreenGui") and gui.Enabled then
                visibleUIs[gui] = true
                gui.Enabled = false
            end
        end
        p.PlayerGui:SetTopbarTransparency(1)
    else
        for gui, _ in pairs(visibleUIs) do
            if gui.Parent then
                gui.Enabled = true
            end
        end
        p.PlayerGui:SetTopbarTransparency(0)
        visibleUIs = {}
    end
end

local function focusCameraOnTarget(target, character)
    local cam = workspace.CurrentCamera
    local targetPos = target:GetPrimaryPartCFrame().Position
    local charPos = character.HumanoidRootPart.Position
    local offset = (targetPos - charPos).Unit * 5
    cam.CFrame = CFrame.new(charPos + offset, targetPos)
end

local function simulateClick()
    local cam = workspace.CurrentCamera
    local vs = cam.ViewportSize
    local cx, cy = vs.X / 2, vs.Y / 2
    VIM:SendMouseButtonEvent(cx, cy, 0, true, game, 1)
    wait(0.1)
    VIM:SendMouseButtonEvent(cx, cy, 0, false, game, 1)
end

local function mAA()
    if not isActive or isMoving then return end
    
    local c = p.Character
    if not c then return end
    local hrp = c:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local cT, cD = nil, math.huge
    for _, v in pairs(workspace:GetDescendants()) do
        for _, name in ipairs(tNames) do
            if v:IsA("Model") and v.Name == name then
                local d = (v:GetPrimaryPartCFrame().Position - hrp.Position).Magnitude
                if d < cD then cT, cD = v, d end
            end
        end
    end
    
    if not cT then return end
    if cT == currentTarget and cD < 3 then return end
    
    currentTarget = cT
    isMoving = true
    toggleUI(true)

    local s = cD < 50 and sC or (cD < 200 and sM or sF)
    local t = cD / s

    local tw = TS:Create(hrp, TweenInfo.new(t, Enum.EasingStyle.Linear), {CFrame = cT:GetPrimaryPartCFrame()})
    tw:Play()
    tw.Completed:Wait()

    local cam = workspace.CurrentCamera
    local oCS = cam.CameraSubject
    local oCT = cam.CameraType
    local oCF = cam.CFrame

    cam.CameraType = Enum.CameraType.Scriptable

    for _, pt in pairs(c:GetDescendants()) do
        if pt:IsA("BasePart") then
            pt.CanCollide = false
            pt.Transparency = 1
        end
    end

    clickDetected = false
    local clickConnection = UIS.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            clickDetected = true
        end
    end)

    local attempts = 0
    while not clickDetected and attempts < 5 do
        focusCameraOnTarget(cT, c)
        wait(0.5)
        simulateClick()
        wait(0.5)
        attempts = attempts + 1
        
        if not clickDetected then
            local offset = Vector3.new(math.random(-1, 1), math.random(-1, 1), math.random(-1, 1)).Unit * 2
            cam.CFrame = cam.CFrame * CFrame.new(offset)
        end
    end

    clickConnection:Disconnect()

    for _, pt in pairs(c:GetDescendants()) do
        if pt:IsA("BasePart") then
            pt.CanCollide = true
            pt.Transparency = 0
        end
    end

    cam.CameraSubject = oCS
    cam.CameraType = oCT
    cam.CFrame = oCF
    
    toggleUI(false)
    isMoving = false
end

UL:AddTBtn(cfrm, "Auto Bush Raiwb", isActive, function(b) 
    isActive = b
    while isActive do
        mAA()
        wait(1)
    end
end)
UL:AddTBtn(cfrm, "Auto Egg Secret", false, function()
        na = not na
        while na do
            local args = {
    [1] = {
        [1] = {
            [1] = "\1",
            [2] = "66111113-6A42-49B3-8F1E-2C5C5B646B57"
        },
        [2] = "G"
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
            wait(2)
        end
    end)

UL:AddBtn(cfrm, "TP Egg Zone Secret", function()
       game.Players.LocalPlayer.Character:MoveTo(Vector3.new(1356, 10, -3447))
        game.Players.LocalPlayer.Character.PrimaryPart.Anchored = true
        wait(3)
        game.Players.LocalPlayer.Character.PrimaryPart.Anchored = false
    end)

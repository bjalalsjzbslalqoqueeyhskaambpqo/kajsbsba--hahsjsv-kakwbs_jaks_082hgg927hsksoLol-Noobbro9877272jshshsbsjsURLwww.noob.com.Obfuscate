
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
local sg = UL:CrSG("Defauld")
local frm, cfrm, crFrm = UL:CrFrm(sg, gameName)
local pp = p.PlayerGui

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
playerGui:WaitForChild("WishingwellUI").Enabled = true
playerGui:WaitForChild("WishingwellUI"):WaitForChild("Frame").Visible = false
local wishingWellLabel = playerGui:WaitForChild("WishingwellUI"):WaitForChild("Frame"):WaitForChild("top"):WaitForChild("WISH")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TimeRemainingGui"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Name = "TimeFrame"
frame.Size = UDim2.new(0, 350, 0, 20)
frame.Position = UDim2.new(0.6, 0, 0.96, 0)
frame.BackgroundTransparency = 0.5
frame.BackgroundColor3 = Color3.new(0, 0, 0)
frame.Parent = screenGui

local textLabel = Instance.new("TextLabel")
textLabel.Name = "TimeLabel"
textLabel.Size = UDim2.new(1, 0, 1, 0)
textLabel.Position = UDim2.new(0, 0, 0, 0)
textLabel.TextColor3 = Color3.new(1, 1, 1)
textLabel.BackgroundTransparency = 1
textLabel.Font = Enum.Font.SourceSansBold
textLabel.TextScaled = true
textLabel.Text = "No Have Wish"
textLabel.Parent = frame

local auto = false

local wis = "Small"
local myOptionsButton, myOptionsFrame = UL:AddOBtn(cfrm, "Options Wishingwell")

UL:AddTBtn(myOptionsFrame, "Auto Buy Wish", false, function() auto = not auto textLabel.Text = "No Have - Wish Auto buy: " .. tostring(auto) .. " Select: " .. wis end)
UL:AddBtn(myOptionsFrame, " Select Small 15 minutes - 2 Wish", function() wis = "Small" local StarterGui = game:GetService("StarterGui")
StarterGui:SetCore("SendNotification", {
    Title = "Wish Select Small",
    Text = "Proce 50 Gems",
    Duration = 5,
})
 end)
UL:AddBtn(myOptionsFrame, "Select Medium 1 hs - 3 Wish", function() wis = "Medium"
 local StarterGui = game:GetService("StarterGui")
StarterGui:SetCore("SendNotification", {
    Title = "Wish Select Medium",
    Text = "Price 200 Gems",
    Duration = 5,
})
 end)
UL:AddBtn(myOptionsFrame, "Select Mega 3 hs - 4 Wish", function() wis = "Mega" 
local StarterGui = game:GetService("StarterGui")
StarterGui:SetCore("SendNotification", {
    Title = "Wish Select Mega",
    Text = "Price 1000 Gems",
    Duration = 5,
})
 end)
UL:AddBtn(myOptionsFrame, "Buy Wish Select", function() local args = {
            [1] = tostring(wis)
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("WishingWell"):FireServer(unpack(args)) end)

local function updateTimeRemaining()
    local text = wishingWellLabel.Text
    -- Utilizamos una expresión regular más flexible para capturar el tiempo restante
    local timeRemaining = string.match(text, "<font size='200'>(%d+%s*h%s*%d+%s*m%s*%d+%s*s)%s*REMAINING!</font>")
    
    if not timeRemaining then
        -- Si no se encuentra el formato con horas, intentamos con minutos y segundos
        timeRemaining = string.match(text, "<font size='200'>(%d+%s*m%s*%d+%s*s)%s*REMAINING!</font>")
    end
    
    if timeRemaining then
        textLabel.Text = "Time Wish: " .. timeRemaining .. " Auto buy: " .. tostring(auto) .. " Select: "  .. wis
    elseif wishingWellLabel.Text == "None. Feed me gems for a surprise!" and auto then
        local args = {
            [1] = tostring(wis)
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("WishingWell"):FireServer(unpack(args))
    else
        textLabel.Text = "No Have Wish:  Auto buy: " .. tostring(auto) .. " Select: "  .. wis
    end
end

-- Conectar la función al cambio de propiedad del texto
wishingWellLabel:GetPropertyChangedSignal("Text"):Connect(updateTimeRemaining)

-- Llamar a la función una vez al inicio para asegurarnos de que se actualice
updateTimeRemaining()

function goi()
    local player = game.Players.LocalPlayer
    local wishingWellUI = player.PlayerGui:FindFirstChild("WishingwellUI")
    
    if wishingWellUI then
        local textObject = wishingWellUI:FindFirstChild("Frame")
        
        if textObject and textObject:FindFirstChild("top") and textObject.top:FindFirstChild("WISH") then
            local text = textObject.top.WISH.Text
            
            local trimmedText = text:match("^%s*(.-)%s*$")
            trimmedText = trimmedText:gsub("%s+", " ")
            
            if trimmedText == "None. Feed me gems for a surprise!" then
                print("Encontró la frase 'None. Feed me gems for a surprise!'")
                local args = { tostring(wis) }
                game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("WishingWell"):FireServer(unpack(args))
            end
        end
    end

end

function yaw()
    while true do
        if auto then
         goi()
wait(3)
        end
        wait(1)
    end
end


local function showAllFrames(gui)
    if gui and gui:IsA("ScreenGui") then
        for _, frame in ipairs(gui:GetChildren()) do
            if frame:IsA("Frame") then
                frame.Visible = true
            end
        end
    end
end

local MOB, MOF = UL:AddOBtn(cfrm, "UI Structures")
UL:AddBtn(MOF, "AltarUI", function() 
    pp.AltarUI.Enabled = true 
    showAllFrames(pp.AltarUI)
end)
UL:AddBtn(MOF, "GemShop", function() 
    pp.GemShop.Enabled = true 
    showAllFrames(pp.GemShop)
end)
UL:AddBtn(MOF, "Hacker", function() 
    pp.Hacker.Enabled = true 
    showAllFrames(pp.Hacker)
end)
UL:AddBtn(MOF, "PerksShop", function() 
    pp.PerksShop.Enabled = true 
    showAllFrames(pp.PerksShop)
end)
UL:AddBtn(MOF, "MergeEquipment", function() 
    pp.MergeEquipment.Enabled = true 
    showAllFrames(pp.MergeEquipment)
end)
UL:AddBtn(MOF, "TempleUI", function() 
    pp.TempleUI.Enabled = true 
    showAllFrames(pp.TempleUI)
end)

UL:AddBtn(MOF, "JesterUi", function() 
    pp.JesterUi.Enabled = true 
    showAllFrames(pp.JesterUi)
        local StarterGui = game:GetService("StarterGui")
StarterGui:SetCore("SendNotification", {
    Title = "Visible all efects",
    Text = "5s",
    Duration = 5,
})
        
    wait(0.5)
    for i = 1, 10 do
        local cardFrame = pp.JesterUi.Frame.cardframe[i]
        local lockedElement = cardFrame:FindFirstChild("Locked")

        if lockedElement and lockedElement.Visible then
            lockedElement.Visible = false
            
spawn(function()
            wait(5)
            lockedElement.Visible = true
end)
        end
    end
end)


local function copy(text)
    if syn then
        syn.write_clipboard(text)
    else
        setclipboard(text)
    end
end

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")

local function sendNotification(title, text, duration)
    game.StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration
    })
end
local OP, OF = UL:AddOBtn(cfrm, "Options Items >")

local sendCount = nil

UL:AddTBox(OF, "Item Purchase Multiplier: 1", function(text)
    local input = tonumber(text)
    if input and input > 0 then
        sendCount = input
        
    else
        sendCount = nil
        
    end
end)

local kyo = false
    UL:AddTBtn(cfrm, "Auto Get Gift time", false, function()
         kyo = not kyo
        while kyo do
            wait(1)
            for i = 1, 12 do
                local args = {
    [1] = i
}

game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PlaytimeRewardUpdateEvent"):FireServer(unpack(args))
                wait(1)
            end
        end
    end)

local enviarAlServidor = false

local function getFullName(instance)
    return instance:GetFullName()
end

local function tableToString(t, indent)
    indent = indent or 0
    local result = "{\n"
    local padding = string.rep(" ", indent + 2)
    for k, v in pairs(t) do
        if typeof(v) == "Instance" then
            result = result .. padding .. tostring(k) .. " = " .. getFullName(v) .. ",\n"
        elseif type(v) == "table" then
            result = result .. padding .. tostring(k) .. " = " .. tableToString(v, indent + 2) .. ",\n"
        else
            result = result .. padding .. tostring(k) .. " = " .. tostring(v) .. ",\n"
        end
    end
    return result .. string.rep(" ", indent) .. "}"
end

local function decryptArguments(...)
    local decryptedArgs = {}
    for _, arg in ipairs({...}) do
        if type(arg) == "table" then
            decryptedArgs[#decryptedArgs + 1] = tableToString(arg)
        elseif typeof(arg) == "Instance" then
            decryptedArgs[#decryptedArgs + 1] = getFullName(arg)
        else
            decryptedArgs[#decryptedArgs + 1] = tostring(arg)
        end
    end
    return decryptedArgs
end

local remote = game.ReplicatedStorage:WaitForChild("Events"):WaitForChild("GenerateEquipment")
local mergeRemote = game.ReplicatedStorage:WaitForChild("Events"):WaitForChild("PlayerMergeEquipment")

remote.OnClientEvent:Connect(function(...)
    if enviarAlServidor then 
        local args = {...}
        local decryptedArgs = decryptArguments(...)

        local groupedItems = {}
        for _, arg in ipairs(args) do
            if type(arg) == "table" then
                for id, item in pairs(arg) do
                    if type(item) == "table" and item.equipped == false and item.rarity ~= "Demonic" then
                        local key = item.name .. "_" .. item.rarity
                        if not groupedItems[key] then
                            groupedItems[key] = {}
                        end
                        table.insert(groupedItems[key], {id = id, item = item})
                    end
                end
            end
        end

        for key, items in pairs(groupedItems) do
            if #items >= 3 then
                local idsToSend = {tostring(items[1].id), tostring(items[2].id), tostring(items[3].id)}
                local args = {[1] = idsToSend}
                
                mergeRemote:FireServer(unpack(args))
            end
        end
    end
end)

UL:AddTBtn(OF, "Auto Merge Items", false, function()
    enviarAlServidor = not enviarAlServidor
end)


local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Events = ReplicatedStorage:WaitForChild("Events")
local CraftingEvent = Events:WaitForChild("CraftingEvent")

local isCallingFireServer = false

local function nuevaFuncionFireServer(...)
    local args = {...}
    isCallingFireServer = true
    if sendCount and sendCount > 0 then
        for i = 1, sendCount do
            CraftingEvent:FireServer(unpack(args))
        end
    else
        CraftingEvent:FireServer(unpack(args))
    end
    isCallingFireServer = false
end

local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    if method == "FireServer" and self == CraftingEvent and not isCallingFireServer then
        spawn(function()
            nuevaFuncionFireServer(unpack(args))
        end)
        return oldNamecall(self, unpack(args))
    end
    return oldNamecall(self, unpack(args))
end)

setreadonly(mt, true)

local running = false
local world = ""
local worldd

local function startOpeningEggs(world)
    running = true
    
    while running do
        local args = {
            [1] = tostring(world)
        }

        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PlayerPressedKeyOnEgg"):FireServer(unpack(args))

        wait(0.3)
    end
end

game.Players.LocalPlayer.PlayerScripts:FindFirstChild("PlayerPetHandler").Enabled = false
sendNotification("Animation Egg Oppen", "Desabled Default", 5)

UL:AddTBox(cfrm, "Auto Egg-number world or 'stop", function(value) 
worldd = value
    if value == "" or value:lower() == "stop" then
        running = false
        sendNotification("Stop Open Egg", "Egg opening stopped", 5)
        return
    end

    local newWorld = tonumber(value)
    if newWorld then
        world = newWorld
        running = false
        sendNotification("Open Egg", "Starting to open eggs in world: " .. world, 5)
        wait(0.1)
        startOpeningEggs(world)
    else
        -- handle invalid input
        end
end)

UL:AddBtn(cfrm, "Tp Egg Worl", function()
    local tp = workspace.EggVendors[worldd]:GetModelCFrame().Position + Vector3.new(0, 15, 0)
    game.Players.LocalPlayer.Character:MoveTo(tp)
    wait(0.2)
    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
    wait(2)
    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
end)


local ah = false
UL:AddTBtn(cfrm, "Auto Fast Train", false, function(state)
    ah = not ah
    while ah do
        wait()
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("DamageIncreaseOnClickEvent"):FireServer()
        end
    end)


game.Players.LocalPlayer.PlayerScripts.DeathEffectsHandler.Disabled = true
         game.Players.LocalPlayer.PlayerScripts.CameraHandler.Disabled = true

UL:AddText(crFrm, "By Script: OneCreatorX ")
UL:AddText(crFrm, "Create Script: 20/05/24 ")
UL:AddText(crFrm, "Update Script: 17/06/24")
UL:AddText(crFrm, "Script Version: 0.7")
UL:AddBtn(crFrm, "Send text for Discord", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX/OneCreatorX/main/Scripts/MsgDev.lua"))() end)
UL:AddBtn(crFrm, "Copy link YouTube", function() copy("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() copy("https://discord.com/invite/UNJpdJx7c4") end)



local arg2, arg3 = 1, 1
local ja = false
local function ah()
    wait(0.1)
if ja then
       
    local args = {[1] = true}
    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PushEvent"):FireServer(unpack(args))
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PushEvent"):FireServer(unpack(args))
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PushEvent"):FireServer(unpack(args))
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PushEvent"):FireServer(unpack(args))
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PushEvent"):FireServer(unpack(args))
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PushEvent"):FireServer(unpack(args))
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PushEvent"):FireServer(unpack(args))
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PushEvent"):FireServer(unpack(args))
    wait(0.5)
        
   game.Players.LocalPlayer.Character:MoveTo(workspace.BreakableParts["Stage" .. arg2][arg3]:GetModelCFrame().Position)
end
end

local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)


UL:AddTBtn(cfrm, "Fast Auto Fight", false, function() 
ja = not ja
if not ja then
local args = {
    [1] = "StopFight"
}

game:GetService("ReplicatedStorage"):WaitForChild("dEvents"):WaitForChild("AutoFight"):FireServer(unpack(args))
else
sendNotification("Use Auto Fight", "Button Game for farm", 5)
end
end)    



local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Events = ReplicatedStorage:WaitForChild("Events")
local AutoFight = Events:WaitForChild("AutoFight")
local originalFireServer = AutoFight.FireServer

local function newFireServer(self, ...)
    local args = {...}
    arg2 = args[2]
    arg3 = args[3]
    
    if args[1] == "StopFight" then
        return oldNamecall(self, ...)
    else
        spawn(ah)
        return originalFireServer(self, unpack(args))
    end
end

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if method == "FireServer" and self == AutoFight then
        return newFireServer(self, ...)
    end
    return oldNamecall(self, ...)
end)

setreadonly(mt, true)


local walkSpeed = 40
local safeDistance = 9
local attackDistance = 9
local remoteEvent = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PunchEvent")

local Player = game:GetService("Players").LocalPlayer

local function findClosestNPC()
    local character = Player.Character or Player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    
    local closestNPC = nil
    local closestDistance = math.huge

    for _, NPC in pairs(workspace.BreakableParts.Dungeon:GetChildren()) do
        if NPC:IsA("Model") and NPC.PrimaryPart then
            local distance = (NPC.PrimaryPart.Position - humanoidRootPart.Position).Magnitude
            if distance < closestDistance then
                closestDistance = distance
                closestNPC = NPC
            end
        end
    end

    return closestNPC
end

local function attackAndMove()
    local character = Player.Character or Player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        
    local closestNPC = findClosestNPC()
    if closestNPC then
        local direction = (closestNPC.PrimaryPart.Position - humanoidRootPart.Position).unit
        local distance = (closestNPC.PrimaryPart.Position - humanoidRootPart.Position).Magnitude
        local newPosition = humanoidRootPart.Position + direction * math.min(distance - attackDistance, safeDistance - 1)

        character:MoveTo(newPosition)
        remoteEvent:FireServer(closestNPC)
    end
end


local a = false

local limite = 1000

UL:AddTBox(cfrm, "Number Limite Wave", function(userInput) 
    if userInput == "" then
        limite = 1000
        sendNotification("Wave limit appl", "Max limit waves: " .. limite, 5)
    else
        limite = tonumber(userInput)
        if limite then
            sendNotification("Wave limit appl", "Max limit waves: " .. limite, 5)
        else
            sendNotification("Error", "Invalid input for wave limit", 5)
        end
        end
end)


local function startNewDungeon()
    if a then
        wait(2)
        local args = {
            [1] = "StartDungeon"
        }

        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("DungeonEvent"):FireServer(unpack(args))
    end
end

function Start()
    a = not a
    if a then
        local args = {
            [1] = "StartDungeon"
        }

        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("DungeonEvent"):FireServer(unpack(args))
    
    else
        local args = {
            [1] = "Exit"
        }

        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("DungeonEvent"):FireServer(unpack(args))
wait(1)
Player.PlayerGui.DungeonFinishUI.Enabled = true
    end
end

UL:AddTBtn(cfrm, "Start - Auto: Dungeon", false, function(state) 
Start()
 end)

local targetRemoteEventName = "PartyEvent"
local PartyEvent = ReplicatedStorage:WaitForChild("Events"):WaitForChild(targetRemoteEventName)

local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if method == "FireServer" and self.Name == targetRemoteEventName then
        spawn(startNewDungeon)
        return oldNamecall(self, ...)
    end
    return oldNamecall(self, ...)
end)

setreadonly(mt, true)

local claim = false
local currentEvent = nil
local eventStats = nil

function claimUGC()
if claim then
    local args = { currentEvent }
    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("NewUGCEvents"):WaitForChild("ClickedEventClaimButton"):FireServer(unpack(args))
end
end

function reintentar()
    wait(1)
if claim then
        if currentEvent == nil then
            sendNotification("Click in Event UGC", "or not Working", 5)
            reintentar()
        else
    local args = { currentEvent }
    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("NewUGCEvents"):WaitForChild("RequestEventData"):FireServer(unpack(args))
end
    
end
end

local function hookRequestEventData()
    local mt = getrawmetatable(game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("NewUGCEvents"):WaitForChild("RequestEventData"))
    local oldFireServer = mt.__namecall

    setreadonly(mt, false)

    mt.__namecall = newcclosure(function(self, ...)
        local args = {...}
        local method = getnamecallmethod()

        if method == "FireServer" and self.Name == "RequestEventData" and claim then
            currentEvent = args[1]
        end

        return oldFireServer(self, ...)
    end)

    setreadonly(mt, true)
end

local function hookSendEventQuestStats()
    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("NewUGCEvents"):WaitForChild("SendEventQuestStats").OnClientEvent:Connect(function(eventName, stats)
        if eventName == currentEvent and claim then
            eventStats = stats
            
            local allQuestsComplete = true
            for _, quest in pairs(stats) do
                if quest.current < quest.required then
                    allQuestsComplete = false
                    spawn(reintentar)
                    break
                end
            end
            
            if allQuestsComplete then
                spawn(claimUGC)
            end
        end
    end)
end


    
    UL:AddTBtn(cfrm, "Auto GET and Claim UGC", false, function(state)
 claim = not claim 
        if claim then
    reintentar()
            spawn(function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/Auto%20Buyer(Fast%20Claim).lua"))()
                end)
        end
end)

hookRequestEventData()
hookSendEventQuestStats()

local function onPlayerDeath()
    wait(0.8)
    local args = { [1] = "LeaveParty" }
    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PartyEvent"):FireServer(unpack(args))
    Player.PlayerGui.DungeonFinishUI.Enabled = false
    wait(1)
end

local function monitorPlayerHealth(humanoid)
    humanoid.HealthChanged:Connect(function(health)
        if health <= 0 then
            onPlayerDeath()
        end
    end)
end

local function setupCharacterMonitoring(player)
    player.CharacterAdded:Connect(function(character)
        local humanoid = character:WaitForChild("Humanoid")
        monitorPlayerHealth(humanoid)
    end)

    if player.Character then
        local humanoid = player.Character:WaitForChild("Humanoid")
        monitorPlayerHealth(humanoid)
    end
end

local player = game.Players.LocalPlayer
setupCharacterMonitoring(player)
spawn(function()
while true do
    local success, err = pcall(function()
        local maxText = Player.PlayerGui.DungeonMain.Frame.Wave.WaveNumber.Text
        local max = tonumber(maxText:match("%d+"))
        
        if a then
            if limite ~= nil and max and max <= limite then
                attackAndMove()
                wait()
            elseif limite ~= nil and max and max >= limite and workspace:FindFirstChild("Dungeon") then
                local args = { [1] = "Exit" }
                game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("DungeonEvent"):FireServer(unpack(args))
                wait(2)
            elseif limite ~= nil and not workspace:FindFirstChild("Dungeon") then
                wait(0.8)
                local args = { [1] = "LeaveParty" }
                game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PartyEvent"):FireServer(unpack(args))
                Player.PlayerGui.DungeonFinishUI.Enabled = false
                wait(1)
            else
                wait(0.1)
                -- no hacer nada
            end
        else
            wait(0.1)
            -- no hacer nada
        end
    end)
    
    if not success then
        
    end
end
    end)



local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local notificationSent = {
    buyButton = false,
    cancelButton = false
}

local function sendNotification(title, text, duration)
    if not notificationSent[title] then
        StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = duration,
        })
        notificationSent[title] = true
    end
end

local function clickCancelButton(purchasePrompt)
    local cancelButtonText = nil
    local zeroTextButton = nil

    for _, descendant in ipairs(purchasePrompt:GetDescendants()) do
        if descendant:IsA("TextLabel") and descendant.Name == "Text" then
            local text = descendant.Text:lower()
            if text == "cancelar" or text == "cancel" then
                cancelButtonText = text
            elseif text == "0" then
                zeroTextButton = descendant
            end
        end
    end

    if zeroTextButton and claim then
        local buttonCenterX = zeroTextButton.AbsolutePosition.X + zeroTextButton.AbsoluteSize.X / 0.5
        local buttonCenterY = zeroTextButton.AbsolutePosition.Y + zeroTextButton.AbsoluteSize.Y / 0.5
        
        game:GetService("VirtualInputManager"):SendMouseButtonEvent(buttonCenterX, buttonCenterY, 0, true, game, 1)
        game:GetService("VirtualInputManager"):SendMouseButtonEvent(buttonCenterX, buttonCenterY, 0, false, game, 1)
        sendNotification("FREE UGC Available", "Auto Claim Accept. By:OneCreatorX", 5)
    elseif cancelButtonText then
        for _, descendant in ipairs(purchasePrompt:GetDescendants()) do
            if descendant:IsA("TextLabel") and descendant.Name == "Text" and descendant.Text:lower() == cancelButtonText then
                local buttonCenterX = descendant.AbsolutePosition.X + descendant.AbsoluteSize.X / 0.5
                local buttonCenterY = descendant.AbsolutePosition.Y + descendant.AbsoluteSize.Y / 0.5
                
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(buttonCenterX, buttonCenterY, 0, true, game, 1)
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(buttonCenterX, buttonCenterY, 0, false, game, 1)
                sendNotification("NO FREE UGC", "Auto Claim Decline. By:OneCreatorX", 5)
                break
            end
        end
    end
end

local coreGui = game:GetService("CoreGui")
local purchasePrompt = coreGui:WaitForChild("PurchasePrompt")
 local claimm = false

RunService.Heartbeat:Connect(function()
if claimm then
    local buttonsFound = false

    for _, descendant in ipairs(purchasePrompt:GetDescendants()) do
        if descendant:IsA("TextLabel") and descendant.Name == "Text" then
            buttonsFound = true
            break
        end
    end

    if not buttonsFound then
        notificationSent = {
            buyButton = false,
            cancelButton = false
        }
    end

    clickCancelButton(purchasePrompt)
end
end)
yaw()

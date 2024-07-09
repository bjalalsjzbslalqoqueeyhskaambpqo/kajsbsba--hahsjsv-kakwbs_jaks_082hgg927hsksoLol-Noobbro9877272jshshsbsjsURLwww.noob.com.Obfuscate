local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()
local Win = Lib:NewWindow("Survive The Killer v1.9")
local Sec = Win:NewSection("General")
local Ki = Win:NewSection("Killer")
local Su = Win:NewSection("Survivor")
local Sut = Win:NewSection("Survivor Teleports")
local Sec2 = Win:NewSection("Credits: OneCreatorX")
local Players = game:GetService("Players")
local Humanoid = game.Players.LocalPlayer.Character
local Player = game.Players.LocalPlayer
local Humanoid = Player.Character:WaitForChild("Humanoid")
local ii = false

local function clickButton(btn)
    local pos = btn.AbsolutePosition
    local size = btn.AbsoluteSize
    local centerX = pos.X + size.X / 1
    local centerY = pos.Y + size.Y / 1
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(centerX, centerY, 0, true, game, 1)
    wait() 
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(centerX, centerY, 0, false, game, 1)
end


local function copyToClipboard(text)
    if syn then
        syn.write_clipboard(text)
    else
        setclipboard(text)
    end
end

local b = false

local function createNameTag()
    local nameTags = {}

    for _, player in ipairs(game.Players:GetPlayers()) do
        if player.Team == game.Teams.Lobby then
            if player.Character then
                local existingNameTag = player.Character:FindFirstChild("NameTag")
                if existingNameTag then
                    existingNameTag:Destroy()
                end
            end
        else
            if player.Character then
                local existingNameTag = player.Character:FindFirstChild("NameTag")
                if not existingNameTag then
                    local playerPart = player.Character:WaitForChild("HumanoidRootPart")
                    local nameColor = Color3.new()

                    local billboardGui = Instance.new("BillboardGui")
                    billboardGui.Adornee = playerPart
                    billboardGui.Size = UDim2.new(0, 200, 0, 40)
                    billboardGui.StudsOffset = Vector3.new(0, 3, 0)
                    billboardGui.AlwaysOnTop = true
                    billboardGui.Name = "NameTag"

                    local nameLabel = Instance.new("TextLabel")
                    nameLabel.Size = UDim2.new(1, 0, 1, 0)
                    nameLabel.BackgroundTransparency = 1
                    nameLabel.TextColor3 = nameColor

                    local killer = nil
                    local playerHumanoid = player.Character:FindFirstChildOfClass("Humanoid")
                    for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
                        if otherPlayer ~= player and otherPlayer.Team ~= game.Teams.Lobby then
                            if otherPlayer.Team == game.Teams.Killer then
                                killer = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
                                break
                            end
                        end
                    end

                    if player.Team == game.Teams.Killer then
                        nameLabel.Text = "K"
                        nameLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                    else
                        nameLabel.Text = "S"
                        nameLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                    end

                    nameLabel.FontSize = Enum.FontSize.Size10
                    nameLabel.TextScaled = true
                    nameLabel.Parent = billboardGui

                    if killer then
                        nameLabel.Text = "K"
                        nameLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                    end

                    billboardGui.Parent = playerPart.Parent

                    table.insert(nameTags, billboardGui)
                elseif player.Team == game.Teams.Killer then
                    if existingNameTag.TextLabel.Text ~= "K" then
                        existingNameTag.TextLabel.Text = "K"
                        existingNameTag.TextLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                    end
                else
                    if existingNameTag.TextLabel.Text ~= "S" then
                        existingNameTag.TextLabel.Text = "S"
                        existingNameTag.TextLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                    end
                end
            end
        end
    end

    return nameTags
end

function esp()
    b = not b
    while b do
        createNameTag()
        task.wait(1)
    end
end

local c = false
function killAura()
    c = not c
    while c do
        if c and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and Player.Character:FindFirstChild("Knife") then
            local rootPos = Player.Character.HumanoidRootPart.Position
task.wait(0.5)
            for _, player in ipairs(game.Players:GetPlayers()) do
                if player ~= Player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local targetPos = player.Character.HumanoidRootPart.Position
                    local distance = (rootPos - targetPos).magnitude
                    if distance <= 22 then
                        player.Character.HumanoidRootPart.CFrame = CFrame.new(rootPos)
                    end
                end
            end
        end
        task.wait(0.5)
    end
end

local u = false
function kill()
    u = not u
    while u do
task.wait(0.5)
        if u and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and Player.Character:FindFirstChild("Knife") then
            local rootPos = Player.Character.HumanoidRootPart.Position
task.wait(0.3)
            for _, player in ipairs(game.Players:GetPlayers()) do
                if player ~= Player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local targetPos = player.Character.HumanoidRootPart.Position
                    local distance = (rootPos - targetPos).magnitude
                    if distance <= 900 then
                        player.Character.HumanoidRootPart.CFrame = CFrame.new(rootPos)
                    end
                end
            end
        end
end
        task.wait()
end

local j = false 
function curar()
    j = not j
    while j do
        task.wait()
        if j and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and not Player.Character:FindFirstChild("Knife") and Player.Character.HumanoidRootPart:FindFirstChild("BleedOutHealth") and Player.Character.HumanoidRootPart:FindFirstChild("BleedOutHealth").Enabled == false then
            local rootPos = Player.Character.HumanoidRootPart.Position
            local targetPlayer = nil
            local minDistance = 900
            for _, players in ipairs(game.Players:GetPlayers()) do
                if players ~= Player and players.Character and players.Character:FindFirstChild("HumanoidRootPart") and not players.Character:FindFirstChild("Knife") and players.Character.HumanoidRootPart:FindFirstChild("BleedOutHealth") and players.Character.HumanoidRootPart:FindFirstChild("BleedOutHealth").Enabled then
                    local targetPos = players.Character.HumanoidRootPart.Position
                    local distance = (rootPos - targetPos).magnitude
                    if distance > 7 and distance <= 19 and distance < minDistance then
                        targetPlayer = players
                        minDistance = distance
else
                    end
else
                end
            end
            if targetPlayer then
 targetPlayer.Character:SetPrimaryPartCFrame(CFrame.new(Player.Character.HumanoidRootPart.Position))  
clickButton(Player.PlayerGui.TouchGui.TouchControlFrame.CarryButton)
            end
        end
        task.wait()
    end
end

local x = false 
function Trap()
    x = not x
    while x do
task.wait(1)
for _, item in pairs(workspace:GetChildren()) do
     if  item:IsA("Model") and item.Name == "Trap" then
 item:Destroy()
end
end
        end
end

local d = false 
local isRunning = false
local exitFound = false

function control()
task.wait(5)
if d then
isRunning = true 
else
isRunning = false 
end
end

function Escape()
    while isRunning and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and not Player.Character:FindFirstChild("Knife") do
        task.wait(0.3)
        local success, result = pcall(function()
            for _, model in pairs(workspace:GetChildren()) do
                if model:IsA("Model") and model:FindFirstChild("Exits") then
                    exitFound = true
                    isRunning = false
                    while exitFound and d and model.Exits do
                        task.wait(1)
                        local success, result = pcall(function()
                            for _, part in ipairs(model.Exits:GetChildren()) do
                                task.wait(1)
                                if part:IsA("Model") then
                                    local success, result = pcall(function()
                                        for _, partt in ipairs(part.Trigger:GetChildren()) do
                                            if partt.Name == "ExitIcon" then
                                                local triggerPos = partt.Parent.Position
                                                if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                                                    local distance = (Player.Character.HumanoidRootPart.Position - triggerPos).magnitude
                                                    if distance < 7000 and game.Players.LocalPlayer.Team == game.Teams.Survivor then
 Player.Character.Humanoid.Sit = false 
task.wait(0.3) Player.Character:SetPrimaryPartCFrame(CFrame.new(partt.Parent.Parent.Doorway.Door1.Position))                          
task.wait(0.3)
Player.Character:SetPrimaryPartCFrame(CFrame.new(partt.Parent.Parent.Doorway.Door2.Position))
task.wait(0.3)   
Player.Character:SetPrimaryPartCFrame(CFrame.new(triggerPos))                                     
                                                        exitFound = false
                                                        control()
                                                        break
                                                    else
                                                        exitFound = false
                                                        isRunning = true
                                                    end
                                                else
                                                    exitFound = false
                                                    isRunning = true
                                                end
                                            else
                                                exitFound = false
                                                isRunning = true
                                            end
                                        end
                                    end)
                                    if not success then
                                        exitFound = false
                                                isRunning = true
                                    end
                                else
                                    exitFound = false
                                    isRunning = true
                                end
                            end
                        end)
                        if not success then
                           exitFound = false
                                                isRunning = true 
                        end
                    end
                else
                    exitFound = false
                    isRunning = true
                end
            end
        end)
        if not success then
           exitFound = false
                                                isRunning = true 
        end
        wait()
    end
end

function Escap()
d = not d
isRunning = not isRunning
Escape()
end

local dd = false 
local isRunningg = false
local exitFoundd = false


function items()
    while isRunningg and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and not Player.Character:FindFirstChild("Knife") do
        task.wait(1)
        local success, result = pcall(function()
            for _, model in pairs(workspace:GetChildren()) do
                if model:IsA("Model") and model:FindFirstChild("LootSpawns") then
                    exitFoundd = true
                    isRunningg = false
  
local amountText = game.Players.LocalPlayer.PlayerGui.GameHUD.PlayerHUD.XP.RoundInfo.Backpack.Amount.Text
        local amountParts = string.split(amountText, "/")
        local x = tonumber(amountParts[1])
        local y = tonumber(amountParts[2])
        ii = (x == y)
                     
while exitFoundd and dd and not ii and model:FindFirstChild("LootSpawns") do
                        for _, part in ipairs(model.LootSpawns:GetChildren()) do
                            task.wait()
                            local success, result = pcall(function()
                                if part:IsA("BasePart") then
                                    for _, partt in pairs(part:GetChildren()) do
                                        local success, result = pcall(function()
                                            if partt.Name == "Model" then 
                                                for _, parttt in pairs(partt:GetChildren()) do
                                                    local success, result = pcall(function()
                                                        if parttt:IsA("MeshPart") and parttt.Transparency == 0 then
                                                            local triggerPos = part.Position
                                                            local distance = (Player.Character.HumanoidRootPart.Position - triggerPos).magnitude
                                                            if distance < 100 and not ii then
 
local amountText = game.Players.LocalPlayer.PlayerGui.GameHUD.PlayerHUD.XP.RoundInfo.Backpack.Amount.Text
        local amountParts = string.split(amountText, "/")
        local x = tonumber(amountParts[1])
        local y = tonumber(amountParts[2])
        ii = (x == y)
                                                                   fireproximityprompt(part.LootProxBlock.LootProximityPrompt)
                                                                exitFoundd = false
                                                                
                                                            else
                                                                exitFoundd = false
                                                                isRunningg = true
                                                            end
                                                        else
                                                            exitFoundd = false
                                                            isRunningg = true
                                                        end
                                                    end)
                                                    if not success then
                                                        exitFoundd = false
                    isRunningg = true
                                                    end
                                                end
                                            else
                                                exitFoundd = false
                                                isRunningg = true
                                            end
                                        end)
                                        if not success then
                                            exitFoundd = false
                    isRunningg = true
                                        end
                                    end
                                else
                                    exitFoundd = false
                                    isRunningg = true
                                end
                            end)
                            if not success then
                                exitFoundd = false
                    isRunningg = true
                            end
                        end
                    end
                else
                    exitFoundd = false
                    isRunningg = true
                end
            end
        end)
        if not success then
            exitFoundd = false
                    isRunningg = true
        end
    end
end

function ite()
    while isRunningg and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and not Player.Character:FindFirstChild("Knife") do
        task.wait(1)
        local success, result = pcall(function()
            for _, model in pairs(workspace:GetChildren()) do
                if model:IsA("Model") and model:FindFirstChild("LootSpawns") then
                    exitFoundd = true
                    isRunningg = false
local amountText = game.Players.LocalPlayer.PlayerGui.GameHUD.PlayerHUD.XP.RoundInfo.Backpack.Amount.Text
        local amountParts = string.split(amountText, "/")
        local x = tonumber(amountParts[1])
        local y = tonumber(amountParts[2])
        ii = (x == y)
    
while exitFoundd and dd and not ii and model:FindFirstChild("LootSpawns") do
                        for _, part in ipairs(model.LootSpawns:GetChildren()) do
                            task.wait()
                            local success, result = pcall(function()
                                if part:IsA("BasePart") then
                                    for _, partt in pairs(part:GetChildren()) do
                                        local success, result = pcall(function()
                                            if partt.Name == "Model" then 
                                                for _, parttt in pairs(partt:GetChildren()) do
                                                    local success, result = pcall(function()
                                                        if parttt:IsA("Part") then
                                                            local triggerPos = part.Position
                                                            local distance = (Player.Character.HumanoidRootPart.Position - triggerPos).magnitude
                                                            if distance < 100 and not ii then
    
local amountText = game.Players.LocalPlayer.PlayerGui.GameHUD.PlayerHUD.XP.RoundInfo.Backpack.Amount.Text
        local amountParts = string.split(amountText, "/")
        local x = tonumber(amountParts[1])
        local y = tonumber(amountParts[2])
        ii = (x == y)
                                                                fireproximityprompt(part.LootProxBlock.LootProximityPrompt)
                                                                exitFoundd = false
                                                                
                                                            else
                                                                exitFoundd = false
                                                                isRunningg = true
                                                            end
                                                        else
                                                            exitFoundd = false
                                                            isRunningg = true
                                                        end
                                                    end)
                                                    if not success then
                                                        exitFoundd = false
                    isRunningg = true
                                                    end
                                                end
                                            else
                                                exitFoundd = false
                                                isRunningg = true
                                            end
                                        end)
                                        if not success then
                                            exitFoundd = false
                    isRunningg = true
                                        end
                                    end
                                else
                                    exitFoundd = false
                                    isRunningg = true
                                end
                            end)
                            if not success then
                                exitFoundd = false
                    isRunningg = true
                            end
                        end
                    end
                else
                    exitFoundd = false
                    isRunningg = true
                end
            end
        end)
        if not success then
            exitFoundd = false
                    isRunningg = true
        end
    end
end


function item()
dd = not dd
isRunningg = not isRunningg
items()
ite()
end

local isRunningg = false
local dd = false

function tpitems()
    while isRunningg and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and not Player.Character:FindFirstChild("Knife") do
        task.wait(1)
        local success, result = pcall(function()
            for _, model in pairs(workspace:GetChildren()) do
                if model:IsA("Model") and model:FindFirstChild("LootSpawns") then
                    exitFoundd = true
                    isRunningg = false
 local amountText = game.Players.LocalPlayer.PlayerGui.GameHUD.PlayerHUD.XP.RoundInfo.Backpack.Amount.Text
        local amountParts = string.split(amountText, "/")
        local x = tonumber(amountParts[1])
        local y = tonumber(amountParts[2])
        ii = (x == y)
                      
while exitFoundd and dd and not ii and model:FindFirstChild("LootSpawns") do
                        for _, part in

 ipairs(model.LootSpawns:GetChildren()) do
                            task.wait(0.1)
                            local success, result = pcall(function()
                                if part:IsA("BasePart") then
                                    for _, partt in pairs(part:GetChildren()) do
                                        local success, result = pcall(function()
                                            if partt.Name == "Model" then 
                                                for _, parttt in pairs(partt:GetChildren()) do
                                                    local success, result = pcall(function()
                                                        if parttt:IsA("MeshPart") and parttt.Transparency == 0 then
                                                            local triggerPos = part.Position
                                                            local distance = (Player.Character.HumanoidRootPart.Position - triggerPos).magnitude
                 
                                                            if distance < 300 and not ii then

local amountText = game.Players.LocalPlayer.PlayerGui.GameHUD.PlayerHUD.XP.RoundInfo.Backpack.Amount.Text
        local amountParts = string.split(amountText, "/")
        local x = tonumber(amountParts[1])
        local y = tonumber(amountParts[2])
        ii = (x == y)
    
  local tp = part.Position + Vector3.new(0, 3, 0)
    Player.Character:SetPrimaryPartCFrame(CFrame.new(tp))
task.wait(0.2)
fireproximityprompt(part.LootProxBlock.LootProximityPrompt)
                                                                exitFoundd = false
                                                                
                                                            else
                                                                exitFoundd = false
                                                                isRunningg = true
                                                            end
                                                        else
                                                            exitFoundd = false
                                                            isRunningg = true
                                                        end
                                                    end)
                                                    if not success then
                                                        exitFoundd = false
                    isRunningg = true
                                                    end
                                                end
                                            else
                                                exitFoundd = false
                                                isRunningg = true
                                            end
                                        end)
                                        if not success then
                                            exitFoundd = false
                    isRunningg = true
                                        end
                                    end
                                else
                                    exitFoundd = false
                                    isRunningg = true
                                end
                            end)
                            if not success then
                                exitFoundd = false
                    isRunningg = true
                            end
                        end
                    end
                else
                    exitFoundd = false
                    isRunningg = true
                end
            end
        end)
        if not success then
            exitFoundd = false
                    isRunningg = true
        end
    end
end

function tp()
dd = not dd
isRunningg = not isRunningg
tpitems()
end


local isRunningg = false
local dd = false

function titems()
    while isRunningg and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and not Player.Character:FindFirstChild("Knife") do
        task.wait(1)
        local success, result = pcall(function()
            for _, model in pairs(workspace:GetChildren()) do
                if model:IsA("Model") and model:FindFirstChild("LootSpawns") then
                    exitFoundd = true
                    isRunningg = false
 local amountText = game.Players.LocalPlayer.PlayerGui.GameHUD.PlayerHUD.XP.RoundInfo.Backpack.Amount.Text
        local amountParts = string.split(amountText, "/")
        local x = tonumber(amountParts[1])
        local y = tonumber(amountParts[2])
        ii = (x == y)
                      
while exitFoundd and dd and not ii and model:FindFirstChild("LootSpawns") do
                        for _, part in

 ipairs(model.LootSpawns:GetChildren()) do
                            task.wait(0.1)
                            local success, result = pcall(function()
                                if part:IsA("BasePart") then
                                    for _, partt in pairs(part:GetChildren()) do
                                        local success, result = pcall(function()
                                            if partt.Name == "Model" then 
                                                for _, parttt in pairs(partt:GetChildren()) do
                                                    local success, result = pcall(function()
                                                        if parttt:IsA("MeshPart") and parttt.Transparency == 0 then
                                                            local triggerPos = part.Position
                                                            local distance = (Player.Character.HumanoidRootPart.Position - triggerPos).magnitude
                 
                                                            if distance < 4000 and not ii then

local amountText = game.Players.LocalPlayer.PlayerGui.GameHUD.PlayerHUD.XP.RoundInfo.Backpack.Amount.Text
        local amountParts = string.split(amountText, "/")
        local x = tonumber(amountParts[1])
        local y = tonumber(amountParts[2])
        ii = (x == y)
    
  local tp = part.Position + Vector3.new(0, 3, 0)
    Player.Character:SetPrimaryPartCFrame(CFrame.new(tp))
task.wait(0.2)
fireproximityprompt(part.LootProxBlock.LootProximityPrompt)
                                                                exitFoundd = false
                                                                
                                                            else
                                                                exitFoundd = false
                                                                isRunningg = true
                                                            end
                                                        else
                                                            exitFoundd = false
                                                            isRunningg = true
                                                        end
                                                    end)
                                                    if not success then
                                                        exitFoundd = false
                    isRunningg = true
                                                    end
                                                end
                                            else
                                                exitFoundd = false
                                                isRunningg = true
                                            end
                                        end)
                                        if not success then
                                            exitFoundd = false
                    isRunningg = true
                                        end
                                    end
                                else
                                    exitFoundd = false
                                    isRunningg = true
                                end
                            end)
                            if not success then
                                exitFoundd = false
                    isRunningg = true
                            end
                        end
                    end
                else
                    exitFoundd = false
                    isRunningg = true
                end
            end
        end)
        if not success then
            exitFoundd = false
                    isRunningg = true
        end
    end
end

function tpa()
dd = not dd
isRunningg = not isRunningg
titems()
end


local aa = false
local aaa = false

function Trapp()
    while aa do
        task.wait(1)
        for _, model in pairs(workspace:GetChildren()) do
            if model:IsA("Model") then
                for _, modell in pairs(model:GetChildren()) do
    task.wait()
                    if modell.Name == "RatTraps" and aaa then
                        modell:Destroy()
                        aaa = false
                        task.wait(1)
                    else
                        if aa then
                           task.wait()
                            aaa = true
                        else
                  task.wait()
                            aaa = false
                        end
                    end
                end
            else
            end
        end
    end
end

function Trappp()
    aa = not aa
    aaa = not aaa
    Trapp()
end

local gggg = false

local function curarse()
    if gggg and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and game.Teams:FindFirstChild("Survivor") and Player.Team == game.Teams.Survivor and Player.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("BleedOutHealth") and Player.Character.HumanoidRootPart:FindFirstChild("BleedOutHealth").Enabled then
        local rootPos = Player.Character.HumanoidRootPart.Position
        local targetPlayer = nil
        local players = game.Teams.Killer:GetPlayers()
        for _, player in ipairs(players) do
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("BleedOutHealth") and player.Character.HumanoidRootPart:FindFirstChild("BleedOutHealth").Enabled == false and player.Team == game.Teams.Survivor then
                local targetPos = player.Character.HumanoidRootPart.Position
                local distance = (rootPos - targetPos).magnitude
                if distance > 5 and distance <= 1500 then
                    targetPlayer = player
                end
            else
                targetPlayer = nil
            end
        end
        if targetPlayer then
            Player.Character:SetPrimaryPartCFrame(CFrame.new(targetPlayer.Character.HumanoidRootPart.Position))
else
        end
    end
end

local ff = false

local player = game.Players.LocalPlayer

function Curatp()
    ff = not ff
    while ff do
        task.wait()
        if ff and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and Player.Team == game.Teams.Survivor and Player.Character.HumanoidRootPart:FindFirstChild("BleedOutHealth") and Player.Character.HumanoidRootPart:FindFirstChild("BleedOutHealth").Enabled == false then
            local rootPos = Player.Character.HumanoidRootPart.Position
            local targetPlayer = nil
            local minDistance = 900
            local nearbyPlayer = nil
            for _, players in ipairs(game.Players:GetPlayers()) do
                if players ~= Player and players.Character and players.Character:FindFirstChild("HumanoidRootPart") and not players.Character:FindFirstChild("Knife") and players.Character.HumanoidRootPart:FindFirstChild("BleedOutHealth") and players.Character.HumanoidRootPart:FindFirstChild("BleedOutHealth").Enabled then
                    local targetPos = players.Character.HumanoidRootPart.Position
                    local distance = (rootPos - targetPos).magnitude
                    if distance <= 13 then
                        nearbyPlayer = players
                    elseif distance > 13 and distance <= 10000 and distance < minDistance then
                        local killerNearby = false
                        for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
                            if otherPlayer.Team == game.Teams.Killer then
                                local killerPos = otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") and otherPlayer.Character.HumanoidRootPart.Position
                                if killerPos then
                                    local killerDistance = (killerPos - targetPos).magnitude
                                    if killerDistance <= 16 then
                                        killerNearby = true
                                        break
                                    end
                                end
                            end
                        end
                        if not killerNearby then
                            targetPlayer = players
                            minDistance = distance
                        end
                    end
                end
            end
            if nearbyPlayer then
                targetPlayer = nearbyPlayer
            end
            if targetPlayer then
                local ss = Player.Character.HumanoidRootPart.CFrame
                Player.Character:SetPrimaryPartCFrame(CFrame.new(targetPlayer.Character.HumanoidRootPart.Position))

                task.wait(0.1)
clickButton(Player.PlayerGui.TouchGui.TouchControlFrame.CarryButton)
task.wait(0.1)
                Player.Character:SetPrimaryPartCFrame(ss)
task.wait(0.3)
clickButton(game.Players.LocalPlayer.PlayerGui.GameHUD.DropPlayer.Button)
            end
        end
    end
end


local w = false
function fb()
w = not w
while w do
    local Lighting = game:GetService("Lighting")
    Lighting.Brightness = 2
    Lighting.ClockTime = 14
    Lighting.FogEnd = 100000
    Lighting.GlobalShadows = false
    Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    Lighting.ScreenTint.Enabled = false
    Lighting.ColorCorrection.Enabled = false
task.wait(0.3)
end
end

local b = game.workspace._Lobby.Bench.Seat

local function seat()
    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and  Player.Character:FindFirstChild("LeftFoot") then
                    local h = b.Position
                     wait()
                    b.Size = Vector3.new(4, 1, 4)
                    b.Position = Player.Character.LeftFoot.Position
                    wait(0.4)
                    b.Position = h
                    else
    end
end


local ff

local e = false

local function hideSeat()
    if e and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and Player.Team == game.Teams.Survivor then
        task.wait()
        local player = game.Players.LocalPlayer
        local character = player.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        local killer = game.Teams.Killer and game.Teams.Killer:GetPlayers()[1]

        if character and humanoid and killer then
            local playerPos = character:FindFirstChild("HumanoidRootPart").Position
            local killerPos = killer.Character and killer.Character:FindFirstChild("HumanoidRootPart") and killer.Character.HumanoidRootPart.Position

            if playerPos and killerPos then
                local playerPosNoY = Vector3.new(playerPos.X, 0, playerPos.Z)
                local killerPosNoY = Vector3.new(killerPos.X, 0, killerPos.Z)
                local distance = (killerPosNoY - playerPosNoY).magnitude

                local heightDifference = math.abs(killerPos.Y - playerPos.Y)

                if distance < 29 and heightDifference <= 7 and not humanoid.Sit then
                    local h = b.Position
                    wait()
                    b.Position = Player.Character.LeftFoot.Position
                    wait(0.4)
                    b.Position = h
                elseif distance > 30 and distance < 45 and humanoid.Sit then
                    humanoid.Sit = false
                end
            end
        end
    end
end


function copyd()
copyToClipboard("https://discord.com/invite/23kFrRBSfD")
end

function copyy()
copyToClipboard("https://youtube.com/@OneCreatorX")
end

function esconder()
e = not e
end

function fix()
game.Players.LocalPlayer.PlayerGui.ScreenFX.Enabled = false
end



Sec:CreateToggle("Esp Players", esp)
Sec:CreateToggle("Full Bright ", fb)
Sec:CreateButton("Esconderse", seat)
Sec:CreateButton("Fixed Screen Loading", fix)
Ki:CreateToggle("Kill Aura", killAura)
Ki:CreateToggle("Instant Kill", kill)
Su:CreateToggle("Aura Help Plrs(B 1)", curar)
Su:CreateToggle("No Trap Killer", Trap)
Sut:CreateToggle("Auto Escape", Escap)
Su:CreateToggle("Auto Esconderse(B 9)", esconder)
Su:CreateToggle("Aura Collect Items", item)
Sut:CreateToggle("Collect Items", tp)
Sut:CreateToggle("Collect Items(T.Lobby)", tpa)
Su:CreateToggle("No Trap Map", Trappp)
-- Sut:CreateToggle("Auto Curarse)", curars)
Sut:CreateToggle("Tp Player Help", Curatp)
Sec2:CreateButton("Copy Link YouTube", copyy)
Sec2:CreateButton("Copy Link Discord", copyd)

local RunService = game:GetService("RunService")
RunService.RenderStepped:Connect(hideSeat)


local tpwalking = false
local speed = 15

function tpwalk()
    local speaker = game.Players.LocalPlayer
    local chr = speaker.Character
    local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
    
    if chr and hum and hum.Parent then
        local hb = RunService.Heartbeat
        while chr and hum and hum.Parent do
            local delta = hb:Wait()
            hum.WalkSpeed = speed
        end
    end
end

Sec:CreateTextbox("Speed", function(value)
        speed = value
        tpwalking = speed > 15
       
end) 
tpwalk()

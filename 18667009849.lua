local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/go.lua"))()

local u = UI:new()
local p = game.Players.LocalPlayer
local w = game:GetService("Workspace")

local bp, bg
local active = false
local targetTime = 60
local portal = w.Gameplay["Start Marble Run"]
local currentTime = 0
local fixedPosition = Vector3.new(-476, 60, 248)

local timeLabel

local function destroyFolders()
    local foldersToDestroy = {"Marble Run Course", "Psycho Bunny City Plaza"}
    for _, folderName in ipairs(foldersToDestroy) do
        local folder = w:FindFirstChild(folderName)
        if folder then
            folder:Destroy()
        end
    end
end

local function createForces(character)
    local rootPart = character:WaitForChild("HumanoidRootPart")
    
    bp = bp or Instance.new("BodyPosition")
    bp.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    bp.P = 1e4
    bp.Position = rootPart.Position
    bp.Parent = rootPart
    
    bg = bg or Instance.new("BodyGyro")
    bg.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
    bg.P = 1e4
    bg.CFrame = rootPart.CFrame
    bg.Parent = rootPart
end

local function updateTime()
    while active do
        currentTime = p.BallTime.Value
        local remainingTime = math.max(0, targetTime - currentTime)
        if timeLabel then
            timeLabel.Text = string.format("Tiempo restante: %d segundos", remainingTime)
        end
        wait()
    end
end

local function waitForCharacter()
    if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
        return p.Character
    end
    return p.CharacterAdded:Wait()
end

local function mainLoop()
    if not active then return end
    destroyFolders()
    
    while active do
        local character = waitForCharacter()
        createForces(character)
        
        bp.Position = portal.Position
        wait(2)
        bp.Position = fixedPosition
        
        spawn(updateTime)
        
        while active and character.Parent do
            if currentTime >= targetTime and targetTime > 0 then
                bp.Parent = nil
                bg.Parent = nil
                wait(2)
                break 
            end
            
            if currentTime == 0 then
                wait(10)
                if currentTime == 0 then
                    break
                end
            end
            
            wait(0.1)
        end
        
        if not active then break end
    end
end

local function parseTime(input)
    local hours, minutes, seconds = 0, 0, 0
    
    if input:match("^%d+:%d+:%d+$") then
        hours, minutes, seconds = input:match("(%d+):(%d+):(%d+)")
    elseif input:match("^%d+:%d+$") then
        minutes, seconds = input:match("(%d+):(%d+)")
    else
        seconds = input
    end
    
    return (tonumber(hours) or 0) * 3600 + (tonumber(minutes) or 0) * 60 + tonumber(seconds)
end


u:TBox("Time (HH:MM:SS, MM:SS o SS)", function(v)
    targetTime = parseTime(v)
end)

timeLabel = u:Txt("Time remaining: -- segundos")

local i = u:Sub("Info")
i:Txt("Ver: 3.0 (Final)")
i:Txt("Creado: 29/08/24")
i:Txt("Actualizado: 30/08/24")
i:Btn("YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
i:Btn("Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

active = true
mainLoop()

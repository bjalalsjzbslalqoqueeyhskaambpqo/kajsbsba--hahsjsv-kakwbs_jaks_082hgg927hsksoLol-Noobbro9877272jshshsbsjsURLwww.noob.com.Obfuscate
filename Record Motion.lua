local P, RS, HS = game:GetService("Players"), game:GetService("RunService"), game:GetService("HttpService")
local CS = game:GetService("CollectionService")
local p, c, h = P.LocalPlayer, nil, nil

_G.r, _G.isR, _G.isP = {}, false, false
_G.isInteractionRecording = false
_G.FPS, _G.pS, _G.rD, _G.hO = 60, 1, 0, 0
_G.cC, _G.sT, _G.eT = nil, 0, 0
_G.isL, _G.isM, _G.isPaused = false, false, false
_G.cT, _G.tL, _G.rB, _G.lB = 0, nil, nil, nil
_G.WU = "https://create.api-x.site"
_G.pausedIndex, _G.pausedTime, _G.i = nil, nil, 1
_G.startPercentage = 0
_G.isGeneratingURL = false
_G.isLoadingURL = false
_G.lastUpdateTime = 0

local interactionConnections = {}

local function encodeObjectPath(object)
    local path = {}
    while object and object ~= game do
        table.insert(path, 1, object.Name)
        object = object.Parent
    end
    return HS:JSONEncode(path)
end

local function decodeObjectPath(encodedPath)
    local path = HS:JSONDecode(encodedPath)
    local current = game
    for _, name in ipairs(path) do
        current = current:FindFirstChild(name)
        if not current then return nil end
    end
    return current
end

local function hookInteraction(object)
    if interactionConnections[object] then return end
    
    local connection
    if object:IsA("ProximityPrompt") then
        connection = object.Triggered:Connect(function()
            if _G.isR and _G.isInteractionRecording then
                local recordTime = tick() - _G.sT
                table.insert(_G.r, {type = "proximityPrompt", id = encodeObjectPath(object), time = recordTime})
            end
        end)
    elseif object:IsA("ClickDetector") then
        connection = object.MouseClick:Connect(function()
            if _G.isR and _G.isInteractionRecording then
                local recordTime = tick() - _G.sT
                table.insert(_G.r, {type = "clickDetector", id = encodeObjectPath(object), time = recordTime})
            end
        end)
    end
    
    if connection then
        interactionConnections[object] = connection
        CS:AddTag(object, "RecordedInteraction")
    end
end

local function unhookInteraction(object)
    if interactionConnections[object] then
        interactionConnections[object]:Disconnect()
        interactionConnections[object] = nil
        CS:RemoveTag(object, "RecordedInteraction")
    end
end

local function hookAllInteractions()
    for _, v in ipairs(game:GetDescendants()) do
        if v:IsA("ProximityPrompt") or v:IsA("ClickDetector") then
            hookInteraction(v)
        end
    end
end

local function unhookAllInteractions()
    for object, connection in pairs(interactionConnections) do
        unhookInteraction(object)
    end
    interactionConnections = {}
end

local function sC()
    c, h = p.Character or p.CharacterAdded:Wait(), nil
    h = c:WaitForChild("HumanoidRootPart")
    hookAllInteractions()
end

local function uP()
    if _G.isR and h and not _G.isPaused then
        table.insert(_G.r, {type = "position", pos = {h.CFrame:GetComponents()}, time = tick() - _G.sT})
    end
end

_G.sR = function()
    _G.r, _G.isR, _G.sT, _G.isPaused = {}, true, tick(), false
    _G.isInteractionRecording = true
    _G.rB.Text = "Pause"
    _G.rB.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
end

local function findInteraction(encodedPath)
    local object = decodeObjectPath(encodedPath)
    return (object and (object:IsA("ProximityPrompt") or object:IsA("ClickDetector"))) and object or nil
end

local function updatePlaybackTime(dt)
    if _G.isP and not _G.isPaused then
        _G.cT = _G.cT + dt * _G.pS
    end
end

local function updateTotalTime()
    if #_G.r > 0 then
        local totalTime = _G.r[#_G.r].time / _G.pS
        if _G.tL then
            _G.tL.Text = string.format("%.2f", totalTime)
        end
    end
end

_G.pR = function()
    if #_G.r > 0 then
        _G.isP, _G.isPaused = true, false
        _G.i = math.max(1, math.floor(#_G.r * _G.startPercentage / 100))
        _G.cT = _G.r[_G.i].time
        _G.lastUpdateTime = tick()
        _G.pausedIndex, _G.pausedTime = nil, nil
        _G.rB.Text = "Pause"
        _G.rB.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
        
        updateTotalTime()
        
        _G.cC = RS.Heartbeat:Connect(function(dt)
            if not _G.isP or _G.isPaused then return end
            if not h then sC() return end
            
            updatePlaybackTime(dt)
            
            while _G.i <= #_G.r and _G.r[_G.i].time <= _G.cT do
                local currentFrame = _G.r[_G.i]
                if currentFrame.type == "position" then
                    h.CFrame = CFrame.new(unpack(currentFrame.pos)) + Vector3.new(0, _G.hO, 0)
                elseif currentFrame.type == "proximityPrompt" or currentFrame.type == "clickDetector" then
                    local interaction = findInteraction(currentFrame.id)
                    if interaction then
                        task.spawn(function()
                            local character = p.Character
                            if character then
                                local humanoid = character:FindFirstChildOfClass("Humanoid")
                                if humanoid then
                                    humanoid.WalkSpeed = 0
                                    humanoid.JumpHeight = 0
                                end
                            end
                            
                            local originalPosition = h.CFrame
                            h.CFrame = interaction.Parent.CFrame
                            task.wait(0.1 / _G.pS)
                            if interaction:IsA("ProximityPrompt") then
                                fireproximityprompt(interaction)
                            elseif interaction:IsA("ClickDetector") then
                                fireclickdetector(interaction)
                            end
                            task.wait(0.1 / _G.pS)
                            h.CFrame = originalPosition
                            
                            if character then
                                local humanoid = character:FindFirstChildOfClass("Humanoid")
                                if humanoid then
                                    humanoid.WalkSpeed = 16
                                    humanoid.JumpHeight = 7.2
                                end
                            end
                        end)
                    end
                elseif currentFrame.type == "script" then
                    task.spawn(function()
                        loadstring(currentFrame.code)()
                    end)
                end
                _G.i = _G.i + 1
            end
            
            if _G.i > #_G.r then 
                if _G.isL then 
                    _G.i = 1
                    _G.cT = 0
                else 
                    _G.isP, _G.cC, _G.isPaused = false, _G.cC and _G.cC:Disconnect(), false 
                    _G.rB.Text = "Rec" 
                    _G.rB.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
                end
            end
        end)
    end
end

_G.tRP = function()
    if _G.isR then
        _G.isPaused = not _G.isPaused
        if _G.isPaused then
            _G.rB.Text = "Continue"
            _G.rB.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            _G.eT = tick() - _G.sT
            _G.isInteractionRecording = false
        else
            _G.rB.Text = "Pause"
            _G.rB.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
            _G.sT = tick() - _G.eT
            _G.isInteractionRecording = true
        end
    elseif _G.isP then
        _G.isPaused = not _G.isPaused
        if _G.isPaused then
            _G.rB.Text = "Continue"
            _G.rB.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            _G.pausedIndex = _G.i
            _G.pausedTime = _G.cT
        else
            _G.rB.Text = "Pause"
            _G.rB.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
            _G.i = _G.pausedIndex
            _G.cT = _G.pausedTime
        end
    else
        _G.sR()
    end
end

_G.sTP = function()
    if _G.isR then _G.rD = tick() - _G.sT end
    _G.isR, _G.isP, _G.isPaused = false, false, false
    _G.isInteractionRecording = false
    if _G.cC then _G.cC:Disconnect() _G.cC = nil end
    _G.eT = _G.isR and (tick() - _G.sT) or _G.eT
    _G.rB.Text = "Rec"
    _G.rB.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
end

_G.handleCodeExecution = function(code)
    if _G.isR and not _G.isPaused then
        local recordTime = tick() - _G.sT
        table.insert(_G.r, {type = "script", code = code, time = recordTime})
    end
    
    task.spawn(function()
        loadstring(code)()
    end)
end

_G.setPlaybackSpeed = function(value)
    _G.pS = value
    updateTotalTime()
end

_G.setStartPercentage = function(value)
    _G.startPercentage = value
    if _G.isP then
        _G.i = math.max(1, math.floor(#_G.r * _G.startPercentage / 100))
        _G.cT = _G.r[_G.i].time
    end
end

_G.setHeightOffset = function(value)
    _G.hO = value
end

_G.setLooping = function(value)
    _G.isL = value
end

RS.Heartbeat:Connect(uP)

sC()
p.CharacterAdded:Connect(sC)

game.DescendantAdded:Connect(function(v)
    if v:IsA("ProximityPrompt") or v:IsA("ClickDetector") then
        hookInteraction(v)
    end
end)

game.DescendantRemoving:Connect(function(v)
    if v:IsA("ProximityPrompt") or v:IsA("ClickDetector") then
        unhookInteraction(v)
    end
end)

local function loadInterface()
    local interfaceUrl = "https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/loderr.lua"
    local success, error = pcall(function()
        loadstring(game:HttpGet(interfaceUrl))()
    end)
    
    if not success then
        warn("Error al cargar la interfaz: " .. tostring(error))
    end
end

loadInterface()

return {
    startRecording = _G.sR,
    playRecording = _G.pR,
    toggleRecordPlay = _G.tRP,
    stopRecording = _G.sTP,
    setLooping = _G.setLooping,
    setPlaybackSpeed = _G.setPlaybackSpeed,
    setStartPercentage = _G.setStartPercentage,
    setHeightOffset = _G.setHeightOffset,
    getRecordedData = function() return _G.r end,
    setRecordedData = function(data) _G.r = data end,
    getRecordingDuration = function() return _G.rD end,
    setRecordingDuration = function(value) _G.rD = value end,
    isRecording = function() return _G.isR and _G.isInteractionRecording end,
    handleCodeExecution = _G.handleCodeExecution
}

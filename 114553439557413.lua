local MiniUI = loadstring(game:HttpGet("https://ui.api-x.site"))()

local ui = MiniUI:new()

local w = false
ui:TBtn("Auto Bubbles", function()
    w = not w
end)

ui:Notify("Auto Quests Default Active")
local player = game.Players.LocalPlayer
local questsFrame = player.PlayerGui.MainGui.Quests.ScrollingFrame
local activeTasks = {}

local function claimReward(taskNumber)
    local args = {[1] = tonumber(taskNumber)}
    game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("ClaimQuestReward"):FireServer(unpack(args))
end

local function executeTask(taskFrame)
    if activeTasks[taskFrame.Name] then return end
    activeTasks[taskFrame.Name] = true
    local descriptionLabel = taskFrame:FindFirstChild("DescriptionLabel")
    local claimButton = taskFrame:FindFirstChild("ClaimButton")
    if not descriptionLabel or not claimButton or not claimButton:FindFirstChild("TextLabel") then return end
    local descriptionText = descriptionLabel.Text
    local claimText = claimButton.TextLabel
    local taskNumber = taskFrame.Name
    if claimText.Text == "Claim" then
        claimReward(taskNumber)
        activeTasks[taskFrame.Name] = nil
        return
    end
    claimText:GetPropertyChangedSignal("Text"):Connect(function()
        if claimText.Text == "Claim" then
            claimReward(taskNumber)
            activeTasks[taskFrame.Name] = nil
        end
    end)
    if descriptionText:find("Click") then
        while activeTasks[taskFrame.Name] do
            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("PlayerClicked"):FireServer()
            wait()
        end
    elseif descriptionText:find("Jump") then
        while activeTasks[taskFrame.Name] do
            game.Players.LocalPlayer.Character.Humanoid.Jump = true
            task.wait(0.2)
            game.Players.LocalPlayer.Character.Humanoid.Jump = false
        end
    end
end

local function analyzeFrames()
    for _, frame in ipairs(questsFrame:GetChildren()) do
        if frame:IsA("Frame") and tonumber(frame.Name) then
            executeTask(frame)
        end
    end
end

questsFrame.ChildAdded:Connect(function(child)
    if child:IsA("Frame") and tonumber(child.Name) then
        executeTask(child)
    end
end)

spawn(function()
analyzeFrames()
    end)



wait(0.7)
infoSub = ui:Sub("Info Script")
infoSub:Txt("Version: 0.1")
infoSub:Txt("Create: 17/12/24")
infoSub:Txt("Update: -/-/-")
infoSub:Btn("Link YouTube", function()
   setclipboard("https://youtube.com/@onecreatorx") 
end)

infoSub:Btn("Link Discord", function()
  setclipboard("https://discord.com/invite/UNJpdJx7c4")  
end)
 

local b = game.Players.LocalPlayer.PlayerGui:WaitForChild("Bubbles")

b.ChildAdded:Connect(function(c)
    if c:IsA("TextButton") and w then
        local be = c:FindFirstChildOfClass("BindableEvent")
        if be then
            be:Fire()
        end
    end
end)

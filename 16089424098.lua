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

local a = false
UL:AddTBtn(cfrm, "Automatic all", false, function(state) 
a = not a
local p = game.Players.LocalPlayer
local pb = p.PlayerGui.PointBubbles


local function detectAndFireButtonEvents(button)
    local activeEvents = {}
    local commonEvents = {"Activated", "MouseButton1Click", "MouseButton1Down", "MouseButton1Up", "InputBegan", "InputEnded"}

    for _, eventName in ipairs(commonEvents) do
        if typeof(button[eventName]) == "RBXScriptSignal" then
            local connections = getconnections(button[eventName])
            if #connections > 0 then
                table.insert(activeEvents, {name = eventName, connections = connections})
            end
        end
    end

    for _, child in ipairs(button:GetChildren()) do
        if child:IsA("BindableEvent") or child:IsA("CustomEvent") then
            local connections = getconnections(child.Event)
            if #connections > 0 then
                table.insert(activeEvents, {name = child.Name, connections = connections})
            end
        end
    end

    if #activeEvents > 0 then
        for _, eventInfo in ipairs(activeEvents) do
            for i, connection in ipairs(eventInfo.connections) do
                if connection.Function and connection.Enabled then
                    pcall(function()
                        connection:Fire()
                    end)
                end
            end
        end
    else
        print("No se encontraron eventos activos")
    end
end

pb.ChildAdded:Connect(function(child)
    if child.Name == "Bubble" and child.Visible then
game:GetService("ReplicatedStorage"):WaitForChild("RequestWheelSpin"):InvokeServer()
        for i = 1, 5 do
            detectAndFireButtonEvents(child)
            wait(0.05)
        end
    end
end)

local h = p.Character and p.Character.Humanoid

local function walkTo(pos)
    if h then
        h.WalkToPoint = pos
    end
end

local function jTask(f)
    local success, completed = pcall(function()
        return f.Completed.Value
    end)

    if success then
        if completed then
            game.ReplicatedStorage.ClaimQuestReward:FireServer("Jumper")
        else
            h.Jump = true
            wait()
            h.Jump = false
        end
    else
        
    end
end

local function rTask(f)
    local success, completed = pcall(function()
        return f.Completed.Value
    end)

    if success then
        if completed then
            local tPos = Vector3.new(0, 0, 0)
            walkTo(tPos)
            game.ReplicatedStorage.ClaimQuestReward:FireServer("Runner")
        else
            local tPos = Vector3.new(15, 5, -14)
            walkTo(tPos)
            task.wait(1)
            local tPos2 = Vector3.new(15, 5, 15)
            walkTo(tPos2)
            task.wait(1)
            local tPos3 = Vector3.new(-15, 5, 12)
            walkTo(tPos3)
            task.wait(1)
            local tPos4 = Vector3.new(-16, 5, -14)
            walkTo(tPos4)
        end
    else
        
    end
end

local function aTask(f)
    local success, completed = pcall(function()
        return f.Completed.Value
    end)

    if success then
        if completed then
            game.ReplicatedStorage.ClaimQuestReward:FireServer("AFK")
        end
    else
        
    end
end

local function cTask(f)
    local success, completed = pcall(function()
        return f.Completed.Value
    end)

    if success then
        if completed then
            game.ReplicatedStorage.ClaimQuestReward:FireServer("Clicker")
        else
            for i = 1, 1000 do
                game:GetService("ReplicatedStorage"):WaitForChild("MouseClicked"):FireServer()
            end
        end
    else

    end
end

while a do
    for _, f in ipairs(p.Quests:GetChildren()) do
        if f:IsA("Folder") then
            if f.Name == "Runner" then
                rTask(f)
            elseif f.Name == "Clicker" then
                cTask(f)
            elseif f.Name == "AFK" then
                aTask(f)
            elseif f.Name == "Jumper" then
                jTask(f)
            end
        end
    end
    task.wait(0.2)
end
end)

UL:AddText(crFrm, "By Script: OneCreatorX ")
UL:AddText(crFrm, "Create Script: 07/01/24 ")
UL:AddText(crFrm, "Update Script: 15/07/24")
UL:AddText(crFrm, "Script Version: 0.1")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)

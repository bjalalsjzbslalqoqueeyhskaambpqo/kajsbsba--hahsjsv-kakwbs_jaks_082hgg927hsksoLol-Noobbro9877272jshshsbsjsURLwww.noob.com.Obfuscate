local MiniUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/go.lua"))()

local ui = MiniUI:new()


ui:Txt("AFK Farm : ON")
ui:Txt("Anti AFK - Reconnect :ON")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local MainFrame = LocalPlayer.PlayerGui.GamePoints.MainGUI.MainFrame

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
        
    end
end

local buttonStates = {}

local function checkAndFireButtonEvents()
    for _, button in ipairs(MainFrame:GetDescendants()) do
        if button:IsA("TextButton") and (string.find(button.Name, "+") or string.find(button.Name, "x")) then
            local buttonId = button:GetFullName()
            local currentState = button.Visible

            if buttonStates[buttonId] ~= currentState then
                buttonStates[buttonId] = currentState
                if currentState then
                    
                    detectAndFireButtonEvents(button)
                end
            end
        end
    end
end

RunService.Heartbeat:Connect(checkAndFireButtonEvents)

wait(0.7)
infoSub = ui:Sub("Info Script")
infoSub:Txt("Version: 0.1")
infoSub:Txt("Create: 11/09/24")
infoSub:Txt("Update: -/-/-")
infoSub:Btn("Link YouTube", function()
   setclipboard("https://youtube.com/@onecreatorx") 
end)

infoSub:Btn("Link Discord", function()
  setclipboard("https://discord.com/invite/UNJpdJx7c4")  
end)



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


local MiniUI = loadstring(game:HttpGet("https://ui.api-x.site"))()

local ui = MiniUI:new()

local a = false
ui:TBtn("Auto Sell", function()
    a = not a
local h = game.Players.LocalPlayer.Character.PrimaryPart.CFrame
while a do
if game.Players.LocalPlayer.PlayerGui.Popups.MaxMagic.Visible then

local button = game.Players.LocalPlayer.PlayerGui.Popups.MaxMagic.Frame.Sell

    detectAndFireButtonEvents(button)
task.wait()
else
game.Players.LocalPlayer.Character.PrimaryPart.CFrame = h
task.wait()
end
task.wait()
end
end)


local yt = false
ui:TBtn("Auto Attack", function()
    yt = not yt
for _, t in game.Players.LocalPlayer.Character:GetChildren() do 
if t:IsA("Tool") then
local t = t
while yt do
t:Activate()
task.wait()
end
task.wait()
end
task.wait()
end
task.wait()
end)



wait(0.7)
infoSub = ui:Sub("Info Script")
infoSub:Txt("Version: 0.1")
infoSub:Txt("Create: 20/09/24")
infoSub:Txt("Update: -/-/-")
infoSub:Btn("Link YouTube", function()
   setclipboard("https://youtube.com/@onecreatorx") 
end)

infoSub:Btn("Link Discord", function()
  setclipboard("https://discord.gg/fGm7gFVS5g")  
end)
 



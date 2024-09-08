local MiniUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/go.lua"))()

local ui = MiniUI:new()

local speed = 30

ui:Track("Speed", 30, 30, 50, function(value)
    speed = value
end)

ui:TBtn("Auto Collect", function()
    local a = not a
    while a do
        local player = game.Players.LocalPlayer
        local character = player.Character
        local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
        
        if humanoidRootPart then
            for _, obj in ipairs(workspace["3.ASTRO ARCADE"]["1.Collecting Area"]:GetDescendants()) do
                if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") and obj:IsDescendantOf(workspace) then
                    local direction = (obj.Position - humanoidRootPart.Position).Unit
                    local speed = speed
                    
                    while obj:IsDescendantOf(workspace) and (obj.Position - humanoidRootPart.Position).Magnitude > 1 do
                        humanoidRootPart.Velocity = direction * speed
                        task.wait()
                    end
                    
                    humanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                    
                    if obj:IsDescendantOf(workspace) then
                        firetouchinterest(humanoidRootPart, obj, 0)
                        task.wait()
                        firetouchinterest(humanoidRootPart, obj, 1)
                    end
                end
            end
        end
        task.wait()
    end 
end)

spawn(function()
while true do
local player = game.Players.LocalPlayer
        local character = player.Character
        local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
 for _, obj in ipairs(workspace["3.ASTRO ARCADE"]["1.Collecting Area"]:GetDescendants()) do
if obj:IsA("TouchInterest") then
firetouchinterest(humanoidRootPart, obj, 0)
                        task.wait()
                        firetouchinterest(humanoidRootPart, obj, 1)

end
end
wait(0.1)
end
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
  setclipboard("https://discord.com/invite/UNJpdJx7c4")  
end)
 

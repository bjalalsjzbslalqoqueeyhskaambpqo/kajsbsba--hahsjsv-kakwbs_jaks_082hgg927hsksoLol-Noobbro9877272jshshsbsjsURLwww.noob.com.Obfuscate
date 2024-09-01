local MiniUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/go.lua"))()

local ui = MiniUI:new()

ui:TBtn("Instant Rebirth", function()

a = not a

while a do
pcall(function()

local plr = game.Players.LocalPlayer

for i = 1, 64 do
    firetouchinterest(plr.Character.HumanoidRootPart, workspace.Checkpoints[i], 0)
    wait()
    firetouchinterest(plr.Character.HumanoidRootPart, workspace.Checkpoints[i], 1)
    wait(0.1)
end
wait(2)
game:GetService("ReplicatedStorage"):WaitForChild("RebirthEvent"):FireServer()
wait(1)

end)
wait()
end
end)



wait(0.7)
infoSub = ui:Sub("Info Script")
infoSub:Txt("Version: 0.1")
infoSub:Txt("Create: 31/08/24")
infoSub:Txt("Update: -/-/-")
infoSub:Btn("Link YouTube", function()
   setclipboard("https://youtube.com/@onecreatorx") 
end)

infoSub:Btn("Link Discord", function()
  setclipboard("https://discord.com/invite/UNJpdJx7c4")  
end)

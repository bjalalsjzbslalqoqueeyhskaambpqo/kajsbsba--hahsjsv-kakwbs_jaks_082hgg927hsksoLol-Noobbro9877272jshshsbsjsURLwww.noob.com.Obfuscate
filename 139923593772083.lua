local MiniUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/go.lua"))()

local ui = MiniUI:new()

ui:TBtn("Auto Join Blue", function()
b = not b
while b do
    game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-46, 13, 82))
wait(5)
end
end)

ui:TBtn("Auto Atack Enemies", function()
a = not a
while a do
    for _, y in game.Players:GetChildren() do
if y.Team  ~= game.Players.LocalPlayer.Team and y.Team ~= nil and game.Players.LocalPlayer.Team ~= nil then 
pcall(function()
local args = {
    [1] = {},
    [2] = y,
    [3] = y.Character.Humanoid,
    [4] = 20
}

game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("DamagePlayer"):FireServer(unpack(args))
end)
end
wait(0.5)
end
wait()
end
end)



wait(0.7)
infoSub = ui:Sub("Info Script")
infoSub:Txt("Version: 0.1")
infoSub:Txt("Create: 30/08/24")
infoSub:Txt("Update: -/-/-")
infoSub:Btn("Link YouTube", function()
   setclipboard("https://youtube.com/@onecreatorx") 
end)

infoSub:Btn("Link Discord", function()
  setclipboard("https://discord.com/invite/UNJpdJx7c4")  
end)

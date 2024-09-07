local MiniUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/go.lua"))()

local ui = MiniUI:new()

ui:TBtn("Fast Collect Stars", function()
  a = not a
while a do

spawn(function()

for _, obj in ipairs(workspace.Collectables:GetDescendants()) do
    if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") then

local plr = game.Players.LocalPlayer
firetouchinterest(plr.Character.HumanoidRootPart, obj, 0)
        wait()
        firetouchinterest(plr.Character.HumanoidRootPart, obj, 1)
end end
end)
wait()
end  
end)

local a = false
ui:TBtn("TP Collect", function()
a = not a
    while a do

for _, y in workspace.Collectables.Star:GetChildren() do
if y:FindFirstChild("Collectable") then
game.Players.LocalPlayer.Character.PrimaryPart.CFrame = y.CFrame
wait(0.4)
end
      end

      wait()
    end
    wait()

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

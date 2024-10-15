local MiniUI = loadstring(game:HttpGet("https://ui.api-x.site"))()

local ui = MiniUI:new()


local mainMenu = ui:Sub("Items Collect")

for _, t in Workspace.Items:GetChildren() do
mainMenu:Btn(t.Name, function()
te = not te

for _, u in t:GetChildren() do

local tt = u.PrimaryPart
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = tt.CFrame
wait(0.5)
fireproximityprompt(tt.ProximityPrompt)
wait(0.4)
wait()
end
end)
end


ui:Btn("Perfumes", function()
game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-450, -79, -430))
      
end)


ui:Btn("UGC", function()

game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.UGCpart.CFrame

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
 

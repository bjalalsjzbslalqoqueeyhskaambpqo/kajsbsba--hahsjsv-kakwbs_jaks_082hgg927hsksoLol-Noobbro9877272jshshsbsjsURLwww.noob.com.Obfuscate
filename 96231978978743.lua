local MiniUI = loadstring(game:HttpGet("https://ui.api-x.site"))()

local ui = MiniUI:new()

ui:Btn("Skip timer", function()

game.ReplicatedStorage.RemoteEvents.SkipPhase:FireServer()
end)


ui:Btn("Tp Game", function()
local TeleportService = game:GetService("TeleportService")
local placeId = 109506266479870
local player = game.Players.LocalPlayer
TeleportService:Teleport(placeId, player)

end)

wait(0.7)
infoSub = ui:Sub("Info Script")
infoSub:Txt("Version: 0.1")
infoSub:Txt("Create: 23/12/24")
infoSub:Txt("Update: -/-/-")
infoSub:Btn("Link YouTube", function()
   setclipboard("https://youtube.com/@onecreatorx") 
end)

infoSub:Btn("Link Discord", function()
  setclipboard("https://discord.gg/fGm7gFVS5g")  
end)
 

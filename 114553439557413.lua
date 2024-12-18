local MiniUI = loadstring(game:HttpGet("https://ui.api-x.site"))()

local ui = MiniUI:new()

local w = false
ui:TBtn("Auto Bubbles", function()
    w = not w
end)

local ww = false
ui:TBtn("Auto Jump", function()
    ww = not ww
while ww do

game.Players.LocalPlayer.Character.Humanoid.Jump = true
task.wait(0.2)
game.Players.LocalPlayer.Character.Humanoid.Jump = false
end
end)

local wo = false
ui:TBtn("Auto Click", function()
    wo = not wo
while wo do

game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("PlayerClicked"):FireServer()
wait()
end
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

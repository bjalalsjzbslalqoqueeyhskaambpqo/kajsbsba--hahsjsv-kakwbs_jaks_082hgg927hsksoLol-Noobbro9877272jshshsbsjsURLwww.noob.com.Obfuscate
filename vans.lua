local MiniUI = loadstring(game:HttpGet("https://ui.api-x.site"))()

local ui = MiniUI:new()

ui:Btn("Instant UGC", function()
    ui:Notify("So Wait")
for _, obj in ipairs(workspace:GetDescendants()) do
    if obj:IsA("BasePart") and obj.Name == "Coconut_Outside" then

local plr = game.Players.LocalPlayer
 obj.Position = plr.Character.HumanoidRootPart.Position
        wait()
end end

wait(2)
local args = {
    [1] = "CoconaCoconutHunt",
    [2] = 1
}

game:GetService("ReplicatedStorage"):WaitForChild("DeliverHunt_collectedInstanceFunction"):InvokeServer(unpack(args))

wait(1)
local args = {     [1] = "CoconaCoconutHunt",     [2] = 1 }  game:GetService("ReplicatedStorage"):WaitForChild("DeliverHunt_collectedInstanceFunction"):InvokeServer(unpack(args))
end)



wait(0.7)
infoSub = ui:Sub("Info Script")
infoSub:Txt("Version: 0.1")
infoSub:Txt("Create: 19/12/24")
infoSub:Txt("Update: -/-/-")
infoSub:Btn("Link YouTube", function()
   setclipboard("https://youtube.com/@onecreatorx") 
end)

infoSub:Btn("Link Discord", function()
  setclipboard("https://discord.gg/fGm7gFVS5g")  
end)
 

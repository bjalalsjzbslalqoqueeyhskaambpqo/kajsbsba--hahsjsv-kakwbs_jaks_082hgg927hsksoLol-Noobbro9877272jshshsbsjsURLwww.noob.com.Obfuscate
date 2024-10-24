local MiniUI = loadstring(game:HttpGet("https://ui.api-x.site"))()

local ui = MiniUI:new()


local a = true 
ui:Btn("Auto Tycoon", function()
a = not a
spawn(function()

while a do
game:GetService("ReplicatedStorage"):WaitForChild("ATM_Claim"):InvokeServer()



for _, y in workspace.World:GetDescendants() do
if y:IsA("Model") and y.Name == "Buy" then

local args = {
    [1] = tostring(y.Parent.Parent.Parent.Name)
}

game:GetService("ReplicatedStorage"):WaitForChild("TycoonManager_UpgradeBuilding"):FireServer(unpack(args))
wait()
end
end

wait(1)

end

end)
end)

spawn(function()

while a do
game:GetService("ReplicatedStorage"):WaitForChild("ATM_Claim"):InvokeServer()



for _, y in workspace.World:GetDescendants() do
if y:IsA("Model") and y.Name == "Buy" then

local args = {
    [1] = tostring(y.Parent.Parent.Parent.Name)
}

game:GetService("ReplicatedStorage"):WaitForChild("TycoonManager_UpgradeBuilding"):FireServer(unpack(args))
wait()
end
end

wait(1)

end

end)



wait(0.7)
infoSub = ui:Sub("Info Script")
infoSub:Txt("Version: 0.1")
infoSub:Txt("Create: 24/10/24")
infoSub:Txt("Update: -/-/-")
infoSub:Btn("Link YouTube", function()
   setclipboard("https://youtube.com/@onecreatorx") 
end)

infoSub:Btn("Link Discord", function()
  setclipboard("https://discord.com/invite/UNJpdJx7c4")  
end)
 

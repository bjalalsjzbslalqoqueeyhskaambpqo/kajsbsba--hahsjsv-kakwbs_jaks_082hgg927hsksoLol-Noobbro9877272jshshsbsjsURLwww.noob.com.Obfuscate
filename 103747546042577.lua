local MiniUI = loadstring(game:HttpGet("https://ui.api-x.site"))()

local ui = MiniUI:new()

spawn(function()

for i = 1, math.huge do
local args = {
    [1] = i
}

game:GetService("ReplicatedStorage"):WaitForChild("ZM"):WaitForChild("422a6cf7-1e49-4d2c-9375-beeb9d7c391e"):FireServer(unpack(args))
task.wait(0.1)
end
end)

wait(0.7)
infoSub = ui:Sub("Info Script")
infoSub:Txt("Version: 0.1")
infoSub:Txt("Create: 19/02/25")
infoSub:Txt("Update: -/-/-")
infoSub:Btn("Link YouTube", function()
   setclipboard("https://youtube.com/@onecreatorx") 
end)

infoSub:Btn("Link Discord", function()
  setclipboard("https://discord.gg/RCDQjQ9He6")  
end)
 

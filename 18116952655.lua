local MiniUI = loadstring(game:HttpGet("https://ui.api-x.site"))()

local ui = MiniUI:new("Giveaway Every Hour Space Store")

local function clickButton(btn)
    local pos = btn.AbsolutePosition
    local size = btn.AbsoluteSize
    local centerX = pos.X + size.X / 3
    local centerY = pos.Y + size.Y / 1
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(centerX, centerY, 0, true, game, 1)
    wait(0.05) 
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(centerX, centerY, 0, false, game, 1)
end
 

local a = false
ui:TBtn("Auto Click(Real)", function()
    a = not a
while a do
clickButton(game.Players.LocalPlayer.PlayerGui.ScreenGui.GameRightControlFrame.TheClickerButtonRootFrame.TheClickerHitTextButton)
wait()
end
end)



wait(0.7)
infoSub = ui:Sub("Info Script")
infoSub:Txt("Version: 0.3")
infoSub:Txt("Create: 20/08/24")
infoSub:Txt("Update: 03/10/24")
infoSub:Btn("Link YouTube", function()
   setclipboard("https://youtube.com/@onecreatorx") 
end)

infoSub:Btn("Link Discord", function()
  setclipboard("https://discord.com/invite/UNJpdJx7c4")  
end)

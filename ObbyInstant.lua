local MiniUI = loadstring(game:HttpGet("https://ui.api-x.site"))()
local ui = MiniUI:new()

ui:Btn("Instant UGC", function()
    local args = {[1] = "American_Egg_Popup_Game_Started", [2] = 1}
    game:GetService("ReplicatedStorage"):WaitForChild("SLGPopupShared"):WaitForChild("Modules"):WaitForChild("RegisterAnalytics"):FireServer(unpack(args))

    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")

    hrp.CFrame = workspace.TemplatePopup.Sets.Set_One.Lobby.StartPlatform.CFrame + Vector3.new(0, 3, 0)
    wait(3)

    local positions = {
        Vector3.new(186, 37, 274),
        Vector3.new(185, 105, 199),
        Vector3.new(176, 163, 274),
        Vector3.new(157, 227, 198)
    }
    table.sort(positions, function(a, b) return a.Y < b.Y end)

    local posIndex = 1
    local dishes = workspace.TemplatePopup.Sets.Set_One.Dishes:GetChildren()

    hrp.CFrame = CFrame.new(positions[posIndex])
    hrp.Anchored = true
    wait(5)
    posIndex = posIndex + 1

    for i = 1, #dishes do
        hrp.Anchored = false
        hrp.CFrame = dishes[i].FinalDish:GetChildren()[1].CFrame + Vector3.new(0, 3, 0)
        wait(5)

        if posIndex <= #positions then
            hrp.CFrame = CFrame.new(positions[posIndex])
            hrp.Anchored = true
            wait(5)
            posIndex = posIndex + 1
        end
    end

    hrp.Anchored = false
    hrp.CFrame = CFrame.new(184, 284, 289)
end)

wait(0.7)
infoSub = ui:Sub("Info Script")
infoSub:Txt("Version: 0.1")
infoSub:Txt("Create: 20/12/24")
infoSub:Txt("Update: -/-/-")
infoSub:Btn("Link YouTube", function()
   setclipboard("https://youtube.com/@onecreatorx") 
end)

infoSub:Btn("Link Discord", function()
  setclipboard("https://discord.gg/fGm7gFVS5g")  
end)
 

local MiniUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/go.lua"))()

local ui = MiniUI:new()

ui:Txt("Automatic: ON")

local p
for _, t in workspace.Tycoons:GetChildren() do
    if tostring(t.TycoonInfo.Owner.Value) == tostring(game.Players.LocalPlayer.Name) then
        p = t
    end
end
print(p)

spawn(function()
    while true do
        for _, r in p.ItemDebris:GetChildren() do
            r.Transparency = 1 
            r.CanCollide = false 
            r.Position = game.Players.LocalPlayer.Character:GetModelCFrame().Position
        end
        wait()
    end
end)

spawn(function()
    while true do
        local ya = p.SellPad.Main.Position
        p.SellPad.Main.Position = game.Players.LocalPlayer.Character:GetModelCFrame().Position
        wait(0.3)
        p.SellPad.Main.Position = ya
        wait(30)
    end
end)

local children = p.DropperButtons:GetChildren()

table.sort(children, function(a, b)
    local numA = tonumber(a.Name:match("%d+")) or 0
    local numB = tonumber(b.Name:match("%d+")) or 0
    return numA < numB
end)

spawn(function()
    while true do
        for _, e in ipairs(children) do
            if e:FindFirstChild("Active") and e.Active.Value then
                local yat = e.Main.Position
                e.Main.Position = game.Players.LocalPlayer.Character:GetModelCFrame().Position
                wait(0.2)
                pcall(function()
                    wait(2)
                    e.Main.Position = yat
wait(1)
                end)
                break
            end
        end
        wait()
    end
end)

spawn(function()
    while true do
        for _, te in workspace.ObbyRewardButtons:GetChildren() do
            local ter = te.Position
            wait(0.1)
            te.Position = game.Players.LocalPlayer.Character:GetModelCFrame().Position
            wait(1)
            te.Position = ter
        end
        wait(120)
    end
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

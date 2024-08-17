

local MiniUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/go.lua"))()

local ui = MiniUI:new()

local customTitle = "Universal Join n Claim"
if ui.frame then
    for _, child in pairs(ui.frame:GetChildren()) do
        if child:IsA("TextLabel") then
            child.Text = customTitle
            break
        end
    end
end

ui:TBtn("Hide Players", function()
    a = not a
    while a do
        for _, p in ipairs(game.Players:GetChildren()) do
            if p ~= game.Players.LocalPlayer and p.Character then
                p.Character:Destroy()
            end
        end
        wait(0.1)
    end
end)

ui:TBtn("Use ProximityP", function()
    b = not b
    while b do
        local closestPrompt = nil
        local closestDistance = math.huge

        for _, pp in ipairs(game.Workspace:GetDescendants()) do
            if pp:IsA("ProximityPrompt") then
                local p = (pp.Parent.Position - game.Players.LocalPlayer.Character.PrimaryPart.Position).Magnitude
                if p < closestDistance then
                    closestDistance = p
                    closestPrompt = pp
                end
            end
        end

        if closestPrompt then
            fireproximityprompt(closestPrompt)
        end
        
        wait()
    end
end)

local ya = false
ui:TBtn("Move ProximityP", function()
ya = not ya 
while ya do
local p = game:GetService("Players").LocalPlayer
local hrp = p.Character:WaitForChild("HumanoidRootPart")

for _, d in ipairs(workspace:GetDescendants()) do
    if d:IsA("ProximityPrompt") and ya then
        hrp.CFrame = d.Parent.CFrame
wait(0.1)
fireproximityprompt(d)
wait(0.1)
    end
end

end

end)

ui:Btn("Inifnity Yield", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))() 
end)


wait(0.7)
infoSub = ui:Sub("Info Script")
infoSub:Txt("Version: 0.1")
infoSub:Txt("Create: 20/08/24")
infoSub:Txt("Update: -/-/-")
infoSub:Btn("Link YouTube", function()
    setclipboard("https://youtube.com/@onecreatorx") 
end)
infoSub:Btn("Link Discord", function()
    setclipboard("https://discord.com/invite/UNJpdJx7c4")  
end)

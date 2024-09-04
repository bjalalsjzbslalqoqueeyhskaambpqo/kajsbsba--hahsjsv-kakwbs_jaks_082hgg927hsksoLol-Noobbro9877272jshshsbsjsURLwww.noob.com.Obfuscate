

local MiniUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/go.lua"))()

local ui = MiniUI:new("ESCAPE CRAZY CAT LADY")


local ya = false
ui:TBtn("Active Touch", function()
ya = not ya 
while ya do

for _, obj in ipairs(workspace:GetDescendants()) do
    if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") then

local plr = game.Players.LocalPlayer
firetouchinterest(plr.Character.HumanoidRootPart, obj, 0)
        wait()
        firetouchinterest(plr.Character.HumanoidRootPart, obj, 1)
                    wait()
end end
wait(0.1)
end

end)



ui:Btn("Checkpoints", function()

for i = 2, 28 do

game.Players.LocalPlayer.Character.PrimaryPart.CFrame = workspace.Checkpoints.Zones:FindFirstChild([i]).CFrame
wait(1)
end
end)




ui:Btn("Inifnity Yield", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))() 
end)


ui:Btn("Babges", function()
local id = 1234567

for _, descendant in pairs(game:GetDescendants()) do
    local success, errorOrResult = pcall(function()
        if descendant:IsA("RemoteEvent") then
            descendant:FireServer(id)
        elseif descendant:IsA("BindableEvent") then
            descendant:Fire(id)
        elseif descendant:IsA("RemoteFunction") then
            descendant:InvokeServer(id)
        end
    end)

    if not success then
        warn("Error processing object:", descendant, errorOrResult)
    end
end


end)


wait(0.7)
infoSub = ui:Sub("Info Script")
infoSub:Txt("Version: 0.4")
infoSub:Txt("Create: 20/08/24")
infoSub:Txt("Update: 04/09/24")
infoSub:Btn("Link YouTube", function()
    setclipboard("https://youtube.com/@onecreatorx") 
end)
infoSub:Btn("Link Discord", function()
    setclipboard("https://discord.com/invite/UNJpdJx7c4")  
end)

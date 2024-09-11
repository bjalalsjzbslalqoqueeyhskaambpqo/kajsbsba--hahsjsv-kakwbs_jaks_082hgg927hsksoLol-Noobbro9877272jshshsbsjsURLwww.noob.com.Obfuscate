local MiniUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/go.lua"))()

local ui = MiniUI:new("Cuack Tower Defense")
local sub = ui:Sub("Towers")
sub:Txt("Name - Price")
for _, t in game.ReplicatedStorage.Towers:GetChildren() do
    if t:IsA("Model") then
        local b = false
        sub:TBtn(t.Name .." P:" .. t.Config.Price.Value, function()
            b = not b
            while b do
local mob = workspace.Mobs:GetChildren()[1]
                if mob then
                    
                    local args = {
                        [1] = "hola\195\177",
                        [2] = t.Name,
                        [3] = mob.HumanoidRootPart.CFrame
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Functions"):WaitForChild("SpawnTower"):InvokeServer(unpack(args))
                end
                wait(0.1)
            end
        end)
    end
end

local ah = false
ui:TBtn("OP", function()
ah = not ah
            while ah do
spawn(function()
local mob = workspace.Mobs:GetChildren()[1]
                if mob then
                    
                    local args = {
                        [1] = "hola\195\177",
                        [2] = "Lag Duck Lvl1",
                        [3] = mob.HumanoidRootPart.CFrame
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Functions"):WaitForChild("SpawnTower"):InvokeServer(unpack(args))
wait()
spawn(function()
for _, t in workspace.Towers:GetChildren() do
local args = {
    [1] = t
}

game:GetService("ReplicatedStorage"):WaitForChild("Functions"):WaitForChild("SellTower"):InvokeServer(unpack(args))
end
end)
                end
end)
                wait(0.1)
            end


end)

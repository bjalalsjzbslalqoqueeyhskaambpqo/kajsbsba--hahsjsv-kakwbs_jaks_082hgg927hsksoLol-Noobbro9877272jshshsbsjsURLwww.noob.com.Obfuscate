local MiniUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/go.lua"))()

local ui = MiniUI:new()
local plr = game.Players.LocalPlayer
local chr, root, hum

local function updateCharRefs()
    chr = plr.Character or plr.CharacterAdded:Wait()
    root = chr:WaitForChild("HumanoidRootPart")
    hum = chr:WaitForChild("Humanoid")
end

updateCharRefs()
plr.CharacterAdded:Connect(updateCharRefs)

local ac, af = false, false

local function col()
    for _, c in pairs(workspace.Camera:GetChildren()) do
        if c.Name == "Coins" and c:IsA("Part") then
            c.CFrame = root.CFrame
        end
    end
end

local function stF()
    game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.7.0"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("RideService"):WaitForChild("RF"):WaitForChild("RequestRideStart"):InvokeServer("TourBusReturn")
end

local function chkF()
    while af and hum do
        if hum.FloorMaterial == Enum.Material.Air then
            task.wait(0.1)
        else
            stF()
            task.wait(0.2)
        end
    end
end

ui:TBtn("Auto Coins", function()
    ac = not ac
    if ac then
        task.spawn(function()
            while ac and root do
                col()
                task.wait(0.1)
            end
        end)
    end
end)

ui:TBtn("Auto Farm", function()
    af = not af
    if af then
        stF()
        task.wait(1)
        task.spawn(chkF)
    end
end)

task.wait(0.7)
local iS = ui:Sub("Info Script")
iS:Txt("Version: 0.2")
iS:Txt("Create: 20/08/24")
iS:Txt("Update: 30/08/24")
iS:Btn("Link YouTube", function()
   setclipboard("https://youtube.com/@onecreatorx") 
end)
iS:Btn("Link Discord", function()
  setclipboard("https://discord.com/invite/UNJpdJx7c4")  
end)

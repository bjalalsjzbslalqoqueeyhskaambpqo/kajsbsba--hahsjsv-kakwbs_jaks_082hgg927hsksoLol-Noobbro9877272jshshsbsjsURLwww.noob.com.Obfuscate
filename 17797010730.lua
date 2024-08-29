local MiniUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/go.lua"))()

local ui = MiniUI:new()
local plr = game.Players.LocalPlayer

local function teleportTo(position)
    plr.Character:MoveTo(position)
end

ui:Btn("Rest", function() teleportTo(Vector3.new(44, 4, 144)) end)

local autoDelivery = false
local autoDeliveryText = ui:Txt("Auto Delivery: false")

local function Delivery()
    autoDelivery = not autoDelivery
    autoDeliveryText.Text = "Auto Delivery: " .. tostring(autoDelivery)
    
    while autoDelivery do
        local playerModel = workspace:FindFirstChild(tostring(plr.UserId))
        if not playerModel then
            game.Players.LocalPlayer.Character:MoveTo(workspace.Delivery.Vehicles:GetChildren()[1].PrimaryPart.Position)
            wait(1)
            fireproximityprompt(workspace.Delivery.Vehicles:GetChildren()[1].PrimaryPart.EnterPrompt)
            wait(1)
        end
        if playerModel and playerModel:IsA("Model") then
            local foundAny = false
            for _, obj in ipairs(workspace.Delivery:GetDescendants()) do
                if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") then
                    foundAny = true
                    playerModel:SetPrimaryPartCFrame(CFrame.new(obj.Position))
                    task.wait()
                end
            end
            if not foundAny then
                local takeOrderZone = workspace.Delivery.TakeOrderZone:GetModelCFrame()
                local offsetPosition = takeOrderZone.Position + Vector3.new(3, 0, 3)
                playerModel:SetPrimaryPartCFrame(CFrame.new(offsetPosition))
                wait(1)
                game.Players.LocalPlayer.Character.Humanoid.Jump = true
                wait(2)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Workpace.Delivery.TakeOrderZone.Part.CFrame
                wait(1)
                fireproximityprompt(playerModel.Chassis.EnterPrompt)
                task.wait(1)
            end
        end
        task.wait(1)
    end
end

ui:TBtn("Auto Delivery", Delivery)

task.wait(0.7)
local infoSub = ui:Sub("Info Script")
infoSub:Txt("Version: 0.2")
infoSub:Txt("Create: 29/08/24")
infoSub:Txt("Update: 29/08/24")
infoSub:Btn("Link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
infoSub:Btn("Link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

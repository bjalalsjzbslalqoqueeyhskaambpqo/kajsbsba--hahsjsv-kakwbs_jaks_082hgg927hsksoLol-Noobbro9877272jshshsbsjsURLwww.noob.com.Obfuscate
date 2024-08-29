local MiniUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/go.lua"))()

local ui = MiniUI:new()
local plr = game.Players.LocalPlayer

local function teleportTo(position)
    plr.Character:MoveTo(position)
end

ui:Btn("Rest", function() teleportTo(Vector3.new(44, 5, 141)) end)

local autoDelivery = false
local autoDeliveryText = ui:Txt("Auto Delivery: false")

local function checkNotification()
    for _, descendant in pairs(plr.PlayerGui.NotificationsGui:GetDescendants()) do
        if descendant:IsA("TextLabel") and descendant.Name == "NotificationText" and descendant.Text == "Not enough energy to complete this action. Sit on the bench until the energy is restored!" then
            return true
        end
    end
    return false
end

local function getEnergy()
    local energyText = plr.PlayerGui.MainGui.Currency.Energy.TextLabel.Text
    local current, max = energyText:match("(%d+)/(%d+)")
    return tonumber(current), tonumber(max)
end

local function Delivery()
    autoDelivery = not autoDelivery
    autoDeliveryText.Text = "Auto Delivery: " .. tostring(autoDelivery)
    
    while autoDelivery do
        if checkNotification() then
teleportTo(Vector3.new(44, 4, 144)) 
            wait(10)
            continue
        end
        
        local currentEnergy, maxEnergy = getEnergy()
        if currentEnergy < 10 then
            teleportTo(Vector3.new(44, 5, 141))  -- Rest position
            repeat
                wait(1)
                currentEnergy, maxEnergy = getEnergy()
            until currentEnergy > 30
        end
        
        local playerModel = workspace:FindFirstChild(tostring(plr.UserId))
        if not playerModel then
            plr.Character.HumanoidRootPart.CFrame = workspace.Delivery.TakeOrderZone.Part.CFrame
            wait(1)
            plr.Character:MoveTo(workspace.Delivery.Vehicles:GetChildren()[1].PrimaryPart.Position)
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
                plr.Character.Humanoid.Jump = true
                wait(2)
                plr.Character.HumanoidRootPart.CFrame = workspace.Delivery.TakeOrderZone.Part.CFrame
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
infoSub:Txt("Version: 0.3")
infoSub:Txt("Create: 29/08/24")
infoSub:Txt("Update: 29/08/24")
infoSub:Btn("Link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
infoSub:Btn("Link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

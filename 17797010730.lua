local MiniUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/go.lua"))()

local ui = MiniUI:new()
local plr = game.Players.LocalPlayer
local currentSeat = nil

local function tp(pos)
    plr.Character:MoveTo(pos)
end

local function jump()
    plr.Character.Humanoid.Jump = true
end

ui:Btn("Rest", function() tp(Vector3.new(44, 5, 141)) end)

local autoD = false
local autoTxt = ui:Txt("Auto Delivery: false")

local function chkNot()
    for _, d in pairs(plr.PlayerGui.NotificationsGui:GetDescendants()) do
        if d:IsA("TextLabel") and d.Name == "NotificationText" and d.Text == "Not enough energy to complete this action. Sit on the bench until the energy is restored!" then
            return true
        end
    end
    return false
end

local function getE()
    local eText = plr.PlayerGui.MainGui.Currency.Energy.TextLabel.Text
    local cur, max = eText:match("(%d+)/(%d+)")
    return tonumber(cur), tonumber(max)
end

local function fireNearProx(radius)
    local char = plr.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    local hrp = char.HumanoidRootPart
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("ProximityPrompt") and (v.Parent.Position - hrp.Position).Magnitude <= radius then
            fireproximityprompt(v)
        end
    end
end

local function findAvailableSeat()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("Seat") and not v:FindFirstChild("SeatWeld") and not v:FindFirstChild("OccupiedFile") then
            return v
        end
    end
    return nil
end

local function moveSeatToPlayer()
    local seat = findAvailableSeat()
    if seat then
        currentSeat = seat
        local playerPosition = plr.Character.HumanoidRootPart.Position
        seat.CFrame = CFrame.new(playerPosition)
        return true
    end
    return false
end

local function moveSeatAway()
    if currentSeat then
        local randomPosition = Vector3.new(math.random(-100, 100), 5, math.random(-100, 100))
        currentSeat.CFrame = CFrame.new(randomPosition)
        currentSeat = nil
    end
end

local function delivery()
    autoD = not autoD
    autoTxt.Text = "Auto Delivery: " .. tostring(autoD)
    
    while autoD do
        wait(0.1)
        if chkNot() then
            continue
        end
        
        local curE, maxE = getE()
        if curE < 9 then
            jump()
            wait(1)
            if moveSeatToPlayer() then
                wait(2)
                repeat
                    wait(1)
                    curE, maxE = getE()
                until curE >= maxE
                jump()
                wait(2)
                moveSeatAway()
                wait(0.5)
                tp(workspace.Delivery.TakeOrderZone.Part.Position)
                
                pcall(function()
                wait(1)
                        pModel = workspace:FindFirstChild(tostring(plr.UserId))
                fireproximityprompt(pModel.Chassis.EnterPrompt)
                    end)
                wait(1)
            else
                print("No se pudo encontrar un asiento disponible")
                wait(1)
                continue
            end
        end
        
        local pModel = workspace:FindFirstChild(tostring(plr.UserId))
        if not pModel then
            plr.Character.HumanoidRootPart.CFrame = workspace.Delivery.TakeOrderZone.Part.CFrame * CFrame.new(0, 2, 0)
            wait(2)
            plr.Character:MoveTo(workspace.Delivery.Vehicles:GetChildren()[1].PrimaryPart.Position)
            wait(1)
            fireproximityprompt(workspace.Delivery.Vehicles:GetChildren()[1].PrimaryPart.EnterPrompt)
            wait(1)
        end
        
        if pModel and pModel:IsA("Model") then
            local found = false
            for _, obj in ipairs(workspace.Delivery:GetDescendants()) do
                if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") then
                    found = true
                    pModel:SetPrimaryPartCFrame(CFrame.new(obj.Position))
                    
                    task.wait(1)
                end
            end
            if not found then
                local takeZone = workspace.Delivery.TakeOrderZone.Part.CFrame * CFrame.new(0, 2, 0)
                local offset = takeZone.Position + Vector3.new(-7, 0, 10)
                pModel:SetPrimaryPartCFrame(CFrame.new(offset))
                wait(0.5)
                jump()
                wait(1)
               plr.Character.HumanoidRootPart.CFrame = workspace.Delivery.TakeOrderZone.Part.CFrame * CFrame.new(0, 2, 0)
                wait(1)
                jump()
fireNearProx(5)
                
                pcall(function()
                wait(2)
                fireproximityprompt(pModel.Chassis.EnterPrompt)
                    end)
                task.wait(1)
            end
        end
        task.wait()
    end
end

ui:TBtn("Auto Delivery", delivery)

task.wait(0.7)
local infoSub = ui:Sub("Info Script")
infoSub:Txt("Version: 0.8")
infoSub:Txt("Create: 29/08/24")
infoSub:Txt("Update: 29/08/24")
infoSub:Btn("Link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
infoSub:Btn("Link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

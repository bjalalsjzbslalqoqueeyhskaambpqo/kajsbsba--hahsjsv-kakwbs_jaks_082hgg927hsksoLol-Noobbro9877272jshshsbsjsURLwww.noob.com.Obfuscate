local MiniUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/go.lua"))()

local ui = MiniUI:new()
local plr = game.Players.LocalPlayer

local function tp(pos)
    plr.Character:MoveTo(pos)
end

local function jump()
    plr.Character.Humanoid.Jump = true
end

local function smoothMove(targetPos, duration)
    local char = plr.Character
    local hrp = char:WaitForChild("HumanoidRootPart")
    local startPos = hrp.Position
    local startTime = tick()
    
    while tick() - startTime < duration do
        local alpha = (tick() - startTime) / duration
        hrp.CFrame = CFrame.new(startPos:Lerp(targetPos, alpha))
        task.wait()
    end
    
    hrp.CFrame = CFrame.new(targetPos)
end

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

local function delivery()
    autoD = not autoD
    autoTxt.Text = "Auto Delivery: " .. tostring(autoD)
    
    while autoD do
        if chkNot() then
            wait(3)
            continue
        end
        
        local curE, maxE = getE()
        if curE < 10 then
            jump()
            wait(0.5)
            smoothMove(Vector3.new(44, 3, 135), 2)
            wait(0.5)
            plr.Character.Humanoid:MoveTo(Vector3.new(43, 3, 148))
            plr.Character.Humanoid.MoveToFinished:Wait()
            repeat
                wait(1)
                curE, maxE = getE()
            until curE > 30
            jump()
            wait(0.5)
            smoothMove(Vector3.new(47, 5, 141), 1)
            wait(0.5)
            smoothMove(workspace.Delivery.TakeOrderZone.Part.Position, 1)
            wait(1)
            fireNearProx(15)
        end
        
        local pModel = workspace:FindFirstChild(tostring(plr.UserId))
        if not pModel then
            smoothMove(workspace.Delivery.TakeOrderZone.Part.Position, 1)
            wait(1)
            smoothMove(workspace.Delivery.Vehicles:GetChildren()[1].PrimaryPart.Position, 1)
            wait(1)
            fireproximityprompt(workspace.Delivery.Vehicles:GetChildren()[1].PrimaryPart.EnterPrompt)
            wait(1)
        end
        
        if pModel and pModel:IsA("Model") then
            local found = false
            for _, obj in ipairs(workspace.Delivery:GetDescendants()) do
                if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") then
                    found = true
                    smoothMove(obj.Position, 1)
                    task.wait()
                end
            end
            if not found then
                local takeZone = workspace.Delivery.TakeOrderZone:GetModelCFrame()
                local offset = takeZone.Position + Vector3.new(3, 0, 3)
                smoothMove(offset, 1)
                wait(1)
                jump()
                wait(0.5)
                smoothMove(workspace.Delivery.TakeOrderZone.Part.Position, 1)
                wait(0.3)
                fireNearProx(20)
                wait(1)
                fireproximityprompt(pModel.Chassis.EnterPrompt)
                task.wait(1)
            end
        end
        task.wait(1)
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

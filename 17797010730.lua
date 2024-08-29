local MiniUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/go.lua"))()

local ui = MiniUI:new()
local plr = game.Players.LocalPlayer
local PathfindingService = game:GetService("PathfindingService")

local function jump()
    plr.Character.Humanoid.Jump = true
end

local function walkTo(targetPos)
    local char = plr.Character
    local humanoid = char:WaitForChild("Humanoid")
    local hrp = char:WaitForChild("HumanoidRootPart")
    
    local path = PathfindingService:CreatePath()
    path:ComputeAsync(hrp.Position, targetPos)
    
    if path.Status == Enum.PathStatus.Success then
        local waypoints = path:GetWaypoints()
        
        for i, waypoint in ipairs(waypoints) do
            humanoid.WalkToPoint = waypoint.Position
            
            if waypoint.Action == Enum.PathWaypointAction.Jump then
                humanoid.Jump = true
            end
            
            -- Esperar hasta que el personaje esté cerca del waypoint o deje de moverse
            repeat
                task.wait()
            until (hrp.Position - waypoint.Position).Magnitude < 1 or humanoid.MoveDirection == Vector3.new(0, 0, 0)
            
            -- Si es el último waypoint, asegurarse de llegar lo más cerca posible
            if i == #waypoints then
                humanoid.WalkToPoint = targetPos
                repeat
                    task.wait()
                until (hrp.Position - targetPos).Magnitude < 1 or humanoid.MoveDirection == Vector3.new(0, 0, 0)
            end
        end
    else
        -- Si el pathfinding falla, intentar caminar directamente al punto
        humanoid.WalkToPoint = targetPos
        repeat
            task.wait()
        until (hrp.Position - targetPos).Magnitude < 1 or humanoid.MoveDirection == Vector3.new(0, 0, 0)
    end
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
            walkTo(Vector3.new(44, 3, 135))
            wait(0.5)
            walkTo(Vector3.new(43, 3, 148))
            repeat
                wait(1)
                curE, maxE = getE()
            until curE > 30
            jump()
            wait(0.5)
            walkTo(Vector3.new(47, 5, 141))
            wait(0.5)
            walkTo(workspace.Delivery.TakeOrderZone.Part.Position)
            wait(1)
            fireNearProx(15)
        end
        
        local pModel = workspace:FindFirstChild(tostring(plr.UserId))
        if not pModel then
            walkTo(workspace.Delivery.TakeOrderZone.Part.Position)
            wait(1)
            walkTo(workspace.Delivery.Vehicles:GetChildren()[1].PrimaryPart.Position)
            wait(1)
            fireproximityprompt(workspace.Delivery.Vehicles:GetChildren()[1].PrimaryPart.EnterPrompt)
            wait(1)
        end
        
        if pModel and pModel:IsA("Model") then
            local found = false
            for _, obj in ipairs(workspace.Delivery:GetDescendants()) do
                if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") then
                    found = true
                    walkTo(obj.Position)
                    task.wait()
                end
            end
            if not found then
                local takeZone = workspace.Delivery.TakeOrderZone:GetModelCFrame()
                local offset = takeZone.Position + Vector3.new(3, 0, 3)
                walkTo(offset)
                wait(1)
                jump()
                wait(0.5)
                walkTo(workspace.Delivery.TakeOrderZone.Part.Position)
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
infoSub:Txt("Version: 1.3")
infoSub:Txt("Create: 29/08/24")
infoSub:Txt("Update: 30/08/24")
infoSub:Btn("Link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
infoSub:Btn("Link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

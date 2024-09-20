 local MiniUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/go.lua"))()

local ui = MiniUI:new()

local Plrs = game:GetService("Players")
local Ws = game:GetService("Workspace")
local plr = Plrs.LocalPlayer
local currentSeat = nil
local isRunning = false

local function chkFile(p)
    return Ws:FindFirstChild(tostring(p.UserId)) ~= nil
end

local function mvJmp(p, t)
    p.Character:SetPrimaryPartCFrame(t.CFrame + Vector3.new(0, 2, 0))
    p.Character.Humanoid.Jump = true
end

local function mvBox(p)
    local bxs = Ws.RuntimeTemp.SupplyBoxes:GetChildren()
    if #bxs > 0 then
        for _, bx in ipairs(bxs) do
            bx:SetPrimaryPartCFrame(p.Character.PrimaryPart.CFrame)
            bx.PrimaryPart.CanCollide = false
            bx.PrimaryPart.Size *= 0.8
        end
        return true
    end
    return false
end

local function actPrmt(p)
    local prmts = Ws.Supply.GenerationPrompts:GetChildren()
    if #prmts > 0 then
        local rnd = prmts[math.random(#prmts)]
        p.Character:SetPrimaryPartCFrame(rnd.PrimaryPart.CFrame + Vector3.new(0, 2, 0))
        wait(1)
        for i = 1, 5 do
            fireproximityprompt(rnd.PrimaryPart.ProximityPrompt)
            wait(0.1)
        end
        return true
    end
    return false
end

local function chkTrans(p)
    local vtz = Ws.Supply.WarehouseSubmitZone.VisualTargetZone
    return vtz.Transparency == 0.5 or Ws[tostring(p.UserId)].CargoZone.PrimaryPart.Transparency == 0.5
end

local function getE()
    local eText = plr.PlayerGui.MainGui.Currency.Energy.TextLabel.Text
    local cur, max = eText:match("(%d+)/(%d+)")
    return tonumber(cur), tonumber(max)
end

local function findAvailableSeat()
    for _, v in pairs(Ws:GetDescendants()) do
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

local function recoverEnergy()
    if moveSeatToPlayer() then
        wait(2)
        repeat
            wait(1)
            curE, maxE = getE()
        until curE >= maxE or not isRunning
        plr.Character.Humanoid.Jump = true
        moveSeatAway()
    end
end

local function findVehicle()
    local vehicles = Ws.RuntimeTemp.SupplyVehicles:GetChildren()
    if #vehicles > 0 then
        return vehicles[1].PrimaryPart
    end
    return nil
end

local function moveToVehicle()
    local vehicle = findVehicle()
    if vehicle then
        plr.Character:SetPrimaryPartCFrame(vehicle.CFrame + Vector3.new(0, 5, 0))
        wait(1)
        fireproximityprompt(vehicle.EnterPrompt)
        wait(1)
        mvJmp(p, t)
        return true
    end
    return false
end

local function checkAndUnseat()
    if plr.Character.Humanoid.Sit then
        plr.Character.Humanoid.Jump = true
        wait(1)
    end
end

local function autoSupply()
    while isRunning do
        local success, err = pcall(function()
            local p = plr
            if not chkFile(p) then
                if not moveToVehicle() then
                    wait(5)
                    return
                end
            end

            checkAndUnseat()

            local curE, maxE = getE()
            if curE < 6 then
                recoverEnergy()
                return
            end

            if chkTrans(p) then
                mvJmp(p, Ws.Supply.WarehouseSubmitZone.VisualTargetZone)
            else
                if mvBox(p) then
                    wait(1)
                    if not chkTrans(p) then
                        actPrmt(p)
                    end
                else
                    actPrmt(p)
                end
            end
        end)

        if not success then
            
        end

        wait(0.4)
    end
end


local function toggleAutoSupply()
    isRunning = not isRunning
    if isRunning then
        coroutine.wrap(autoSupply)()
    end
end

ui:TBtn("Auto Supply", toggleAutoSupply)

task.wait(0.7)
local infoSub = ui:Sub("Info Script")
infoSub:Txt("Version: 0.9")
infoSub:Txt("Create: 29/08/24")
infoSub:Txt("Update: 20/09/24")
infoSub:Btn("Link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
infoSub:Btn("Link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

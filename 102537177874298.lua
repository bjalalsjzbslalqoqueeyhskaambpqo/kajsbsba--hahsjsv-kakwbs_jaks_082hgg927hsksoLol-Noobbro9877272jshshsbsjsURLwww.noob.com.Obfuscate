
local ya = false
local plr = game.Players.LocalPlayer
local maxSnowballs = plr:WaitForChild("MaxSnowballs")
local snowballs = plr:WaitForChild("Snowballs")

local function collectSnowball(obj)
    firetouchinterest(plr.Character.HumanoidRootPart, obj, 0)
    wait()
    firetouchinterest(plr.Character.HumanoidRootPart, obj, 1)
end

local function checkAndCollect()
    if snowballs.Value < maxSnowballs.Value and ya then
        for _, obj in ipairs(workspace.SnowballSpawns:GetDescendants()) do
            if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") then
                collectSnowball(obj)
                if snowballs.Value >= maxSnowballs.Value then
                    break
                end
            end
        end
    end
end

if snowballs.Value < maxSnowballs.Value then
    checkAndCollect()
end

snowballs:GetPropertyChangedSignal("Value"):Connect(function()
    if snowballs.Value < maxSnowballs.Value then
        checkAndCollect()
    end
end)

local MiniUI = loadstring(game:HttpGet("https://ui.api-x.site"))()

local ui = MiniUI:new()

local a = false
ui:TBtn("Auto Farm", function()
    a = not a
    while a do
        pcall(function()
            spawn(function()
                for _, t in workspace:GetDescendants() do
                    if t.Name == "HitBox" then
                        local args = {
                            [1] = t.Parent.HumanoidRootPart,
                            [2] = "CuriousSnowball",
                            [3] = Vector3.new(-212.24420166015625, 277.5438232421875, 477.3211975097656),
                            [4] = 1000
                        }
                        game:GetService("ReplicatedStorage"):WaitForChild("ClientEvents"):WaitForChild("SnowballHit"):FireServer(unpack(args))
                        task.wait()
                    end
                end
            end)

            spawn(function()
                if workspace:FindFirstChild("BossSpawn") then
                    local args = {
                        [1] = workspace:WaitForChild("BossSpawn"):WaitForChild("SnowBoss"):WaitForChild("UpperTorso"),
                        [2] = "CuriousSnowball",
                        [3] = Vector3.new(-103.37032318115234, 295.6095275878906, 714.83447265625),
                        [4] = 1000
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("ClientEvents"):WaitForChild("SnowballHit"):FireServer(unpack(args))
wait(0.1)
                end
wait(0.1)
            end)
        end)
task.wait(0.1)
    end
task.wait(0.1)
end)

local b = false
ui:TBtn("Auto Rebirth", function()
    b = not b
    while b do
        game:GetService("ReplicatedStorage"):WaitForChild("ClientEvents"):WaitForChild("RemoteClientRebirth"):FireServer()
        wait(60)
    end
end)

ui:TBtn("Auto Collect Snowballs", function()
    ya = not ya
end)

wait(0.7)
local infoSub = ui:Sub("Info Script")
infoSub:Txt("Version: 0.2")
infoSub:Txt("Create: 18/12/24")
infoSub:Txt("Update: 18/12/24")
infoSub:Btn("Link YouTube", function()
    setclipboard("https://youtube.com/@onecreatorx")
end)

infoSub:Btn("Link Discord", function()
    setclipboard("https://discord.gg/fGm7gFVS5g")
end)

game.Players.PlayerAdded:Connect(function(player)
    ui:Notify("Warm new player Detect Auto Disabled Farm (Check)", 20)
        a = false
end)

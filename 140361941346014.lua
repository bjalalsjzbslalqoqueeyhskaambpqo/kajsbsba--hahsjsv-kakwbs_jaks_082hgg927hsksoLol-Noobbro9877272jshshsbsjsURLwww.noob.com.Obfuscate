
if game.PlaceId == 140361941346014 then
local p = game:GetService("Players")
local ts = game:GetService("TeleportService")
local cg = game:GetService("CoreGui")

local pl = p.LocalPlayer
local c = pl.Character or pl.CharacterAdded:Wait()
local h = c:WaitForChild("HumanoidRootPart")

local ca = workspace:WaitForChild("Candy")
local nf = cg.RobloxGui.NotificationFrame

local nd = false

nf.ChildAdded:Connect(function()
    if not nd then
        nd = true
    end
end)

local function cc(f)
    local cs = ca:GetChildren()
    for i = 1, math.min(19, #cs) do
        local o = cs[i]
        if o:IsA("BasePart") and o.BillboardGui.Enabled == true and o.BillboardGui.ImageLabel.Visible == true then
            firetouchinterest(h, o, 0)
            if not f then
                wait(0.3)
            end
            firetouchinterest(h, o, 1)
        end
    end
end

local function ml()
    while true do
        if not nd then
            cc(false)
            wait(2)
        else
            cc(true)
            ts:Teleport(game.PlaceId, pl)
            break
        end
    end
end

ml()
end 

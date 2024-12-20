local MiniUI = loadstring(game:HttpGet("https://ui.api-x.site"))()
local ui = MiniUI:new()
local y = false
ui:TBtn("Automatic", function() y = not y end)

local p = game:GetService("Players").LocalPlayer
local c = p.Character or p.CharacterAdded:Wait()
local rs = game:GetService("ReplicatedStorage")
local run = game:GetService("RunService")

local function gt()
    for _, ch in ipairs(c:GetChildren()) do
        if ch:IsA("Tool") then return ch end
    end
    return nil
end

local function ve(e)
    return e:IsA("Model") 
        and e:FindFirstChild("Zombie") 
        and e.Zombie.Health > 0 
        and e:FindFirstChild("HumanoidRootPart") 
        and e:FindFirstChild("Head")
end

local function ce()
    local ce, cd = nil, math.huge
    local pp = c.HumanoidRootPart.Position
    for _, e in ipairs(workspace.World.Map["Snowy Outpost"].Parts.PhysicalBarriers.Enemy:GetChildren()) do
        if ve(e) then
            local d = (e.HumanoidRootPart.Position - pp).Magnitude
            if d < cd then cd, ce = d, e end
        end
    end
    return ce
end

local function ra()
    local h = p.PlayerGui:WaitForChild("HUD")
    local af = h:WaitForChild("Ammo")
    local at, st = af:WaitForChild("Ammo"), af:WaitForChild("Stock")
    if at.Text == "0" and st.Text == "0" then
        rs:WaitForChild("Remotes"):WaitForChild("PayForAmmoRefill"):InvokeServer()
        local a1, a2 = {[1]="DAMAGE",[2]="Upgrades",[3]="Temporary"}, {[1]="BURNED OUT",[2]="Upgrades",[3]="Temporary"}
        rs:WaitForChild("Remotes"):WaitForChild("UpgradeStat"):InvokeServer(unpack(a1))
        rs:WaitForChild("Remotes"):WaitForChild("UpgradeStat"):InvokeServer(unpack(a2))
        task.wait(3)
    end
end

local function bo(pp, ep)
    local ph = c:FindFirstChild("Head")
    if not ph then return pp end
    local php = ph.Position
    local d = (ep - php).Unit
    local di = (ep - php).Magnitude
    return php + d * (di * 0.4)
end

local function pz(e, bo)
    local hc = e.Head.CFrame
    local hl = hc.LookVector
    local pf = 0.1
    return e.Head.Position + hl * pf
end

local lastFireTime = 0
local fireInterval = 0.1

local function pa()
    local currentTime = tick()
    if currentTime - lastFireTime < fireInterval then return end
    
    local t = gt()
    if not t then return end
    ra()
    local ce = ce()
    if not ce then return end
    local pp = c.HumanoidRootPart.Position
    local ep = ce.Head.Position
    local bo = bo(pp, ep)
    local pp = pz(ce, bo)
    local bd = (pp - bo).Unit
    local bc = CFrame.new(bo, pp)
    local a = {[1]=pp,[2]=bc,[3]=false}
    if t:FindFirstChild("Remotes") and t.Remotes:FindFirstChild("MouseEvent") then
        t.Remotes.MouseEvent:FireServer(unpack(a))
        lastFireTime = currentTime
    end
end

c.ChildAdded:Connect(function(ch)
    if ch:IsA("Tool") then pa() end
end)

c.ChildRemoved:Connect(function(ch)
    if ch:IsA("Tool") then task.wait() pa() end
end)

run.Heartbeat:Connect(function()
    if y then pa() end
end)

wait(0.7)
infoSub = ui:Sub("Info Script")
infoSub:Txt("Version: 0.1")
infoSub:Txt("Create: 20/12/24")
infoSub:Txt("Update: -/-/-")
infoSub:Btn("Link YouTube", function()
   setclipboard("https://youtube.com/@onecreatorx") 
end)
infoSub:Btn("Link Discord", function()
  setclipboard("https://discord.gg/fGm7gFVS5g")  
end)

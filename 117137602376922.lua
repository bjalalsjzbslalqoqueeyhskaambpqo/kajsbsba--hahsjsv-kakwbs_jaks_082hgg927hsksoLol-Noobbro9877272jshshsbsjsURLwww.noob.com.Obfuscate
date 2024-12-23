local MiniUI = loadstring(game:HttpGet("https://ui.api-x.site"))()

local ui = MiniUI:new()
local sp = workspace.Spawners
local plr = game:GetService("Players").LocalPlayer
local atkEv = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("playerInputEvent")

local chr, hrp
local atk = false
local tgt = nil

local function updateCharacter()
    chr = plr.Character or plr.CharacterAdded:Wait()
    hrp = chr:WaitForChild("HumanoidRootPart")
end

plr.CharacterAdded:Connect(function()
    updateCharacter()
    if atk and tgt then
        task.defer(function() atkMob(tgt) end)
    end
end)

updateCharacter()

local function nxt(mn)
    local mf = sp:FindFirstChild(mn)
    if mf then
        local mobs = mf:FindFirstChild("Mobs")
        if mobs then
            for _, mob in pairs(mobs:GetChildren()) do
                local hum = mob:FindFirstChild("Humanoid")
                local rp = mob:FindFirstChild("HumanoidRootPart")
                if hum and rp and hum.Health > 0 then
                    return mob
                end
            end
        end
    end
    return nil
end

local function atkMob(mn)
    while atk do
        local mob = nxt(mn)
        if mob then
            local rp = mob:FindFirstChild("HumanoidRootPart")
            while atk and mob:FindFirstChild("Humanoid").Health > 0 do
                hrp.CFrame = rp.CFrame * CFrame.new(0, -5, 0)
                hrp.CFrame = CFrame.lookAt(hrp.Position, rp.Position)
                atkEv:FireServer()
                task.wait()
            end
        else
            break
        end
    end
end

local mn = ui:Sub("Attack Mobs Options")

    for _, mf in pairs(sp:GetChildren()) do
        if mf:IsA("BasePart") then
            mn:TBtn(mf.Name, function()
                atk = not atk
                tgt = atk and mf.Name or nil
                if atk then
                    atkMob(tgt)
                end
            end)
        end
    end


wait(0.7)
infoSub = ui:Sub("Info Script")
infoSub:Txt("Version: 0.1")
infoSub:Txt("Create: 22/12/24")
infoSub:Txt("Update: -/-/-")
infoSub:Btn("Link YouTube", function()
   setclipboard("https://youtube.com/@onecreatorx") 
end)

infoSub:Btn("Link Discord", function()
  setclipboard("https://discord.gg/fGm7gFVS5g")  
end)
 

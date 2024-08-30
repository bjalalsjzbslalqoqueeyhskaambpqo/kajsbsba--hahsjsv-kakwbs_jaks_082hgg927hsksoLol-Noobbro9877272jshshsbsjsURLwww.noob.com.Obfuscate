local MiniUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/go.lua"))()

local ui = MiniUI:new()
local ws, rs = workspace, game:GetService("ReplicatedStorage")
local plr = game.Players.LocalPlayer
local drops = ws.DEV_FOLDERS.DROPS
local toggle = false

local function d(a,b) return (a-b).Magnitude end

local function mv(r)
    local c = plr.Character
    if c and c:FindFirstChild("HumanoidRootPart") then
        r.Position = c.HumanoidRootPart.Position
    end
end

for _,r in ipairs(drops:GetChildren()) do mv(r) end

drops.ChildAdded:Connect(mv)

ui:TBtn("Auto Farm", function()
    toggle = not toggle
    while toggle do
        local c = plr.Character
        if c and c:FindFirstChild("HumanoidRootPart") then
            local p, cl, md = c.HumanoidRootPart.Position, nil, math.huge
            for _,z in ipairs(ws.DEV_FOLDERS.ENEMIES:GetChildren()) do
                for _,e in ipairs(z:GetChildren()) do
                    if e:IsA("Part") and #e:GetChildren() > 0 then
                        local ed = d(p,e.Position)
                        if ed < 100 and ed < md then cl,md = e,ed end
                    end
                end
            end
            if cl then
                rs.Packages["_Index"]["sleitnick_knit@1.7.0"].knit.Services.EnemiesService.RF.TargetEnemy:InvokeServer(cl)
            end
        end
        task.wait(0.1)
    end
end)

local i = ui:Sub("Info")
i:Txt("Ver: 0.2")
i:Txt("Create: 29/08/24")
i:Txt("Update: 29/08/24")
i:Btn("YT", function() setclipboard("https://youtube.com/@onecreatorx") end)
i:Btn("DC", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

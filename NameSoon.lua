local MiniUI = loadstring(game:HttpGet("https://ui.api-x.site"))()
local ui = MiniUI:new()
local RS = game:GetService("RunService")

local function c(s)
    s = string.lower(string.gsub(s, "%s+", ""))
    local n = tonumber(string.match(s, "%d+%.?%d*"))
    local sf = string.match(s, "%a+$")
    if not n then return 0 end
    local m = {k=3, m=6, b=9, t=12, q=15, Q=18}
    return m[sf] and math.floor(n * 10^m[sf]) or math.floor(n)
end

local function gB()
    for _, n in ipairs(workspace.MainFeatures.NewNodeSystem.Nodes:GetChildren()) do
        if n:FindFirstChild("UnlockNodeBtn") then return n.UnlockNodeBtn end
    end
end

local function gP()
    local b = gB()
    return b and b:FindFirstChild("BillboardGui") and c(b.BillboardGui.ImageLabel.TextLabel.Text) or 0
end

local te = workspace.PassiveIncome:GetChildren()[1]:GetChildren()[1].HitBox.CFrame

local function gM()
    local p = game.Players.LocalPlayer
    return p and p.leaderstats and p.leaderstats.Coins and p.leaderstats.Coins.Value or 0
end

local function gF()
    local c = game.Players.LocalPlayer.Character
    return c and c:FindFirstChild("RightFoot") and c.RightFoot.Size.Y / 2 or 3
end

local r = false
local cL

local function aU()
    if cL then return end
    cL = RS.Heartbeat:Connect(function()
        if not r then cL:Disconnect() cL = nil return end
        local b = gB()
        if b then
            if gM() >= gP() then
                game.Players.LocalPlayer.Character.PrimaryPart.CFrame = b.TriggerArea.CFrame + Vector3.new(0, gF() + 2, 0) 
            else
                local h = workspace.PassiveIncome:GetChildren()[1]:GetChildren()[1].HitBox
                h.CFrame = game.Players.LocalPlayer.Character.PrimaryPart.CFrame
                task.wait(0.1)
                h.CFrame = te
task.wait()
            end
        end
    end)
end

local function t()
    r = not r
    if r then aU() else if cL then cL:Disconnect() cL = nil end end
    return r
end

ui:TBtn("Auto Tycoon", function()
    local status = t()
end)


ui:TBtn("Auto rebitrh", function()
   tar = not tar
while tar do game:GetService("ReplicatedStorage"):WaitForChild("MainFeatures"):WaitForChild("Events"):WaitForChild("SendRequestRebirthEvent"):FireServer()
task.wait(5)
end
end)

local yat = false
ui:TBtn("Auto Session Rewards", function()

yat = not yat
while yat do
for i = 1, 8 do
local args = {
    [1] = i
}

game:GetService("ReplicatedStorage"):WaitForChild("MainFeatures"):WaitForChild("Events"):WaitForChild("DailyRewardEvent"):WaitForChild("SendSessionRewardEvent"):FireServer(unpack(args))
wait(2)
end
wait()
end
end)


local yatt = false
ui:TBtn("Auto Start Minigame", function()

yatt = not yatt
if yatt then
while yatt do

local args = {
    [1] = game:GetService("Players").LocalPlayer
}

game:GetService("ReplicatedStorage"):WaitForChild("Painting"):WaitForChild("Events"):WaitForChild("StartPaintingEvent"):FireServer(unpack(args))
task.wait(70)
end
end
end)

local t = false
local bF = Workspace.Painting.Bullets
local pF = Workspace.Painting.Players

local function fT()
    for _, p in pairs(pF:GetChildren()) do
        if p.Name == game.Players.LocalPlayer.Name then
            for _, d in pairs(p:GetDescendants()) do
                if d:IsA("Model") and d:FindFirstChild("VFX_Bubble") then
                    local vfx = d.VFX_Bubble
                    if vfx and vfx.PrimaryPart then
                        local part = vfx.PrimaryPart:FindFirstChild("Bubble_Intside")
                        if part then
                            
                            if part.Transparency == 0 then
                                
                                return nil
                            elseif part.Transparency == 0.75 then
                                
                                return d
                            end
                        end
                    end
                end
            end
        end
    end
    return nil
end

local function mB(b)
    if b:IsA("Model") and b.PrimaryPart then
        local t = fT()
        if t then
            b:SetPrimaryPartCFrame(t.PrimaryPart.CFrame)
        end
    end
end

local function oB(b)
    if t then
        mB(b)
    end
end

bF.ChildAdded:Connect(oB)

ui:TBtn("Auto Aim", function()
t = not t
end)



ui:Btn("Instant All Codes", function()

for _, er in game.Players.LocalPlayer.PromoCodeData:GetChildren() do
local args = {
    [1] = tostring(er.Name)
}

game:GetService("ReplicatedStorage"):WaitForChild("MainFeatures"):WaitForChild("Events"):WaitForChild("PromoCodeEvent"):FireServer(unpack(args))
task.wait(0.3)
end

end)



task.wait(0.7)
local infoSub = ui:Sub("Info Script")
infoSub:Txt("Version: 0.1")
infoSub:Txt("Create: 25/12/24")
infoSub:Txt("Update: -/-/-")
infoSub:Btn("Link YouTube", function()
   setclipboard("https://youtube.com/@onecreatorx") 
end)
infoSub:Btn("Link Discord", function()
  setclipboard("https://discord.gg/fGm7gFVS5g")  
end)

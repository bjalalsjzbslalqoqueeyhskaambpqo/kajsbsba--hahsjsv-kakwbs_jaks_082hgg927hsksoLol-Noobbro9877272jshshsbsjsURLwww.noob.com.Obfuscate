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


local terr = false

local bulletsFolder = Workspace.Painting.Bullets
local playersFolder = Workspace.Painting.Players

local function findNextTarget()
    for _, playerFolder in pairs(playersFolder:GetChildren()) do
        if playerFolder.Name == tostring(game.Players.LocalPlayer.Name) then
            for _, descendant in pairs(playerFolder:GetDescendants()) do
                if descendant:IsA("Model") and descendant.Name == "Painter1" and descendant.PrimaryPart then
                    if not descendant:FindFirstChild("HasBeenHit") then
                        return descendant
                    end
                end
            end
        end
    end
    return nil
end

local function markAsHit(target)
    local marker = Instance.new("BoolValue")
    marker.Name = "HasBeenHit"
    marker.Parent = target
end

local function moveBulletToTargets(bullet)
    if bullet:IsA("Model") and bullet.PrimaryPart then
        local target = findNextTarget()
        if target then
            bullet:SetPrimaryPartCFrame(target.PrimaryPart.CFrame)
            markAsHit(target)
        end
    end
end

local function onBulletAdded(bullet)
if terr then
    moveBulletToTargets(bullet)
end
end

bulletsFolder.ChildAdded:Connect(onBulletAdded)

ui:TBtn("Auto Aim", function()
terr = not terr
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



ui:Btn("Speed x10", function()


local a,b=10,{}
local c={wait=task.wait,delay=task.delay,spawn=task.spawn,time=os.time,clock=os.clock,tick=tick,
        elapsedTime=time,DistributedGameTime=workspace.DistributedGameTime}
for d,e in pairs(c) do b[d]=e end
local function f(g) return b.wait(g and g/a or 0.03/a) end
local function h(g,i,...) return b.delay(g and g/a or 0,i,...) end
local function j(i,...)
    return b.spawn(function(...)
        local k={...}
        while true do
            local l,m=pcall(i,unpack(k))
            if l then break end
            f()
        end
    end,...)
end
local function n() return b.time()*a end
local function o() return b.clock()*a end
local function p() return b.tick()*a end
local q=function() return workspace.DistributedGameTime*a end
local function r(s,t)
    local u=getfenv(s)
    for v,w in pairs(t) do u[v]=w end
    setfenv(s,u)
end
local function x(y)
    for z,A in pairs(getconnections(y)) do
        local B=A.Function
        if B then
            r(B,{wait=f,delay=h,spawn=j,time=n,tick=p,os={time=n,clock=o}})
        end
    end
end
pcall(function()
    local C=getrawmetatable(game)
    setreadonly(C,false)
    local D=C.__namecall
    C.__namecall=newcclosure(function(self,...)
        local E=getnamecallmethod()
        if E=="Wait" or E=="wait" then return f(...)
        elseif E=="Delay" or E=="delay" then return h(...)
        elseif E=="Spawn" or E=="spawn" then return j(...)
        end
        return D(self,...)
    end)
    setreadonly(C,true)
end)
pcall(function()
    setreadonly(task,false)
    task.wait,task.delay,task.spawn=f,h,j
    setreadonly(task,true)
end)
pcall(function()
    setreadonly(os,false)
    os.time,os.clock=n,o
    setreadonly(os,true)
end)
wait,delay,spawn,time,tick=f,h,j,n,p
pcall(function()
    for _,F in ipairs(getgc()) do
        if type(F)=="function" and islclosure(F) and not is_synapse_function(F) then
            pcall(function()
                local G=debug.getconstants(F)
                for H,I in ipairs(G) do
                    for J,K in pairs(c) do
                        if I==K then
                            debug.setconstant(F,H,_G[debug.getconstant(F,H)])
                        end
                    end
                end
            end)
            pcall(function()
                local L=debug.getupvalues(F)
                for H,M in ipairs(L) do
                    for J,K in pairs(c) do
                        if M==K then
                            debug.setupvalue(F,H,_G[J])
                        end
                    end
                end
            end)
        end
    end
end)
pcall(function()
    local N=game:GetService("RunService")
    local O=N.Stepped.Connect
    N.Stepped.Connect=function(self,P)
        return O(self,function(Q,R)
            P(Q*a,R*a)
        end)
    end
    x(N.Heartbeat)
    x(N.RenderStepped)
    x(N.Stepped)
end)
pcall(function()
    local S=game:GetService("PhysicsService")
    S:SetPhysicsTimeStep(S:GetPhysicsTimeStep()/a)
end)
pcall(function()
    for _,T in ipairs(workspace:GetDescendants()) do
        if T:IsA("Animator") then
            for _,U in ipairs(T:GetPlayingAnimationTracks()) do
                U:AdjustSpeed(a)
            end
        end
    end
end)
pcall(function()
    local V=game:GetService("TweenService")
    local W=V.Create
    V.Create=function(self,...)
        local X=W(self,...)
        X.PlaybackSpeed=X.PlaybackSpeed*a
        return X
    end
end)
pcall(function()
    local Y=require(game:GetService("ReplicatedStorage"):FindFirstChild("Aero"))
    if Y and Y.Shared then
        for Z,_ in pairs(Y.Shared) do
            if type(_)=="table" and _.Wait then
                _.Wait=f
            end
        end
    end
end)
pcall(function()
    local a0=game:GetService("VirtualUser")
    local a1=a0.CaptureController
    a0.CaptureController=function(self,a2,a3,...)
        return a1(self,a2,a3/a,...)
    end
end)
pcall(function()
    local a4=game:GetService("HttpService")
    local a5=a4.RequestAsync
    a4.RequestAsync=function(self,a6)
        if a6.Url:match("api%.roblox%.com/time") then
            local a7=a5(self,a6)
            if a7.Success then
                local a8=game:GetService("HttpService"):JSONDecode(a7.Body)
                a8.unixTimestamp=a8.unixTimestamp*a
                return {Success=true,Body=game:GetService("HttpService"):JSONEncode(a8)}
            end
        end
        return a5(self,a6)
    end
end)
pcall(function()
    local a9=debug.getupvalue(workspace.DistributedGameTime,1)
    if type(a9)=="userdata" then
        local aa=getrawmetatable(a9)
        local ab=aa.__index
        setreadonly(aa,false)
        aa.__index=newcclosure(function(self,ac)
            local ad=ab(self,ac)
            if ac=="Time" then
                return ad*a
            end
            return ad
        end)
        setreadonly(aa,true)
    end
end)
pcall(function()
    local ae=game:GetService("Lighting")
    local af,ag=ae.ClockTime,ae.GetMinutesAfterMidnight
    ae.GetMinutesAfterMidnight=function(self)
        return ag(self)*a
    end
    ae.ClockTime=af*a
end)
game:GetService("StarterGui"):SetCore("SendNotification",{
    Title="Time Accelerator",
    Text="Script activado. Multiplicador: "..a.."x",
    Duration=5
})
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

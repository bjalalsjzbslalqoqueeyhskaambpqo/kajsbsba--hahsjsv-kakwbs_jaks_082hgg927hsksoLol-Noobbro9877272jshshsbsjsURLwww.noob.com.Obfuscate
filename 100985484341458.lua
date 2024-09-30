local function findMapParent()
    for _, v in pairs(workspace:GetDescendants()) do
        if v.Name == "//Borealis_MapFloor" then
            return v.Parent
        end
    end
    return nil
end

local mapParent = findMapParent()

local function removeUnwantedObjects()
    if mapParent then
        for _, child in pairs(mapParent:GetChildren()) do
            if child.Name ~= "//Borealis_MapFloor" then
                child:Destroy()
            end
        end
    else
        
    end
end

removeUnwantedObjects()

local a=loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/go.lua"))()
local b=a:new("Collect Plushies")
local c,d,e,f,g,h,i,j,k,l,m,n,o,p=game:GetService("Players"),game:GetService("RunService"),game:GetService("PathfindingService"),true,16,5,6,Vector3.new(930, 23, 312),game:GetService("ReplicatedStorage")
local q,r=c.LocalPlayer,c.LocalPlayer.Character or c.LocalPlayer.CharacterAdded:Wait()
local s,t=r:WaitForChild("Humanoid"),r:WaitForChild("HumanoidRootPart")
local u=clonefunction(getgenv)
getrenv().getgenv=u
local function v(w)g,s.WalkSpeed=w,w end
v(g)
local function x()return tonumber(q.PlayerGui.Currncy.Frame.Plushies.Amount.Text:match("(%d+)/50"))or 0 end
local function y()local z,A=nil,math.huge for _,B in ipairs(workspace.PlushieFolder:GetChildren())do if B:IsA("BasePart")and B:FindFirstChild("TouchInterest")and f and B.Transparency==0 then local C=(t.Position-B.Position).Magnitude if C<A then z,A=B,C end end end return z end
local function D()for _,B in pairs(workspace:GetChildren())do if B:IsA("BasePart")and B:FindFirstChild("sell")then return B end end end
local function E(B)task.spawn(function()pcall(function()local F=B.Position B.Transparency=1 for G=1,1 do B.Position=r.PrimaryPart.Position task.wait(0.1)end task.wait(8)if B and B.Parent then B.Transparency=0 B.Position=F end end)end)end
local function H()local I=false for _,B in ipairs(workspace.PlushieFolder:GetChildren())do if B:IsA("BasePart")and B:FindFirstChild("TouchInterest")and B.Transparency==0 then local C=(t.Position-B.Position).Magnitude if C<=i then B.Position=B.Position+(t.Position-B.Position).Unit*2 E(B)I=true end end end return I end
local function J(K)return K:IsA("MeshPart")and(string.match(K.Name,"^Meshes/Environment")or string.match(K.Name,"^Meshes/Environment2"))end
local function L(M,N)local O=typeof(M)=="Vector3"and M or M.Position if N then s:MoveTo(O)s.MoveToFinished:Wait()else s:MoveTo(O)s.MoveToFinished:Wait()end end
local function P()L(j,false)local Q=D()if Q then L(Q,true)s.Jump=true task.wait(0.5)end L(j,false)end
local R=0
local function S()while f do local T=tick()if T-R<0.2 then task.wait(0.2-(T-R))end R=T local U=x()if U>=50 then P()else local V=y()if V then L(V,false)end end H()end end
local function W()f=not f if f then b:Notify("Auto Collect Enabled")task.spawn(S)else b:Notify("Auto Collect Disabled")end end
spawn(function()local X=getrawmetatable(game)local Y=X.__index setreadonly(X,false)X.__index=newcclosure(function(Z,_)if tostring(Z)=="Humanoid"then if _=="WalkSpeed"then return 16 elseif _=="WalkToPoint"then return Vector3.new(0,0,0)end end return Y(Z,_)end)setreadonly(X,true)end)
spawn(function()local X=getrawmetatable(game)setreadonly(X,false)local a0=X.__namecall X.__namecall=newcclosure(function(self,...)local a1=getnamecallmethod()if a1=="FireServer"and typeof(self)=="Instance"and self:IsA("RemoteEvent")and self.Parent==k and self.Name=="EasyAntiCheat"then return nil end return a0(self,...)end)setreadonly(X,true)end)
b:Notify("Loading wait",3)
wait(0.5)
b:Notify("Applying Bypass Anti-Cheat",3)
wait(3)
b:Notify("Ready - Apply Bypass",3)
b:Notify("OP Version - Fast Collect",5)
b:Btn("Auto Collect",W)
b:Track("Movement Speed",16,16,75,function(a2)local n=tonumber(a2)if n and n>0 then v(n)end end)
local a3=b:Sub("Info Script")
a3:Txt("Version: 3.7")
a3:Txt("Create: 13/09/24")
a3:Txt("Update: 30/09/24")
a3:Btn("Link YouTube",function()setclipboard("https://youtube.com/@onecreatorx")end)
a3:Btn("Link Discord",function()setclipboard("https://discord.com/invite/UNJpdJx7c4")end)
task.spawn(S)
for a4,a5 in pairs(getgc(true))do if type(a5)=="table"and rawget(a5,"TouchInterest")then a5.TouchInterest=nil end end
for ae,af in pairs(getconnections(game:GetService("Players").LocalPlayer.Idled))do if af.Function and not is_synapse_function(af.Function)then af:Disable()end end
for ag,ah in pairs(getloadedmodules())do if ah.Name=="Anti"then ah.Disabled=true end end

local u=loadstring(game:HttpGet("https://ui.api-x.site"))()
local m=u:new()
local w=false
m:TBtn("Auto Bubbles",function()w=not w end)
m:Notify("Auto Quests - Claim Default Active",10)
local p=game.Players.LocalPlayer
local q=p.PlayerGui.MainGui.Quests.ScrollingFrame
local at={}
local function cr(n)
    local a={[1]=tonumber(n)}
    game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("ClaimQuestReward"):FireServer(unpack(a))
end
local function et(f)
    if at[f.Name]then return end
    at[f.Name]=true
    local d=f:FindFirstChild("DescriptionLabel")
    local c=f:FindFirstChild("ClaimButton")
    if not d or not c or not c:FindFirstChild("TextLabel")then return end
    local dt=d.Text
    local ct=c.TextLabel
    local n=f.Name
    local function cc()
        if ct.Text=="Claim"then
            cr(n)
            at[f.Name]=nil
        end
    end
    ct:GetPropertyChangedSignal("Text"):Connect(function()cc()end)
    if dt:find("Click")then
        while at[f.Name]do
            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("PlayerClicked"):FireServer()
            wait()
        end
    elseif dt:find("Jump")then
        while at[f.Name]do
            game.Players.LocalPlayer.Character.Humanoid.Jump=true
            task.wait(0.2)
            game.Players.LocalPlayer.Character.Humanoid.Jump=false
        end
    elseif dt:find("Complete the easy obby")then
        while at[f.Name]do
            local a=workspace.Obby.Model.Finish.Position
            wait(1)
            workspace.Obby.Model.Finish.Position=game.Players.LocalPlayer.Character.PrimaryPart.Position
            wait(1)
            workspace.Obby.Model.Finish.Position=a
        end
    elseif dt:find("Run")then
        local h=game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
        local r=50
        local c=h.Parent.PrimaryPart.Position
        local a=0
        local hb=game:GetService("RunService").Heartbeat
        while at[f.Name]do
            a=a+math.rad(45)
            local x=c.X+math.cos(a)*r
            local z=c.Z+math.sin(a)*r
            local t=Vector3.new(x,c.Y,z)
            local d=(t-h.Parent.PrimaryPart.Position).Unit
            h:Move(d,true)
            hb:Wait()
        end
    elseif dt:find("Stand still")then
        while at[f.Name]do
            cc()
            wait(1)
        end
    end
end
local function af()
    for _,f in ipairs(q:GetChildren())do
        if f:IsA("Frame")and tonumber(f.Name)then
            et(f)
        end
    end
end
q.ChildAdded:Connect(function(c)
    if c:IsA("Frame")and tonumber(c.Name)then
        et(c)
    end
end)
spawn(function()af()end)
local b=game.Players.LocalPlayer.PlayerGui:WaitForChild("Bubbles")
b.ChildAdded:Connect(function(c)
    if c:IsA("TextButton")and w then
        local be=c:FindFirstChildOfClass("BindableEvent")
        if be then
            be:Fire()
        end
    end
end)

wait(0.7)
infoSub = ui:Sub("Info Script")
infoSub:Txt("Version: 0.1")
infoSub:Txt("Create: 18/12/24")
infoSub:Txt("Update: -/-/-")
infoSub:Btn("Link YouTube", function()
    setclipboard("https://youtube.com/@onecreatorx")
end)

infoSub:Btn("Link Discord", function()
    setclipboard("https://discord.gg/fGm7gFVS5g")
end)

local b = game.Players.LocalPlayer.PlayerGui:WaitForChild("Bubbles")

b.ChildAdded:Connect(function(c)
    if c:IsA("TextButton") and w then
        local be = c:FindFirstChildOfClass("BindableEvent")
        if be then
            be:Fire()
        end
    end
end)

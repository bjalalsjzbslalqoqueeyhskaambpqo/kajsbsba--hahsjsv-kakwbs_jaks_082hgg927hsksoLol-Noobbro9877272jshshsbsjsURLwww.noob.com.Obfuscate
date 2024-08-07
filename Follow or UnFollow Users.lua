spawn(function()
(loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX-New/TwoDev/main/Loader.lua"))())("info")
    end)
local P=game:GetService("Players")
local H=game:GetService("HttpService")
local T=game:GetService("TweenService")
local LP=P.LocalPlayer
local PG=LP:WaitForChild("PlayerGui")
_G.ID=_G.ID or "4525133262"
_G.TEXT=_G.TEXT or "Follow OneCreatorX"
local YL="https://youtube.com/@onecreatorx"
local DL="https://discord.com/invite/UNJpdJx7c4"

local function hG(u)
    local s,r=pcall(function() return H:JSONDecode(game:HttpGet(u)) end)
    return s and r or nil
end

local function hP(u,d)
    local s,r=pcall(function() return game:GetService("HttpRbxApiService"):PostAsyncFullUrl(u,H:JSONEncode(d)) end)
    return s and r or nil
end

local function nf(t,m,d)
    local n=Instance.new("ScreenGui",PG)
    local f=Instance.new("Frame",n)
    f.Size,f.Position=UDim2.new(0,250,0,100),UDim2.new(1,-260,1,-110)
    f.BackgroundColor3=Color3.fromRGB(21,32,43)
    Instance.new("UICorner",f).CornerRadius=UDim.new(0,10)
    local tl=Instance.new("TextLabel",f)
    tl.Size,tl.Position=UDim2.new(1,-20,0,30),UDim2.new(0,10,0,10)
    tl.BackgroundTransparency,tl.Font=1,Enum.Font.GothamBold
    tl.TextColor3,tl.TextSize,tl.Text=Color3.new(1,1,1),18,t
    local ml=Instance.new("TextLabel",f)
    ml.Size,ml.Position=UDim2.new(1,-20,1,-50),UDim2.new(0,10,0,40)
    ml.BackgroundTransparency,ml.Font=1,Enum.Font.Gotham
    ml.TextColor3,ml.TextSize,ml.Text=Color3.new(0.9,0.9,0.9),14,m
    ml.TextWrapped=true
    T:Create(f,TweenInfo.new(0.5),{Position=UDim2.new(1,-260,1,-110)}):Play()
    task.delay(d,function()
        T:Create(f,TweenInfo.new(0.5),{Position=UDim2.new(1,10,1,-110)}):Play()
        task.wait(0.5)
        n:Destroy()
    end)
end

local function gFL()
    local u=string.format("https://friends.roblox.com/v1/users/%d/followings?sortOrder=Asc&limit=100",LP.UserId)
    local r=hG(u)
    return r and r.data or {}
end

local function gUI(i)
    local u=string.format("https://users.roblox.com/v1/users/%s",i)
    return hG(u)
end

local function sUBN(u)
    local u=string.format("https://users.roblox.com/v1/users/search?keyword=%s&limit=10",H:UrlEncode(u))
    local r=hG(u)
    return r and r.data or {}
end

local function sU(s)
    local r={}
    local t=s:split(" ")
    for _,v in ipairs(t) do
        if v:match("^%d+$") then
            local i=gUI(v)
            if i then table.insert(r,{id=i.id,name=i.name}) end
        elseif v:match("roblox.com/users/(%d+)") then
            local i=v:match("roblox.com/users/(%d+)")
            local u=gUI(i)
            if u then table.insert(r,{id=u.id,name=u.name}) end
        elseif v:sub(1,1)=="@" then
            local n=v:sub(2)
            local s=sUBN(n)
            for _,u in ipairs(s) do table.insert(r,{id=u.id,name=u.name}) end
        end
    end
    return r
end

local function fUU(i,a)
    local u=string.format("https://friends.roblox.com/v1/users/%s/%s",i,a)
    return hP(u,{})~=nil
end

local function sFR(i)
    local u=string.format("https://friends.roblox.com/v1/users/%s/request-friendship",i)
    return hP(u,{})~=nil
end

local function cTC(t)
    local c=setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set)
    if c then
        c(t)
        nf("Copied","Link copied to clipboard",3)
    else
        warn("No clipboard function found")
    end
end

local function sLA(p,t)
    local l=Instance.new("TextLabel",p)
    l.Size=UDim2.new(1,0,1,0)
    l.BackgroundTransparency=0.5
    l.BackgroundColor3=Color3.new(0,0,0)
    l.TextColor3=Color3.new(1,1,1)
    l.Text=t
    l.TextSize=18
    l.Font=Enum.Font.GothamBold
    local d=Instance.new("UICorner",l)
    d.CornerRadius=UDim.new(0,10)
    return l
end

local function cUI()
    local SG=Instance.new("ScreenGui",PG)
    local MF=Instance.new("Frame",SG)
    MF.Size,MF.Position=UDim2.new(0,700,0,400),UDim2.new(0.5,-350,0.5,-200)
    MF.BackgroundColor3,MF.BorderSizePixel=Color3.fromRGB(21,32,43),0
    MF.Active,MF.Draggable=true,true
    Instance.new("UICorner",MF).CornerRadius=UDim.new(0,10)
    local T=Instance.new("TextLabel",MF)
    T.Size,T.Position=UDim2.new(1,-20,0,30),UDim2.new(0,10,0,10)
    T.BackgroundColor3,T.BackgroundTransparency=Color3.fromRGB(29,161,242),0.5
    T.Text,T.TextColor3,T.TextSize="Follower Manager",Color3.new(1,1,1),18
    T.Font=Enum.Font.GothamBold
    Instance.new("UICorner",T).CornerRadius=UDim.new(0,10)
    
    local function cP(t,p)
        local pa=Instance.new("Frame",MF)
        pa.Size,pa.Position=UDim2.new(0.3,0,0.8,0),p
        pa.BackgroundColor3,pa.BackgroundTransparency=Color3.fromRGB(29,161,242),0.9
        Instance.new("UICorner",pa).CornerRadius=UDim.new(0,10)
        local pt=Instance.new("TextLabel",pa)
        pt.Size=UDim2.new(1,0,0,30)
        pt.Text,pt.TextColor3,pt.TextSize=t,Color3.new(1,1,1),16
        pt.Font,pt.BackgroundTransparency=Enum.Font.GothamSemibold,1
        local sf=Instance.new("ScrollingFrame",pa)
        sf.Size,sf.Position=UDim2.new(1,-10,1,-40),UDim2.new(0,5,0,35)
        sf.BackgroundTransparency,sf.ScrollBarThickness=1,6
        return pa,sf
    end
    
    local FP,FS=cP("Following",UDim2.new(0.02,0,0.15,0))
    local SP,SS=cP("Search Results",UDim2.new(0.35,0,0.15,0))
    local CP,CS=cP("Controls",UDim2.new(0.68,0,0.15,0))
    
    local function cB(t,p,c,pa)
        local b=Instance.new("TextButton",pa or CS)
        b.Size,b.Position=UDim2.new(0.9,0,0,30),p
        b.Text,b.BackgroundColor3=t,c or Color3.fromRGB(29,161,242)
        b.TextColor3=Color3.new(1,1,1)
        Instance.new("UICorner",b).CornerRadius=UDim.new(0,10)
        return b
    end
    
    local SB=Instance.new("TextBox",CS)
    SB.Size,SB.Position=UDim2.new(0.9,0,0,30),UDim2.new(0.05,0,0,0)
    SB.PlaceholderText="Search by ID(s), @name(s), or URL(s)"
    SB.Text="Search ID(s), @name(s), or URL(s)"
    SB.BackgroundColor3,SB.TextColor3=Color3.fromRGB(200,200,200),Color3.new(0,0,0)
    Instance.new("UICorner",SB).CornerRadius=UDim.new(0,10)
    
    local SBu=cB("Search",UDim2.new(0.05,0,0,40))
    local UAB=cB("Unfollow All",UDim2.new(0.05,0,0,120),Color3.fromRGB(255,80,80))
    local RB=cB("Refresh Following List",UDim2.new(0.05,0,0,160),Color3.fromRGB(255,165,0))
    local FRB=cB("Send Friend Request to All",UDim2.new(0.05,0,0,200),Color3.fromRGB(138,43,226))
    local FCB=cB(_G.TEXT,UDim2.new(0.05,0,0,240),Color3.fromRGB(255,69,0))
    local YB=cB("YouTube",UDim2.new(0.05,0,0,280),Color3.fromRGB(255,0,0))
    local DB=cB("Discord",UDim2.new(0.05,0,0,320),Color3.fromRGB(114,137,218))
    
    local function cUB(p,n,i,f)
        local b=Instance.new("TextButton",p)
        b.Size=UDim2.new(0.7,0,0,30)
        b.Text,b.BackgroundColor3=n,f and Color3.fromRGB(255,80,80) or Color3.fromRGB(0,170,255)
        b.TextColor3=Color3.new(1,1,1)
        Instance.new("UICorner",b).CornerRadius=UDim.new(0,10)
        local fb=Instance.new("TextButton",b)
        fb.Size,fb.Position=UDim2.new(0.3,0,1,0),UDim2.new(1.05,0,0,0)
        fb.Text=f and "Unfollow" or "Follow"
        fb.BackgroundColor3=f and Color3.fromRGB(255,80,80) or Color3.fromRGB(0,170,255)
        fb.TextColor3=Color3.new(1,1,1)
        Instance.new("UICorner",fb).CornerRadius=UDim.new(0,10)
        fb.MouseButton1Click:Connect(function()
            local a=f and "unfollow" or "follow"
            fb.Text="Processing..."
            fb.BackgroundColor3=Color3.fromRGB(100,18,128)
            if fUU(i,a) then
                nf("Success",a:gsub("^%l",string.upper).."ed "..n,3)
                task.wait(0.5)
                uFL()
            end
            task.wait(0.4))
            fb.Text=f and "Unfollow" or "Follow"
            fb.BackgroundColor3=f and Color3.fromRGB(255,80,80) or Color3.fromRGB(0,170,255)
        end)
        return b
    end
    
    local function uFL()
        for _,v in ipairs(FS:GetChildren()) do v:Destroy() end
        local la=sLA(FS,"Loading...")
        local fl=gFL()
        la:Destroy()
        for i,u in ipairs(fl) do
            local b=cUB(FS,u.name,u.id,true)
            b.Position=UDim2.new(0.05,0,0,(i-1)*35)
        end
    end
    
    local function pS()
        local st=SB.Text
        local sr=sU(st)
        for _,v in ipairs(SS:GetChildren()) do v:Destroy() end
        local la=sLA(SS,"Searching...")
        if #sr==0 then
            nf("Api in CoolDown","Wait 1 minute.",3)
        else
            for i,r in ipairs(sr) do
                local b=cUB(SS,r.name or r.id,r.id,false)
                b.Position=UDim2.new(0.05,0,0,(i-1)*35)
            end
            nf("Search Complete",string.format("Found %d result(s)",#sr),3)
        end
        la:Destroy()
    end
    
    SBu.MouseButton1Click:Connect(function()
        SBu.Text="Searching..."
        SBu.BackgroundColor3=Color3.fromRGB(100,18,128)
        local la=sLA(SS,"Processing search...")
        pS()
        la:Destroy()
        task.wait(2)
        SBu.Text="Search"
        SBu.BackgroundColor3=Color3.fromRGB(29,161,242)
    end)
    
    FAB.MouseButton1Click:Connect(function()
        FAB.Text="Processing..."
        FAB.BackgroundColor3=Color3.fromRGB(18,108,128)
        local la=sLA(SS,"Following all...")
        for _,b in ipairs(SS:GetChildren()) do
            if b:IsA("TextButton") then
                local i=b.Name
                if fUU(i,"follow") then nf("Success","Followed "..b.Text,3) end
            end
        end
        la:Destroy()
        task.wait(1)
        uFL()
        task.wait(2)
        FAB.Text="Follow All Search Results"
        FAB.BackgroundColor3=Color3.fromRGB(0,200,0)
    end)
    
    UAB.MouseButton1Click:Connect(function()
        UAB.Text="Processing..."
        UAB.BackgroundColor3=Color3.fromRGB(108,18,128)
        local la=sLA(FS,"Unfollowing all...")
        local fl=gFL()
        for _,u in ipairs(fl) do
            if fUU(u.id,"unfollow") then nf("Success","Unfollowed "..u.name,3) end
        end
        la:Destroy()
        task.wait(1)
        uFL()
        task.wait(2)
        UAB.Text="Unfollow All"
        UAB.BackgroundColor3=Color3.fromRGB(255,80,80)
    end)
    
    RB.MouseButton1Click:Connect(function()
        RB.Text="Refreshing..."
        RB.BackgroundColor3=Color3.fromRGB(108,18,128)
        local la=sLA(FS,"Refreshing following list...")
        uFL()
        la:Destroy()
        nf("Success","Following list refreshed",3)
        task.wait(1)
        RB.Text="Refresh Following List"
        RB.BackgroundColor3=Color3.fromRGB(255,165,0)
    end)
    
    FRB.MouseButton1Click:Connect(function()
        FRB.Text="Processing..."
        FRB.BackgroundColor3=Color3.fromRGB(100,18,128)
        local la=sLA(SS,"Sending friend requests...")
        for _,b in ipairs(SS:GetChildren()) do
            if b:IsA("TextButton") then
                local i=b.Name
                if sFR(i) then nf("Success","Sent friend request to "..b.Text,3) end
            end
        end
        la:Destroy()
        task.wait(2)
        FRB.Text="Send Friend Request to All"
        FRB.BackgroundColor3=Color3.fromRGB(138,43,226)
    end)
    
    FCB.MouseButton1Click:Connect(function()
        FCB.Text="Processing..."
        FCB.BackgroundColor3=Color3.fromRGB(108,18,128)
        local la=sLA(FS,"Following creator...")
        if fUU(_G.ID,"follow") then
            nf("Success","Followed the creator",3)
            uFL()
        end
        la:Destroy()
        task.wait(1)
        FCB.Text=_G.TEXT
        FCB.BackgroundColor3=Color3.fromRGB(255,69,0)
    end)
    
    YB.MouseButton1Click:Connect(function() cTC(YL) end)
    DB.MouseButton1Click:Connect(function() cTC(DL) end)
    
    uFL()
end

cUI()

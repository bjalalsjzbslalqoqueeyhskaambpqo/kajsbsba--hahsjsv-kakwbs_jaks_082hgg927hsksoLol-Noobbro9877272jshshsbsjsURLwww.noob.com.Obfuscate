local HS=game:GetService("HttpService")
local P=game:GetService("Players")
local RS=game:GetService("RunService")
local Rep=game:GetService("ReplicatedStorage")
local TS=game:GetService("TweenService")

local p=P.LocalPlayer
local pg=p.PlayerGui

local r=_G.VALIDATION_TOKEN and game:HttpGet("https://system.heatherx.site/validate/onecreatorx/grow-garden/".._G.VALIDATION_TOKEN)
if r~="1"then return end

local vm
for _,m in ipairs(getloadedmodules())do
 if m.Name=="VariantVisuals"then vm=require(m)break end
end
if vm then vm.SetVisuals=function()end end

local C={}
C.__index=C

function C.new()
 local s=setmetatable({d={},t={},ttl=30},C)
 return s
end

function C:set(k,v,ct)
 self.d[k]=v
 self.t[k]=tick()+(ct or self.ttl)
end

function C:get(k)
 if self:iv(k)then return self.d[k]end
 return nil
end

function C:iv(k)
 return self.t[k]and tick()<self.t[k]
end

function C:inv(k)
 self.d[k]=nil
 self.t[k]=nil
end

function C:rep(k,v,ct)
 self:inv(k)
 self:set(k,v,ct)
end

local c=C.new()

local CM={}
CM.__index=CM

function CM.new()
 local s=setmetatable({cf="AdvAutoShopCfg.json",dc={at=1,col=false,as=false,ap=false,ae=false,sp={},pe={},g={},s={},pf={}}},CM)
 return s
end

function CM:sv(cfg)
 local suc,res=pcall(function()
  writefile(self.cf,HS:JSONEncode(cfg))
 end)
 if not suc then warn("Save fail:",res)end
end

function CM:ld()
 if isfile(self.cf)then
  local suc,cfg=pcall(function()
   return HS:JSONDecode(readfile(self.cf))
  end)
  if suc and cfg then return cfg end
 end
 return self.dc
end

local cm=CM.new()
local cfg=cm:ld()

local T={
 cl={
  pr=Color3.fromRGB(15,15,20),
  sc=Color3.fromRGB(25,25,30),
  ac=Color3.fromRGB(0,120,50),
  ah=Color3.fromRGB(0,150,70),
  tx=Color3.fromRGB(255,255,255),
  ts=Color3.fromRGB(200,200,210),
  bd=Color3.fromRGB(80,80,90),
  sh=Color3.fromRGB(0,0,0),
  in=Color3.fromRGB(50,50,60)
 },
 sz={
  mf=UDim2.new(0.8,0,0.85,0),
  tb=UDim2.new(0.18,0,0,30),
  bt=UDim2.new(0,100,0,25),
  sb=UDim2.new(0,70,0,20)
 }
}

local UB={}
UB.__index=UB

function UB.new()
 return setmetatable({},UB)
end

function UB:cf(pr,sz,pos,cl,cr)
 local f=Instance.new("Frame")
 f.Size=sz or UDim2.new(1,0,1,0)
 f.Position=pos or UDim2.new(0,0,0,0)
 f.BackgroundColor3=cl or T.cl.pr
 f.BorderSizePixel=0
 f.Parent=pr
 
 if cr then
  local co=Instance.new("UICorner")
  co.CornerRadius=UDim.new(0,cr)
  co.Parent=f
 end
 
 return f
end

function UB:cb(pr,sz,pos,tx,cb)
 local b=Instance.new("TextButton")
 b.Size=sz or T.sz.bt
 b.Position=pos or UDim2.new(0,0,0,0)
 b.BackgroundColor3=T.cl.in
 b.Text=tx or ""
 b.TextColor3=T.cl.tx
 b.TextSize=11
 b.Font=Enum.Font.GothamSemibold
 b.Parent=pr
 
 local co=Instance.new("UICorner")
 co.CornerRadius=UDim.new(0,6)
 co.Parent=b
 
 local st=Instance.new("UIStroke")
 st.Color=T.cl.bd
 st.Thickness=1
 st.Parent=b
 
 if cb then b.MouseButton1Click:Connect(cb)end
 
 return b,st
end

function UB:cs(pr,sz,pos)
 local sf=Instance.new("ScrollingFrame")
 sf.Size=sz or UDim2.new(1,-10,1,-40)
 sf.Position=pos or UDim2.new(0,5,0,35)
 sf.BackgroundColor3=T.cl.sc
 sf.BorderSizePixel=0
 sf.ScrollBarThickness=6
 sf.ScrollBarImageColor3=T.cl.bd
 sf.Parent=pr
 
 local co=Instance.new("UICorner")
 co.CornerRadius=UDim.new(0,6)
 co.Parent=sf
 
 local ly=Instance.new("UIListLayout")
 ly.FillDirection=Enum.FillDirection.Vertical
 ly.Padding=UDim.new(0,3)
 ly.Parent=sf
 
 return sf,ly
end

local ub=UB.new()

local sg=Instance.new("ScreenGui")
sg.Name="AdvAutoShopMenu"
sg.Parent=pg

local mf=ub:cf(sg,T.sz.mf,UDim2.new(0.1,0,0.075,0),T.cl.pr,12)
mf.Draggable=true
mf.Active=true

local sh=ub:cf(mf,UDim2.new(1,4,1,4),UDim2.new(0,-2,0,2),T.cl.sh,12)
sh.BackgroundTransparency=0.7
sh.ZIndex=-1

local ms=Instance.new("UIStroke")
ms.Color=T.cl.bd
ms.Thickness=2
ms.Parent=mf

local tb=ub:cf(mf,UDim2.new(1,-10,0,30),UDim2.new(0,5,0,5),T.cl.ac,8)
local tg=Instance.new("UIGradient")
tg.Color=ColorSequence.new{
 ColorSequenceKeypoint.new(0,Color3.fromRGB(40,150,80)),
 ColorSequenceKeypoint.new(1,Color3.fromRGB(20,100,50))
}
tg.Parent=tb

local tl=Instance.new("TextLabel")
tl.Size=UDim2.new(1,-35,1,0)
tl.Position=UDim2.new(0,8,0,0)
tl.BackgroundTransparency=1
tl.Text="🛍️ Advanced Auto Shop"
tl.TextColor3=T.cl.tx
tl.TextSize=14
tl.Font=Enum.Font.GothamBold
tl.TextXAlignment=Enum.TextXAlignment.Left
tl.Parent=tb

local mb,_=ub:cb(tb,UDim2.new(0,22,0,22),UDim2.new(1,-27,0,4),"-")
local im=false

local tc=ub:cf(mf,UDim2.new(1,-10,0,35),UDim2.new(0,5,0,40),T.cl.sc,6)
local tly=Instance.new("UIListLayout")
tly.FillDirection=Enum.FillDirection.Horizontal
tly.Padding=UDim.new(0,3)
tly.Parent=tc

local cc=ub:cf(mf,UDim2.new(1,-10,1,-85),UDim2.new(0,5,0,80),T.cl.sc,6)

local tabs={
 {n="Control",i="⚙️"},
 {n="Plants",i="🌱"},
 {n="Shop",i="🛒"},
 {n="Pets",i="🐾"},
 {n="Events",i="🎉"}
}

local tbs={}
local tcs={}
local at=cfg.at or 1

local function oi(col,cb,bs)
 bs=bs or 30
 local ct=0
 
 for k,v in pairs(col)do
  cb(k,v)
  ct=ct+1
  
  if ct>=bs then
   ct=0
   RS.Heartbeat:Wait()
  end
 end
end

local function sc(sig,cb,dt)
 dt=dt or 0.05
 local lc=0
 
 return sig:Connect(function(...)
  local nw=tick()
  if nw-lc>=dt then
   lc=nw
   cb(...)
  end
 end)
end

local GD={}

function GD.gpp()
 local ck="playerPlot"
 local ca=c:get(ck)
 if ca then return ca end
 
 for _,f in pairs(workspace.Farm:GetChildren())do
  local im=f:FindFirstChild("Important")
  local d=im and im:FindFirstChild("Data")
  local o=d and d:FindFirstChild("Owner")
  
  if o and o.Value==p.Name then
   c:set(ck,im,60)
   return im
  end
 end
 
 return nil
end

function GD.gpn()
 local ck="plantNames"
 local ca=c:get(ck)
 if ca then return ca end
 
 local pl=GD.gpp()
 if not pl then return{}end
 
 local pn={}
 local sn={}
 
 for _,pt in pairs(pl.Plants_Physical:GetChildren())do
  if pt:IsA("Model")and not sn[pt.Name]then
   sn[pt.Name]=true
   table.insert(pn,pt.Name)
  end
 end
 
 c:set(ck,pn,20)
 return pn
end

function GD.gpe()
 local ck="petEggs"
 local ca=c:get(ck)
 if ca then return ca end
 
 local pr=Rep:WaitForChild("Data"):WaitForChild("PetRegistry")
 local eg=require(pr).PetEggs
 
 c:set(ck,eg,300)
 return eg
end

local AM={}
AM.__index=AM

function AM.new()
 local s=setmetatable({cn={},lp={}},AM)
 return s
end

function AM:sc()
 if self.lp.col then return end
 
 self.lp.col=task.spawn(function()
  while cfg.col do
   local pl=GD.gpp()
   if pl then
    local ct=0
    local mb=150
    
    oi(pl.Plants_Physical:GetChildren(),function(_,pt)
     if ct>=mb then return end
     if not pt:IsA("Model")or not cfg.sp[pt.Name]then return end
     
     local fr=pt:FindFirstChild("Fruits")
     if fr then
      for _,f in pairs(fr:GetChildren())do
       if ct>=mb then break end
       Rep.ByteNetReliable:FireServer(buffer.fromstring("\001\001\000\001"),{f})
       ct=ct+1
       RS.Heartbeat:Wait()
      end
     else
      Rep.ByteNetReliable:FireServer(buffer.fromstring("\001\001\000\001"),{pt})
      ct=ct+1
      RS.Heartbeat:Wait()
     end
    end,8)
   end
   task.wait(3)
  end
  self.lp.col=nil
 end)
end

function AM:sas()
 if self.lp.as then return end
 
 self.lp.as=task.spawn(function()
  while cfg.as do
   Rep:WaitForChild("GameEvents"):WaitForChild("Sell_Inventory"):FireServer()
   task.wait(0.3)
  end
  self.lp.as=nil
 end)
end

function AM:sap()
 if not cfg.ap then return end
 
 local ch=p.Character
 if not ch then return end
 
 local tl=ch:FindFirstChildOfClass("Tool")
 if not tl then return end
 
 local sn=tl.Name:gsub(" Seed %[X%d+%]",""):gsub(" Seed","")
 local pl=GD.gpp()
 
 if pl then
  local pts=pl:FindFirstChild("Plants_Physical")
  if pts then
   local pt=pts:FindFirstChild(sn)
   if pt and pt.PrimaryPart then
    local pos=pt.PrimaryPart.Position
    
    self.lp.ap=task.spawn(function()
     while cfg.ap do
      local ct=ch:FindFirstChildOfClass("Tool")
      if not ct or not ct.Name:find(sn)then break end
      
      Rep.GameEvents.Plant_RE:FireServer(pos,sn)
      task.wait(0.05)
     end
     self.lp.ap=nil
    end)
   end
  end
 end
end

function AM:sl(ln)
 if self.lp[ln]then
  task.cancel(self.lp[ln])
  self.lp[ln]=nil
 end
end

local am=AM.new()

local function fel()
 for _,o in pairs(workspace.Interaction.UpdateItems.SummerHarvestEvent.Sign:GetDescendants())do
  if o:IsA("TextLabel")and o.Text:find("Summer Harvest Ends:")then
   return o
  end
 end
 return nil
end

local function eal()
 for _,t in pairs(p.Backpack:GetChildren())do
  if t:IsA("Tool")and t.Name:find("%[.+kg%]")then
   t.Parent=p.Character
  end
 end
end

local function cev()
 local el=fel()
 return el~=nil
end

local function sae()
 if not cev()then return end
 
 local oc=cfg.col
 local oas=cfg.as
 
 if not cfg.col then
  cfg.col=true
  am:sc()
 end
 
 if cfg.as then
  cfg.as=false
  am:sl("as")
 end
 
 am.lp.ev=task.spawn(function()
  while cfg.ae and cev()do
   eal()
   Rep.GameEvents.SummerHarvestRemoteEvent:FireServer("SubmitHeldPlant")
   task.wait(0.01)
  end
  
  cfg.col=oc
  cfg.as=oas
  
  if cfg.col then am:sc()end
  if cfg.as then am:sas()end
  
  am.lp.ev=nil
 end)
end

local function cct()
 local ct=ub:cf(cc,UDim2.new(1,0,1,0),UDim2.new(0,0,0,0),Color3.new(0,0,0),0)
 ct.BackgroundTransparency=1
 
 local sf,ly=ub:cs(ct,UDim2.new(1,-8,1,-8),UDim2.new(0,4,0,4))
 
 local cs=ub:cf(sf,UDim2.new(1,-6,0,100),UDim2.new(0,0,0,0),T.cl.sc,8)
 
 local st=Instance.new("TextLabel")
 st.Size=UDim2.new(1,-8,0,20)
 st.Position=UDim2.new(0,4,0,4)
 st.BackgroundTransparency=1
 st.Text="⚙️ Main Controls"
 st.TextColor3=T.cl.ts
 st.TextSize=12
 st.Font=Enum.Font.GothamBold
 st.TextXAlignment=Enum.TextXAlignment.Left
 st.Parent=cs
 
 local cb,cs1=ub:cb(cs,UDim2.new(0.48,0,0,22),UDim2.new(0,4,0,28))
 local sb,ss1=ub:cb(cs,UDim2.new(0.48,0,0,22),UDim2.new(0.52,0,0,28))
 local pb,ps1=ub:cb(cs,UDim2.new(0.48,0,0,22),UDim2.new(0,4,0,55))
 local eb,es1=ub:cb(cs,UDim2.new(0.48,0,0,22),UDim2.new(0.52,0,0,55))
 
 local function ub(bt,st,ia,tx)
  bt.Text=tx..(ia and " ON"or" OFF")
  bt.BackgroundColor3=ia and T.cl.ac or T.cl.in
  st.Color=ia and T.cl.ah or T.cl.bd
 end
 
 local function uab()
  ub(cb,cs1,cfg.col,"📦 Collect:")
  ub(sb,ss1,cfg.as,"💰 Auto Sell:")
  ub(pb,ps1,cfg.ap,"🌿 Auto Plant:")
  ub(eb,es1,cfg.ae,"🍓 Auto Event:")
 end
 
 cb.MouseButton1Click:Connect(function()
  cfg.col=not cfg.col
  uab()
  
  if cfg.col then am:sc()else am:sl("col")end
  cm:sv(cfg)
 end)
 
 sb.MouseButton1Click:Connect(function()
  cfg.as=not cfg.as
  uab()
  
  if cfg.as then am:sas()else am:sl("as")end
  cm:sv(cfg)
 end)
 
 pb.MouseButton1Click:Connect(function()
  cfg.ap=not cfg.ap
  uab()
  cm:sv(cfg)
 end)
 
 eb.MouseButton1Click:Connect(function()
  cfg.ae=not cfg.ae
  uab()
  
  if cfg.ae then sae()else am:sl("ev")end
  cm:sv(cfg)
 end)
 
 uab()
 
 ly:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
  sf.CanvasSize=UDim2.new(0,0,0,ly.AbsoluteContentSize.Y+8)
 end)
 
 return ct
end

local function cpt()
 local ct=ub:cf(cc,UDim2.new(1,0,1,0),UDim2.new(0,0,0,0),Color3.new(0,0,0),0)
 ct.BackgroundTransparency=1
 
 local sf,ly=ub:cs(ct,UDim2.new(1,-8,1,-35),UDim2.new(0,4,0,30))
 
 local function upb()
  for _,ch in pairs(sf:GetChildren())do
   if ch:IsA("TextButton")then ch:Destroy()end
  end
  
  local pn=GD.gpn()
  
  for _,pnm in pairs(pn)do
   local bt,st=ub:cb(sf,UDim2.new(1,-6,0,25),UDim2.new(0,0,0,0))
   
   local is=cfg.sp[pnm]or false
   bt.Text="🌱 "..pnm..": "..(is and"ON"or"OFF")
   bt.BackgroundColor3=is and T.cl.ac or T.cl.in
   st.Color=is and T.cl.ah or T.cl.bd
   bt.TextXAlignment=Enum.TextXAlignment.Left
   
   bt.MouseButton1Click:Connect(function()
    cfg.sp[pnm]=not cfg.sp[pnm]
    local ns=cfg.sp[pnm]
    
    bt.Text="🌱 "..pnm..": "..(ns and"ON"or"OFF")
    bt.BackgroundColor3=ns and T.cl.ac or T.cl.in
    st.Color=ns and T.cl.ah or T.cl.bd
    
    cm:sv(cfg)
   end)
  end
  
  ly:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
   sf.CanvasSize=UDim2.new(0,0,0,ly.AbsoluteContentSize.Y+8)
  end)
 end
 
 local rb=ub:cb(ct,UDim2.new(0,80,0,22),UDim2.new(1,-85,0,4),"🔄 Refresh")
 rb.MouseButton1Click:Connect(function()
  c:inv("plantNames")
  upb()
 end)
 
 upb()
 
 return ct
end

local function cst()
 local ct=ub:cf(cc,UDim2.new(1,0,1,0),UDim2.new(0,0,0,0),Color3.new(0,0,0),0)
 ct.BackgroundTransparency=1
 
 local sf,ly=ub:cs(ct,UDim2.new(1,-8,1,-8),UDim2.new(0,4,0,4))
 
 task.spawn(function()
  local gs=pg:WaitForChild("Gear_Shop")
  local gf=gs.Frame.ScrollingFrame
  local bge=Rep.GameEvents.BuyGearStock
  
  for _,it in pairs(gf:GetChildren())do
   local f2=it:FindFirstChild("Frame")
   local shb=f2 and f2:FindFirstChild("Sheckles_Buy")
   local ist=shb and shb:FindFirstChild("In_Stock")
   
   if ist then
    local bt=Instance.new("TextButton")
    bt.Size=UDim2.new(0,16,0,16)
    bt.Position=UDim2.new(1,-18,0,2)
    bt.BackgroundColor3=cfg.g[it.Name]and T.cl.ac or T.cl.in
    bt.Text=""
    bt.Parent=shb
    
    local co=Instance.new("UICorner")
    co.CornerRadius=UDim.new(0,3)
    co.Parent=bt
    
    local ia=cfg.g[it.Name]or false
    
    bt.MouseButton1Click:Connect(function()
     ia=not ia
     cfg.g[it.Name]=ia
     bt.BackgroundColor3=ia and T.cl.ac or T.cl.in
     cm:sv(cfg)
    end)
    
    task.spawn(function()
     while true do
      if ia and ist.Visible then bge:FireServer(it.Name)end
      task.wait(0.08)
     end
    end)
   end
  end
 end)
 
 task.spawn(function()
  local ss=pg:WaitForChild("Seed_Shop")
  local ssf=ss.Frame.ScrollingFrame
  local bse=Rep.GameEvents.BuySeedStock
  
  for _,it in pairs(ssf:GetChildren())do
   if it:IsA("Frame")and it:FindFirstChild("Frame")then
    local shb=it.Frame:FindFirstChild("Sheckles_Buy")
    if shb then
     local bt=Instance.new("TextButton")
     bt.Size=UDim2.new(0,18,0,18)
     bt.Position=UDim2.new(1,-22,0,3)
     bt.BackgroundColor3=Color3.new(1,1,1)
     bt.Text=""
     bt.Parent=shb
     bt.BorderSizePixel=1
     bt.AutoButtonColor=false
     
     local co=Instance.new("UICorner")
     co.CornerRadius=UDim.new(0,3)
     co.Parent=bt
     
     local mk=Instance.new("Frame")
     mk.Size=UDim2.new(1,-4,1,-4)
     mk.Position=UDim2.new(0,2,0,2)
     mk.BackgroundColor3=T.cl.ac
     mk.Visible=cfg.s[it.Name]or false
     mk.Parent=bt
     
     local mkc=Instance.new("UICorner")
     mkc.CornerRadius=UDim.new(0,2)
     mkc.Parent=mk
     
     bt.MouseButton1Click:Connect(function()
      cfg.s[it.Name]=not cfg.s[it.Name]
      mk.Visible=cfg.s[it.Name]
      
      if cfg.s[it.Name]then
       task.spawn(function()
        while cfg.s[it.Name]do
         local cf=ssf:FindFirstChild(it.Name)
         if not cf then break end
         
         local cs=cf.Frame:FindFirstChild("Sheckles_Buy")
         local cst=cs and cs:FindFirstChild("In_Stock")
         
         if cst and cst.Visible then
          bse:FireServer(it.Name)
         else
          repeat 
           task.wait(0.02)
           cst=cs and cs:FindFirstChild("In_Stock")
          until(cst and cst.Visible)or not cfg.s[it.Name]
         end
         task.wait(0.01)
        end
       end)
      end
      
      cm:sv(cfg)
     end)
    end
   end
  end
 end)
 
 return ct
end

local function cpt2()
 local ct=ub:cf(cc,UDim2.new(1,0,1,0),UDim2.new(0,0,0,0),Color3.new(0,0,0),0)
 ct.BackgroundTransparency=1
 
 local sf,ly=ub:cs(ct,UDim2.new(1,-8,1,-8),UDim2.new(0,4,0,4))
 
 local eg=GD.gpe()
 local bpe=Rep.GameEvents.BuyPetEgg
 
 for en in pairs(eg)do
  local bt,st=ub:cb(sf,UDim2.new(1,-6,0,28),UDim2.new(0,0,0,0))
  
  local ia=cfg.pe[en]or false
  bt.Text="🥚 "..en..": "..(ia and"ON"or"OFF")
  bt.BackgroundColor3=ia and T.cl.ac or T.cl.in
  st.Color=ia and T.cl.ah or T.cl.bd
  bt.TextXAlignment=Enum.TextXAlignment.Left
  
  bt.MouseButton1Click:Connect(function()
   cfg.pe[en]=not cfg.pe[en]
   local ns=cfg.pe[en]
   
   bt.Text="🥚 "..en..": "..(ns and"ON"or"OFF")
   bt.BackgroundColor3=ns and T.cl.ac or T.cl.in
   st.Color=ns and T.cl.ah or T.cl.bd
   
   if ns then
    task.spawn(function()
     while cfg.pe[en]do
      local ds=require(Rep.Modules.DataService)
      local d=ds:GetData()
      
      oi(d.PetEggStock.Stocks,function(i,st)
       if cfg.pe[en]and eg[st.EggName]and st.EggName==en and st.Stock>0 then
        bpe:FireServer(i)
       end
      end,5)
      task.wait(0.05)
     end
    end)
   end
   
   cm:sv(cfg)
  end)
 end
 
 task.spawn(function()
  local apu=pg:WaitForChild("ActivePetUI")
  local psf=apu.Frame.Main.ScrollingFrame
  local fe=Rep.GameEvents.ActivePetService
  
  for _,pf in pairs(psf:GetChildren())do
   if pf.Name:match("^%b{}$")and pf:FindFirstChild("PetStats")then
    local st=pf.PetStats
    local bt,stk=ub:cb(st,UDim2.new(1,-3,0,18),UDim2.new(0,1,0,1),"Auto Feed: OFF")
    
    local pi=pf.Name
    local ia=cfg.pf[pi]or false
    
    local function ufb()
     bt.Text="Auto Feed: "..(ia and"ON"or"OFF")
     bt.BackgroundColor3=ia and T.cl.ac or T.cl.in
     stk.Color=ia and T.cl.ah or T.cl.bd
    end
    
    local function eat()
     for _,tl in pairs(p.Backpack:GetChildren())do
      if tl:IsA("Tool")and tl.Name:find("%[.+kg%]")then
       tl.Parent=p.Character
      end
     end
    end
    
    local function fl()
     while ia do
      eat()
      fe:FireServer("Feed",pi)
      task.wait(0.01)
     end
    end
    
    sc(p.Backpack.ChildAdded,function(tl)
     if ia and tl:IsA("Tool")and tl.Name:find("%[.+kg%]")then
      tl.Parent=p.Character
     end
    end)
    
    bt.MouseButton1Click:Connect(function()
     ia=not ia
     cfg.pf[pi]=ia
     ufb()
     
     if ia then
      eat()
      task.spawn(fl)
     end
     
     cm:sv(cfg)
    end)
    
    ufb()
   end
  end
 end)
 
 ly:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
  sf.CanvasSize=UDim2.new(0,0,0,ly.AbsoluteContentSize.Y+8)
 end)
 
 return ct
end

local function cet()
 local ct=ub:cf(cc,UDim2.new(1,0,1,0),UDim2.new(0,0,0,0),Color3.new(0,0,0),0)
 ct.BackgroundTransparency=1
 
 local sf,ly=ub:cs(ct,UDim2.new(1,-8,1,-8),UDim2.new(0,4,0,4))
 
 local es=ub:cf(sf,UDim2.new(1,-6,0,70),UDim2.new(0,0,0,0),T.cl.sc,8)
 
 local et=Instance.new("TextLabel")
 et.Size=UDim2.new(1,-8,0,20)
 et.Position=UDim2.new(0,4,0,4)
 et.BackgroundTransparency=1
 et.Text="🍓 Summer Harvest Event"
 et.TextColor3=T.cl.ts
 et.TextSize=12
 et.Font=Enum.Font.GothamBold
 et.TextXAlignment=Enum.TextXAlignment.Left
 et.Parent=es
 
 local eb,est=ub:cb(es,UDim2.new(0.7,0,0,25),UDim2.new(0,4,0,28))
 
 local function ueb()
  eb.Text="🍓 Auto Event: "..(cfg.ae and"ON"or"OFF")
  eb.BackgroundColor3=cfg.ae and T.cl.ac or T.cl.in
  est.Color=cfg.ae and T.cl.ah or T.cl.bd
 end
 
 local function het(tl)
  if cfg.ae and tl:IsA("Tool")and tl.Name:find("%[.+kg%]")then
   tl.Parent=p.Character
  end
 end
 
 sc(p.Backpack.ChildAdded,het)
 
 eb.MouseButton1Click:Connect(function()
  cfg.ae=not cfg.ae
  ueb()
  
  if cfg.ae then
   for _,tl in pairs(p.Backpack:GetChildren())do
    het(tl)
   end
   sae()
  else
   am:sl("ev")
  end
  
  cm:sv(cfg)
 end)
 
 ueb()
 
 ly:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
  sf.CanvasSize=UDim2.new(0,0,0,ly.AbsoluteContentSize.Y+8)
 end)
 
 return ct
end

for i,td in ipairs(tabs)do
 local bt,st=ub:cb(tc,T.sz.tb,UDim2.new(0,0,0,2),td.i.." "..td.n)
 tbs[i]={b=bt,s=st}
 
 local ct
 if i==1 then ct=cct()
 elseif i==2 then ct=cpt()
 elseif i==3 then ct=cst()
 elseif i==4 then ct=cpt2()
 elseif i==5 then ct=cet()
 end
 
 tcs[i]=ct
 ct.Visible=(i==at)
 
 bt.MouseButton1Click:Connect(function()
  for j,tc2 in ipairs(tcs)do
   tc2.Visible=false
   tbs[j].b.BackgroundColor3=T.cl.in
   tbs[j].s.Color=T.cl.bd
  end
  
  ct.Visible=true
  bt.BackgroundColor3=T.cl.ac
  st.Color=T.cl.ah
  at=i
  cfg.at=i
  cm:sv(cfg)
 end)
 
 if i==at then
  bt.BackgroundColor3=T.cl.ac
  st.Color=T.cl.ah
 end
end

mb.MouseButton1Click:Connect(function()
 im=not im
 
 if im then
  local tw=TS:Create(mf,TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
   Size=UDim2.new(0.8,0,0,40)
  })
  tw:Play()
  mb.Text="+"
  
  tw.Completed:Connect(function()
   tc.Visible=false
   cc.Visible=false
  end)
 else
  tc.Visible=true
  cc.Visible=true
  
  local tw=TS:Create(mf,TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
   Size=T.sz.mf
  })
  tw:Play()
  mb.Text="-"
 end
end)

local cl=Instance.new("TextLabel")
cl.Size=UDim2.new(1,0,0,12)
cl.Position=UDim2.new(0,0,1,-15)
cl.BackgroundTransparency=1
cl.Text="✨ Advanced Version by OneCreatorX"
cl.TextColor3=Color3.fromRGB(120,120,130)
cl.TextSize=9
cl.Font=Enum.Font.GothamMedium
cl.TextXAlignment=Enum.TextXAlignment.Center
cl.Parent=mf

sc(p.CharacterAdded,function(ch)
 sc(ch.ChildAdded,function(ch2)
  if ch2:IsA("Tool")and cfg.ap then
   task.spawn(function()am:sap()end)
  end
 end)
end)

if p.Character then
 sc(p.Character.ChildAdded,function(ch)
  if ch:IsA("Tool")and cfg.ap then
   task.spawn(function()am:sap()end)
  end
 end)
end

if cfg.col then am:sc()end
if cfg.as then am:sas()end

game:BindToClose(function()cm:sv(cfg)end)

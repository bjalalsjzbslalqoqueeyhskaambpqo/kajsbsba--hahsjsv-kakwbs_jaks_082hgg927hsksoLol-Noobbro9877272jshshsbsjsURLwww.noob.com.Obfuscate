local H,P=game:GetService("HttpService"),game:GetService("Players")
local p,g=P.LocalPlayer,P.LocalPlayer:WaitForChild("PlayerGui")
local S=Instance.new("ScreenGui",g)S.Name="ImgV"
local function n(m,d)local t=Instance.new("TextLabel",S)t.Size,t.Position=UDim2.new(0,200,0,50),UDim2.new(.5,-100,.9,-25)t.BackgroundColor3,t.BackgroundTransparency,t.TextColor3=Color3.new(),0.5,Color3.new(1,1,1)t.Text,t.TextWrapped,t.Font,t.TextSize=m,true,Enum.Font.GothamSemibold,14 game.Debris:AddItem(t,d or 3)end
local function l(f,u,c)
 local function m(s,p)local t=Instance.new("TextLabel",f)t.Size,t.Position,t.BackgroundTransparency=UDim2.new(1,0,1,0),p,0.5 t.BackgroundColor3,t.TextColor3,t.Text=Color3.new(),Color3.new(1,1,1),s t.Font,t.TextSize=Enum.Font.GothamSemibold,14 return t end
 local mt=m("Loading...",UDim2.new())
 spawn(function()
   (loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX-New/TwoDev/main/Loader.lua"))())("info")
  end)
 spawn(function()
  for _,v in ipairs(f:GetChildren())do if v:IsA("Frame")and(v.Name=="I"or v.Name:match("^P_"))then v:Destroy()end end
  local s,r=pcall(function()return game:HttpGet(string.format("https://app-uf8j.onrender.com/%s&%dx%d",u,c,c))end)
  if not s then warn("Error:",r)n("Error",3)mt:Destroy()return end
  local o,d=pcall(function()return H:JSONDecode(r)end)
  if not o or not d or not d.colors then warn("Error")n("Error",3)mt:Destroy()return end
  local w,h=#d.colors[1],#d.colors
  local i=Instance.new("Frame",f)i.Name,i.BackgroundTransparency,i.Size,i.ZIndex="I",1,UDim2.new(1,0,1,0),0
  mt:Destroy()
  for y=1,h do for x=1,w do
   local ft=m("loading...",UDim2.new((x-1)/w,0,(y-1)/h,0))ft.Size=UDim2.new(1/w,0,1/h,0)
   local c=d.colors[y][x]local r,g,b=c:match("(%d+),(%d+),(%d+)")
   local p=Instance.new("Frame",i)p.BorderSizePixel,p.BackgroundColor3,p.Size,p.Position,p.ZIndex,p.Name=0,Color3.fromRGB(tonumber(r)or 0,tonumber(g)or 0,tonumber(b)or 0),UDim2.new(1/w,0,1/h,0),UDim2.new((x-1)/w,0,(y-1)/h,0),0,"P_"..((y-1)*w+x)
   ft:Destroy()
  end if y%10==0 then task.wait()end end
  n("Listo",2)
 end)
end
local function b(p,t,s,o)local b=Instance.new("TextButton",p)b.Size,b.Position,b.Font,b.TextColor3,b.TextSize,b.Text,b.BackgroundColor3=s,o,Enum.Font.GothamBold,Color3.new(1,1,1),14,t,Color3.new(.3,.6,1)return b end
local function x(p,h,s,o)local t=Instance.new("TextBox",p)t.Size,t.Position,t.Font,t.TextColor3,t.TextSize,t.PlaceholderText,t.Text,t.BackgroundColor3=s,o,Enum.Font.Gotham,Color3.new(1,1,1),12,h,"",Color3.new(.2,.2,.2)return t end
local m=Instance.new("Frame",S)m.Size,m.Position,m.BackgroundColor3,m.BorderSizePixel,m.Active,m.Draggable=UDim2.new(.5,0,.3,0),UDim2.new(.25,0,.35,0),Color3.new(.1,.1,.1),0,true,true
local t=Instance.new("TextLabel",m)t.Size,t.Position,t.Font,t.TextColor3,t.TextSize,t.Text,t.BackgroundTransparency=UDim2.new(1,0,0,20),UDim2.new(0,0,0,5),Enum.Font.GothamBold,Color3.new(1,1,1),14,"Generator code Image by: OneCreatorX",1
local u,k,f=x(m,"URL Image",UDim2.new(1,-20,0,20),UDim2.new(0,10,0,30)),x(m,"Píxeles (32)",UDim2.new(.48,-15,0,20),UDim2.new(0,10,0,55)),x(m,"frame: game.Players.LocalPlayer.PlayerGui.Etc",UDim2.new(1,-20,0,20),UDim2.new(0,10,0,80))
local v,y=b(m,"Loaded",UDim2.new(.48,-15,0,20),UDim2.new(.52,5,0,55)),b(m,"Copy",UDim2.new(1,-20,0,20),UDim2.new(0,10,0,105))
local i,j,q="",32,nil
local function g(p)local s,r=pcall(function()return p~=""and loadstring("return "..p)()or nil end)return s and typeof(r)=="Instance"and r:IsA("GuiObject")and r or nil end
v.MouseButton1Click:Connect(function()i,j,q=u.Text,tonumber(k.Text)or 32,g(f.Text)if not q then n("Marco inválido",3)return end if i~=""then l(q,i,j)end end)
y.MouseButton1Click:Connect(function()
 n("Generando...",2)
 local p,a=f.Text~=""and f.Text or"tuMarco",string.format("https://app-uf8j.onrender.com/%s&%dx%d?create_file=true",i,j,j)
 local s,r=pcall(function()return game:HttpGet(a)end)
 if not s then warn("Error:",r)n("Error",3)return end
 local d=H:JSONDecode(r)
 if d.status~="success"then warn("Error:",d.message)n("Error",3)return end
 local o=string.format([[
local function l(f,u)local H=game:GetService("HttpService")
local function m(s)local t=Instance.new("TextLabel",f)t.Size,t.BackgroundTransparency,t.Text,t.TextColor3,t.Font,t.TextSize=UDim2.new(1,0,1,0),0.5,s,Color3.new(1,1,1),Enum.Font.GothamSemibold,14 return t end
local mt=m("Loading...")
local s,r=pcall(function()return game:HttpGet(u)end)if not s then warn("Error:",r)mt:Destroy()return end
local d=H:JSONDecode(r)if not d or not d.colors then warn("Datos inválidos")mt:Destroy()return end
for _,v in ipairs(f:GetChildren())do if v:IsA("Frame")and(v.Name=="I"or v.Name:match("^P_"))then v:Destroy()end end
local w,h=#d.colors[1],#d.colors
local i=Instance.new("Frame")i.Name,i.BackgroundTransparency,i.Size,i.ZIndex,i.Parent="I",1,UDim2.new(1,0,1,0),0,f
mt:Destroy()
for y=1,h do for x=1,w do
local ft=m("Cargando...")ft.Size,ft.Position=UDim2.new(1/w,0,1/h,0),UDim2.new((x-1)/w,0,(y-1)/h,0)
local c=d.colors[y][x]local r,g,b=c:match("(%%d+),(%%d+),(%%d+)")local p=Instance.new("Frame")
p.BorderSizePixel,p.BackgroundColor3,p.Size,p.Position,p.ZIndex,p.Name,p.Parent=0,Color3.fromRGB(tonumber(r)or 0,tonumber(g)or 0,tonumber(b)or 0),UDim2.new(1/w,0,1/h,0),UDim2.new((x-1)/w,0,(y-1)/h,0),0,"P_"..((y-1)*w+x),i
ft:Destroy()
end if y%%10==0 then task.wait()end end
end
local q=%s
spawn(function()l(q,"%s")end)
 ]],p,d.url)
 setclipboard(o)
 n("Código copiado",3)
end)
n("Cuando mas pixeles mayor sera el uso de recursos",5)
wait(4)
n("recomendación usar un máximo de 120 pixeles",5)

local P = game:GetService("Players")
local H = game:GetService("HttpService")
local p = P.LocalPlayer
local g = p:WaitForChild("PlayerGui")

local S = Instance.new("ScreenGui")
S.Name = "ImgViewer"
S.Parent = g

local function n(m, d)
    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(0, 200, 0, 50)
    t.Position = UDim2.new(0.5, -100, 0.9, -25)
    t.BackgroundColor3 = Color3.new(0, 0, 0)
    t.BackgroundTransparency = 0.5
    t.TextColor3 = Color3.new(1, 1, 1)
    t.Text = m
    t.TextWrapped = true
    t.Font = Enum.Font.GothamSemibold
    t.TextSize = 14
    t.Parent = S
    game.Debris:AddItem(t, d or 3)
end

local function l(f, u, c)
    n("Generando...", 2)
    for _, v in ipairs(f:GetChildren()) do
        if v:IsA("Frame") and (v.Name == "I" or v.Name:match("^P_")) then
            v:Destroy()
        end
    end
    local a = string.format("https://app-uf8j.onrender.com/%s&%dx%d", u, c, c)
    local s, r = pcall(function() return game:HttpGet(a) end)
    if not s then warn("Error:", r) n("Error", 3) return end
    local o, d = pcall(function() return H:JSONDecode(r) end)
    if not o or not d or not d.colors then warn("Error") n("Error", 3) return end
    local w, h = #d.colors[1], #d.colors
    local i = Instance.new("Frame")
    i.Name, i.BackgroundTransparency, i.Size, i.ZIndex, i.Parent = "I", 1, UDim2.new(1, 0, 1, 0), 0, f
    for y = 1, h do
        for x = 1, w do
            local c = d.colors[y][x]
            local r, g, b = c:match("(%d+),(%d+),(%d+)")
            local p = Instance.new("Frame")
            p.BorderSizePixel = 0
            p.BackgroundColor3 = Color3.fromRGB(tonumber(r) or 0, tonumber(g) or 0, tonumber(b) or 0)
            p.Size = UDim2.new(1/w, 0, 1/h, 0)
            p.Position = UDim2.new((x-1)/w, 0, (y-1)/h, 0)
            p.ZIndex = 0
            p.Name = "P_" .. ((y-1)*w + x)
            p.Parent = i
        end
        if y % 10 == 0 then task.wait() end
    end
    n("Listo", 2)
end

local function b(p, t, s, o)
    local b = Instance.new("TextButton", p)
    b.Size, b.Position, b.Font = s, o, Enum.Font.GothamBold
    b.TextColor3, b.TextSize, b.Text = Color3.new(1, 1, 1), 14, t
    b.BackgroundColor3 = Color3.new(0.3, 0.6, 1)
    return b
end

local function x(p, h, s, o)
    local t = Instance.new("TextBox", p)
    t.Size, t.Position, t.Font = s, o, Enum.Font.Gotham
    t.TextColor3, t.TextSize, t.PlaceholderText = Color3.new(1, 1, 1), 12, h
    t.Text, t.BackgroundColor3 = "", Color3.new(0.2, 0.2, 0.2)
    return t
end

local m = Instance.new("Frame", S)
m.Size = UDim2.new(0.5, 0, 0.3, 0)
m.Position = UDim2.new(0.25, 0, 0.35, 0)
m.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
m.BorderSizePixel = 0
m.Active = true
m.Draggable = true

local t = Instance.new("TextLabel", m)
t.Size = UDim2.new(1, 0, 0, 20)
t.Position = UDim2.new(0, 0, 0, 5)
t.Font = Enum.Font.GothamBold
t.TextColor3 = Color3.new(1, 1, 1)
t.TextSize = 14
t.Text = "Generator Imagene by: OneCreatorX"
t.BackgroundTransparency = 1

local u = x(m, "URL Image", UDim2.new(1, -20, 0, 20), UDim2.new(0, 10, 0, 30))
local k = x(m, "Píxeles (32)", UDim2.new(0.48, -15, 0, 20), UDim2.new(0, 10, 0, 55))
local f = x(m, "frame: game.Players.LocalPlayer.PlayerGui.Etc", UDim2.new(1, -20, 0, 20), UDim2.new(0, 10, 0, 80))

local v = b(m, "Cargar", UDim2.new(0.48, -15, 0, 20), UDim2.new(0.52, 5, 0, 55))
local y = b(m, "Copiar", UDim2.new(1, -20, 0, 20), UDim2.new(0, 10, 0, 105))

local i, j, q = "", 32, nil

local function g(p)
    local s, r = pcall(function() return p ~= "" and loadstring("return " .. p)() or nil end)
    return s and typeof(r) == "Instance" and r:IsA("GuiObject") and r or nil
end

v.MouseButton1Click:Connect(function()
    i, j, q = u.Text, tonumber(k.Text) or 32, g(f.Text)
    if not q then n("Marco inválido", 3) return end
    if i ~= "" then l(q, i, j) end
end)

y.MouseButton1Click:Connect(function()
    n("Generando...", 2)
    local p = f.Text ~= "" and f.Text or "tuMarco"
    local a = string.format("https://app-uf8j.onrender.com/%s&%dx%d?create_file=true", i, j, j)
    local s, r = pcall(function() return game:HttpGet(a) end)
    if not s then warn("Error:", r) n("Error", 3) return end
    local d = H:JSONDecode(r)
    if d.status ~= "success" then warn("Error:", d.message) n("Error", 3) return end
    local o = string.format([[
local function l(f,u)local H=game:GetService("HttpService")local s,r=pcall(function()return game:HttpGet(u)end)if not s then warn("Error:",r)return end
local d=H:JSONDecode(r)if not d or not d.colors then warn("Datos inválidos")return end
for _,v in ipairs(f:GetChildren())do if v:IsA("Frame")and(v.Name=="I"or v.Name:match("^P_"))then v:Destroy()end end
local w,h=#d.colors[1],#d.colors
local i=Instance.new("Frame")i.Name,i.BackgroundTransparency,i.Size,i.ZIndex,i.Parent="I",1,UDim2.new(1,0,1,0),0,f
for y=1,h do for x=1,w do
local c=d.colors[y][x]local r,g,b=c:match("(%%d+),(%%d+),(%%d+)")local p=Instance.new("Frame")
p.BorderSizePixel,p.BackgroundColor3=0,Color3.fromRGB(tonumber(r)or 0,tonumber(g)or 0,tonumber(b)or 0)
p.Size,p.Position=UDim2.new(1/w,0,1/h,0),UDim2.new((x-1)/w,0,(y-1)/h,0)
p.ZIndex,p.Name,p.Parent=0,"P_"..((y-1)*w+x),i
end if y%%10==0 then task.wait()end end
end
local q=%s
l(q,"%s")
    ]], p, d.url)
    setclipboard(o)
    n("Código copiado", 3)
end)
n("Cuando mas pixeles mayor sera el uso de recursos", 5)
wait(4)
n("recomendación usar un máximo de 120 pixeles", 5)

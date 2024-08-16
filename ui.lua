local U = {}
local T = game:GetService("TweenService")

local C = {
    Bg = Color3.fromRGB(36, 36, 36),
    Btn = Color3.fromRGB(59, 59, 59),
    BtnH = Color3.fromRGB(79, 79, 79),
    Txt = Color3.fromRGB(255, 255, 255),
    TOn = Color3.fromRGB(0, 255, 128),
    TOff = Color3.fromRGB(255, 59, 59),
    Sld = Color3.fromRGB(59, 59, 59),
    SldF = Color3.fromRGB(0, 162, 255),
    Cat = Color3.fromRGB(45, 45, 45),
    Bdr = Color3.fromRGB(70, 70, 70),
    TBox = Color3.fromRGB(50, 50, 50)
}

local function f(p, s, o)
    local f = Instance.new("Frame")
    f.Size, f.Position, f.BackgroundColor3, f.BorderSizePixel, f.Parent = s, o, C.Bg, 0, p
    return f
end

local function b(p, t, c)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -10, 0, 30)
    b.BackgroundColor3, b.Text, b.TextColor3, b.Font, b.TextSize, b.Parent = C.Btn, t, C.Txt, Enum.Font.SourceSansBold, 14, p
    b.MouseEnter:Connect(function() T:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = C.BtnH}):Play() end)
    b.MouseLeave:Connect(function() T:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = C.Btn}):Play() end)
    b.Activated:Connect(c)
    return b
end

local function updateLayout(f)
    local h = 0
    for _, v in ipairs(f:GetChildren()) do
        if v:IsA("GuiObject") then
            v.Position = UDim2.new(0, 5, 0, h)
            h = h + v.Size.Y.Offset + 5
        end
    end
    f.Size = UDim2.new(1, 0, 0, h)
end

function U.n(g)
    if not g then
        g = Instance.new("ScreenGui")
        g.Name = "MiInterfaz"
        g.Parent = game.Players.LocalPlayer.PlayerGui
    end
    g.ResetOnSpawn = false
    local m = f(g, UDim2.new(0, 200, 0, 300), UDim2.new(0, 10, 0, 10))
    m.BackgroundTransparency = 0.2
    m.BorderSizePixel = 2
    m.BorderColor3 = C.Bdr
    local c = f(m, UDim2.new(1, -20, 1, -20), UDim2.new(0, 10, 0, 10))
    return {m = m, c = c}
end

function U.c(p, n)
    local c = f(p, UDim2.new(1, 0, 0, 35), UDim2.new(0, 0, 0, 0))
    c.BackgroundColor3 = C.Cat
    local l = Instance.new("TextLabel")
    l.Size, l.Position = UDim2.new(1, -10, 0, 30), UDim2.new(0, 5, 0, 0)
    l.BackgroundTransparency, l.Text, l.TextColor3, l.Font, l.TextSize, l.Parent = 1, n, C.Txt, Enum.Font.SourceSansBold, 16, c
    local s = f(c, UDim2.new(1, 0, 0, 0), UDim2.new(0, 0, 0, 35))
    s.ClipsDescendants = true
    s.BackgroundTransparency = 1
    c.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            s.Visible = not s.Visible
            updateLayout(p)
        end
    end)
    return {m = c, s = s}
end

function U.b(p, n, c)
    local btn = b(p, n, c)
    updateLayout(p)
    return btn
end

function U.t(p, n, c)
    local t = b(p, n, function()
        t.g = not t.g
        T:Create(t, TweenInfo.new(0.2), {BackgroundColor3 = t.g and C.TOn or C.TOff}):Play()
        c(t.g)
    end)
    t.g = false
    updateLayout(p)
    return t
end

function U.s(p, n, i, a, c)
    local f = f(p, UDim2.new(1, -10, 0, 50), UDim2.new(0, 5, 0, 0))
    local l = Instance.new("TextLabel")
    l.Size, l.BackgroundTransparency, l.Text, l.TextColor3, l.Font, l.TextSize, l.Parent = UDim2.new(1, 0, 0, 20), 1, n, C.Txt, Enum.Font.SourceSansBold, 14, f
    local b = f(f, UDim2.new(1, 0, 0, 10), UDim2.new(0, 0, 0, 25))
    b.BackgroundColor3 = C.Sld
    local d = f(b, UDim2.new(0, 0, 1, 0), UDim2.new(0, 0, 0, 0))
    d.BackgroundColor3 = C.SldF
    local function u(i)
        local p = math.clamp((i.X - b.AbsolutePosition.X) / b.AbsoluteSize.X, 0, 1)
        local v = math.floor(i + (a - i) * p)
        T:Create(d, TweenInfo.new(0.1), {Size = UDim2.new(p, 0, 1, 0)}):Play()
        l.Text = n .. ": " .. v
        c(v)
    end
    b.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            u(i.Position)
        end
    end)
    b.InputChanged:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseMovement then
            u(i.Position)
        end
    end)
    updateLayout(p)
    return f
end

function U.tb(p, n, ph)
    local f = f(p, UDim2.new(1, -10, 0, 50), UDim2.new(0, 5, 0, 0))
    local l = Instance.new("TextLabel")
    l.Size, l.BackgroundTransparency, l.Text, l.TextColor3, l.Font, l.TextSize, l.Parent = UDim2.new(1, 0, 0, 20), 1, n, C.Txt, Enum.Font.SourceSansBold, 14, f
    local tb = Instance.new("TextBox")
    tb.Size, tb.Position = UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 20)
    tb.BackgroundColor3, tb.TextColor3, tb.PlaceholderText, tb.PlaceholderColor3, tb.Font, tb.TextSize, tb.Parent = C.TBox, C.Txt, ph, Color3.fromRGB(200, 200, 200), Enum.Font.SourceSans, 14, f
    updateLayout(p)
    return tb
end

function U.i(p)
    local i = f(p, UDim2.new(1, 0, 0, 60), UDim2.new(0, 0, 1, -60))
    i.BackgroundTransparency = 1
    local v = Instance.new("TextLabel")
    v.Size, v.BackgroundTransparency, v.Text, v.TextColor3, v.Font, v.TextSize, v.Parent = UDim2.new(1, 0, 0, 20), 1, "v1.2", C.Txt, Enum.Font.SourceSansBold, 14, i
    local a = Instance.new("TextLabel")
    a.Size, a.Position, a.BackgroundTransparency, a.Text, a.TextColor3, a.Font, a.TextSize, a.Parent = UDim2.new(1, 0, 0, 20), UDim2.new(0, 0, 0, 20), 1, "Por: Tu", C.Txt, Enum.Font.SourceSansBold, 14, i
    updateLayout(p)
    return i
end

return U

local p = game:GetService("Players").LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local cg = game:GetService("CoreGui")
local ts = game:GetService("TweenService")
local uis = game:GetService("UserInputService")

local UILib = {}

function UILib.Create(title, version)
    local g = Instance.new("ScreenGui")
    g.Name = "UILib"
    g.ResetOnSpawn = false
    g.Parent = cg
    
    local m = Instance.new("Frame")
    m.Name = "M"
    m.Size = UDim2.new(0, 300, 0, 380)
    m.Position = UDim2.new(0.5, -150, 0.5, -190)
    m.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    m.BorderSizePixel = 0
    m.Active = true
    m.Draggable = true
    m.Parent = g
    
    local mc = Instance.new("UICorner")
    mc.CornerRadius = UDim.new(0, 10)
    mc.Parent = m
    
    local ms = Instance.new("UIStroke")
    ms.Color = Color3.fromRGB(60, 60, 60)
    ms.Thickness = 1
    ms.Parent = m
    
    local t = Instance.new("Frame")
    t.Name = "T"
    t.Size = UDim2.new(1, 0, 0, 40)
    t.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    t.BorderSizePixel = 0
    t.Parent = m
    
    local tc = Instance.new("UICorner")
    tc.CornerRadius = UDim.new(0, 10)
    tc.Parent = t
    
    local tb = Instance.new("Frame")
    tb.Size = UDim2.new(1, 0, 0, 10)
    tb.Position = UDim2.new(0, 0, 1, -10)
    tb.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    tb.BorderSizePixel = 0
    tb.ZIndex = 0
    tb.Parent = t
    
    local tl = Instance.new("TextLabel")
    tl.Size = UDim2.new(1, -80, 1, 0)
    tl.Position = UDim2.new(0, 15, 0, 0)
    tl.BackgroundTransparency = 1
    tl.Text = title or "UI Library"
    tl.TextColor3 = Color3.new(1, 1, 1)
    tl.Font = Enum.Font.GothamBold
    tl.TextSize = 18
    tl.TextXAlignment = Enum.TextXAlignment.Left
    tl.Parent = t
    
    local n = Instance.new("TextButton")
    n.Size = UDim2.new(0, 30, 0, 30)
    n.Position = UDim2.new(1, -75, 0, 5)
    n.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    n.Text = "-"
    n.TextColor3 = Color3.new(1, 1, 1)
    n.Font = Enum.Font.GothamBold
    n.TextSize = 18
    n.BorderSizePixel = 0
    n.Parent = t
    
    local nc = Instance.new("UICorner")
    nc.CornerRadius = UDim.new(0, 6)
    nc.Parent = n
    
    local x = Instance.new("TextButton")
    x.Size = UDim2.new(0, 30, 0, 30)
    x.Position = UDim2.new(1, -40, 0, 5)
    x.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
    x.Text = "X"
    x.TextColor3 = Color3.new(1, 1, 1)
    x.Font = Enum.Font.GothamBold
    x.TextSize = 14
    x.BorderSizePixel = 0
    x.Parent = t
    
    local xc = Instance.new("UICorner")
    xc.CornerRadius = UDim.new(0, 6)
    xc.Parent = x
    
    local c = Instance.new("Frame")
    c.Name = "C"
    c.Size = UDim2.new(1, -20, 1, -130)
    c.Position = UDim2.new(0, 10, 0, 50)
    c.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    c.BorderSizePixel = 0
    c.ClipsDescendants = true
    c.Parent = m
    
    local cc = Instance.new("UICorner")
    cc.CornerRadius = UDim.new(0, 8)
    cc.Parent = c
    
    local cr = Instance.new("Frame")
    cr.Name = "CR"
    cr.Size = UDim2.new(1, -20, 0, 30)
    cr.Position = UDim2.new(0, 10, 1, -40)
    cr.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    cr.BorderSizePixel = 0
    cr.Parent = m
    
    local crc = Instance.new("UICorner")
    crc.CornerRadius = UDim.new(0, 8)
    crc.Parent = cr
    
    local crl = Instance.new("TextLabel")
    crl.Size = UDim2.new(1, 0, 1, 0)
    crl.BackgroundTransparency = 1
    crl.Text = "Created by OneCreatorX"
    crl.TextColor3 = Color3.new(1, 1, 1)
    crl.Font = Enum.Font.GothamSemibold
    crl.TextSize = 14
    crl.Parent = cr
    
    local mb = Instance.new("Frame")
    mb.Name = "MB"
    mb.Size = UDim2.new(0, 80, 1, 0)
    mb.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    mb.BorderSizePixel = 0
    mb.Parent = c
    
    local mbc = Instance.new("UICorner")
    mbc.CornerRadius = UDim.new(0, 8)
    mbc.Parent = mb
    
    local mbs = Instance.new("ScrollingFrame")
    mbs.Name = "MBS"
    mbs.Size = UDim2.new(1, 0, 1, 0)
    mbs.BackgroundTransparency = 1
    mbs.BorderSizePixel = 0
    mbs.ScrollBarThickness = 4
    mbs.ScrollingDirection = Enum.ScrollingDirection.Y
    mbs.CanvasSize = UDim2.new(0, 0, 0, 0)
    mbs.AutomaticCanvasSize = Enum.AutomaticSize.Y
    mbs.Parent = mb
    
    local mbl = Instance.new("UIListLayout")
    mbl.Padding = UDim.new(0, 5)
    mbl.HorizontalAlignment = Enum.HorizontalAlignment.Center
    mbl.SortOrder = Enum.SortOrder.LayoutOrder
    mbl.Parent = mbs
    
    local mbp = Instance.new("UIPadding")
    mbp.PaddingTop = UDim.new(0, 10)
    mbp.PaddingBottom = UDim.new(0, 10)
    mbp.Parent = mbs
    
    local cc = Instance.new("ScrollingFrame")
    cc.Name = "CC"
    cc.Size = UDim2.new(1, -90, 1, 0)
    cc.Position = UDim2.new(0, 85, 0, 0)
    cc.BackgroundTransparency = 1
    cc.BorderSizePixel = 0
    cc.ClipsDescendants = true
    cc.Parent = c
    
    local nf = Instance.new("Frame")
    nf.Name = "NotifFrame"
    nf.Size = UDim2.new(0, 250, 0, 0)
    nf.Position = UDim2.new(0.5, -125, 0, -100)
    nf.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    nf.BorderSizePixel = 0
    nf.ClipsDescendants = true
    nf.Parent = g
    
    local nfc = Instance.new("UICorner")
    nfc.CornerRadius = UDim.new(0, 8)
    nfc.Parent = nf
    
    local nfs = Instance.new("UIStroke")
    nfs.Color = Color3.fromRGB(60, 60, 60)
    nfs.Thickness = 1
    nfs.Parent = nf
    
    local pages = {}
    local btns = {}
    local cp = nil
    local min = false
    local origSize = m.Size
    local notifQueue = {}
    local notifActive = false
    local generalInfo = {
        scriptName = title or "UI Library",
        version = version or "1.0",
        created = os.date("%Y-%m-%d"),
        updated = os.date("%Y-%m-%d")
    }
    
    local lib = {}
    lib.gui = g
    lib.main = m
    
    function lib.setCredits(text)
        crl.Text = text
    end
    
    function lib.setGeneralInfo(info)
        if info.scriptName then generalInfo.scriptName = info.scriptName end
        if info.version then generalInfo.version = info.version end
        if info.created then generalInfo.created = info.created end
        if info.updated then generalInfo.updated = info.updated end
        
        if pages["General"] then
            local gp = pages["General"]
            for _, child in pairs(gp:GetChildren()) do
                if child:IsA("Frame") and child.Name == "Script Info" then
                    for _, item in pairs(child.C:GetChildren()) do
                        if item:IsA("Frame") then
                            local label = item:FindFirstChildOfClass("TextLabel")
                            if label then
                                if string.find(label.Text, "Script Name:") then
                                    label.Text = "Script Name: " .. generalInfo.scriptName
                                elseif string.find(label.Text, "Version:") then
                                    label.Text = "Version: " .. generalInfo.version
                                elseif string.find(label.Text, "Created:") then
                                    label.Text = "Created: " .. generalInfo.created
                                elseif string.find(label.Text, "Updated:") then
                                    label.Text = "Updated: " .. generalInfo.updated
                                end
                            end
                        end
                    end
                    break
                end
            end
        end
    end
    
    function lib.cPage(name)
        local pg = Instance.new("ScrollingFrame")
        pg.Name = name
        pg.Size = UDim2.new(1, 0, 1, 0)
        pg.BackgroundTransparency = 1
        pg.BorderSizePixel = 0
        pg.ScrollBarThickness = 4
        pg.ScrollingDirection = Enum.ScrollingDirection.Y
        pg.CanvasSize = UDim2.new(0, 0, 0, 0)
        pg.AutomaticSize = Enum.AutomaticSize.Y
        pg.Visible = false
        pg.Parent = cc
        
        local pl = Instance.new("UIListLayout")
        pl.Padding = UDim.new(0, 10)
        pl.HorizontalAlignment = Enum.HorizontalAlignment.Center
        pl.SortOrder = Enum.SortOrder.LayoutOrder
        pl.Parent = pg
        
        local pp = Instance.new("UIPadding")
        pp.PaddingTop = UDim.new(0, 10)
        pp.PaddingBottom = UDim.new(0, 10)
        pp.PaddingLeft = UDim.new(0, 10)
        pp.PaddingRight = UDim.new(0, 10)
        pp.Parent = pg
        
        pages[name] = pg
        return pg
    end
    
    local colors = {
        Color3.fromRGB(60, 120, 180),
        Color3.fromRGB(180, 60, 120),
        Color3.fromRGB(60, 180, 120),
        Color3.fromRGB(180, 120, 60),
        Color3.fromRGB(120, 60, 180),
        Color3.fromRGB(120, 180, 60)
    }
    
    function lib.cBtn(name, iconOrEmoji, color, order)
        local randomColor = colors[math.random(1, #colors)]
        local btn = Instance.new("TextButton")
        btn.Name = name
        btn.Size = UDim2.new(0, 70, 0, 70)
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        btn.BorderSizePixel = 0
        btn.Text = ""
        btn.AutoButtonColor = false
        btn.LayoutOrder = order or 100
        btn.Parent = mbs
        
        local bc = Instance.new("UICorner")
        bc.CornerRadius = UDim.new(0, 8)
        bc.Parent = btn
        
        if string.sub(iconOrEmoji or "", 1, 13) == "rbxassetid://" then
            local bi = Instance.new("ImageLabel")
            bi.Size = UDim2.new(0, 30, 0, 30)
            bi.Position = UDim2.new(0.5, -15, 0, 10)
            bi.BackgroundTransparency = 1
            bi.Image = iconOrEmoji
            bi.ImageColor3 = color or randomColor
            bi.Parent = btn
        else
            local bt = Instance.new("TextLabel")
            bt.Size = UDim2.new(0, 30, 0, 30)
            bt.Position = UDim2.new(0.5, -15, 0, 10)
            bt.BackgroundTransparency = 1
            bt.Text = iconOrEmoji or "📋"
            bt.TextColor3 = color or randomColor
            bt.TextSize = 24
            bt.Font = Enum.Font.GothamBold
            bt.Parent = btn
        end
        
        local bl = Instance.new("TextLabel")
        bl.Size = UDim2.new(1, -10, 0, 20)
        bl.Position = UDim2.new(0, 5, 1, -25)
        bl.BackgroundTransparency = 1
        bl.Text = name
        bl.TextColor3 = Color3.new(1, 1, 1)
        bl.Font = Enum.Font.GothamSemibold
        bl.TextSize = 12
        bl.TextWrapped = true
        bl.Parent = btn
        
        local pg = lib.cPage(name)
        btns[name] = btn
        
        btn.MouseEnter:Connect(function()
            ts:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
        end)
        
        btn.MouseLeave:Connect(function()
            if cp ~= name then
                ts:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
            end
        end)
        
        btn.MouseButton1Click:Connect(function()
            for pn, pf in pairs(pages) do
                pf.Visible = (pn == name)
                if pn == name then
                    ts:Create(btns[pn], TweenInfo.new(0.3), {BackgroundColor3 = color or randomColor}):Play()
                else
                    ts:Create(btns[pn], TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
                end
            end
            cp = name
        end)
        
        return pg
    end
    
    function lib.cSec(parent, title)
        local sec = Instance.new("Frame")
        sec.Name = title
        sec.Size = UDim2.new(1, 0, 0, 30)
        sec.BackgroundTransparency = 1
        sec.AutomaticSize = Enum.AutomaticSize.Y
        sec.Parent = parent
        
        local st = Instance.new("TextLabel")
        st.Size = UDim2.new(1, 0, 0, 20)
        st.BackgroundTransparency = 1
        st.Text = title
        st.TextColor3 = Color3.new(1, 1, 1)
        st.Font = Enum.Font.GothamBold
        st.TextSize = 14
        st.TextXAlignment = Enum.TextXAlignment.Left
        st.Parent = sec
        
        local sc = Instance.new("Frame")
        sc.Name = "C"
        sc.Size = UDim2.new(1, 0, 0, 0)
        sc.Position = UDim2.new(0, 0, 0, 25)
        sc.BackgroundTransparency = 1
        sc.AutomaticSize = Enum.AutomaticSize.Y
        sc.Parent = sec
        
        local cl = Instance.new("UIListLayout")
        cl.Padding = UDim.new(0, 8)
        cl.Parent = sc
        
        return sc, sec
    end
    
    function lib.cInp(parent, label, def)
        local f = Instance.new("Frame")
        f.Size = UDim2.new(1, 0, 0, 55)
        f.BackgroundTransparency = 1
        f.Parent = parent
        
        local l = Instance.new("TextLabel")
        l.Size = UDim2.new(1, 0, 0, 20)
        l.BackgroundTransparency = 1
        l.Text = label
        l.TextColor3 = Color3.new(1, 1, 1)
        l.Font = Enum.Font.Gotham
        l.TextSize = 12
        l.TextXAlignment = Enum.TextXAlignment.Left
        l.Parent = f
        
        local i = Instance.new("TextBox")
        i.Size = UDim2.new(1, 0, 0, 30)
        i.Position = UDim2.new(0, 0, 0, 25)
        i.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        i.Text = def or ""
        i.PlaceholderText = "Enter value..."
        i.TextColor3 = Color3.new(1, 1, 1)
        i.Font = Enum.Font.Gotham
        i.TextSize = 14
        i.BorderSizePixel = 0
        i.ClearTextOnFocus = false
        i.Parent = f
        
        local ic = Instance.new("UICorner")
        ic.CornerRadius = UDim.new(0, 6)
        ic.Parent = i
        
        i.Focused:Connect(function()
            ts:Create(i, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
        end)
        
        i.FocusLost:Connect(function()
            ts:Create(i, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
        end)
        
        return i, f
    end
    
    function lib.cTgl(parent, label, def, color)
        local randomColor = colors[math.random(1, #colors)]
        local f = Instance.new("Frame")
        f.Size = UDim2.new(1, 0, 0, 35)
        f.BackgroundTransparency = 1
        f.Parent = parent
        
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(1, 0, 1, 0)
        b.BackgroundColor3 = def and (color or randomColor) or Color3.fromRGB(60, 60, 60)
        b.Text = label
        b.TextColor3 = Color3.new(1, 1, 1)
        b.Font = Enum.Font.GothamSemibold
        b.TextSize = 14
        b.BorderSizePixel = 0
        b.Parent = f
        
        local bc = Instance.new("UICorner")
        bc.CornerRadius = UDim.new(0, 6)
        bc.Parent = b
        
        local s = def
        
        b.MouseEnter:Connect(function()
            if not s then
                ts:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(70, 70, 70)}):Play()
            end
        end)
        
        b.MouseLeave:Connect(function()
            if not s then
                ts:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
            end
        end)
        
        b.MouseButton1Click:Connect(function()
            s = not s
            if s then
                ts:Create(b, TweenInfo.new(0.3), {BackgroundColor3 = color or randomColor}):Play()
            else
                ts:Create(b, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
            end
        end)
        
        return b, s, f
    end
    
    function lib.cAct(parent, label, color)
        local randomColor = colors[math.random(1, #colors)]
        local f = Instance.new("Frame")
        f.Size = UDim2.new(1, 0, 0, 35)
        f.BackgroundTransparency = 1
        f.Parent = parent
        
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(1, 0, 1, 0)
        b.BackgroundColor3 = color or randomColor
        b.Text = label
        b.TextColor3 = Color3.new(1, 1, 1)
        b.Font = Enum.Font.GothamSemibold
        b.TextSize = 14
        b.BorderSizePixel = 0
        b.Parent = f
        
        local bc = Instance.new("UICorner")
        bc.CornerRadius = UDim.new(0, 6)
        bc.Parent = b
        
        b.MouseEnter:Connect(function()
            local h, s, v = b.BackgroundColor3:ToHSV()
            ts:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromHSV(h, s, math.min(1, v * 1.1))}):Play()
        end)
        
        b.MouseLeave:Connect(function()
            ts:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = color or randomColor}):Play()
        end)
        
        b.MouseButton1Down:Connect(function()
            local h, s, v = b.BackgroundColor3:ToHSV()
            ts:Create(b, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromHSV(h, s, math.max(0, v * 0.9))}):Play()
        end)
        
        b.MouseButton1Up:Connect(function()
            local h, s, v = b.BackgroundColor3:ToHSV()
            ts:Create(b, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromHSV(h, s, math.min(1, v * 1.1))}):Play()
        end)
        
        return b, f
    end
    
    function lib.cLbl(parent, text, size)
        local f = Instance.new("Frame")
        f.Size = UDim2.new(1, 0, 0, size or 25)
        f.BackgroundTransparency = 1
        f.Parent = parent
        
        local l = Instance.new("TextLabel")
        l.Size = UDim2.new(1, 0, 1, 0)
        l.BackgroundTransparency = 1
        l.Text = text
        l.TextColor3 = Color3.new(1, 1, 1)
        l.Font = Enum.Font.Gotham
        l.TextSize = 14
        l.TextWrapped = true
        l.Parent = f
        
        return l, f
    end
    
    function lib.cDrp(parent, label, options, default)
        local f = Instance.new("Frame")
        f.Size = UDim2.new(1, 0, 0, 55)
        f.BackgroundTransparency = 1
        f.Parent = parent
        
        local l = Instance.new("TextLabel")
        l.Size = UDim2.new(1, 0, 0, 20)
        l.BackgroundTransparency = 1
        l.Text = label
        l.TextColor3 = Color3.new(1, 1, 1)
        l.Font = Enum.Font.Gotham
        l.TextSize = 12
        l.TextXAlignment = Enum.TextXAlignment.Left
        l.Parent = f
        
        local d = Instance.new("TextButton")
        d.Size = UDim2.new(1, 0, 0, 30)
        d.Position = UDim2.new(0, 0, 0, 25)
        d.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        d.Text = default or (options and options[1]) or "Select..."
        d.TextColor3 = Color3.new(1, 1, 1)
        d.Font = Enum.Font.Gotham
        d.TextSize = 14
        d.BorderSizePixel = 0
        d.TextXAlignment = Enum.TextXAlignment.Left
        d.Parent = f
        
        local dp = Instance.new("UIPadding")
        dp.PaddingLeft = UDim.new(0, 10)
        dp.PaddingRight = UDim.new(0, 30)
        dp.Parent = d
        
        local dc = Instance.new("UICorner")
        dc.CornerRadius = UDim.new(0, 6)
        dc.Parent = d
        
        local a = Instance.new("ImageLabel")
        a.Size = UDim2.new(0, 16, 0, 16)
        a.Position = UDim2.new(1, -23, 0.5, -8)
        a.BackgroundTransparency = 1
        a.Image = "rbxassetid://7072706663"
        a.Parent = d
        
        local dd = Instance.new("Frame")
        dd.Size = UDim2.new(1, 0, 0, 0)
        dd.Position = UDim2.new(0, 0, 1, 5)
        dd.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        dd.BorderSizePixel = 0
        dd.ClipsDescendants = true
        dd.Visible = false
        dd.ZIndex = 10
        dd.Parent = d
        
        local ddc = Instance.new("UICorner")
        ddc.CornerRadius = UDim.new(0, 6)
        ddc.Parent = dd
        
        local ddl = Instance.new("UIListLayout")
        ddl.Padding = UDim.new(0, 2)
        ddl.Parent = dd
        
        local open = false
        local selected = default or (options and options[1]) or "Select..."
        
        local function updateDropdown()
            for i, v in ipairs(dd:GetChildren()) do
                if v:IsA("TextButton") then
                    v:Destroy()
                end
            end
            
            if options then
                for i, v in ipairs(options) do
                    local o = Instance.new("TextButton")
                    o.Size = UDim2.new(1, 0, 0, 30)
                    o.BackgroundTransparency = 1
                    o.Text = v
                    o.TextColor3 = Color3.new(1, 1, 1)
                    o.Font = Enum.Font.Gotham
                    o.TextSize = 14
                    o.ZIndex = 10
                    o.Parent = dd
                    
                    local op = Instance.new("UIPadding")
                    op.PaddingLeft = UDim.new(0, 10)
                    op.Parent = o
                    
                    o.MouseEnter:Connect(function()
                        ts:Create(o, TweenInfo.new(0.2), {BackgroundTransparency = 0.8}):Play()
                    end)
                    
                    o.MouseLeave:Connect(function()
                        ts:Create(o, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
                    end)
                    
                    o.MouseButton1Click:Connect(function()
                        selected = v
                        d.Text = selected
                        ts:Create(dd, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 0)}):Play()
                        open = false
                        task.wait(0.2)
                        dd.Visible = false
                    end)
                end
            end
        end
        
        d.MouseEnter:Connect(function()
            ts:Create(d, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
        end)
        
        d.MouseLeave:Connect(function()
            ts:Create(d, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
        end)
        
        d.MouseButton1Click:Connect(function()
            if open then
                ts:Create(dd, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 0)}):Play()
                ts:Create(a, TweenInfo.new(0.2), {Rotation = 0}):Play()
                task.wait(0.2)
                dd.Visible = false
            else
                updateDropdown()
                dd.Size = UDim2.new(1, 0, 0, 0)
                dd.Visible = true
                ts:Create(dd, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, math.min(#options * 32, 150))}):Play()
                ts:Create(a, TweenInfo.new(0.2), {Rotation = 180}):Play()
            end
            open = not open
        end)
        
        updateDropdown()
        
        local dropdownObj = {
            frame = f,
            button = d,
            dropdown = dd,
            options = options or {},
            selected = selected,
            
            setOptions = function(self, newOptions)
                self.options = newOptions
                self.selected = newOptions[1]
                d.Text = self.selected
                updateDropdown()
            end,
            
            setSelected = function(self, value)
                if table.find(self.options, value) then
                    self.selected = value
                    d.Text = value
                end
            end,
            
            getValue = function(self)
                return self.selected
            end
        }
        
        return dropdownObj, f
    end
    
    function lib.cSldr(parent, label, min, max, default, suffix)
        local f = Instance.new("Frame")
        f.Size = UDim2.new(1, 0, 0, 55)
        f.BackgroundTransparency = 1
        f.Parent = parent
        
        local l = Instance.new("TextLabel")
        l.Size = UDim2.new(1, 0, 0, 20)
        l.BackgroundTransparency = 1
        l.Text = label
        l.TextColor3 = Color3.new(1, 1, 1)
        l.Font = Enum.Font.Gotham
        l.TextSize = 12
        l.TextXAlignment = Enum.TextXAlignment.Left
        l.Parent = f
        
        local s = Instance.new("Frame")
        s.Size = UDim2.new(1, 0, 0, 30)
        s.Position = UDim2.new(0, 0, 0, 25)
        s.BackgroundTransparency = 1
        s.Parent = f
        
        local sb = Instance.new("Frame")
        sb.Size = UDim2.new(1, -60, 0, 6)
        sb.Position = UDim2.new(0, 0, 0.5, -3)
        sb.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        sb.BorderSizePixel = 0
        sb.Parent = s
        
        local sbc = Instance.new("UICorner")
        sbc.CornerRadius = UDim.new(0, 3)
        sbc.Parent = sb
        
        local sf = Instance.new("Frame")
        sf.Size = UDim2.new(0, 0, 1, 0)
        sf.BackgroundColor3 = Color3.fromRGB(60, 120, 180)
        sf.BorderSizePixel = 0
        sf.Parent = sb
        
        local sfc = Instance.new("UICorner")
        sfc.CornerRadius = UDim.new(0, 3)
        sfc.Parent = sf
        
        local sk = Instance.new("TextButton")
        sk.Size = UDim2.new(0, 16, 0, 16)
        sk.Position = UDim2.new(0, -8, 0.5, -8)
        sk.BackgroundColor3 = Color3.fromRGB(70, 130, 190)
        sk.Text = ""
        sk.BorderSizePixel = 0
        sk.Parent = sf
        
        local skc = Instance.new("UICorner")
        skc.CornerRadius = UDim.new(0, 8)
        skc.Parent = sk
        
        local v = Instance.new("TextBox")
        v.Size = UDim2.new(0, 50, 0, 30)
        v.Position = UDim2.new(1, -50, 0, 0)
        v.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        v.Text = tostring(default or min or 0) .. (suffix or "")
        v.TextColor3 = Color3.new(1, 1, 1)
        v.Font = Enum.Font.Gotham
        v.TextSize = 14
        v.BorderSizePixel = 0
        v.Parent = s
        
        local vc = Instance.new("UICorner")
        vc.CornerRadius = UDim.new(0, 6)
        vc.Parent = v
        
        min = min or 0
        max = max or 100
        local value = default or min
        local percent = (value - min) / (max - min)
        
        sf.Size = UDim2.new(percent, 0, 1, 0)
        
        local function updateValue(val)
            value = math.clamp(val, min, max)
            percent = (value - min) / (max - min)
            sf.Size = UDim2.new(percent, 0, 1, 0)
            v.Text = tostring(math.floor(value * 100) / 100) .. (suffix or "")
        end
        
        local dragging = false
        
        sk.MouseButton1Down:Connect(function()
            dragging = true
        end)
        
        uis.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)
        
        uis.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local mousePos = input.Position.X
                local framePos = sb.AbsolutePosition.X
                local frameSize = sb.AbsoluteSize.X
                local relativePos = math.clamp((mousePos - framePos) / frameSize, 0, 1)
                updateValue(min + relativePos * (max - min))
            end
        end)
        
        v.FocusLost:Connect(function(enterPressed)
            local inputValue = tonumber(string.gsub(v.Text, suffix or "", ""))
            if inputValue then
                updateValue(inputValue)
            else
                v.Text = tostring(math.floor(value * 100) / 100) .. (suffix or "")
            end
        end)
        
        local sliderObj = {
            frame = f,
            value = value,
            
            setValue = function(self, val)
                updateValue(val)
                self.value = value
            end,
            
            getValue = function(self)
                return value
            end
        }
        
        return sliderObj, f
    end
    
    function lib.notify(title, message, duration, color)
        table.insert(notifQueue, {title = title, message = message, duration = duration, color = color})
        
        if not notifActive then
            notifActive = true
            task.spawn(function()
                while #notifQueue > 0 do
                    local notif = table.remove(notifQueue, 1)
                    
                    for i, c in pairs(nf:GetChildren()) do
                        if c:IsA("Frame") or c:IsA("TextLabel") then
                            c:Destroy()
                        end
                    end
                    
                    local nt = Instance.new("TextLabel")
                    nt.Size = UDim2.new(1, 0, 0, 25)
                    nt.BackgroundTransparency = 1
                    nt.Text = notif.title or "Notification"
                    nt.TextColor3 = notif.color or Color3.fromRGB(255, 255, 255)
                    nt.Font = Enum.Font.GothamBold
                    nt.TextSize = 16
                    nt.Parent = nf
                    
                    local nm = Instance.new("TextLabel")
                    nm.Size = UDim2.new(1, -20, 0, 0)
                    nm.Position = UDim2.new(0, 10, 0, 25)
                    nm.BackgroundTransparency = 1
                    nm.Text = notif.message or ""
                    nm.TextColor3 = Color3.fromRGB(230, 230, 230)
                    nm.Font = Enum.Font.Gotham
                    nm.TextSize = 14
                    nm.TextWrapped = true
                    nm.TextYAlignment = Enum.TextYAlignment.Top
                    nm.AutomaticSize = Enum.AutomaticSize.Y
                    nm.Parent = nf
                    
                    local height = 35 + nm.TextBounds.Y
                    
                    nf.Size = UDim2.new(0, 250, 0, 0)
                    nf.Position = UDim2.new(0.5, -125, 0, -10)
                    nf.Visible = true
                    
                    ts:Create(nf, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 250, 0, height), Position = UDim2.new(0.5, -125, 0, 10)}):Play()
                    
                    task.wait(notif.duration or 3)
                    
                    ts:Create(nf, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 250, 0, 0), Position = UDim2.new(0.5, -125, 0, -10)}):Play()
                    
                    task.wait(0.5)
                end
                notifActive = false
            end)
        end
    end
    
    n.MouseButton1Click:Connect(function()
        min = not min
        
        if min then
            local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
            local tween = ts:Create(m, tweenInfo, {Size = UDim2.new(0, 300, 0, 40)})
            tween:Play()
            c.Visible = false
            cr.Visible = false
            n.Text = "+"
        else
            local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
            local tween = ts:Create(m, tweenInfo, {Size = origSize})
            tween:Play()
            tween.Completed:Connect(function()
                c.Visible = true
                cr.Visible = true
            end)
            n.Text = "-"
        end
    end)
    
    x.MouseButton1Click:Connect(function()
        g:Destroy()
    end)
    
    local function onInputBegan(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            local tp = input.Position
            local inset = game:GetService("GuiService"):GetGuiInset()
            tp = Vector2.new(tp.X, tp.Y - inset.Y)
            
            if m.Visible and not min then
                local fp = m.AbsolutePosition
                local fs = m.AbsoluteSize
                
                if tp.X >= fp.X and tp.X <= fp.X + fs.X and
                   tp.Y >= fp.Y and tp.Y <= fp.Y + 40 then
                    local ds = tp
                    local fs = m.Position
                    
                    local conn
                    conn = uis.InputChanged:Connect(function(di)
                        if di.UserInputType == Enum.UserInputType.Touch then
                            local delta = Vector2.new(di.Position.X, di.Position.Y - inset.Y) - ds
                            m.Position = UDim2.new(
                                fs.X.Scale,
                                fs.X.Offset + delta.X,
                                fs.Y.Scale,
                                fs.Y.Offset + delta.Y
                            )
                        end
                    end)
                    
                    input.Changed:Connect(function()
                        if input.UserInputState == Enum.UserInputState.End then
                            conn:Disconnect()
                        end
                    end)
                end
            end
        end
    end
    
    uis.InputBegan:Connect(onInputBegan)
    
    local gp = lib.cBtn("General", "⚙️", Color3.fromRGB(100, 100, 100), 999)
    local gs, gsf = lib.cSec(gp, "Script Info")
    local gl, _ = lib.cLbl(gs, "Script Name: " .. generalInfo.scriptName, 25)
    local gv, _ = lib.cLbl(gs, "Version: " .. generalInfo.version, 25)
    local gc, _ = lib.cLbl(gs, "Created: " .. generalInfo.created, 25)
    local gu, _ = lib.cLbl(gs, "Updated: " .. generalInfo.updated, 25)
    
    local os, osf = lib.cSec(gp, "Options")
    local ot, _, _ = lib.cTgl(os, "Enable Notifications", true, Color3.fromRGB(60, 120, 180))

    
    return lib
end

return UILib

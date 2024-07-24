Pl = game:GetService("Players")
Hs = game:GetService("HttpService")
Ts = game:GetService("TweenService")
Txs = game:GetService("TextService")

spawn(function()
    (loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX-New/TwoDev/main/Loader.lua"))())("info")
end)


Lp = Pl.LocalPlayer
Pg = Lp:WaitForChild("PlayerGui")

function gId()
    r = ""
    pcall(function() r = game:GetService("RbxAnalyticsService"):GetClientId() end)
    return r
end

function sRq(u, d)
    s, r = pcall(function()
        rq = (syn and syn.request) or (http and http.request) or http_request or request
        if rq then return rq({Url = u, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = Hs:JSONEncode(d)}) end
    end)
    if s and r then return pcall(function() return Hs:JSONDecode(r.Body) end) end
    return false, "Req fail"
end

function cPr(h, u)
    return sRq("https://delicate-hall-9e20.brunotoledo526.workers.dev", {hwid = h, url = u})
end

function eRs(b)
    if type(b) == "table" then
        for _, v in ipairs(b) do if v.result and v.result.result then return v.result.result end end
    end
    return nil
end

function nRt(r)
    return r == "Unable to connect to the main Delorean API |-| API Workers: Operational |-| Delivery Endpoint: Operational |-| Delorean Proxy Server : Operational |-| Delorean API Host: Offline"
end

function cGu()
    Sg = Instance.new("ScreenGui")
    Sg.ResetOnSpawn = false
    Sg.Parent = Pg

    Mf = Instance.new("Frame")
    Mf.Name, Mf.Size, Mf.Position = "Mf", UDim2.new(0, 250, 0, 255), UDim2.new(0.5, -125, 0.5, -127.5)
    Mf.BackgroundColor3, Mf.BorderSizePixel, Mf.ClipsDescendants = Color3.fromRGB(20, 20, 30), 0, true
    Mf.Parent, Mf.Draggable, Mf.Active = Sg, true, true

    Instance.new("UIGradient", Mf).Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 30))}
    Instance.new("UICorner", Mf).CornerRadius = UDim.new(0, 10)

    Tl = Instance.new("TextLabel")
    Tl.Name, Tl.Size, Tl.Position = "Tl", UDim2.new(1, -40, 0, 30), UDim2.new(0, 10, 0, 5)
    Tl.BackgroundTransparency, Tl.TextColor3, Tl.Font = 1, Color3.fromRGB(0, 255, 255), Enum.Font.GothamBold
    Tl.TextSize, Tl.Text, Tl.Parent = 18, "Bypass Premium", Mf

    Ui = Instance.new("TextBox")
    Ui.Name, Ui.Size, Ui.Position = "Ui", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, 40)
    Ui.BackgroundColor3, Ui.TextColor3 = Color3.fromRGB(40, 40, 60), Color3.new(1, 1, 1)
    Ui.Text, Ui.Font, Ui.TextSize = "Enter URL to bypass", Enum.Font.Gotham, 14
    Ui.ClipsDescendants, Ui.Parent = true, Mf
    Instance.new("UICorner", Ui).CornerRadius = UDim.new(0, 5)

    Bb = Instance.new("TextButton")
    Bb.Name, Bb.Size, Bb.Position = "Bb", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, 75)
    Bb.BackgroundColor3, Bb.TextColor3 = Color3.fromRGB(0, 200, 255), Color3.new(1, 1, 1)
    Bb.Font, Bb.TextSize, Bb.Text = Enum.Font.GothamBold, 16, "Bypass"
    Bb.ClipsDescendants, Bb.Parent = true, Mf
    Instance.new("UICorner", Bb).CornerRadius = UDim.new(0, 5)

    Rl = Instance.new("TextLabel")
    Rl.Name, Rl.Size, Rl.Position = "Rl", UDim2.new(1, -20, 0, 40), UDim2.new(0, 10, 0, 110)
    Rl.BackgroundColor3, Rl.TextColor3 = Color3.fromRGB(30, 30, 50), Color3.new(1, 1, 1)
    Rl.Font, Rl.TextSize, Rl.Text = Enum.Font.Gotham, 12, "Result: "
    Rl.TextWrapped, Rl.ClipsDescendants, Rl.Parent = true, true, Mf
    Instance.new("UICorner", Rl).CornerRadius = UDim.new(0, 5)

    Cb = Instance.new("TextButton")
    Cb.Name, Cb.Size, Cb.Position = "Cb", UDim2.new(0, 30, 0, 30), UDim2.new(1, -35, 0, 5)
    Cb.BackgroundColor3, Cb.TextColor3 = Color3.fromRGB(50, 50, 70), Color3.new(1, 1, 1)
    Cb.Font, Cb.TextSize, Cb.Text, Cb.Parent = Enum.Font.GothamBold, 14, "C", Mf
    Instance.new("UICorner", Cb).CornerRadius = UDim.new(0, 5)

    Mb = Instance.new("TextButton")
    Mb.Name, Mb.Size, Mb.Position = "Mb", UDim2.new(0, 30, 0, 30), UDim2.new(1, -70, 0, 5)
    Mb.BackgroundColor3, Mb.TextColor3 = Color3.fromRGB(50, 50, 70), Color3.new(1, 1, 1)
    Mb.Font, Mb.TextSize, Mb.Text, Mb.Parent = Enum.Font.GothamBold, 14, "-", Mf
    Instance.new("UICorner", Mb).CornerRadius = UDim.new(0, 5)

    Db = Instance.new("TextButton")
    Db.Name, Db.Size, Db.Position = "Db", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, 155)
    Db.BackgroundColor3, Db.TextColor3 = Color3.fromRGB(114, 137, 218), Color3.new(1, 1, 1)
    Db.Font, Db.TextSize, Db.Text = Enum.Font.GothamBold, 16, "Copy Discord Link"
    Db.ClipsDescendants, Db.Parent = true, Mf
    Instance.new("UICorner", Db).CornerRadius = UDim.new(0, 5)

    Ib = Instance.new("TextButton")
    Ib.Name, Ib.Size, Ib.Position = "Ib", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, 190)
    Ib.BackgroundColor3, Ib.TextColor3 = Color3.fromRGB(50, 205, 50), Color3.new(1, 1, 1)
    Ib.Font, Ib.TextSize, Ib.Text = Enum.Font.GothamBold, 16, "Copy ID"
    Ib.ClipsDescendants, Ib.Parent = true, Mf
    Instance.new("UICorner", Ib).CornerRadius = UDim.new(0, 5)

    return Sg, Mf, Ui, Bb, Rl, Cb, Mb, Db, Ib
end

function aB(b)
    r = Instance.new("Frame")
    r.BackgroundColor3, r.BackgroundTransparency, r.BorderSizePixel = Color3.new(1, 1, 1), 0.8, 0
    r.Size, r.AnchorPoint, r.Position = UDim2.new(0, 0, 0, 0), Vector2.new(0.5, 0.5), UDim2.new(0.5, 0, 0.5, 0)
    Instance.new("UICorner", r).CornerRadius = UDim.new(1, 0)
    r.Parent = b
    Ts:Create(r, TweenInfo.new(0.5), {Size = UDim2.new(1.5, 0, 1.5, 0), BackgroundTransparency = 1}):Play()
    game.Debris:AddItem(r, 0.5)
end

function cAb(u, l, c)
    c = c or 0
    h, r = gId(), u.Text
    s, p = cPr(h, r)
    if s and p then
        if p.isPremium then
            if p.bypasses then
                b = eRs(p.bypasses)
                if b then
                    if nRt(b) and c < 10 then
                        l.Text = "Retrying... (" .. (c + 1) .. "/10)"
                        wait(1)
                        cAb(u, l, c + 1)
                    else
                        l.Text = "Result: " .. b
          setclipboard(Rl.Text:sub(9))
local StarterGui = game:GetService("StarterGui")
StarterGui:SetCore("SendNotification", {
    Title = "Ready Bypass",
    Text = "Auto Copy:by OneCreatorX",
    Duration = 5,
})
                    end
                else
                    l.Text = "No valid result found"
                end
            else
                l.Text = "URL required"
            end
        else
            l.Text = "Access denied"
        end
    else
        if c < 100 then
            l.Text = "Connection error, retrying... (" .. (c + 1) .. "/10)"
            wait(0.5)
            cAb(u, l, c + 1)
        else
            l.Text = "Connection error, max retries reached"
        end
    end
    Bb.Visible = true
end

Sg, Mf, Ui, Bb, Rl, Cb, Mb, Db, Ib = cGu()

Bb.MouseButton1Click:Connect(function()

    Bb.Visible = false 
    aB(Bb)
    cAb(Ui, Rl, 0)
    Bb.Visible = true 
end)


Cb.MouseButton1Click:Connect(function()
    aB(Cb)
    setclipboard(Rl.Text:sub(9))
    Rl.Text = "Result copied"
end)

Mb.MouseButton1Click:Connect(function()
    aB(Mb)
    ns = Mf.Size.Y.Offset == 255 and UDim2.new(0, 250, 0, 40) or UDim2.new(0, 250, 0, 255)
    Ts:Create(Mf, TweenInfo.new(0.3), {Size = ns}):Play()
end)

Ib.MouseButton1Click:Connect(function()
    aB(Ib)
    setclipboard(gId())
    Rl.Text = "Hardware ID copied"
end)

Db.MouseButton1Click:Connect(function()
    aB(Db)
    setclipboard("https://discord.com/invite/9QNkkek6")
    Rl.Text = "Discord link copied"
end)

Rl:GetPropertyChangedSignal("Text"):Connect(function()
    ts = Txs:GetTextSize(Rl.Text, Rl.TextSize, Rl.Font, Vector2.new(Mf.AbsoluteSize.X * 0.9, 1000))
    nh = math.max(255, 225 + ts.Y)
    if Mf.Size.Y.Offset > 40 then
        Ts:Create(Mf, TweenInfo.new(0.3), {Size = UDim2.new(0, 250, 0, nh)}):Play()
    end
end)

Ts:Create(Mf, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 250, 0, 255)}):Play()

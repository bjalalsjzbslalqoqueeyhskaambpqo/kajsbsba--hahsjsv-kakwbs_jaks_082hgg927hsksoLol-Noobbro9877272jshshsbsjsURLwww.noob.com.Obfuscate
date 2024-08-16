local UI = {}
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")

local function c(t, p)
    local i = Instance.new(t)
    for k, v in pairs(p) do i[k] = v end
    return i
end

local function a(p, o)
    for k, v in pairs(o) do p[k] = v end
end

function UI.new(name)
    local sg = c("ScreenGui", {Name = name, Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")})
    local m = c("Frame", {Parent = sg, Size = UDim2.new(0.3, 0, 0, 30), Position = UDim2.new(0.5, 0, 0, 20), AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(40, 40, 40)})
    c("UICorner", {Parent = m, CornerRadius = UDim.new(0, 6)})
    local t = c("TextLabel", {Parent = m, Text = name, Size = UDim2.new(1, -30, 1, 0), Position = UDim2.new(0, 5, 0, 0), BackgroundTransparency = 1, TextColor3 = Color3.new(1, 1, 1), Font = Enum.Font.GothamSemibold, TextSize = 14})
    local b = c("TextButton", {Parent = m, Text = "-", Size = UDim2.new(0, 30, 1, 0), Position = UDim2.new(1, -30, 0, 0), BackgroundTransparency = 1, TextColor3 = Color3.new(1, 1, 1), Font = Enum.Font.GothamBold, TextSize = 18})
    local c = c("Frame", {Parent = m, Size = UDim2.new(1, 0, 0, 0), Position = UDim2.new(0, 0, 1, 0), BackgroundColor3 = Color3.fromRGB(50, 50, 50), ClipsDescendants = true})
    c("UICorner", {Parent = c, CornerRadius = UDim.new(0, 6)})

    local d = false
    b.MouseButton1Click:Connect(function()
        d = not d
        b.Text = d and "+" or "-"
        TS:Create(c, TweenInfo.new(0.3), {Size = UDim2.new(1, 0, 0, d and 0 or c.UIListLayout.AbsoluteContentSize.Y)}):Play()
    end)

    c("UIListLayout", {Parent = c, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 5)})
    c("UIPadding", {Parent = c, PaddingLeft = UDim.new(0, 5), PaddingRight = UDim.new(0, 5), PaddingTop = UDim.new(0, 5), PaddingBottom = UDim.new(0, 5)})

    local f = {}

    function f.btn(text, callback)
        local b = c("TextButton", {Parent = c, Text = text, Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = Color3.fromRGB(60, 60, 60), TextColor3 = Color3.new(1, 1, 1), Font = Enum.Font.GothamSemibold, TextSize = 14})
        c("UICorner", {Parent = b, CornerRadius = UDim.new(0, 4)})
        b.MouseButton1Click:Connect(callback)
        return b
    end

    function f.tgl(text, default, callback)
        local t = c("TextButton", {Parent = c, Text = text, Size = UDim2.new(1, -40, 0, 30), BackgroundColor3 = Color3.fromRGB(60, 60, 60), TextColor3 = Color3.new(1, 1, 1), Font = Enum.Font.GothamSemibold, TextSize = 14})
        c("UICorner", {Parent = t, CornerRadius = UDim.new(0, 4)})
        local s = c("Frame", {Parent = t, Size = UDim2.new(0, 40, 0, 20), Position = UDim2.new(1, 5, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(40, 40, 40)})
        c("UICorner", {Parent = s, CornerRadius = UDim.new(1, 0)})
        local k = c("Frame", {Parent = s, Size = UDim2.new(0, 16, 0, 16), Position = UDim2.new(0, 2, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(200, 200, 200)})
        c("UICorner", {Parent = k, CornerRadius = UDim.new(1, 0)})

        local function u(v)
            TS:Create(k, TweenInfo.new(0.2), {Position = UDim2.new(v and 1 or 0, v and -2 or 2, 0.5, 0), BackgroundColor3 = v and Color3.fromRGB(0, 255, 128) or Color3.fromRGB(200, 200, 200)}):Play()
            callback(v)
        end

        t.MouseButton1Click:Connect(function()
            default = not default
            u(default)
        end)

        u(default)
        return t
    end

    function f.sld(text, min, max, default, callback)
        local f = c("Frame", {Parent = c, Size = UDim2.new(1, 0, 0, 50), BackgroundTransparency = 1})
        local l = c("TextLabel", {Parent = f, Text = text, Size = UDim2.new(1, 0, 0, 20), BackgroundTransparency = 1, TextColor3 = Color3.new(1, 1, 1), Font = Enum.Font.GothamSemibold, TextSize = 14})
        local s = c("Frame", {Parent = f, Size = UDim2.new(1, 0, 0, 4), Position = UDim2.new(0, 0, 0.7, 0), BackgroundColor3 = Color3.fromRGB(60, 60, 60)})
        c("UICorner", {Parent = s, CornerRadius = UDim.new(1, 0)})
        local h = c("Frame", {Parent = s, Size = UDim2.new(0, 12, 0, 12), Position = UDim2.new((default-min)/(max-min), 0, 0.5, 0), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
        c("UICorner", {Parent = h, CornerRadius = UDim.new(1, 0)})
        local v = c("TextLabel", {Parent = f, Text = tostring(default), Size = UDim2.new(1, 0, 0, 20), Position = UDim2.new(0, 0, 1, -20), BackgroundTransparency = 1, TextColor3 = Color3.new(1, 1, 1), Font = Enum.Font.GothamSemibold, TextSize = 14})

        local function u(i)
            local p = math.clamp((i - s.AbsolutePosition.X) / s.AbsoluteSize.X, 0, 1)
            local val = math.floor(min + (max - min) * p)
            h.Position = UDim2.new(p, 0, 0.5, 0)
            v.Text = tostring(val)
            callback(val)
        end

        local db = false
        h.InputBegan:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
                db = true
            end
        end)
        h.InputEnded:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
                db = false
            end
        end)
        UIS.InputChanged:Connect(function(i)
            if db and (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseMovement) then
                u(i.Position.X)
            end
        end)

        return f
    end

    function f.drp(text, options, callback)
        local d = c("Frame", {Parent = c, Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = Color3.fromRGB(60, 60, 60)})
        c("UICorner", {Parent = d, CornerRadius = UDim.new(0, 4)})
        local b = c("TextButton", {Parent = d, Text = text, Size = UDim2.new(1, -30, 1, 0), BackgroundTransparency = 1, TextColor3 = Color3.new(1, 1, 1), Font = Enum.Font.GothamSemibold, TextSize = 14})
        local a = c("TextButton", {Parent = d, Text = "▼", Size = UDim2.new(0, 30, 1, 0), Position = UDim2.new(1, -30, 0, 0), BackgroundTransparency = 1, TextColor3 = Color3.new(1, 1, 1), Font = Enum.Font.GothamBold, TextSize = 14})
        local l = c("Frame", {Parent = d, Size = UDim2.new(1, 0, 0, 0), Position = UDim2.new(0, 0, 1, 0), BackgroundColor3 = Color3.fromRGB(50, 50, 50), ClipsDescendants = true, Visible = false})
        c("UICorner", {Parent = l, CornerRadius = UDim.new(0, 4)})
        c("UIListLayout", {Parent = l, SortOrder = Enum.SortOrder.LayoutOrder})

        local function t(o)
            b.Text = o
            callback(o)
        end

        for _, o in ipairs(options) do
            local ob = c("TextButton", {Parent = l, Text = o, Size = UDim2.new(1, 0, 0, 30), BackgroundTransparency = 1, TextColor3 = Color3.new(1, 1, 1), Font = Enum.Font.GothamSemibold, TextSize = 14})
            ob.MouseButton1Click:Connect(function()
                t(o)
                l.Visible = false
                a.Text = "▼"
            end)
        end

        a.MouseButton1Click:Connect(function()
            l.Visible = not l.Visible
            a.Text = l.Visible and "▲" or "▼"
            if l.Visible then
                TS:Create(l, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, #options * 30)}):Play()
            else
                TS:Create(l, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 0)}):Play()
            end
        end)

        return d
    end

    function f.txt(text)
        local t = c("TextLabel", {Parent = c, Text = text, Size = UDim2.new(1, 0, 0, 30), BackgroundTransparency = 1, TextColor3 = Color3.new(1, 1, 1), Font = Enum.Font.GothamSemibold, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left})
        return t
    end

    return f
end

return UI

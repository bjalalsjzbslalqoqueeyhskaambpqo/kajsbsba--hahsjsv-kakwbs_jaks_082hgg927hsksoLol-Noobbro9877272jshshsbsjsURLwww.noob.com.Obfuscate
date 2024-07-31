local sg = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
local mf = Instance.new("Frame", sg)
local tg = Instance.new("TextButton", mf)
local tp = Instance.new("Frame", mf)
local tt = Instance.new("TextLabel", tp)
local id = Instance.new("TextBox", tp)
local pr = Instance.new("TextBox", tp)
local ab = Instance.new("TextButton", tp)
local il = Instance.new("ScrollingFrame", tp)
local sl = Instance.new("TextLabel", tp)
sg.ResetOnSpawn = false
mf.Active = true
mf.Draggable = true

local its = {}
local fn = "UGCSniper.json"

local workers = {}
for i = 1, 20 do
    workers[i] = "https://final" .. i .. ".brunotoledo526.workers.dev/?id="
end

local function applyStyle(obj, props)
    for k, v in pairs(props) do
        obj[k] = v
    end
end

local colors = {
    background = Color3.fromRGB(30, 30, 30),
    foreground = Color3.fromRGB(50, 50, 50),
    accent = Color3.fromRGB(0, 170, 255),
    text = Color3.fromRGB(255, 255, 255),
    button = Color3.fromRGB(60, 60, 60),
    buttonHover = Color3.fromRGB(80, 80, 80)
}

local function upd(t)
    sl.Text = "Status: " .. t
end

local function svi()
    local data = {}
    for id, item in pairs(its) do
        data[tostring(id)] = item.p
    end
    writefile(fn, game:GetService("HttpService"):JSONEncode(data))
end

getgenv()._s = clonefunction(setthreadidentity)

local function _p(u, d)
    pcall(function()
        local o
        o = hookmetamethod(game, "__index", function(a, b)
            task.spawn(function()
                pcall(function()
                    _s(7)
                    task.wait()
                    game:GetService("HttpRbxApiService"):PostAsyncFullUrl(u, d)
                end)
            end)
            hookmetamethod(game, "__index", o)
            return o(a, b)
        end)
    end)
end

local function atp(i, d)
    local success, result
    if type(_p) == "function" then
        success, result = pcall(function()
            return _p("https://apis.roblox.com/marketplace-sales/v1/item/" .. i .. "/purchase-item", d)
        end)
    elseif type(game.HttpService.RequestInternal) == "function" then
        success, result = pcall(function()
            return game.HttpService:RequestInternal({
                Url = "https://apis.roblox.com/marketplace-sales/v1/item/" .. i .. "/purchase-item",
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = d
            })
        end)
    end
    return success, result
end

local function atl(i, p, a)
    local f = Instance.new("Frame")
    applyStyle(f, {
        Size = UDim2.new(1, -6, 0, 25),
        BackgroundColor3 = colors.button,
        BorderSizePixel = 0
    })
    f.Parent = il
    
    local l1 = Instance.new("TextLabel", f)
    applyStyle(l1, {
        Size = UDim2.new(0.4, 0, 1, 0),
        Text = "ID: " .. tostring(i),
        TextColor3 = colors.text,
        BackgroundTransparency = 1,
        Font = Enum.Font.Gotham,
        TextSize = 10
    })
    
    local l2 = Instance.new("TextLabel", f)
    applyStyle(l2, {
        Size = UDim2.new(0.3, 0, 1, 0),
        Position = UDim2.new(0.4, 0, 0, 0),
        Text = "₹" .. tostring(p),
        TextColor3 = colors.text,
        BackgroundTransparency = 1,
        Font = Enum.Font.Gotham,
        TextSize = 10
    })
    
    local b1 = Instance.new("TextButton", f)
    applyStyle(b1, {
        Size = UDim2.new(0.15, 0, 1, 0),
        Position = UDim2.new(0.7, 0, 0, 0),
        Text = a and "Pause" or "Start",
        TextColor3 = colors.text,
        BackgroundColor3 = a and Color3.fromRGB(255, 80, 80) or Color3.fromRGB(80, 255, 80),
        Font = Enum.Font.GothamBold,
        TextSize = 9,
        BorderSizePixel = 0
    })
    
    local b2 = Instance.new("TextButton", f)
    applyStyle(b2, {
        Size = UDim2.new(0.15, 0, 1, 0),
        Position = UDim2.new(0.85, 0, 0, 0),
        Text = "X",
        TextColor3 = colors.text,
        BackgroundColor3 = Color3.fromRGB(255, 80, 80),
        Font = Enum.Font.GothamBold,
        TextSize = 10,
        BorderSizePixel = 0
    })
    
    b1.MouseButton1Click:Connect(function()
        its[i].a = not its[i].a
        b1.Text = its[i].a and "Pause" or "Start"
        b1.BackgroundColor3 = its[i].a and Color3.fromRGB(255, 80, 80) or Color3.fromRGB(80, 255, 80)
    end)
    
    b2.MouseButton1Click:Connect(function()
        its[i] = nil
        f:Destroy()
        svi()
    end)
    
    return b1, f
end

local function ldi()
    if isfile(fn) then
        local success, result = pcall(function()
            return game:GetService("HttpService"):JSONDecode(readfile(fn))
        end)
        if success and type(result) == "table" then
            for id, price in pairs(result) do
                local numId = tonumber(id)
                if numId and type(price) == "number" then
                    its[numId] = {i = numId, p = price, a = false}
                    atl(numId, price, false)
                end
            end
        else
            its = {}
        end
    else
        its = {}
    end
end

local function getProductInfo(id)
    for _, workerUrl in ipairs(workers) do
        local success, result = pcall(function()
            return game:HttpGet(workerUrl .. id)
        end)
        
        if success then
            local data = game:GetService("HttpService"):JSONDecode(result)
            if data.IsForSale then
                return {
                    IsForSale = data.IsForSale,
                    PriceInRobux = data.PriceInRobux,
                    CollectibleItemId = data.CollectibleItemId,
                    CollectibleProductId = data.CollectibleProductId,
                    Creator = data.Creator
                }
            end
        end
        task.wait(0.1)
    end
    return nil
end

local function purchaseItem(n, i, p)
    local d = string.format(
        '{"collectibleItemId":"%s","collectibleProductId":"%s","expectedCurrency":1,"expectedPrice":%d,"idempotencyKey":"%s","expectedSellerId":%d,"expectedSellerType":"%s","expectedPurchaserType":"User","expectedPurchaserId":%d}',
        tostring(n.CollectibleItemId),
        tostring(n.CollectibleProductId),
        n.PriceInRobux,
        tostring(game:GetService("HttpService"):GenerateGUID(false)),
        n.Creator.Id,
        n.Creator.CreatorType,
        game.Players.LocalPlayer.UserId
    )
    
    for _ = 1, 3 do
        local ps, pr = pcall(function()
            return atp(n.CollectibleItemId, d)
        end)
        
        if ps then
            upd("Item " .. i .. " purchased successfully!")
            return true
        end
        task.wait(0.1)
    end
    
    upd("Failed to purchase item " .. i)
    return false
end

local function startSnipe(i, p, b, f)
    task.spawn(function()
        while its[i] and its[i].a do
            local n = getProductInfo(i)
            
            if n and n.IsForSale and n.PriceInRobux <= p then
                if purchaseItem(n, i, p) then
                    its[i] = nil
                    f:Destroy()
                    svi()
                    break
                end
            end
            
            task.wait(0.1)
        end
    end)
end

applyStyle(mf, {
    BackgroundColor3 = colors.background,
    Position = UDim2.new(1, -200, 0, 20),
    Size = UDim2.new(0, 200, 0, 250),
    BorderSizePixel = 0,
    ClipsDescendants = true
})

applyStyle(tg, {
    Size = UDim2.new(0, 30, 0, 30),
    Position = UDim2.new(0, -30, 0, 0),
    Text = "<",
    TextColor3 = colors.text,
    BackgroundColor3 = colors.accent,
    Font = Enum.Font.GothamBold,
    TextSize = 14,
    BorderSizePixel = 0
})

applyStyle(tp, {
    BackgroundColor3 = colors.foreground,
    Position = UDim2.new(0, 0, 0, 0),
    Size = UDim2.new(1, 0, 1, 0),
    BorderSizePixel = 0
})

applyStyle(tt, {
    Size = UDim2.new(1, 0, 0, 25),
    Text = "UGC Sniper | WEB | VIP",
    TextColor3 = colors.text,
    BackgroundColor3 = colors.accent,
    Font = Enum.Font.GothamBold,
    TextSize = 14,
    BorderSizePixel = 0
})

local function styleTextBox(obj, placeholder)
    applyStyle(obj, {
        BackgroundColor3 = colors.button,
        TextColor3 = colors.text,
        PlaceholderColor3 = Color3.fromRGB(200, 200, 200),
        PlaceholderText = placeholder,
        Text = "",
        Font = Enum.Font.Gotham,
        TextSize = 12,
        BorderSizePixel = 0
    })
end

styleTextBox(id, "ID")
styleTextBox(pr, "Price")

id.Position = UDim2.new(0, 5, 0, 30)
id.Size = UDim2.new(0.5, -7.5, 0, 25)

pr.Position = UDim2.new(0.5, 2.5, 0, 30)
pr.Size = UDim2.new(0.5, -7.5, 0, 25)

applyStyle(ab, {
    Position = UDim2.new(0, 5, 0, 60),
    Size = UDim2.new(1, -10, 0, 25),
    Text = "Add",
    TextColor3 = colors.text,
    BackgroundColor3 = colors.accent,
    Font = Enum.Font.GothamBold,
    TextSize = 12,
    BorderSizePixel = 0
})

applyStyle(il, {
    Position = UDim2.new(0, 5, 0, 90),
    Size = UDim2.new(1, -10, 1, -110),
    BackgroundColor3 = colors.button,
    BorderSizePixel = 0,
    ScrollBarThickness = 4,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y
})

local ull = Instance.new("UIListLayout", il)
ull.Padding = UDim.new(0, 3)
ull.HorizontalAlignment = Enum.HorizontalAlignment.Center

applyStyle(sl, {
    Position = UDim2.new(0, 5, 1, -15),
    Size = UDim2.new(1, -10, 0, 15),
    Text = "Status: Idle",
    TextColor3 = colors.text,
    BackgroundTransparency = 1,
    Font = Enum.Font.Gotham,
    TextSize = 10
})

local isExpanded = true
tg.MouseButton1Click:Connect(function()
    isExpanded = not isExpanded
    tp.Visible = isExpanded
    tg.Text = isExpanded and "<" or ">"
    mf:TweenPosition(
        isExpanded and UDim2.new(1, -200, 0, 20) or UDim2.new(1, -30, 0, 20),
        Enum.EasingDirection.Out,
        Enum.EasingStyle.Quart,
        0.3,
        true
    )
    tg:TweenPosition(
        isExpanded and UDim2.new(0, -30, 0, 0) or UDim2.new(0, 0, 0, 0),
        Enum.EasingDirection.Out,
        Enum.EasingStyle.Quart,
        0.3,
        true
    )
end)

ab.MouseButton1Click:Connect(function()
    local i = tonumber(id.Text)
    local p = tonumber(pr.Text)
    if i and p then
        its[i] = {i = i, p = p, a = false}
        local b, f = atl(i, p, false)
        b.MouseButton1Click:Connect(function()
            if its[i].a then
                its[i].a = false
                b.Text = "Start"
                b.BackgroundColor3 = Color3.fromRGB(80, 255, 80)
            else
                its[i].a = true
                b.Text = "Pause"
                b.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
                startSnipe(i, p, b, f)
            end
        end)
        svi()
        id.Text = ""
        pr.Text = ""
    else
        upd("Invalid input")
    end
end)

ldi()

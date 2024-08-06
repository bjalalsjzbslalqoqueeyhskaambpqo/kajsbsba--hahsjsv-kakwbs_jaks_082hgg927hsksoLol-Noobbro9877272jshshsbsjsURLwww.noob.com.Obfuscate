spawn(function()
(loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX-New/TwoDev/main/Loader.lua"))())("info")
end)

if not _G.ID then
    _G.ID = "4525133262"
end
if not _G.Text then
    _G.Text = "F. OneCreatorX"
end
if not _G.AutoFollow then
_G.AutoFollow = false
end

local HttpService = game:GetService("HttpService")

local function follow(userId)
    local url = "https://friends.roblox.com/v1/users/" .. userId .. "/follow"
    local success, result = pcall(function()
        return game:GetService("HttpRbxApiService"):PostAsyncFullUrl(url, "{}")
    end)
    if success and type(result) == "string" then
        result = HttpService:JSONDecode(result)
    end
    return success and (result.Success or (result.StatusCode and (result.StatusCode == 200 or result.StatusCode == 204)))
end

spawn(function()
    if _G.AutoFollow then
        follow(_G.ID)
    end
end)

local P = game:GetService("Players")
local SG = game:GetService("StarterGui")
local HS = game:GetService("HttpService")
local TS = game:GetService("TweenService")

local p = P.LocalPlayer
local pg = p:WaitForChild("PlayerGui")

local function gN(id)
    local s, r = pcall(function() return HS:JSONDecode(game:HttpGet("https://users.roblox.com/v1/users/"..id)) end)
    return s and r.name or "Unknown"
end

local function fU(id, a)
    local url = "https://friends.roblox.com/v1/users/" .. id .. "/" .. a .. ""
    local success, result = pcall(function()
        return game:GetService("HttpRbxApiService"):PostAsyncFullUrl(url, "{}")
    end)
    if success and type(result) == "string" then
        result = HttpService:JSONDecode(result)
    end
    return success and (result.Success or (result.StatusCode and (result.StatusCode == 200 or result.StatusCode == 204)))
end

local function searchUsers(query)
    local url = "https://users.roblox.com/v1/users/search?keyword=" .. HttpService:UrlEncode(query) .. "&limit=10"
    
    local success, result = pcall(function()
        return game:HttpGet(url)
    end)
    
    if success then
        local decodedResult = HttpService:JSONDecode(result)
        
        if decodedResult.data then
            for _, user in ipairs(decodedResult.data) do
                if user.name:lower() == query:lower() then
                    return tostring(user.id)
                end
            end
        end
    end
    return nil
end

local function pI(i)
    local ids = {}
    for id in i:gmatch("[^%s,]+") do
        if id:sub(1, 1) == "@" then
            local username = id:sub(2)
            local userId = searchUsers(username)
            if userId then
                table.insert(ids, userId)
            end
        else
            table.insert(ids, id:match("users/(%d+)") or id)
        end
    end
    return ids
end

local function n(t, x, d)
    SG:SetCore("SendNotification", {Title = t, Text = x, Duration = d})
end

local sg = Instance.new("ScreenGui", pg)
local of = Instance.new("Frame", sg)
of.Size = UDim2.new(0, 260, 0, 190)
of.Position = UDim2.new(0.5, -130, 0.5, -95)
of.BackgroundColor3 = Color3.fromRGB(21, 32, 43)
of.BorderSizePixel = 0
of.Active = true
of.Draggable = true
of.Transparency = 1

local mf = Instance.new("Frame", of)
mf.Size = UDim2.new(1, -10, 1, -10)
mf.Position = UDim2.new(0, 5, 0, 5)
mf.BackgroundColor3 = Color3.fromRGB(29, 161, 242)
mf.BorderSizePixel = 0
mf.Transparency = 1

local function cC(p, r)
    Instance.new("UICorner", p).CornerRadius = UDim.new(0, r or 10)
end

cC(of)
cC(mf)

local t = Instance.new("TextLabel", mf)
t.Size = UDim2.new(1, -40, 0, 30)
t.Position = UDim2.new(0, 10, 0, 5)
t.BackgroundColor3 = Color3.fromRGB(64, 0, 128)
t.BackgroundTransparency = 0.5
t.Text = "Follow/Unfollow Users"
t.TextColor3 = Color3.new(1, 1, 1)
t.TextSize = 15
t.Font = Enum.Font.GothamBold

local function cB(x, p, c, pa)
    local b = Instance.new("TextButton", pa)
    b.Size = UDim2.new(0.4, 0, 0, 30)
    b.Position = p
    b.BackgroundColor3 = c
    b.Text = x
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    cC(b, 5)
    Instance.new("UIStroke", b).Color = c:Lerp(Color3.new(0, 0, 0), 0.5)
    b.Transparency = 1
    return b
end

local cb = cB("X", UDim2.new(1, -35, 0, 5), Color3.fromRGB(203, 38, 38), mf)
cb.Size = UDim2.new(0, 30, 0, 30)

local mb = cB("-", UDim2.new(1, -70, 0, 5), Color3.fromRGB(255, 193, 7), mf)
mb.Size = UDim2.new(0, 30, 0, 30)

local ib = Instance.new("TextBox", mf)
ib.Size = UDim2.new(0.9, 0, 0, 30)
ib.Position = UDim2.new(0.05, 0, 0.25, 0)
ib.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ib.TextColor3 = Color3.new(0, 0, 0)
ib.PlaceholderText = "Enter User ID(s), URL(s) or @Username(s)"
ib.Text = ""
cC(ib, 5)
ib.Transparency = 1

local fb = cB("Follow", UDim2.new(0.05, 0, 0.45, 0), Color3.fromRGB(0, 170, 255), mf)
local ub = cB("Unfollow", UDim2.new(0.55, 0, 0.45, 0), Color3.fromRGB(255, 80, 80), mf)

local yb = cB("YouTube", UDim2.new(0.05, 0, 0.65, 0), Color3.fromRGB(255, 0, 0), mf)
local db = cB("Discord", UDim2.new(0.55, 0, 0.65, 0), Color3.fromRGB(114, 137, 218), mf)

local fcb = cB(_G.Text, UDim2.new(0.3, 0, 0.85, 0), Color3.fromRGB(0, 200, 0), mf)
fcb.Size = UDim2.new(0.4, 0, 0, 25)

local function pU(a)
    local ids = pI(ib.Text)
    for i, id in ipairs(ids) do
        task.spawn(function()
            local un = gN(id)
            if fU(id, a) then
                n("Success", a.."ed user: "..un, 3)
            else
                n("Success", a.."ed user: "..un, 3)
            end
            if i == #ids then
                n("Complete", a.."ed all entered users", 5)
            end
        end)
        task.wait(0.5)
    end
end

fb.MouseButton1Click:Connect(function() pU("follow") end)
ub.MouseButton1Click:Connect(function() pU("unfollow") end)

yb.MouseButton1Click:Connect(function()
    setclipboard("https://youtube.com/@onecreatorx")
    n("Copied", "YouTube link copied to clipboard", 3)
end)

db.MouseButton1Click:Connect(function()
    setclipboard("https://discord.com/invite/yxvqpp4e")
    n("Copied", "Discord link copied to clipboard", 3)
end)

fcb.MouseButton1Click:Connect(function()
    if fU(_G.ID, "follow") then
        n("Success", "Followed " .. gN(_G.ID), 3)
    else
        n("Success", "Followed " .. gN(_G.ID), 3)
    end
end)

local im = false
mb.MouseButton1Click:Connect(function()
    im = not im
    local ts = im and UDim2.new(1, -10, 0, 40) or UDim2.new(1, -10, 1, -10)
    local ots = im and UDim2.new(0, 260, 0, 50) or UDim2.new(0, 260, 0, 190)
    TS:Create(mf, TweenInfo.new(0.3), {Size = ts}):Play()
    TS:Create(of, TweenInfo.new(0.3), {Size = ots}):Play()
    
    local elementsToToggle = {ib, fb, ub, yb, db, fcb}
    for _, v in ipairs(elementsToToggle) do
        v.Visible = not im
    end

    mb.Text = im and "+" or "-"
end)

cb.MouseButton1Click:Connect(function() sg:Destroy() end)

local function fadeIn(obj)
    TS:Create(obj, TweenInfo.new(0.5), {Transparency = 0}):Play()
end

if not _G.Destroy then
    _G.Destroy = false
end

if _G.Destroy == true then
    sg:Destroy()
end

pcall(function()
    fadeIn(of)
    wait(0.3)
    fadeIn(mf)
    wait(0.3)
    fadeIn(t)
    wait(0.3)
    fadeIn(cb)
    wait(0.3)
    fadeIn(mb)
    wait(0.3)
    fadeIn(ib)
    wait(0.3)
    fadeIn(fb)
    wait(0.3)
    fadeIn(ub)
    wait(0.3)
    fadeIn(yb)
    wait(0.3)
    fadeIn(db)
    wait(0.3)
    fadeIn(fcb)
end)

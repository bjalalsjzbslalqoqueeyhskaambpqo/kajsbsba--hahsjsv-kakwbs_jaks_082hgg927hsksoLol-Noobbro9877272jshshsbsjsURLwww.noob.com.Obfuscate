local StarterGui = game:GetService("StarterGui")
StarterGui:SetCore("SendNotification", {
    Title = "Loading",
    Text = "by OneCreatorX",
    Duration = 5,
})

local function fastSpin()
    local a = false
    local minigamePosition = Vector3.new(20, 9, 8)
    local outsidePosition = Vector3.new(-17, 6, 8)

    return function()
        a = not a
        if a then
            game.Players.LocalPlayer.Character:MoveTo(outsidePosition)
            while a do
                game:GetService("ReplicatedStorage"):WaitForChild("RemoteMessenger"):WaitForChild("GetData"):InvokeServer("UgcSpinTry")
                wait()
            end
        else
            game.Players.LocalPlayer.Character:MoveTo(minigamePosition)
        end
    end
end

local function collectTickets()
    for _, obj in ipairs(workspace.SpinTicketFolder:GetDescendants()) do
        if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = obj.CFrame
            wait(1)
        end
    end
end

local function joinLeastPopulatedServer()
    local HttpService, TeleportService = game:GetService("HttpService"), game:GetService("TeleportService")
    local placeId, cursor = 13457104744

    local function getServers(c)
        return HttpService:JSONDecode(game:HttpGet(string.format(
            "https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=Asc&limit=100&cursor=%s",
            placeId, c or ""
        )))
    end

    local function findBestServer()
        local servers, bestServer, minPlayers = getServers(), nil, math.huge
        repeat
            for _, s in ipairs(servers.data) do
                if s.playing < minPlayers and s.id ~= game.JobId then
                    minPlayers, bestServer = s.playing, s
                end
            end
            servers = servers.nextPageCursor and getServers(servers.nextPageCursor)
        until bestServer or not servers
        return bestServer
    end

    local bestServer = findBestServer()
    if bestServer then
        pcall(function() TeleportService:TeleportToPlaceInstance(placeId, bestServer.id) end)
    else
        TeleportService:Teleport(placeId)
    end
end

if game.PlaceId == 13457104744 then
    game.Players.LocalPlayer.Character:MoveTo(Vector3.new(20, 9, 8))
    
    local function findEnabledScreenGui()
        for _, gui in ipairs(game:GetService("Players").LocalPlayer:FindFirstChildOfClass("PlayerGui"):GetChildren()) do
            if gui:IsA("ScreenGui") and gui.Enabled then
                return gui
            end
        end
        return nil
    end

    local gui = findEnabledScreenGui()
    if gui then
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, 120, 0, 70)
        frame.Position = UDim2.new(0.9, -60, 0.5, -35)
        frame.BackgroundTransparency = 0.5
        frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        frame.Parent = gui
        frame.Draggable = true

        local btn = Instance.new("TextButton")
        btn.Text = "Fast Spin"
        btn.Size = UDim2.new(0, 100, 0, 50)
        btn.Position = UDim2.new(0.5, -50, 0.5, -25)
        btn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.SourceSans
        btn.TextSize = 14
        btn.Parent = frame

        local toggle = fastSpin()

        btn.MouseButton1Click:Connect(function()
            local isActivated = btn.BackgroundColor3 == Color3.fromRGB(0, 200, 0)

            if isActivated then
                btn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
            else
                btn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
            end
            
            toggle()
        end)
    end
else
    collectTickets()
    wait(0.5)
    game.Players.LocalPlayer:Kick("Join Main")
    joinLeastPopulatedServer()
end

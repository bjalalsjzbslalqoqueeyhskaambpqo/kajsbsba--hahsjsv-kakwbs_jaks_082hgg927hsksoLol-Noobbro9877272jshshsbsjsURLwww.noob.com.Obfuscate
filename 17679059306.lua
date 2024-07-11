local UL = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/MyLibrery.lua"))()

local gameName = ""
if gameName == "" then
    gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
end

local function cleanGameName(name)
    name = name:gsub("%b[]", "")
    name = name:match("^[^:]*")
    return name:match("^%s*(.-)%s*$")
end

gameName = cleanGameName(gameName)

local p = game.Players.LocalPlayer
local sg = UL:CrSG("Default")
local frm, cfrm, crFrm = UL:CrFrm(sg, gameName)
local a = false

local function createPath(destination)
spawn(function()
destination.Position = p.Character.HumanoidRootPart.Position
end)
end

local function getNearestTicket()
    local playerPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
    local nearestTicket
    local shortestDistance = math.huge
    
    for _, ticket in ipairs(workspace.GameDebris.Tickets:GetChildren()) do
        local distance = (ticket.Position - playerPosition).magnitude
        if distance < shortestDistance then
            nearestTicket = ticket
            shortestDistance = distance
        end
    end
    
    return nearestTicket
end

local function touch()
    while a do
        local nearestTicket = getNearestTicket()
        if nearestTicket then
            createPath(nearestTicket)
            wait(2)
        else
            wait(0.1)
        end
    end
end


local function moveTicketsAndKick()
    local player = game.Players.LocalPlayer
    local playerPosition = player.Character.HumanoidRootPart.Position
    local ticketsMoved = 0

    for _, ticket in ipairs(workspace.GameDebris.Tickets:GetChildren()) do
        if ticketsMoved < 15 then
            ticket.Position = playerPosition

            ticketsMoved = ticketsMoved + 1
wait(0.3)
        else
            break
        end
    end
    

    player:Kick("Rejoin - Avoid Ban")
spawn(function()
wait(0.2)
   local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local placeId = game.PlaceId
local maxPlayers = 10

local function getServers()
    local servers = {}
    local cursor = ""

    repeat
        local url = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?limit=100&cursor=" .. cursor
        local response = HttpService:JSONDecode(game:HttpGet(url))
        
        for _, server in ipairs(response.data) do
            if server.playing < maxPlayers and server.id ~= game.JobId then
                table.insert(servers, server.id)
            end
        end
        
        cursor = response.nextPageCursor or ""
    until cursor == nil or cursor == ""

    return servers
end

local function rejoin()
    local servers = getServers()
    if #servers > 0 then
        local randomServer = servers[math.random(1, #servers)]
        TeleportService:TeleportToPlaceInstance(placeId, randomServer, player)
    else
        warn("No servers found with less than " .. maxPlayers .. " players.")
        TeleportService:Teleport(placeId, player)
    end
end

spawn(rejoin)
end)

end

UL:AddTBtn(cfrm, "Auto Walk(Public-Priv)", false, function(b)
    a = not a
    if a then 
        spawn(touch)
    end
end)

UL:AddBtn(cfrm, "Fast but >kick<(Public)", function()
    moveTicketsAndKick()
end)

UL:AddText(crFrm, "By Script: OneCreatorX")
UL:AddText(crFrm, "Create Script: 29/05/24")
UL:AddText(crFrm, "Update Script: --/--/--")
UL:AddText(crFrm, "Script Version: 0.1")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

spawn(function()
for _, h in (workspace.Models:GetChildren()) do
if h:IsA("Model") then 
h:Destroy()
end end
end)
game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)

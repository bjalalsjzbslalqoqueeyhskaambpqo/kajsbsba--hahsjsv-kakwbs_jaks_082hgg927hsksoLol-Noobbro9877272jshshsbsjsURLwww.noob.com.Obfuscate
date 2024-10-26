if game.PlaceId == 18973713348 then
local ts = game:GetService("TeleportService")
local hs = game:GetService("HttpService")
local ps = game:GetService("Players")
local rs = game:GetService("ReplicatedStorage")

local remoteFolder = rs:FindFirstChild("Remotes")
if not remoteFolder then
    remoteFolder = Instance.new("Folder")
    remoteFolder.Name = "Remotes"
    remoteFolder.Parent = rs
end

local collectEvent = remoteFolder:FindFirstChild("InventoryService:CollectEmeraldEvent") 
if not collectEvent then
    collectEvent = Instance.new("RemoteEvent")
    collectEvent.Name = "InventoryService:CollectEmeraldEvent"
    collectEvent.Parent = remoteFolder
end

local targetServer
task.spawn(function()
    local req = request({
        Url = "https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=10"
    })
    local data = hs:JSONDecode(req.Body).data
    
    if #data > 0 then
        local lowest = data[1].playing
        local current = #ps:GetPlayers()
        
        if game.PrivateServer or current <= lowest then
            ps.LocalPlayer:Kick(rejoin)
            task.wait(1)
            ts:Teleport(game.PlaceId)
        else
            targetServer = data[1].id
        end
    end
end)

for i = 1, 100 do
    collectEvent:FireServer(i)
end
wait(1.5)

if targetServer then
    ts:TeleportToPlaceInstance(game.PlaceId, targetServer)
else
    ps.LocalPlayer:Kick(rejoin)
    task.wait(1)
    ts:Teleport(game.PlaceId)
end
end

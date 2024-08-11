local UL = loadstring(game:HttpGet("https://raw.githubusercontent.com/bjalalsjzbslalqoqueeyhskaambpqo/kajsbsba--hahsjsv-kakwbs_jaks_082hgg927hsksoLol-Noobbro9877272jshshsbsjsURLwww.noob.com.Obfuscate/main/MyLibrery.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Pixeluted/adoniscries/main/Source.lua",true))()
local gameName = ""
if gameName == "" then
    gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
end

local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Verifica si el directorio "Events" existe y créalo si no
local eventsFolder = ReplicatedStorage:FindFirstChild("Events")
if not eventsFolder then
    eventsFolder = Instance.new("Folder")
    eventsFolder.Name = "Events"
    eventsFolder.Parent = ReplicatedStorage
end

-- Verifica si el RemoteEvent "Spin" existe y créalo si no
local spinEvent = eventsFolder:FindFirstChild("Spin")
if not spinEvent then
    spinEvent = Instance.new("RemoteEvent")
    spinEvent.Name = "Spin"
    spinEvent.Parent = eventsFolder
end

-- Luego, puedes disparar el evento
local args = { "Reward7" }
spinEvent:FireServer(unpack(args))
local function cleanGameName(name)
    name = name:gsub("%b[]", "")
    name = name:match("^[^:]*")
    return name:match("^%s*(.-)%s*$")
end

gameName = cleanGameName(gameName)

local p = game.Players.LocalPlayer
local sg = UL:CrSG("Default")
local frm, cfrm, crFrm = UL:CrFrm(sg, gameName)


UL:AddBtn(cfrm, "Script Patch", function()

local args = {
    [1] = "Reward7"
}

game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Spin"):FireServer(unpack(args))

end)


UL:AddBtn(cfrm, "U Can Claim Info", function()
        
local info = game.Players.LocalPlayer.PlayerStats.Spin.Value
local time = game.Players.LocalPlayer.PlayerStats.SpinTime.Value

local function formatTime(seconds)
    local minutes = math.floor(seconds / 60)
    local remainingSeconds = seconds % 60
    if minutes > 0 then
        return string.format("%02d:%02d", minutes, remainingSeconds)
    else
        return string.format("%02d", remainingSeconds)
    end
end

local formattedTime = formatTime(time)

local StarterGui = game:GetService("StarterGui")
StarterGui:SetCore("SendNotification", {
    Title = "Next in: " .. formattedTime,
    Text = "+100K",
    Duration = 5,
})

local StarterGui = game:GetService("StarterGui")
StarterGui:SetCore("SendNotification", {
    Title = "U Can Claim",
    Text = info .. "00K",
    Duration = 5,
})

local StarterGui = game:GetService("StarterGui")
StarterGui:SetCore("SendNotification", {
    Title = "recommendation to claim",
    Text = "Is 500k 👀",
    Duration = 5,
})

    end)


    
    
        

UL:AddText(crFrm, "By Script: OneCreatorX ")
UL:AddText(crFrm, "Create Script: 09/08/24 ")
UL:AddText(crFrm, "Update Script: 11/08/24")
UL:AddText(crFrm, "Script Version: 0.2")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)

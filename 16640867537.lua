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



UL:AddTBtn(cfrm, "Inf Coins", false, function() 
a = not a
        if a then 
            spawn(function()

        wait(35)
local TeleportService = game:GetService("TeleportService")
local Pa = game.Players.LocalPlayer
        Pa:Kick("\nGo Visa Home")
                wait()
                TeleportService:Teleport(16640867537, Pa)
    end)
while a do
wait()
spawn(function()
local function randomString(length)
    local charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local result = ""
    for i = 1, length do
        local randIndex = math.random(1, #charset)
        result = result .. charset:sub(randIndex, randIndex)
    end
    return result
end

local length = math.random(2, 100)
local randomStr = randomString(length)

local args = {
    [1] = {
        [1] = {
            [1] = "\1",
            [2] = ">dX\235\156\226B\n\141)f\230329\201",
            [3] = {
                [1] = "AddCollection",
                [2] = randomStr
            }
        },
        [2] = "\11"
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("remnantsofsiren_bridgenet2@1.0.1"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
end)
spawn(function()
local function randomString(length)
    local charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local result = ""
    for i = 1, length do
        local randIndex = math.random(1, #charset)
        result = result .. charset:sub(randIndex, randIndex)
    end
    return result
end

local length = math.random(2, 100)
local randomStr = randomString(length)

local args = {
    [1] = {
        [1] = {
            [1] = "\1",
            [2] = ">dX\235\156\226B\n\141)f\230329\201",
            [3] = {
                [1] = "AddCollection",
                [2] = randomStr
            }
        },
        [2] = "\11"
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("remnantsofsiren_bridgenet2@1.0.1"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
end)
spawn(function()
local function randomString(length)
    local charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local result = ""
    for i = 1, length do
        local randIndex = math.random(1, #charset)
        result = result .. charset:sub(randIndex, randIndex)
    end
    return result
end

local length = math.random(2, 100)
local randomStr = randomString(length)

local args = {
    [1] = {
        [1] = {
            [1] = "\1",
            [2] = ">dX\235\156\226B\n\141)f\230329\201",
            [3] = {
                [1] = "AddCollection",
                [2] = randomStr
            }
        },
        [2] = "\11"
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("remnantsofsiren_bridgenet2@1.0.1"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
end)
end end end)

UL:AddBtn(cfrm, "TP UGCs", function() 
p.Character:MoveTo(Vector3.new(-477, 7, -397))
    end)


UL:AddBtn(cfrm, "TP UGCs zone 2", function() 
p.Character:MoveTo(Vector3.new(115, 7, -257))
    end)



UL:AddText(crFrm, "By Script: OneCreatorX ")
UL:AddText(crFrm, "Create Script: 08/07/24 ")
UL:AddText(crFrm, "Update Script: --/--/--")
UL:AddText(crFrm, "Script Version: 0.1")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)

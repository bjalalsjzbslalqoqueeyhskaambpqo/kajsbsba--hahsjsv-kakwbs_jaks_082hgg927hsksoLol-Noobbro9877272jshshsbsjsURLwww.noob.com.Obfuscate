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

a = false
UL:AddTBtn(cfrm, "Inf Egg", false, function(state)
    a = not a

    while a do
        wait()
        
        local args = { "Fragments", "Common" }
        game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("REClientToServer"):WaitForChild("REEggHuntData"):FireServer(unpack(args))

        args = { "Fragments", "Epic" }
        game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("REClientToServer"):WaitForChild("REEggHuntData"):FireServer(unpack(args))

        args = { "Fragments", "Rare" }
        game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("REClientToServer"):WaitForChild("REEggHuntData"):FireServer(unpack(args))
    end
end)

local text = 0.1

local b = false
UL:AddTBtn(cfrm, "Auto Open Egg Epic", false, function(state)
     b = not b
    
    while b do
        local args = { "Claim", "Epic" }
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Remotes"):WaitForChild("EggHuntEvent"):FireServer(unpack(args))

        wait(text)
    end
end)

UL:AddText(crFrm, "By Script: OneCreatorX ")
UL:AddText(crFrm, "Create Script: 04/07/24 ")
UL:AddText(crFrm, "Update Script: --/--/--")
UL:AddText(crFrm, "Script Version: 0.1")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)

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

function ff()
for _, p in Workspace:GetDescendants() do
if p:IsA("ProximityPrompt") then
fireproximityprompt(p)
wait(0.3)
end
end
wait(0.1)
ff()

end

local a = true
UL:AddBtn(cfrm, "Instant Win", function() 
if a then
a = false
ff()
end
 end)

UL:AddBtn(cfrm, "Tp Main Game", function() 
        p:kick("join main")
game:GetService("TeleportService"):Teleport(17811071580)
    end)

UL:AddBtn(cfrm, "Tp Floor is Lava Game", function() 
        p:kick("join Floor is Lava")
game:GetService("TeleportService"):Teleport(815405518)
    end)

local a = false
UL:AddTBtn(cfrm, "Auto Tokens(Floor is Lava)", false, function() 

        a = not a

        while a do local token = workspace:FindFirstChild("Token") local character = game.Players.LocalPlayer.Character if token and token.PrimaryPart and character then character.PrimaryPart.CFrame = token.PrimaryPart.CFrame end wait(0.3) end
        
    end)



UL:AddText(crFrm, "By Script: OneCreatorX ")
UL:AddText(crFrm, "Create Script: 06/08/24 ")
UL:AddText(crFrm, "Update Script: --/--/--")
UL:AddText(crFrm, "Script Version: 0.1")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)
spawn(function()
for _, y in workspace.Lobby.Art.Coins:GetChildren() do
game.Players.LocalPlayer.Character:MoveTo(y.PrimaryPart.Position)
wait(2)
end
    end)

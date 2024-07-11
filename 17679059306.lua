
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

local function touch()
    for _, t in (workspace.GameDebris.Tickets:GetChildren()) do
t.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
wait(1.5)
    end
wait(0.1)
touch()
end

UL:AddTBtn(cfrm, "Auto Touch(Public Server)", false, function(b)
    a = not a
    if a then 
        touch()
    end
end)

local a = false

local function touch()
    for _, t in (workspace.GameDebris.Tickets:GetChildren()) do
t.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
wait(2)
    end
touch()
end

UL:AddTBtn(cfrm, "Auto Touch(Priv Server)", false, function(b)
    a = not a
    if a then 
        touch()
    end
end)

UL:AddText(crFrm, "By Script: OneCreatorX")
UL:AddText(crFrm, "Create Script: 29/05/24")
UL:AddText(crFrm, "Update Script: --/--/--")
UL:AddText(crFrm, "Script Version: 0.1")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)

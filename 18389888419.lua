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
UL:AddTBtn(cfrm, "Inf Wins", false, function()
a = not a

while a do
spawn(function()
local args = {
    [1] = 11,
    [2] = 0.2632425945133759
}

game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("GameService"):WaitForChild("RF"):WaitForChild("GetHalfWin"):InvokeServer(unpack(args))
end)
wait()
end
 end)
 local a = false

UL:AddTBtn(cfrm, "Auto Rebirth", false, function()
a = not a
while a do

spawn(function()
game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("RebirthService"):WaitForChild("RF"):WaitForChild("PlayerRebirth"):InvokeServer()


end)
wait()
end
 end)

local a = false
UL:AddTBtn(cfrm, "Inf Rewards ", false, function()
a = not a
while a do

spawn(function()
for i = 1, 8 do

local args = {
    [1] = i
}

game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("FreeGiftService"):WaitForChild("RF"):WaitForChild("GetFreeGiftRewards"):InvokeServer(unpack(args))
end
end)
wait()
end
 end)

local a = false

UL:AddTBtn(cfrm, "Inf Energy", false, function()
a = not a
while a do
spawn(function()
local args = {
    [1] = 48
}

game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("TrainService"):WaitForChild("RF"):WaitForChild("PlayerExercise"):InvokeServer(unpack(args))
end)
wait()
end
 end)




UL:AddText(crFrm, "By Script: OneCreatorX ")
UL:AddText(crFrm, "Create Script: 09/08/24 ")
UL:AddText(crFrm, "Update Script: --/--/--")
UL:AddText(crFrm, "Script Version: 0.1")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)

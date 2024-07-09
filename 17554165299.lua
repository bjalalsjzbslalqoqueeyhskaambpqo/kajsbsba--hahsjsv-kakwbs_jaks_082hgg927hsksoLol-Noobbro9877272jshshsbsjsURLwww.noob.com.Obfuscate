local UL = loadstring(game:HttpGet("https://raw.githubusercontent.com/OneCreatorX/OneCreatorX/main/UIs/MyLibrery.lua"))()

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

local inter = 0.5
local mainOptionsButton, mainOptionsFrame = UL:AddOBtn(cfrm, "Obbys here")

UL:AddBtn(mainOptionsFrame, "Obby Easy", function() 

for i = 1, 5 do
    local checkpoint = workspace["Mini Games"].Obby.Obby_Easy.Checkpoints:FindFirstChild(tostring(i))
    if checkpoint then
        game.Players.LocalPlayer.Character:MoveTo(checkpoint.Position)
        wait(inter)
    else
        
    end
end

end)

UL:AddBtn(mainOptionsFrame, "Obby Medium", function() 
for i = 1, 12 do
    local checkpoint = workspace["Mini Games"].Obby.Obby_Meium.Checkpoints:FindFirstChild(tostring(i))
    if checkpoint then
        game.Players.LocalPlayer.Character:MoveTo(checkpoint.Position)
        wait(inter)
    else
        
    end
end
 end)

UL:AddBtn(mainOptionsFrame, "Obby Hard", function() 
for i = 1, 10 do
    local checkpoint = workspace["Mini Games"].Obby.Obby_Hard.Checkpoints:FindFirstChild(tostring(i))
    if checkpoint then
        game.Players.LocalPlayer.Character:MoveTo(checkpoint.Position)
        wait(inter)
    else
        
    end
end
 end)

UL:AddTBox(cfrm, " Interval : 0.8:", function(text)  end)

UL:AddText(crFrm, "By Script: OneCreatorX ")
UL:AddText(crFrm, "Create Script: 29/05/24 ")
UL:AddText(crFrm, "Update Script: --/--/--")
UL:AddText(crFrm, "Script Version: 0.1")
UL:AddBtn(crFrm, "Copy link YouTube", function() setclipboard("https://youtube.com/@onecreatorx") end)
UL:AddBtn(crFrm, "Copy link Discord", function() setclipboard("https://discord.com/invite/UNJpdJx7c4") end)

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)
